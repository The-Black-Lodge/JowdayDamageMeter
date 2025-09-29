---@meta _
---@diagnostic disable

local mod = JowdayDPS

local function setupMainData()
    mod.CurrentLocale = GetLanguage()
    mod.Locale = setmetatable({}, {
        __index = function(_, k)
            return mod.GetLanguageString(k)
        end
    })
end

function mod.UpdateScreenData()
    if mod.CurrentLocale ~= GetLanguage() then
        mod.CurrentLocale = GetLanguage()
    end
    mod.getLocalizedNames()
end

mod.List = {}
-- List functions
function mod.List.new(maxSize)
    return { first = 0, last = -1, count = 0, max = maxSize }
end

function mod.List.addValue(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
    list.count = list.count + 1
    if list.count > list.max then
        mod.List.removeHead(list)
    end
end

function mod.List.removeHead(list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil -- to allow garbage collection
    list.first = first + 1
    list.count = list.count - 1
    return value
end

function mod.List.emptyList(list)
    while list.count > 0 do
        mod.List.removeHead(list)
    end
end

mod.DamageHistory = mod.List.new(10000)
mod.CurrentGods = {}
mod.WeaponVar = {}
mod.DpsUpdateThread = false
mod.DpsBars = {}
mod.DpsIcons = {}
mod.LastDpsPosition = {}
mod.LastDpsBackgroundPosition = {}
local dpsInterval = 999999

-- damage/data functions
function mod.calculateDps(list)
    -- sum up damage dealt from each source
    local totalDamage = 0
    local earliestTimestamp = 999999;
    local latestTimestamp = 0;
    local totalDamageBySource = {}
    for i = list.first, list.last do
        local damageData = list[i]
        local time = GetTime({})
        if damageData.Timestamp > (time - dpsInterval) then
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

    -- sort sources from most damage to least
    local dps = round(totalDamage / (latestTimestamp - earliestTimestamp))
    local sourcesSortedByDamage = {}
    for source in pairs(totalDamageBySource) do table.insert(sourcesSortedByDamage, source) end
    table.sort(sourcesSortedByDamage, function(a, b)
        return totalDamageBySource[a] < totalDamageBySource[b]
    end)
    local maxDamage = totalDamageBySource[sourcesSortedByDamage[#sourcesSortedByDamage]]

    -- Delete any existing UI (e.g the bars from last update)
    -- TODO: Consider resizing / renaming bars instead of destroying and recreating (no performance issues so far though)
    for bar, component in pairs(mod.DpsBars) do
        Destroy({ Id = component.Id })
        mod.DpsBars[bar] = nil
    end

    for bar, component in pairs(mod.DpsIcons) do
        Destroy({ Id = component.Id })
        mod.DpsIcons[bar] = nil
    end
    if mod.Config.ShowMeter
        and (
            not mod.Config.CarrotMode
            or (
                mod.Config.CarrotMode
                and not mod.DpsUpdateThread
            )
            or ModUtil.Path.Get("CurrentHubRoom.Name") == "Hub_PreRun"
        ) then
        local yPos = mod.Config.InitialY
        -- Create UI to show DPS bars for each source
        for i, source in ipairs(sourcesSortedByDamage) do
            local barDamageRounded = math.floor(totalDamageBySource[source] + 0.5)
            mod.createDpsBar(
                source,
                barDamageRounded,
                maxDamage,
                totalDamage,
                mod.Config.XPosition,
                yPos
            )
            yPos = yPos + mod.Config.YPositionIncrement
        end

        -- Show the DPS menu only if there are recorded instances of damage, otherwise destroy
        if #sourcesSortedByDamage > 0 then
            local totalDamageRounded = math.floor(totalDamage + 0.5)
            mod.createDpsHeader(
                "DpsMeter",
                totalDamageRounded,
                dps,
                mod.Config.XPosition,
                yPos - 5
            )
            local height = (mod.Config.InitialY - yPos + mod.Config.Margin)
            local yPosOverlay = yPos + mod.Config.YPositionIncrement + height / 2
            mod.createDpsOverlayBackground(
                "DpsBackground",
                mod.Config.XPosition + mod.Config.Margin,
                yPosOverlay,
                mod.Config.DisplayWidth,
                height
            )
        else
            Destroy({ Id = ScreenAnchors["DpsMeter"] })
            Destroy({ Id = ScreenAnchors["DpsBackground"] })
            ScreenAnchors["DpsMeter"] = nil
            ScreenAnchors["DpsBackground"] = nil
        end
    else
        Destroy({ Id = ScreenAnchors["DpsMeter"] })
        Destroy({ Id = ScreenAnchors["DpsBackground"] })
        ScreenAnchors["DpsMeter"] = nil
        ScreenAnchors["DpsBackground"] = nil
    end
end

-- there is no longer a God attribute on traits, so here we are
function mod.godMatcher(name)
    if name == nil then return end

    if name:match("Apollo") then return "Apollo" end
    if name:match("Aphrodite") then return "Aphrodite" end
    if name:match("Ares") then return "Ares" end
    if name:match("Artemis") then return "Artemis" end
    if name:match("Athena") then return "Athena" end
    if name:match("Demeter") then return "Demeter" end
    if name:match("Dionysus") then return "Dionysus" end
    if name:match("Hera") then return "Hera" end
    if name:match("Hephaestus") then return "Hephaestus" end
    if name:match("Hestia") then return "Hestia" end
    if name:match("Poseidon") then return "Poseidon" end
    if name:match("Selene") then return "Selene" end
    if name:match("Zeus") then return "Zeus" end
end

-- -- add more accurate names, and build an array of gods
function mod.getEquippedBoons(trait)
    local slot = trait.Slot or ''
    local name = trait.Name or ''
    local god = mod.godMatcher(name) or ''

    if slot == "Melee" and god then
        mod.WeaponVar["Attack"] = god
    end
    if slot == "Secondary" and god then
        mod.WeaponVar["Special"] = god
    end
    if slot == "Ranged" and name then
        if god ~= nil then
            mod.WeaponVar["Cast"] = god
        end
        mod.NameLookup["RangedWeapon"] = name
    end
    if slot == "Rush" and name then
        if god ~= nil then
            mod.WeaponVar["Dash"] = god
        end
    end
    -- most boons have a God value in the trait
    if god ~= nil then
        mod.CurrentGods[god] = true
    end
    -- check for Knuckle Bone uses
    if name ~= nil and name == 'BossPreDamageKeepsake' and trait.Uses ~= nil and trait.Uses > 0 then
        mod.WeaponVar["KnuckleBones"] = trait.ReportedDamage
    end
    -- check for Old Grudge
    if name ~= nil and name == 'HadesPreDamageBoon' and trait.Uses ~= nil and trait.Uses > 0 then
        mod.WeaponVar["OldGrudge"] = trait.ReportedDamage
    end

    if mod.WeaponVar["KnuckleBones"] ~= nil or mod.WeaponVar["OldGrudge"] ~= nil then
        mod.WeaponVar["BossPreDamage"] = true
    end
end

-- reset attack, special, cast, etc.
function mod.clearWeaponInfo()
    mod.NameLookup["RangedWeapon"] = "Cast"
    mod.WeaponVar["Attack"] = nil
    mod.WeaponVar["Special"] = nil
    mod.WeaponVar["Cast"] = nil
    mod.WeaponVar["Dash"] = nil
    mod.WeaponVar["KnuckleBones"] = nil
    mod.WeaponVar["OldGrudge"] = nil
    mod.WeaponVar["BossPreDamage"] = nil

    -- also reset god list
    mod.CurrentGods = {}
end

-- partial name lookup - consolidates attack/special/etc. into single types
function mod.getSourceName(triggerArgs, victim)
    local attackerWeaponData = triggerArgs.AttackerWeaponData or {}
    local attackerTable = triggerArgs.AttackerTable or {}
    local activeEffects = attackerTable.ActiveEffects or {}
    local activeEffectsStart = attackerTable.ActiveEffectsAtDamageStart or {}
    local source = 'Unknown'
    -- WeaponName > EffectName > SourceProjectile > SourceWeapon > LinkedUpgrades > name lookup
    source = triggerArgs.WeaponName or source
    source = triggerArgs.EffectName or source
    source = triggerArgs.SourceProjectile or source
    -- stop here if ApolloCast
    if source ~= 'ApolloCast' then
        source = triggerArgs.SourceWeapon or source
        source = attackerWeaponData.LinkedUpgrades or source
    end

    -- investigate further, but special handling for divine dash
    if (triggerArgs.SourceProjectile == 'AthenaRushProjectile') then source = 'AthenaRushProjectile' end

    if mod.Config.SplitDashStrike == true then
        local sourceProjectile = triggerArgs.SourceProjectile or nil
        if sourceProjectile ~= nil then
            for k, v in pairs(mod.DashStrikeLookup) do
                if sourceProjectile:match(v) then
                    source = 'AttackDashStrike'
                end
            end
        end
    end

    -- ares is acting weird
    if source == 'AresProjectile' then source = 'OCastAres' end
    if mod.Config.SplitOmega == true then
        local sourceProjectile = triggerArgs.SourceProjectile or nil
        local sourceWeapon = triggerArgs.SourceWeapon or nil
        local isAttackEX = false
        local isSpecialEX = false
        if sourceWeapon ~= nil then
            for k, v in pairs(mod.AttackEXLookup) do
                if sourceWeapon:match(v) or sourceProjectile:match(v) then
                    isAttackEX = true
                end
            end
            for k, v in pairs(mod.SpecialEXLookup) do
                if sourceWeapon:match(v) or sourceProjectile:match(v) then
                    isSpecialEX = true
                end
            end
            if isAttackEX == true then
                source = "OAttack"
            elseif isSpecialEX == true then
                source = "OSpecial"
            end
        end
    end

    source = mod.NameLookup[source] or source

    -- charm has several flavors
    if attackerTable.Charmed or activeEffects["Charm"] == 1 or activeEffectsStart["Charm"] == 1 then
        source = "Charm"
    end

    if triggerArgs.ProjectileDeflected then
        source = "ParryHit"
    end

    if source == "MedeaCurse" then
        source = triggerArgs.CurseName or "MedeaCurse"
    end

    if source == 'Unknown' then
        -- check if user has Old Grudge and/or Knuckle Bones
        if mod.WeaponVar["BossPreDamage"] ~= nil and triggerArgs.Silent and victim.IsBoss == true then
            -- old grudge
            if triggerArgs.PreDamageBossFunctionName ~= nil and triggerArgs.PreDamageBossFunctionName == "HadesPreDamagePresentation" then
                source = "OldGrudge"
                mod.WeaponVar["OldGrudge"] = nil
            end
            -- knuckle bones
            if mod.WeaponVar["KnuckleBones"] ~= nil and triggerArgs.PreDamageBossFunctionName ~= nil and triggerArgs.PreDamageBossFunctionName == "PreDamagePresentation" then
                source = "KnuckleBones"
                mod.WeaponVar["KnuckleBones"] = nil
            end
        end
    end

    return source
end

-- creates a thread that runs until we tell it not to
function mod.createPollingThread(currentHubRoom)
    thread(function()
        while mod.DpsUpdateThread do
            -- in training room only, empty list after 5 seconds of no activity
            if currentHubRoom == 'Hub_PreRun' and mod.DamageHistory[mod.DamageHistory.last] ~= nil then
                if GetTime({}) - mod.DamageHistory[mod.DamageHistory.last].Timestamp > mod.Config.TrainingRoomClearTime then
                    mod.List.emptyList(mod.DamageHistory)
                end
            end
            -- calculate dps every interval
            mod.calculateDps(mod.DamageHistory)
            wait(mod.Config.PollingInterval)
        end
    end)
end

-- UI functions
-- Creates a transparent background behind the dps. Resizes and moves the existing component if this is called with new height and position
function mod.createDpsOverlayBackground(obstacleName, x, y, width, height)
    local scaleWidth = width / (mod.Config.DisplayWidth + mod.Config.Margin)
    local scaleHeight = height / 250
    if ScreenAnchors[obstacleName] ~= nil then
        SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = scaleWidth })
        SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = scaleHeight })
        Move({
            Ids = ScreenAnchors[obstacleName],
            Angle = 90,
            Distance = mod.LastDpsBackgroundPosition.y - y,
            Speed = 1000
        })
    else
        ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "rectangle01", X = x, Y = y })
        SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = scaleWidth })
        SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = scaleHeight })
        SetColor({ Id = ScreenAnchors[obstacleName], Color = mod.Config.BackgroundColor })
    end
    mod.LastDpsBackgroundPosition.y = y
end

-- Create a header that shows overall DPS and overall damage total
function mod.createDpsHeader(obstacleName, totalDamage, dps, x, y)
    if tostring(dps) == 'inf' then dps = '···' end
    local text = dps .. mod.Locale.HeaderText .. totalDamage

    if ScreenAnchors[obstacleName] ~= nil then
        ModifyTextBox({ Id = ScreenAnchors[obstacleName], Text = text })
        Move({ Ids = ScreenAnchors[obstacleName], Angle = 90, Distance = mod.LastDpsPosition.y - y, Speed = 1000 })
    else
        ScreenAnchors[obstacleName] = CreateScreenObstacle({ Name = "BlankObstacle", X = x, Y = y })
        CreateTextBox({
            Id = ScreenAnchors[obstacleName],
            Text = text,
            OffsetX = -50,
            OffsetY = 0,
            Font = "LatoSemibold",
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

    mod.LastDpsPosition.y = y
end

-- Create a single DPS bar with damage source, damage amount, and damage portion labels
function mod.createDpsBar(label, damage, maxDamage, totalDamage, x, y)
    local colors, niceLabel = mod.getColorAndLabel(label)

    local abilityName = label
    if niceLabel ~= nil then
        abilityName = niceLabel
    end

    local portion = damage / totalDamage
    local scale = damage / maxDamage
    local percentDamage = math.floor(portion * 100 + .5)

    local labelColor = colors["LabelColor"] or Color.White
    local barColor = colors["BarColor"] or Color.White

    local dpsBar = CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })
    SetAnimation({ Name = "DpsBarWhite", DestinationId = dpsBar.Id })
    -- Scale damage bar
    SetScaleX({ Id = dpsBar.Id, Fraction = scale * 0.5, Duration = 0.0 })
    -- color damage bar
    SetColor({ Id = dpsBar.Id, Color = barColor })

    mod.DpsBars["DpsBar" .. label] = dpsBar

    local textOffsetX = -7
    if mod.Config.ShowIcons == true then textOffsetX = -25 end
    local textOffsetY = -2
    -- name label
    CreateTextBox({
        Id = dpsBar.Id,
        Text = abilityName,
        TextSymbolScale = 0.65,
        OffsetX = textOffsetX,
        OffsetY = textOffsetY,
        Font = "LatoSemibold",
        FontSize = 10,
        Justification = "Right",
        Color = labelColor,
        ShadowOffset = { 1, 1 },
        ShadowBlur = 0,
        ShadowAlpha = 1,
        ShadowColor = Color.Black,
    })

    -- damage percentage label
    CreateTextBox({
        Id = dpsBar.Id,
        Text = percentDamage .. "%",
        OffsetX = 150 * scale + 5,
        OffsetY = textOffsetY,
        Font = "LatoSemibold",
        FontSize = 10,
        Justification = "Left",
        Color = Color.White,
        ShadowOffset = { 1, 1 },
        ShadowBlur = 0,
        ShadowAlpha = 1,
        ShadowColor = Color.Black,
    })

    -- damage total label
    if scale > .2 then
        CreateTextBox({
            Id = dpsBar.Id,
            Text = damage,
            OffsetX = 1,
            OffsetY = textOffsetY,
            Font = "LatoSemibold",
            FontSize = 8,
            Justification = "Left",
            Color = Color.White,
            OutlineThickness = 1.0,
            OutlineColor = Color.Gray,
            ShadowOffset = { 1, 1 },
            ShadowBlur = 0,
            ShadowAlpha = 1,
            ShadowColor = Color.Black,
        })
    end

    -- this prevents the text from flickering/fading. it only needs to be set once
    ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })

    -- add icons
    if mod.Config.ShowIcons == true then
        mod.generateBarIcons(colors, label, dpsBar)
    end
end

-- determines colors and looks up a nice name, so the function name is no longer fully accurate
function mod.getColorAndLabel(source)
    local sources = mod.SourceLookup
    local colors = mod.DpsColors
    local attack = mod.WeaponVar["Attack"]
    local special = mod.WeaponVar["Special"]
    local cast = mod.WeaponVar["Cast"]
    local dash = mod.WeaponVar["Dash"]

    local color
    local niceLabel

    if source == 'Attack' then
        if attack ~= nil and sources[attack] ~= nil then
            color = colors[attack]
            niceLabel = sources[attack]["Attack"]
            return color, niceLabel
        else
            return colors["Default"], "Attack"
        end
    end
    if source == 'OAttack' then
        if attack ~= nil and sources[attack] ~= nil then
            color = colors[attack]
            niceLabel = sources[attack]["OAttack"]
            return color, niceLabel
        else
            return colors["Default"], mod.NameLookup.OAttackText
        end
    end

    if source == 'AttackDashStrike' then
        niceLabel = "DashStrike"
        if attack ~= nil and sources[attack] ~= nil then
            color = colors[attack]
            return color, niceLabel
        else
            return colors["Default"], niceLabel
        end
    end

    if source == 'Special' then
        if special ~= nil and sources[special] ~= nil then
            color = colors[special]
            niceLabel = sources[special]["Special"]
            return color, niceLabel
        else
            return colors["Default"], "Special"
        end
    end
    if source == 'OSpecial' then
        if special ~= nil and sources[special] ~= nil then
            color = colors[special]
            niceLabel = sources[special]["OSpecial"]
            return color, niceLabel
        else
            return colors["Default"], mod.NameLookup.OSpecialText
        end
    end

    if source == 'WeaponCast' then
        if cast ~= nil and sources[cast] ~= nil then
            color = colors[cast]
            niceLabel = sources[cast]["WeaponCast"]
            return color, niceLabel
        else
            return colors["Default"], mod.NameLookup.OCastText
        end
    end

    if source == 'Dash' then
        if dash ~= nil and sources[dash] ~= nil then
            color = colors[dash]
            niceLabel = sources[dash]["Dash"]
            return color, niceLabel
        else
            return colors["Default"], "Dash"
        end
    end

    -- color in our friends :)
    if source == 'Artemis' then
        return colors["ArtemisAssist"], "NPC_Artemis_01"
    elseif source == 'Nemesis' then
        return colors["NemesisAssist"], "NPC_Nemesis_01"
    elseif source == 'Heracles' then
        return colors["HeraclesAssist"], "NPC_Heracles_01"
    elseif source == 'Icarus' then
        return colors["IcarusAssist"], "NPC_Icarus_01"
    elseif source == "ShadeMercSpiritball" then
        return colors["Shade"], "WorldUpgradeShadeMercs"
    elseif source == "SoulPylonSpiritball" then
        return colors["Shade"], mod.Locale.EphyraPylon
    elseif source == "Frinos" then
        return colors["Frinos"], "FrogFamiliar"
    elseif source == "Toula" then
        return colors["Toula"], "CatFamiliar"
    end

    if color == nil then
        for name in pairs(sources) do
            if sources[name][source] ~= nil then
                niceLabel = sources[name][source]
                color = colors[name]
            end
        end
    end

    if color == nil then
        color = colors["Default"]
    end
    return color, niceLabel
end

-- add icons to the bar if available
function mod.generateBarIcons(colors, label, dpsBar)
    local godIcons = ShallowCopyTable(colors["Icons"])

    if godIcons ~= nil then
        -- if one icon, center it
        local iconOffsetX = -12
        -- if two, make room for both
        if #godIcons == 2 then
            iconOffsetX = -8
        end

        local dpsIcon1 = CreateScreenComponent({ Name = "BlankObstacle" })
        local icon1 = mod.Icons[godIcons[1]]
        SetAnimation({ Name = icon1.Name, DestinationId = dpsIcon1.Id, Scale = icon1.Scale })
        mod.DpsIcons["DpsIcon" .. label] = dpsIcon1
        -- if it's a duo, add the icon and attach it
        if #godIcons > 1 then
            local dpsIcon2 = CreateScreenComponent({ Name = "BlankObstacle" })
            local icon2 = mod.Icons[godIcons[2]]
            SetAnimation({ Name = icon2.Name, DestinationId = dpsIcon2.Id, Scale = icon2.Scale })
            mod.DpsIcons["DpsIconDuo" .. label] = dpsIcon2
            Attach({ Id = dpsIcon2.Id, DestinationId = dpsIcon1.Id, OffsetX = -10 })
        end
        -- anchor to the given dps bar
        Attach({ Id = dpsIcon1.Id, DestinationId = dpsBar.Id, OffsetX = iconOffsetX, OffsetY = -3 })
    end
end

-- overrides
--[[ on enemy damage:
    - create damage instance ]]
ModUtil.Path.Wrap("DamageEnemy", function(baseFunc, victim, triggerArgs)
    --print(TableToJSONString(triggerArgs))
    --print(CurrentRun.Hero.ObjectId)
    local preHitHealth = victim.Health
    baseFunc(victim, triggerArgs)
    local attackerTable = triggerArgs.AttackerTable or {}
    local activeEffects = attackerTable.ActiveEffects or {}
    local activeEffectsStart = attackerTable.ActiveEffectsAtDamageStart or {}

    local victimCharmed = IsCharmed({ Id = victim.ObjectId })
    -- don't use ingame function here because reasons
    local attackerCharmed = attackerTable.Charmed or activeEffects["Charm"] == 1 or activeEffectsStart["Charm"] == 1

    local playerWasAttacker = triggerArgs.AttackerName == "_PlayerUnit"

    local preDamage = triggerArgs.PreDamageBossFunctionName ~= nil
    local isCurse = triggerArgs.CurseName ~= nil
    --print('attackerCharmed: ' .. tostring(attackerCharmed))
    --print('victimCharmed: ' .. tostring(victimCharmed))
    --print('playerWasAttacker: ' .. tostring(playerWasAttacker))
    --print('DamageAmount: ' .. triggerArgs.DamageAmount)
    --print('checking if we log the damage...')

    -- bleh special case for scorch
    if (triggerArgs.AttackerId == CurrentRun.Hero.ObjectId) and (triggerArgs.EffectName == "BurnEffect") then
        local damageAmount = triggerArgs.DamageAmount
        if not mod.Config.CountOverkillDamage then
            damageAmount = math.min(preHitHealth, triggerArgs.DamageAmount)
        end
        mod.List.addValue(mod.DamageHistory, {Source = "Burn", Damage = damageAmount, Timestamp = GetTime({})})
        return
    end
    if (triggerArgs.DamageAmount or 0) > 0
        and victim.MaxHealth ~= nil
        and (victim.Name == "NPC_Skelly_01"
            or (victim.GeneratorData or {}).DifficultyRating ~= nil
            or victim.CanBeAggroed
            or victim.IsBoss
        )
        -- this wonky logic is to discard charmed enemies being damaged by other enemies
        -- victim is charmed, hit by NPC
        and not (victimCharmed and not playerWasAttacker)
        -- attacker is not charmed, victim is not charmed, hit by NPC, and also not a boss pre-damage boon or a medea curse. whew
        and not (not attackerCharmed and not victimCharmed and not playerWasAttacker and not preDamage and not isCurse)
    then
        --print('YES')
        local damageInstance = {}
        if mod.Config.CountOverkillDamage then
            damageInstance.Damage = triggerArgs.DamageAmount
        else
            damageInstance.Damage = math.min(preHitHealth, triggerArgs.DamageAmount)
        end
        damageInstance.Timestamp = GetTime({})
        damageInstance.Source = mod.getSourceName(triggerArgs, victim)
        --print('source: ' .. damageInstance.Source)

        -- don't log unknowns
        if damageInstance.Source ~= 'Unknown' then
            mod.List.addValue(mod.DamageHistory, damageInstance)
        else
            --print('unknown damage source: ' .. damageInstance.Source)
        end
    else
        -- print('NO')
    end
end, mod)

--[[ on room unlock:
    - stop polling
    - calculate dps
    - clear list ]]
ModUtil.Path.Wrap("DoUnlockRoomExits", function(baseFunc, run, room)
    baseFunc(run, room)
    mod.DpsUpdateThread = false
    mod.calculateDps(mod.DamageHistory)
    mod.List.emptyList(mod.DamageHistory)
end, mod)

--[[ on room start:
    - clear weapon info
    - regenerate list of equipped boons ]]
ModUtil.Path.Wrap("StartRoom", function(baseFunc, run, room)
    baseFunc(run, room)
    mod.clearWeaponInfo()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        mod.getEquippedBoons(trait)
    end
end, mod)

--[[ on run start:
    - start polling
    - regenerate list of equipped boons ]]
ModUtil.Path.Wrap("BeginOpeningEncounter", function(baseFunc)
    baseFunc()
    mod.createPollingThread()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        mod.getEquippedBoons(trait)
    end
end, mod)

--[[ on player death:
    - stop polling
    - clear weapon info]]
--[[ on trait add:
    - recalculate weapon info
    - this is so using something like PonyMenu will update immediately
]] --
ModUtil.Path.Wrap("AddTraitToHero", function(base, ...)
    local trait = base(...)
    mod.clearWeaponInfo()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        mod.getEquippedBoons(trait)
    end
    return trait
end, mod)

--[[ on trait remove:
    - recalculate weapon info
    - this is so using something like PonyMenu will update immediately
]] --
ModUtil.Path.Wrap("RemoveTrait", function(base, ...)
    local trait = base(...)
    mod.clearWeaponInfo()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        mod.getEquippedBoons(trait)
    end
    return trait
end, mod)

ModUtil.Path.Wrap("KillHero", function(baseFunc, victim, triggerArgs)
    baseFunc(victim, triggerArgs)
    mod.DpsUpdateThread = false
    mod.clearWeaponInfo()
end, mod)

-- add the pre-damage function name to triggerArgs to be used later
ModUtil.Path.Context.Wrap("PreDamageBoss", function(enemy, damageAmount, damageData)
    ModUtil.Path.Wrap("Damage", function(base, victim, triggerArgs)
        local preDamageName = damageData.PresentationFunctionName or "PreDamagePresentation"
        local updatedArgs = { DamageAmount = damageAmount, Silent = true, PreDamageBossFunctionName = preDamageName }
        base(victim, updatedArgs)
    end)
end)

-- determine which of medea's curses is happening
ModUtil.Path.Wrap("CheckSpawnCurseDamage", function(base, enemy, traitArgs)
    traitArgs.CurseName = "SpawnDamageCurse"
    base(enemy, traitArgs)
end)

ModUtil.Path.Wrap("CheckSpawnArmorDamage", function(base, enemy, traitArgs)
    traitArgs.CurseName = "ArmorPenaltyCurse"
    base(enemy, traitArgs)
end)

ModUtil.Path.Wrap("CurseRetaliate", function(base, functionArgs, triggerArgs)
    functionArgs.CurseName = "DeathDefianceRetaliateCurse"
    base(functionArgs, triggerArgs)
end)

ModUtil.Path.Context.Wrap("DoCurseDamage", function(enemy, traitArgs, damageAmount)
    ModUtil.Path.Wrap("Damage", function(base, victim, triggerArgs)
        local curseName = traitArgs.CurseName
        local updatedArgs = {
            AttackerTable = CurrentRun.Hero,
            AttackerId = CurrentRun.Hero.ObjectId,
            SourceProjectile =
            "MedeaCurse",
            DamageAmount = damageAmount,
            Silent = false,
            PureDamage = true,
            CurseName = curseName
        }
        base(victim, updatedArgs)
    end)
end)


-- set up polling if it isn't already
OnAnyLoad { function()
    mod.UpdateScreenData() -- check localization
    mod.clearWeaponInfo()  -- empty weapons
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        mod.getEquippedBoons(trait)
    end

    -- turn polling on in training room
    local currentHubRoom = ModUtil.Path.Get("CurrentHubRoom.Name")
    if currentHubRoom == 'Hub_PreRun' then mod.DpsUpdateThread = false end
    -- turn polling on (almost) everywhere else
    if mod.DpsUpdateThread then return end
    mod.DpsUpdateThread = true
    mod.createPollingThread(currentHubRoom)
end }

setupMainData()
