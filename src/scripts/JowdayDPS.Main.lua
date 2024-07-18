---@meta _
---@diagnostic disable

local function setupMainData()
    CurrentLocale = game.GetLanguage()
    Locale = setmetatable({}, {
        __index = function(_, k)
            return GetLanguageString(k)
        end
    })
end

function UpdateScreenData()
    if CurrentLocale ~= game.GetLanguage() then
        CurrentLocale = game.GetLanguage()
    end
    getLocalizedNames()
end

List = {}
-- List functions
function List.new(maxSize)
    return { first = 0, last = -1, count = 0, max = maxSize }
end

function List.addValue(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
    list.count = list.count + 1
    if list.count > list.max then
        List.removeHead(list)
    end
end

function List.removeHead(list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil -- to allow garbage collection
    list.first = first + 1
    list.count = list.count - 1
    return value
end

function List.emptyList(list)
    while list.count > 0 do
        List.removeHead(list)
    end
end

DamageHistory = List.new(10000)
CurrentGods = {}
WeaponVar = {}
DpsUpdateThread = false
DpsBars = {}
DpsIcons = {}
LastDpsPosition = {}
LastDpsBackgroundPosition = {}
local dpsInterval = 999999

-- damage/data functions
function calculateDps(list)
    -- sum up damage dealt from each source
    local totalDamage = 0
    local earliestTimestamp = 999999;
    local latestTimestamp = 0;
    local totalDamageBySource = {}
    for i = list.first, list.last do
        local damageData = list[i]
        local time = game.GetTime({})
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
    for bar, component in pairs(DpsBars) do
        game.Destroy({ Id = component.Id })
        DpsBars[bar] = nil
    end

    for bar, component in pairs(DpsIcons) do
        game.Destroy({ Id = component.Id })
        DpsIcons[bar] = nil
    end

    if config.ShowMeter == true then
        local yPos = config.InitialY
        -- Create UI to show DPS bars for each source
        for i, source in ipairs(sourcesSortedByDamage) do
            local barDamageRounded = math.floor(totalDamageBySource[source] + 0.5)
            createDpsBar(
                source,
                barDamageRounded,
                maxDamage,
                totalDamage,
                config.XPosition,
                yPos
            )
            yPos = yPos + config.YPositionIncrement
        end

        -- Show the DPS menu only if there are recorded instances of damage, otherwise destroy
        if #sourcesSortedByDamage > 0 then
            local totalDamageRounded = math.floor(totalDamage + 0.5)
            createDpsHeader(
                "DpsMeter",
                totalDamageRounded,
                dps,
                config.XPosition,
                yPos - 5
            )
            local height = (config.InitialY - yPos + config.Margin)
            local yPosOverlay = yPos + config.YPositionIncrement + height / 2
            createDpsOverlayBackground(
                "DpsBackground",
                config.XPosition + config.Margin,
                yPosOverlay,
                config.DisplayWidth,
                height
            )
        else
            game.Destroy({ Id = ScreenAnchors["DpsMeter"] })
            game.Destroy({ Id = ScreenAnchors["DpsBackground"] })
            ScreenAnchors["DpsMeter"] = nil
            ScreenAnchors["DpsBackground"] = nil
        end
    else
        game.Destroy({ Id = ScreenAnchors["DpsMeter"] })
        game.Destroy({ Id = ScreenAnchors["DpsBackground"] })
        ScreenAnchors["DpsMeter"] = nil
        ScreenAnchors["DpsBackground"] = nil
    end
end

-- there is no longer a God attribute on traits, so here we are
function godMatcher(name)
    if name == nil then return end

    if name:match("Apollo") then return "Apollo" end
    if name:match("Aphrodite") then return "Aphrodite" end
    if name:match("Artemis") then return "Artemis" end
    if name:match("Demeter") then return "Demeter" end
    if name:match("Hera") then return "Hera" end
    if name:match("Hephaestus") then return "Hephaestus" end
    if name:match("Hestia") then return "Hestia" end
    if name:match("Poseidon") then return "Poseidon" end
    if name:match("Selene") then return "Selene" end
    if name:match("Zeus") then return "Zeus" end
end

-- -- add more accurate names, and build an array of gods
function getEquippedBoons(trait)
    local slot = trait.Slot or ''
    local name = trait.Name or ''
    local god = godMatcher(name) or ''

    if slot == "Melee" and god then
        WeaponVar["Attack"] = god
    end
    if slot == "Secondary" and god then
        WeaponVar["Special"] = god
    end
    if slot == "Ranged" and name then
        if god ~= nil then
            WeaponVar["Cast"] = god
        end
        NameLookup["RangedWeapon"] = name
    end
    if slot == "Rush" and name then
        if god ~= nil then
            WeaponVar["Dash"] = god
        end
    end
    -- most boons have a God value in the trait
    if god ~= nil then
        CurrentGods[god] = true
    end
    -- check for Knuckle Bone uses
    if name ~= nil and name == 'BossPreDamageKeepsake' and trait.Uses ~= nil and trait.Uses > 0 then
        WeaponVar["KnuckleBones"] = trait.ReportedDamage
    end
    -- check for Old Grudge
    if name ~= nil and name == 'HadesPreDamageBoon' and trait.Uses ~= nil and trait.Uses > 0 then
        WeaponVar["OldGrudge"] = trait.ReportedDamage
    end

    if WeaponVar["KnuckleBones"] ~= nil or WeaponVar["OldGrudge"] ~= nil then
        WeaponVar["BossPreDamage"] = true
    end
end

-- reset attack, special, cast, etc.
function clearWeaponInfo()
    NameLookup["RangedWeapon"] = "Cast"
    WeaponVar["Attack"] = nil
    WeaponVar["Special"] = nil
    WeaponVar["Cast"] = nil
    WeaponVar["Dash"] = nil
    WeaponVar["KnuckleBones"] = nil
    WeaponVar["OldGrudge"] = nil
    WeaponVar["BossPreDamage"] = nil

    -- also reset god list
    CurrentGods = {}
end

-- partial name lookup - consolidates attack/special/etc. into single types
function getSourceName(triggerArgs, victim)
    local attackerWeaponData = triggerArgs.AttackerWeaponData or {}
    local attackerTable = triggerArgs.AttackerTable or {}
    local activeEffects = attackerTable.ActiveEffects or {}
    local activeEffectsStart = attackerTable.ActiveEffectsAtDamageStart or {}
    local source = 'Unknown'
    -- WeaponName > EffectName > SourceProjectile > SourceWeapon > LinkedUpgrades > name lookup
    source = triggerArgs.WeaponName or source
    source = triggerArgs.EffectName or source
    source = triggerArgs.SourceProjectile or source
    source = triggerArgs.SourceWeapon or source
    source = attackerWeaponData.LinkedUpgrades or source

    if config.SplitDashStrike == true then
        local sourceProjectile = triggerArgs.SourceProjectile or nil
        if sourceProjectile ~= nil then
            for k, v in pairs(DashStrikeLookup) do
                if sourceProjectile:match(v) then
                    source = 'AttackDashStrike'
                end
            end
        end
    end

    if config.SplitOmega == true then
        local sourceProjectile = triggerArgs.SourceProjectile or nil
        local sourceWeapon = triggerArgs.SourceWeapon or nil
        local isAttackEX = false
        local isSpecialEX = false
        if sourceWeapon ~= nil then
            for k, v in pairs(AttackEXLookup) do
                if sourceWeapon:match(v) or sourceProjectile:match(v) then
                    isAttackEX = true
                end
            end
            for k, v in pairs(SpecialEXLookup) do
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

    source = NameLookup[source] or source

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

    if source == "Unknown" then
        -- check if user has Old Grudge and/or Knuckle Bones
        if WeaponVar["BossPreDamage"] ~= nil and triggerArgs.Silent and victim.IsBoss == true then
            -- old grudge
            if triggerArgs.PreDamageBossFunctionName ~= nil and triggerArgs.PreDamageBossFunctionName == "HadesPreDamagePresentation" then
                source = "OldGrudge"
                WeaponVar["OldGrudge"] = nil
            end
            -- knuckle bones
            if WeaponVar["KnuckleBones"] ~= nil and triggerArgs.PreDamageBossFunctionName ~= nil and triggerArgs.PreDamageBossFunctionName == "PreDamagePresentation" then
                source = "KnuckleBones"
                WeaponVar["KnuckleBones"] = nil
            end
        end
    end

    return source
end

-- creates a thread that runs until we tell it not to
function createPollingThread(currentHubRoom)
    game.thread(function()
        while DpsUpdateThread do
            -- in training room only, empty list after 5 seconds of no activity
            if currentHubRoom == 'Hub_PreRun' and DamageHistory[DamageHistory.last] ~= nil then
                if game.GetTime({}) - DamageHistory[DamageHistory.last].Timestamp > config.TrainingRoomClearTime then
                    List.emptyList(DamageHistory)
                end
            end
            -- calculate dps every interval
            calculateDps(DamageHistory)
            game.wait(config.PollingInterval)
        end
    end)
end

-- UI functions
-- Creates a transparent background behind the dps. Resizes and moves the existing component if this is called with new height and position
function createDpsOverlayBackground(obstacleName, x, y, width, height)
    local scaleWidth = width / (config.DisplayWidth + config.Margin)
    local scaleHeight = height / 250
    if ScreenAnchors[obstacleName] ~= nil then
        game.SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = scaleWidth })
        game.SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = scaleHeight })
        game.Move({
            Ids = ScreenAnchors[obstacleName],
            Angle = 90,
            Distance = LastDpsBackgroundPosition.y - y,
            Speed = 1000
        })
    else
        ScreenAnchors[obstacleName] = game.CreateScreenObstacle({ Name = "rectangle01", X = x, Y = y })
        game.SetScaleX({ Id = ScreenAnchors[obstacleName], Fraction = scaleWidth })
        game.SetScaleY({ Id = ScreenAnchors[obstacleName], Fraction = scaleHeight })
        game.SetColor({ Id = ScreenAnchors[obstacleName], Color = config.BackgroundColor })
    end
    LastDpsBackgroundPosition.y = y
end

-- Create a header that shows overall DPS and overall damage total
function createDpsHeader(obstacleName, totalDamage, dps, x, y)
    if tostring(dps) == 'inf' then dps = '···' end
    local text = dps .. Locale.HeaderText .. totalDamage

    if ScreenAnchors[obstacleName] ~= nil then
        game.ModifyTextBox({ Id = ScreenAnchors[obstacleName], Text = text })
        game.Move({ Ids = ScreenAnchors[obstacleName], Angle = 90, Distance = LastDpsPosition.y - y, Speed = 1000 })
    else
        ScreenAnchors[obstacleName] = game.CreateScreenObstacle({ Name = "BlankObstacle", X = x, Y = y })
        game.CreateTextBox({
            Id = ScreenAnchors[obstacleName],
            Text = text,
            OffsetX = -5,
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
        game.ModifyTextBox({ Id = ScreenAnchors[obstacleName], FadeTarget = 1, FadeDuration = 0.0 })
    end

    LastDpsPosition.y = y
end

-- Create a single DPS bar with damage source, damage amount, and damage portion labels
function createDpsBar(label, damage, maxDamage, totalDamage, x, y)
    local colors, niceLabel = getColorAndLabel(label)

    local abilityName = label
    if niceLabel ~= nil then
        abilityName = niceLabel
    end

    local portion = damage / totalDamage
    local scale = damage / maxDamage
    local percentDamage = math.floor(portion * 100 + .5)

    local labelColor = colors["LabelColor"] or Color.White
    local barColor = colors["BarColor"] or Color.White

    local dpsBar = game.CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })
    game.SetAnimation({ Name = "DpsBarWhite", DestinationId = dpsBar.Id })
    -- Scale damage bar
    game.SetScaleX({ Id = dpsBar.Id, Fraction = scale * 0.5, Duration = 0.0 })
    -- color damage bar
    game.SetColor({ Id = dpsBar.Id, Color = barColor })

    DpsBars["DpsBar" .. label] = dpsBar

    local textOffsetX = -7
    if config.ShowIcons == true then textOffsetX = -25 end
    local textOffsetY = -2
    -- name label
    game.CreateTextBox({
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
    game.CreateTextBox({
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
        game.CreateTextBox({
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
    game.ModifyTextBox({ Id = dpsBar.Id, FadeTarget = 1, FadeDuration = 0.0 })

    -- add icons
    if config.ShowIcons == true then
        generateBarIcons(colors, label, dpsBar)
    end
end

-- determines colors and looks up a nice name
function getColorAndLabel(source)
    local sources = SourceLookup
    local colors = DpsColors
    local attack = WeaponVar["Attack"]
    local special = WeaponVar["Special"]
    local cast = WeaponVar["Cast"]
    local dash = WeaponVar["Dash"]

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
            return colors["Default"], NameLookup.OAttackText
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
            return colors["Default"], NameLookup.OSpecialText
        end
    end

    if source == 'WeaponCast' then
        if cast ~= nil and sources[cast] ~= nil then
            color = colors[cast]
            niceLabel = sources[cast]["WeaponCast"]
            return color, niceLabel
        else
            return colors["Default"], NameLookup.OCastText
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
        return colors["Shade"], Locale.EphyraPylon
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
function generateBarIcons(colors, label, dpsBar)
    local godIcons = ShallowCopyTable(colors["Icons"])

    if godIcons ~= nil then
        -- if one icon, center it
        local iconOffsetX = -12
        -- if two, make room for both
        if #godIcons == 2 then
            iconOffsetX = -8
        end

        local dpsIcon1 = game.CreateScreenComponent({ Name = "BlankObstacle" })
        local icon1 = Icons[godIcons[1]]
        game.SetAnimation({ Name = icon1.Name, DestinationId = dpsIcon1.Id, Scale = icon1.Scale })
        DpsIcons["DpsIcon" .. label] = dpsIcon1
        -- if it's a duo, add the icon and attach it
        if #godIcons > 1 then
            local dpsIcon2 = game.CreateScreenComponent({ Name = "BlankObstacle" })
            local icon2 = Icons[godIcons[2]]
            game.SetAnimation({ Name = icon2.Name, DestinationId = dpsIcon2.Id, Scale = icon2.Scale })
            DpsIcons["DpsIconDuo" .. label] = dpsIcon2
            game.Attach({ Id = dpsIcon2.Id, DestinationId = dpsIcon1.Id, OffsetX = -10 })
        end
        -- anchor to the given dps bar
        game.Attach({ Id = dpsIcon1.Id, DestinationId = dpsBar.Id, OffsetX = iconOffsetX, OffsetY = -3 })
    end
end

-- overrides
--[[ on enemy damage:
    - create damage instance ]]
ModUtil.Path.Wrap("DamageEnemy", function(baseFunc, victim, triggerArgs)
    local preHitHealth = victim.Health
    baseFunc(victim, triggerArgs)
    local victimCharmed = IsCharmed({ Id = victim.ObjectId })
    local playerWasAttacker = triggerArgs.AttackerName == "_PlayerUnit"
    if (triggerArgs.DamageAmount or 0) > 0
        and victim.MaxHealth ~= nil
        and (victim.Name == "NPC_Skelly_01"
            or (victim.GeneratorData or {}).DifficultyRating ~= nil
            or victim.CanBeAggroed
            or victim.IsBoss
        )
        -- this wonky logic is to discard charmed enemies being damaged by other enemies
        and not (victimCharmed and not playerWasAttacker)
    then
        local damageInstance = {}
        damageInstance.Damage = math.min(preHitHealth, triggerArgs.DamageAmount)
        damageInstance.Timestamp = GetTime({})
        damageInstance.Source = getSourceName(triggerArgs, victim)

        List.addValue(DamageHistory, damageInstance)
    end
end, mod)

--[[ on room unlock:
    - stop polling
    - calculate dps
    - clear list ]]
ModUtil.Path.Wrap("DoUnlockRoomExits", function(baseFunc, run, room)
    baseFunc(run, room)
    DpsUpdateThread = false
    calculateDps(DamageHistory)
    List.emptyList(DamageHistory)
end, mod)

--[[ on room start:
    - clear weapon info
    - regenerate list of equipped boons ]]
ModUtil.Path.Wrap("StartRoom", function(baseFunc, run, room)
    baseFunc(run, room)
    clearWeaponInfo()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        getEquippedBoons(trait)
    end
end, mod)

--[[ on run start:
    - start polling
    - regenerate list of equipped boons ]]
ModUtil.Path.Wrap("BeginOpeningEncounter", function(baseFunc)
    baseFunc()
    createPollingThread()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        getEquippedBoons(trait)
    end
end, mod)

--[[ on player death:
    - stop polling
    - clear weapon info]]
ModUtil.Path.Wrap("KillHero", function(baseFunc, victim, triggerArgs)
    baseFunc(victim, triggerArgs)
    DpsUpdateThread = false
    clearWeaponInfo()
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
        local updatedArgs = { AttackerTable = game.CurrentRun.Hero, AttackerId = game.CurrentRun.Hero.ObjectId, SourceProjectile = "MedeaCurse", DamageAmount = damageAmount, Silent = false, PureDamage = true, CurseName = curseName }
        base(victim, updatedArgs)
    end)
end)

-- set up polling if it isn't already
OnAnyLoad { function()
    UpdateScreenData() -- check localization
    clearWeaponInfo()  -- empty weapons
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        getEquippedBoons(trait)
    end

    -- turn polling on in training room
    local currentHubRoom = ModUtil.Path.Get("CurrentHubRoom.Name")
    if currentHubRoom == 'Hub_PreRun' then DpsUpdateThread = false end
    -- turn polling on (almost) everywhere else
    if DpsUpdateThread then return end
    DpsUpdateThread = true
    createPollingThread(currentHubRoom)
end }

setupMainData()
