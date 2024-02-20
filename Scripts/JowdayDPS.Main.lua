JowdayDPS = ModUtil.Mod.Register("JowdayDPS")
JowdayDPS.Config = {
	DpsInterval = 99999999,
	ShowIcons = true
}

JowdayDPS.List = {}
-- List functions
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
JowdayDPS.CurrentGods = {}
JowdayDPS.WeaponVar = {}
JowdayDPS.DpsUpdateThread = false
JowdayDPS.DpsBars = {}
JowdayDPS.DpsIcons = {}
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

	for bar, component in pairs(JowdayDPS.DpsIcons) do
		Destroy({ Id = component.Id })
		JowdayDPS.DpsIcons[bar] = nil
	end

	-- Create UI to show DPS bars for each source
	for i, source in ipairs(sourcesSortedByDamage) do
		JowdayDPS.createDpsBar(source, math.floor(totalDamageBySource[source] + 0.5), maxDamage, totalDamage, xPos, yPos)
		yPos = yPos - 20
	end

	-- Show the DPS menu only if there are recorded instances of damage, otherwise destroy
	if #sourcesSortedByDamage > 0 then
		JowdayDPS.createDpsHeader("DpsMeter", math.floor(totalDamage + 0.5), dps, xPos, yPos - 5)
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

function JowdayDPS.checkEnemyBucket(source)
	for k, v in pairs(JowdayDPS.EnemyBucket) do
		if source:match("^" .. v) then
			return true
		end
	end
	return false
end

-- add more accurate names, and build an array of gods
function JowdayDPS.getEquippedBoons(trait)
	local slot = trait.Slot or nil
	local name = trait.Name or nil
	local god = trait.God or nil

	if slot == "Melee" and god then
		JowdayDPS.WeaponVar["Attack"] = god
	end
	if slot == "Secondary" and god then
		JowdayDPS.WeaponVar["Special"] = god
	end
	if slot == "Ranged" and name then
		if god ~= nil then
			JowdayDPS.WeaponVar["Cast"] = god
		end
		JowdayDPS.NameLookup["RangedWeapon"] = name
	end
	if slot == "Rush" and name then
		if god ~= nil then
			JowdayDPS.WeaponVar["Dash"] = god
		end
		JowdayDPS.NameLookup["RushWeapon"] = name
		-- artemis modifies dash-strike instead
		if name == "ArtemisRushTrait" then
			JowdayDPS.WeaponVar["HunterDash"] = true
		end
	end
	-- most boons have a God value in the trait
	if god ~= nil then
		JowdayDPS.CurrentGods[god] = true
	end
	-- ...some custom handling here
	if name ~= nil then
		-- this doesn't add athena to CurrentGods which is needed for deflect accuracy
		if name == "AthenaRetaliateTrait" then
			JowdayDPS.CurrentGods["Athena"] = true
		end
		if name == "ShieldLoadAmmoTrait" then
			JowdayDPS.WeaponVar["Beowulf"] = true
		end
	end
end

-- reset attack, special, cast, etc.
function JowdayDPS.clearWeaponInfo()
	JowdayDPS.NameLookup["RangedWeapon"] = "Cast"
	JowdayDPS.WeaponVar["HunterDash"] = false
	JowdayDPS.WeaponVar["Attack"] = nil
	JowdayDPS.WeaponVar["Special"] = nil
	JowdayDPS.WeaponVar["Cast"] = nil
	JowdayDPS.WeaponVar["Dash"] = nil

	-- also reset god list
	JowdayDPS.CurrentGods = {}
end

function JowdayDPS.getAttackerEffects(triggerArgs)
	if triggerArgs.AttackerTable ~= nil then
		local attacker = triggerArgs.AttackerTable
		if attacker.ActiveEffects then
			return attacker.ActiveEffects
		end
	end
	return nil
end

function JowdayDPS.getSourceName(triggerArgs)
	-- determine if the attacker table is present, and if it is make the active effects available
	local effects = JowdayDPS.getAttackerEffects(triggerArgs)

	-- get an internal name from either SourceWeapon or EffectName
	local source
	if triggerArgs.SourceWeapon ~= nil then
		source = triggerArgs.SourceWeapon
	end
	if triggerArgs.EffectName ~= nil then
		source = triggerArgs.EffectName
	end

	-- determine if the attacker was charmed when damage was dealt. if so, mark the damage as such
	if effects ~= nil then
		if effects.Charm ~= nil then
			source = "Charm"
		end
	end

	-- at this point, named damage is most likely deflect if it matches an enemy name, isn't charm, and isn't an explosive
	if source ~= nil and source ~= "Charm" and source ~= "Enemy Explosive" then
		local isEnemy = JowdayDPS.checkEnemyBucket(source)
		if isEnemy == true then
			-- put in the deflect bucket only if the user has an athena boon
			if JowdayDPS.CurrentGods.Athena ~= nil then
				source = "Deflect"
			else
				-- otherwise, you probably pushed something into a blast radius
				source = "Enemy Explosive"
			end
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

	-- fix poseidon, dionysus flares showing up incorrectly
	if JowdayDPS.WeaponVar.Beowulf ~= nil then
		if source == "PoseidonRangedTrait" then
			source = "Flood Flare"
		end
		if source == "DionysusRangedTrait" then
			source = "Trippy Flare"
		end
	end
	return source
end

-- UI functions
-- Creates a transparent background behind the dps.  Resizes and moves the existing component if this is called with new height and position
function JowdayDPS.createDpsOverlayBackground(obstacleName, x, y, width, height)
	if ScreenAnchors[obstacleName] ~= nil then
		SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = width / 480 })
		SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = height / 267 })
		Move({
			Ids = ScreenAnchors[obstacleName],
			Angle = 90,
			Distance = JowdayDPS.LastDpsBackgroundPosition.y - y,
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

-- Create a header that shows overall DPS and overall damage total
function JowdayDPS.createDpsHeader(obstacleName, totalDamage, dps, x, y)
	local text = dps .. " DPS / Total Damage: " .. totalDamage

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
			Justification = "Left",
			Color = Color.White,
			OutlineThickness = 2.0,
			OutlineColor = Color.Black,
			ShadowOffset = { 1, 2 },
			ShadowBlur = 0,
			ShadowAlpha = 1,
			ShadowColor = Color.Black
		})
		ModifyTextBox({ Id = ScreenAnchors[obstacleName], FadeTarget = 1, FadeDuration = 0.0 })
	end

	JowdayDPS.LastDpsPosition.y = y
end

-- Create a single DPS bar with damage source, damage amount, and damage portion labels
function JowdayDPS.createDpsBar(label, damage, maxDamage, totalDamage, x, y)
	local colors = JowdayDPS.findColor(label)
	local portion = damage / totalDamage
	local scale = damage / maxDamage * .6
	local percentDamage = math.floor(portion * 100 + .5)
	local dpsBar = CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })

	local labelColor = colors["LabelColor"] or Color.White
	local barColor = colors["BarColor"] or Color.White

	SetAnimation({ Name = "BarGraphBar", DestinationId = dpsBar.Id })
	JowdayDPS.DpsBars["DpsBar" .. label] = dpsBar

	-- name label
	CreateTextBox({
		Id = dpsBar.Id,
		Text = label,
		OffsetX = -33,
		OffsetY = -1,
		Font = "AlegreyaSansSCBold",
		FontSize = 14,
		Justification = "Right",
		Color = labelColor,
		OutlineThickness = 2.0,
		OutlineColor = Color.Black,
		ShadowOffset = { 1, 2 },
		ShadowBlur = 0,
		ShadowAlpha = 1,
		ShadowColor = Color.Black,
	})
	ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })

	-- Scale damage bar
	SetScaleX({ Id = dpsBar.Id, Fraction = scale, Duration = 0.0 })
	-- color damage bar
	SetColor({ Id = dpsBar.Id, Color = barColor })

	-- Create damage total label
	if scale > .07 then
		CreateTextBox({
			Id = dpsBar.Id,
			Text = damage,
			OffsetX = 320 * scale - 4,
			OffsetY = -1,
			Font = "AlegreyaSansSCBold",
			FontSize = 10,
			Justification = "Right",
			Color = Color.White,
			OutlineThickness = 2.0,
			OutlineColor = Color.Black,
			ShadowOffset = { 1, 2 },
			ShadowBlur = 0,
			ShadowAlpha = 1,
			ShadowColor = Color.Black
		})
		ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })
	end

	-- Create damage portion percentage label
	CreateTextBox({
		Id = dpsBar.Id,
		Text = percentDamage .. "%",
		OffsetX = 320 * scale + 20,
		OffsetY = -1,
		Font = "AlegreyaSansSCBold",
		FontSize = 14,
		Justification = "Left",
		Color = Color.White,
		OutlineThickness = 2.0,
		OutlineColor = Color.Black,
		ShadowOffset = { 1, 2 },
		ShadowBlur = 0,
		ShadowAlpha = 1,
		ShadowColor = Color.Black
	})
	ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })

	-- add icons
	if JowdayDPS.Config.ShowIcons == true then
		JowdayDPS.generateBarIcons(colors, label, dpsBar)
	end
end

-- determines bar color/icons
function JowdayDPS.findColor(source)
	local sources = JowdayDPS.SourceLookup
	local colors = JowdayDPS.DpsColors
	local attack = JowdayDPS.WeaponVar["Attack"]
	local special = JowdayDPS.WeaponVar["Special"]

	if attack ~= nil and JowdayDPS.Attacks[source] ~= nil then
		return colors[attack]
	end
	if special ~= nil and JowdayDPS.Specials[source] ~= nil then
		return colors[special]
	end
	for name in pairs(sources) do
		if sources[name][source] ~= nil then
			return colors[name]
		end
	end
	return colors["Default"]
end

-- add icons to the bar if available
function JowdayDPS.generateBarIcons(colors, label, dpsBar)
	local godIcons = ShallowCopyTable(colors["Icons"])
	-- weird artemis handling
	if label == "Dash-Strike" and JowdayDPS.WeaponVar["HunterDash"] == true and godIcons == nil then
		godIcons = {}
		table.insert(godIcons, 1, "Artemis")
	end



	if godIcons ~= nil then
		-- set default icon scaling
		local scale1 = 0.1
		local scale2 = 0.1
		-- olympus extra
		-- hestia's icon is quite large
		if godIcons[1] == "Hestia" then
			scale1 = 0.06
		end
		if godIcons[2] ~= nil and godIcons[2] == "Hestia" then
			scale2 = 0.06
		end
		-- apollo's is a little too big as well
		if godIcons[1] == "Apollo" then
			scale1 = 0.08
		end
		if godIcons[2] ~= nil and godIcons[2] == "Apollo" then
			scale2 = 0.08
		end

		-- there is one special case where dash-strike damage can be modified by both artemis and whatever god is on attack. if this is the case, tack on the artemis icon after
		if label == "Dash-Strike" and JowdayDPS.WeaponVar["HunterDash"] == true then
			if godIcons[1] ~= "Artemis" then
				table.insert(godIcons, 1, "Artemis")
			end
		end

		-- if one icon, center it
		local iconOffset = -18
		-- if two, make room for both
		if #godIcons == 2 then
			iconOffset = -10
		end

		local dpsIcon1 = CreateScreenComponent({ Name = "BlankObstacle" })
		SetAnimation({ Name = "BoonInfoSymbol" .. godIcons[1] .. "Icon", DestinationId = dpsIcon1.Id, Scale = scale1 })
		JowdayDPS.DpsIcons["DpsIcon" .. label] = dpsIcon1
		-- if it's a duo, add the icon and attach it
		if #godIcons > 1 then
			local dpsIcon2 = CreateScreenComponent({ Name = "BlankObstacle" })
			SetAnimation({ Name = "BoonInfoSymbol" .. godIcons[2] .. "Icon", DestinationId = dpsIcon2.Id, Scale = scale2 })
			JowdayDPS.DpsIcons["DpsIconDuo" .. label] = dpsIcon2
			Attach({ Id = dpsIcon2.Id, DestinationId = dpsIcon1.Id, OffsetX = -13 })
		end
		-- anchor to the given dps bar
		Attach({ Id = dpsIcon1.Id, DestinationId = dpsBar.Id, OffsetX = iconOffset })
	end
end

-- overrides
-- After the damage enemy call, record the instance of damage
ModUtil.Path.Wrap("DamageEnemy", function(baseFunc, victim, triggerArgs)
	local preHitHealth = victim.Health
	baseFunc(victim, triggerArgs)
	if (triggerArgs.DamageAmount or 0) > 0
		and victim.MaxHealth ~= nil
		and (triggerArgs.TriggeredByTable.GenusName == "NPC_Skelly_01"
			or (triggerArgs.TriggeredByTable.GeneratorData or {}).DifficultyRating ~= nil
			or triggerArgs.TriggeredByTable.CanBeAggroed
			or triggerArgs.TriggeredByTable.IsBoss)
	then
		local damageInstance = {}
		damageInstance.Damage = math.min(preHitHealth, triggerArgs.DamageAmount)
		damageInstance.Timestamp = GetTime({})
		damageInstance.Source = JowdayDPS.getSourceName(triggerArgs)

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
	JowdayDPS.clearWeaponInfo()
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

-- empty out god data when you die so the meter isn't confused in skelly's room
OnAnyLoad { "DeathArea", function() JowdayDPS.clearWeaponInfo() end }
