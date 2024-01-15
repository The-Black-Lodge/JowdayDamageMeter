ModUtil.RegisterMod("EllosPunchingBag")

local config = {
	DpsInterval = 99999999
}
EllosPunchingBag.config = config

EllosPunchingBag.List = {}
function EllosPunchingBag.List.new(maxSize)
	return { first = 0, last = -1, count = 0, max = maxSize }
end

function EllosPunchingBag.List.addValue(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
	list.count = list.count + 1
	if list.count > list.max then
		EllosPunchingBag.List.removeHead(list)
	end
end

function EllosPunchingBag.List.removeHead(list)
	local first = list.first
	if first > list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil -- to allow garbage collection
	list.first = first + 1
	list.count = list.count - 1
	return value
end

function EllosPunchingBag.List.emptyList(list)
	while list.count > 0 do
		EllosPunchingBag.List.removeHead(list)
	end
end

EllosPunchingBag.DamageHistory = EllosPunchingBag.List.new(10000) -- 100 * config.DpsInterval )
EllosPunchingBag.DpsUpdateThread = false
EllosPunchingBag.DpsBars = {}
EllosPunchingBag.LastDpsPosition = {}
EllosPunchingBag.LastDpsBackgroundPosition = {}

--[[
HELPER FUNCTIONS ------------------------------------------
]]
function calculateDps(list)
	-- Dum up damage dealt from each source
	local totalDamage = 0
	local earliestTimestamp = 999999;
	local latestTimestamp = 0;
	local totalDamageBySource = {}
	for i = list.first, list.last do
		local damageData = list[i]
		local time = GetTime({})
		if damageData.Timestamp > (time - config.DpsInterval) then
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
	sourcesSortedByDamage = {}
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
	for bar, component in pairs(EllosPunchingBag.DpsBars) do
		Destroy({ Id = component.Id })
		EllosPunchingBag.DpsBars[bar] = nil
	end

	-- Create UI to show DPS bars for each source
	for i, source in ipairs(sourcesSortedByDamage) do
		colors = findColor(source)
		createDpsBar(source, totalDamageBySource[source], maxDamage, totalDamage, xPos, yPos, colors)
		yPos = yPos - 20
	end

	-- Show the DPS menu only if there are recorded instances of damage, otherwise destroy
	if #sourcesSortedByDamage > 0 then
		createDpsHeader("DpsMeter", totalDamage, dps, xPos, yPos - 5)
		local margin = 40
		local width = 500
		local height = (initialY - yPos + margin)
		createDpsOverlayBackground("DpsBackground", xPos + margin, yPos - 20 + height / 2, width, height)
	else
		Destroy({ Id = ScreenAnchors["DpsMeter"] })
		Destroy({ Id = ScreenAnchors["DpsBackground"] })
		ScreenAnchors["DpsMeter"] = nil
		ScreenAnchors["DpsBackground"] = nil
	end
end

-- Creates a transparent background behind the dps.  Resizes and moves the existing component if this is called with new height and position
function createDpsOverlayBackground(obstacleName, x, y, width, height)
	if ScreenAnchors[obstacleName] ~= nil then
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		Move({
			Ids = ScreenAnchors[obstacleName],
			Angle = 90,
			Distance = EllosPunchingBag.LastDpsBackgroundPosition.y -
				y,
			Speed = 1000
		})
	else
		ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "rectangle01", X = x, Y = y }) -- width 480, height 267
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		SetColor({ Id = ScreenAnchors[obstacleName], Color = { 0.090, 0.055, 0.157, 0.6 } })
	end
	EllosPunchingBag.LastDpsBackgroundPosition.y = y
end

-- Create a single DPS bar with damage source, damage amount, and damage portion labels
function createDpsBar(label, damage, maxDamage, totalDamage, x, y, colors)
	local portion = damage / totalDamage
	local scale = damage / maxDamage * .6
	local dpsBar = CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })
	SetAnimation({ Name = "BarGraphBar", DestinationId = dpsBar.Id })
	EllosPunchingBag.DpsBars["DpsBar" .. label] = dpsBar

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
function createDpsHeader(obstacleName, totalDamage, dps, x, y)
	fontSize = 14
	color = Color.White
	local text = dps .. " DPS  |  Total Damage: " .. totalDamage

	if ScreenAnchors[obstacleName] ~= nil then
		ModifyTextBox({ Id = ScreenAnchors[obstacleName], Text = text })
		Move({ Ids = ScreenAnchors[obstacleName], Angle = 90, Distance = EllosPunchingBag.LastDpsPosition.y - y, Speed = 1000 })
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

	EllosPunchingBag.LastDpsPosition.y = y
end

function checkEnemyBucket(source)
	for k, v in pairs(EllosPunchingBag.EnemyBucket) do
		if source:match("^" .. v) then
			return true
		end
	end
	return false
end

-- currently only replaces cast names
function getEquippedBoons(trait)
	local slot = trait.Slot or nil
	local name = trait.Name or nil
	if slot == "Ranged" then
		EllosPunchingBag.NameLookup["RangedWeapon"] = name
	end
end

function findColor(source)
	local sources = EllosPunchingBag.SourceLookup
    local colors = EllosPunchingBag.DpsColors
	
	for name in pairs(sources) do
		if has_value(sources[name], source) then
			return colors[name]
		end
	end
	return colors["Default"]
end

function has_value(tab, val)
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
ModUtil.WrapBaseFunction("DamageEnemy", function(baseFunc, victim, triggerArgs)
	local preHitHealth = victim.Health
	baseFunc(victim, triggerArgs)
	--print(TableToJSONString(triggerArgs))
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
            local isEnemy = checkEnemyBucket(source)
			-- wretched thug deflect is a weird exception
			if isEnemy == true or source == "Wretched Thug" then
				DebugPrint({ Text = source })
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
		source = EllosPunchingBag.NameLookup[source] or source

		-- finally, put it in the table
		damageInstance.Source = source

		EllosPunchingBag.List.addValue(EllosPunchingBag.DamageHistory, damageInstance)
	end
end, EllosPunchingBag)

-- When room is unlocked, stop the DPS meter from updating and clear it to prep for next room
ModUtil.WrapBaseFunction("DoUnlockRoomExits", function(baseFunc, run, room)
	baseFunc(run, room)
	EllosPunchingBag.DpsUpdateThread = false
	calculateDps(EllosPunchingBag.DamageHistory)
	EllosPunchingBag.List.emptyList(EllosPunchingBag.DamageHistory)
end, EllosPunchingBag)

-- at the start of each room, check for equipped traits to hopefully generate more specific names
ModUtil.WrapBaseFunction("StartRoom", function(baseFunc, run, room)
	-- reset cast name to default first
	EllosPunchingBag.NameLookup["RangedWeapon"] = "Cast"
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		getEquippedBoons(trait)
	end
	baseFunc(run, room)
end, EllosPunchingBag)

-- Set up a polling loop to update our dps calculation
OnAnyLoad { function()
	if EllosPunchingBag.DpsUpdateThread then return end
	EllosPunchingBag.DpsUpdateThread = true
	thread(function()
		while EllosPunchingBag.DpsUpdateThread do
			-- If in the courtyard, reset your DPS after 5 seconds with no damage dealt
			if ModUtil.PathGet("CurrentDeathAreaRoom") and EllosPunchingBag.DamageHistory[EllosPunchingBag.DamageHistory.last] ~= nil then
				if GetTime({}) - EllosPunchingBag.DamageHistory[EllosPunchingBag.DamageHistory.last].Timestamp > 5 then
					EllosPunchingBag.List.emptyList(EllosPunchingBag.DamageHistory)
				end
			end

			-- Otherwise continuously update
			calculateDps(EllosPunchingBag.DamageHistory)
			wait(.2)
		end
	end)
end }
