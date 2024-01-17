JowdayDPS = ModUtil.Mod.Register("JowdayDPS")
JowdayDPS.Config = { DpsInterval = 99999999 }

JowdayDPS.List = {}
function JowdayDPS.List.new(maxSize)
	return { first = 0, last = -1, count = 0, max = maxSize }
end

function JowdayDPS.List.addValue(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
	list.count = list.count + 1
	if list.count > list.max then
		JowdayDPS.List.removeHead(list)
	end
end

function JowdayDPS.List.removeHead(list)
	local first = list.first
	if first > list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil -- to allow garbage collection
	list.first = first + 1
	list.count = list.count - 1
	return value
end

function JowdayDPS.List.emptyList(list)
	while list.count > 0 do
		JowdayDPS.List.removeHead(list)
	end
end

JowdayDPS.DamageHistory = JowdayDPS.List.new(10000)
JowdayDPS.DpsUpdateThread = false
JowdayDPS.DpsBars = {}
JowdayDPS.LastDpsPosition = {}
JowdayDPS.LastDpsBackgroundPosition = {}

--[[
HELPER FUNCTIONS ------------------------------------------
]]
function JowdayDPS.calculateDps(list)
	-- Dum up damage dealt from each source
	local totalDamage = 0
	local earliestTimestamp = 999999;
	local latestTimestamp = 0;
	local totalDamageBySource = {}
	for i = list.first, list.last do
		local damageData = list[i]
		local time = GetTime({})
		if damageData.Timestamp > (time - JowdayDPS.Config.DpsInterval) then
			totalDamage = totalDamage + damageData.Damage
			totalDamageBySource[damageData.Source] = (totalDamageBySource[damageData.Source] or 0) + damageData.Damage
			if damageData.Timestamp < earliestTimestamp then
				earliestTimestamp = damageData.Timestamp
			end
			if damageData.Timestamp > latestTimestamp then
				latestTimestamp = damageData.Timestamp
			end
		end
	end

	-- Sort sources from most damage to least
	local dps = round(totalDamage / (latestTimestamp - earliestTimestamp))
	local sourcesSortedByDamage = {}
	for source in pairs(totalDamageBySource) do table.insert(sourcesSortedByDamage, source) end
	table.sort(sourcesSortedByDamage, function(a, b)
		return totalDamageBySource[a] < totalDamageBySource[b]
	end)
	local maxDamage = totalDamageBySource[sourcesSortedByDamage[#sourcesSortedByDamage]]

	-- UI constants to shift whole UI around
	local initialY = 890
	local xPos = 320   --ScreenCenterX - 550
	local yPos = initialY --ScreenCenterY - 200

	-- Delete any existing UI (e.g the bars from last update)
	-- TODO: Consider resizing / renaming bars instead of destroying and recreating (no performance issues so far though)
	for bar, component in pairs(JowdayDPS.DpsBars) do
		Destroy({ Id = component.Id })
		JowdayDPS.DpsBars[bar] = nil
	end

	-- Create UI to show DPS bars for each source
	for i, source in ipairs(sourcesSortedByDamage) do
		local colors = JowdayDPS.findColor(source)
		JowdayDPS.createDpsBar(source, totalDamageBySource[source], maxDamage, totalDamage, xPos, yPos, colors)
		yPos = yPos - 20
	end

	-- Show the DPS menu only if there are recorded instances of damage, otherwise destroy
	if #sourcesSortedByDamage > 0 then
		JowdayDPS.createDpsHeader("DpsMeter", totalDamage, dps, xPos, yPos - 5)
		local margin = 40
		local width = 500
		local height = (initialY - yPos + margin)
		JowdayDPS.createDpsOverlayBackground("DpsBackground", xPos + margin, yPos - 20 + height / 2, width, height)
	else
		Destroy({ Id = ScreenAnchors["DpsMeter"] })
		Destroy({ Id = ScreenAnchors["DpsBackground"] })
		ScreenAnchors["DpsMeter"] = nil
		ScreenAnchors["DpsBackground"] = nil
	end
end

-- Creates a transparent background behind the dps.  Resizes and moves the existing component if this is called with new height and position
function JowdayDPS.createDpsOverlayBackground(obstacleName, x, y, width, height)
	if ScreenAnchors[obstacleName] ~= nil then
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		Move({
			Ids = ScreenAnchors[obstacleName],
			Angle = 90,
			Distance = JowdayDPS.LastDpsBackgroundPosition.y -
				y,
			Speed = 1000
		})
	else
		ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "rectangle01", X = x, Y = y }) -- width 480, height 267
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		SetColor({ Id = ScreenAnchors[obstacleName], Color = { 0.090, 0.055, 0.157, 0.6 } })
	end
	JowdayDPS.LastDpsBackgroundPosition.y = y
end

-- Create a single DPS bar with damage source, damage amount, and damage portion labels
function JowdayDPS.createDpsBar(label, damage, maxDamage, totalDamage, x, y, colors)
	local portion = damage / totalDamage
	local scale = damage / maxDamage * .6
	local dpsBar = CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })
	SetAnimation({ Name = "BarGraphBar", DestinationId = dpsBar.Id })
	JowdayDPS.DpsBars["DpsBar" .. label] = dpsBar

	CreateTextBox({
		Id = dpsBar.Id,
		Text = label,
		OffsetX = -30,
		OffsetY = -1,
		Font = "AlegreyaSansSCBold",
		FontSize = 14,
		Justification = "Right",
		Color = colors[3]
	})
	ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })

	-- Scale damage bar
	SetScaleX({ Id = dpsBar.Id, Fraction = scale, Duration = 0.0 })
	-- color damage bar
	SetColor({ Id = dpsBar.Id, Color = colors[1] })

	-- Create damage total label
	if scale > .06 then
		CreateTextBox({
			Id = dpsBar.Id,
			Text = damage,
			OffsetX = 320 * scale - 4,
			OffsetY = 0,
			Font = "AlegreyaSansSCBold",
			FontSize = 10,
			Justification = "Right",
			Color = colors[2]
		})
		ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })
	end

	-- Create damage portion percentage label
	CreateTextBox({
		Id = dpsBar.Id,
		Text = "(" .. math.floor(portion * 100 + .5) .. "%)",
		OffsetX = 320 * scale + 20,
		OffsetY = -1,
		Font = "AlegreyaSansSCBold",
		FontSize = 14,
		Justification = "Left"
	})
	ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })
end

-- Create a header that shows overall DPS and overall damage total
function JowdayDPS.createDpsHeader(obstacleName, totalDamage, dps, x, y)
	local text = dps .. " DPS  |  Total Damage: " .. totalDamage

	if ScreenAnchors[obstacleName] ~= nil then
		ModifyTextBox({ Id = ScreenAnchors[obstacleName], Text = text })
		Move({ Ids = ScreenAnchors[obstacleName], Angle = 90, Distance = JowdayDPS.LastDpsPosition.y - y, Speed = 1000 })
	else
		ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "BlankObstacle", X = x, Y = y })
		CreateTextBox({
			Id = ScreenAnchors[obstacleName],
			Text = text,
			OffsetX = 0,
			OffsetY = 0,
			Font = "AlegreyaSansSCBold",
			FontSize = 14,
			Justification = "Left"
		})
		ModifyTextBox({ Id = ScreenAnchors[obstacleName], FadeTarget = 1, FadeDuration = 0.0 })
	end

	JowdayDPS.LastDpsPosition.y = y
end

function JowdayDPS.checkEnemyBucket(source)
	for k, v in pairs(JowdayDPS.EnemyBucket) do
		if source:match("^" .. v) then
			return true
		end
	end
	return false
end

-- currently only replaces cast names
function JowdayDPS.getEquippedBoons(trait)
	local slot = trait.Slot or nil
	local name = trait.Name or nil
	if slot == "Ranged" then
		JowdayDPS.NameLookup["RangedWeapon"] = name
	end
end

function JowdayDPS.findColor(source)
	local sources = JowdayDPS.SourceLookup
	local colors = JowdayDPS.DpsColors

	for name in pairs(sources) do
		if JowdayDPS.hasValue(sources[name], source) then
			return colors[name]
		end
	end
	return colors["Default"]
end

function JowdayDPS.hasValue(tab, val)
	for i, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

--[[
OVERRIDES ------------------------------------------
]]

-- After the damage enemy call, record the instance of damage
ModUtil.Path.Wrap("DamageEnemy", function(baseFunc, victim, triggerArgs)
	local preHitHealth = victim.Health
	baseFunc(victim, triggerArgs)
	if (triggerArgs.DamageAmount or 0) > 0 and victim.MaxHealth ~= nil and (triggerArgs.TriggeredByTable.GenusName == "NPC_Skelly_01" or (triggerArgs.TriggeredByTable.GeneratorData or {}).DifficultyRating ~= nil or triggerArgs.TriggeredByTable.CanBeAggroed or triggerArgs.TriggeredByTable.IsBoss) then
		local damageInstance = {}
		damageInstance.Damage = math.min(preHitHealth, triggerArgs.DamageAmount)
		damageInstance.Timestamp = GetTime({})

		-- Check damage source and set its name based on priority EffectName > SourceWeapon > triggerArgs.AttackerWeaponData.Name
		-- If still nil, if the attack was an obstacle, assume it was due to wall slam damage

		-- get an internal name from either SourceWeapon or EffectName
		local source
		if triggerArgs.SourceWeapon ~= nil then
			source = triggerArgs.SourceWeapon
		end
		if triggerArgs.EffectName ~= nil then
			source = triggerArgs.EffectName
		end

		-- if enemy damage is showing up, you either deflected or charmed
		if source ~= nil then
			local isEnemy = JowdayDPS.checkEnemyBucket(source)
			-- wretched thug deflect is a weird exception
			if isEnemy == true or source == "Wretched Thug" then
				source = "Enemy Deflect/Charm"
			end
		end

		-- if no name and an obstacle is present, assume wall slam
		if source == nil and triggerArgs.AttackerIsObstacle then
			source = "Wall Slam"
		end

		-- if damage source is none of the above, just store it as Unknown
		if source == nil then
			source = "Unknown"
		end

		-- try and match with the name lookup table
		source = JowdayDPS.NameLookup[source] or source

		-- finally, put it in the table
		damageInstance.Source = source

		JowdayDPS.List.addValue(JowdayDPS.DamageHistory, damageInstance)
	end
end, JowdayDPS)

-- When room is unlocked, stop the DPS meter from updating and clear it to prep for next room
ModUtil.Path.Wrap("DoUnlockRoomExits", function(baseFunc, run, room)
	baseFunc(run, room)
	JowdayDPS.DpsUpdateThread = false
	JowdayDPS.calculateDps(JowdayDPS.DamageHistory)
	JowdayDPS.List.emptyList(JowdayDPS.DamageHistory)
end, JowdayDPS)

-- at the start of each room, check for equipped traits to hopefully generate more specific names
ModUtil.Path.Wrap("StartRoom", function(baseFunc, run, room)
	-- reset cast name to default first
	JowdayDPS.NameLookup["RangedWeapon"] = "Cast"
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		JowdayDPS.getEquippedBoons(trait)
	end
	baseFunc(run, room)
end, JowdayDPS)

-- Set up a polling loop to update our dps calculation
OnAnyLoad { function()
	if JowdayDPS.DpsUpdateThread then return end
	JowdayDPS.DpsUpdateThread = true
	thread(function()
		while JowdayDPS.DpsUpdateThread do
			-- If in the courtyard, reset your DPS after 5 seconds with no damage dealt
			if ModUtil.Path.Get("CurrentDeathAreaRoom") and JowdayDPS.DamageHistory[JowdayDPS.DamageHistory.last] ~= nil then
				if GetTime({}) - JowdayDPS.DamageHistory[JowdayDPS.DamageHistory.last].Timestamp > 5 then
					JowdayDPS.List.emptyList(JowdayDPS.DamageHistory)
				end
			end

			-- Otherwise continuously update
			JowdayDPS.calculateDps(JowdayDPS.DamageHistory)
			wait(.2)
		end
	end)
end }
