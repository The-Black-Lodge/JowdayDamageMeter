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

-- damage/data functions
function JowdayDPS.calculateDps(list)
    -- sum up damage dealt from each source
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

    -- sort sources from most damage to least
    local dps = round(totalDamage / (latestTimestamp - earliestTimestamp))
    local sourcesSortedByDamage = {}
    for source in pairs(totalDamageBySource) do table.insert(sourcesSortedByDamage, source) end
    table.sort(sourcesSortedByDamage, function(a, b)
        return totalDamageBySource[a] < totalDamageBySource[b]
    end)
    local maxDamage = totalDamageBySource[sourcesSortedByDamage[#sourcesSortedByDamage]]

    -- UI constants to shift whole UI around
    local initialY = 840
    local xPos = 270      --ScreenCenterX - 550
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
        local width = 400
        local height = (initialY - yPos + margin)
        JowdayDPS.createDpsOverlayBackground("DpsBackground", xPos + margin, yPos - 20 + height / 2, width, height)
    else
        Destroy({ Id = ScreenAnchors["DpsMeter"] })
        Destroy({ Id = ScreenAnchors["DpsBackground"] })
        ScreenAnchors["DpsMeter"] = nil
        ScreenAnchors["DpsBackground"] = nil
    end
end

-- there is no longer a God attribute on traits, so here we are
function JowdayDPS.godMatcher(name)
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
function JowdayDPS.getEquippedBoons(trait)
    local slot = trait.Slot or ''
    local name = trait.Name or ''
    local god = JowdayDPS.godMatcher(name) or ''

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
    end
    -- most boons have a God value in the trait
    if god ~= nil then
        JowdayDPS.CurrentGods[god] = true
    end
end

-- reset attack, special, cast, etc.
function JowdayDPS.clearWeaponInfo()
    JowdayDPS.NameLookup["RangedWeapon"] = "Cast"
    JowdayDPS.WeaponVar["Attack"] = nil
    JowdayDPS.WeaponVar["Special"] = nil
    JowdayDPS.WeaponVar["Cast"] = nil
    JowdayDPS.WeaponVar["Dash"] = nil

    -- also reset god list
    JowdayDPS.CurrentGods = {}
end

-- partial name lookup - consolidates attack/special/etc. into single types
function JowdayDPS.getSourceName(triggerArgs, victim)
    local attackerWeaponData = triggerArgs.AttackerWeaponData or {}
    local attackerTable = triggerArgs.AttackerTable or {}
    local source = 'Unknown'
    -- WeaponName > EffectName > SourceProjectile > SourceWeapon > LinkedUpgrades > name lookup
    source = triggerArgs.WeaponName or source
    source = triggerArgs.EffectName or source
    source = triggerArgs.SourceProjectile or source
    source = triggerArgs.SourceWeapon or source
    source = attackerWeaponData.LinkedUpgrades or source
    source = JowdayDPS.NameLookup[source] or source

    if attackerTable.Charmed then
        source = "Charm"
    end

    if source == 'Unknown' then
        -- distinguish between Old Grudge (20%) and Knuckle Bones (15%)
        if triggerArgs.Silent and victim.IsBoss == true then
            local damage = triggerArgs.DamageAmount or 0
            local maxhealth = victim.MaxHealth
            local ratio = damage / maxhealth
            if ratio > 0.15 then
                source = "Old Grudge"
            else
                source = "Knuckle Bones"
            end
        end
    end
    return source
end

-- creates a thread that runs until we tell it not to
function JowdayDPS.createPollingThread(currentHubRoom)
    thread(function()
        while JowdayDPS.DpsUpdateThread do
            -- in training room only, empty list after 5 seconds of no activity
            if currentHubRoom == 'Hub_PreRun' and JowdayDPS.DamageHistory[JowdayDPS.DamageHistory.last] ~= nil then
                if GetTime({}) - JowdayDPS.DamageHistory[JowdayDPS.DamageHistory.last].Timestamp > 5 then
                    JowdayDPS.List.emptyList(JowdayDPS.DamageHistory)
                end
            end
            -- calculate dps every .2 sec
            JowdayDPS.calculateDps(JowdayDPS.DamageHistory)
            wait(.2)
        end
    end)
end

-- UI functions
-- Creates a transparent background behind the dps. Resizes and moves the existing component if this is called with new height and position
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
            OffsetX = -5,
            OffsetY = 0,
            Font = "LatoMedium",
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
    local colors, niceLabel = JowdayDPS.findColor(label)

    local abilityName = label
    if niceLabel ~= nil then
        abilityName = niceLabel
    end

    local portion = damage / totalDamage
    local scale = damage / maxDamage * .6
    local percentDamage = math.floor(portion * 100 + .5)
    local dpsBar = CreateScreenComponent({ Name = "BlankObstacle", X = x, Y = y })

    local labelColor = colors["LabelColor"] or Color.White
    local barColor = colors["BarColor"] or Color.White

    SetAnimation({ Name = "DpsBarWhite", DestinationId = dpsBar.Id })
    JowdayDPS.DpsBars["DpsBar" .. label] = dpsBar

    -- name label
    CreateTextBox({
        Id = dpsBar.Id,
        Text = abilityName,
        OffsetX = -7,
        OffsetY = -2,
        Font = "LatoMedium",
        FontSize = 10,
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
    if scale > .1 then
        CreateTextBox({
            Id = dpsBar.Id,
            Text = damage,
            OffsetX = 1,
            OffsetY = -2,
            Font = "LatoMedium",
            FontSize = 8,
            Justification = "Left",
            Color = Color.White,
            OutlineThickness = 2.0,
            OutlineColor = Color.Black,
            ShadowOffset = { 1, 1 },
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
        OffsetX = 320 * scale + 25,
        OffsetY = -2,
        Font = "LatoMedium",
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

    -- add icons
    -- if JowdayDPS.Config.ShowIcons == true then
    --     JowdayDPS.generateBarIcons(colors, label, dpsBar)
    -- end
end

-- determines colors and looks up a nice name
function JowdayDPS.findColor(source)
    local sources = JowdayDPS.SourceLookup
    local colors = JowdayDPS.DpsColors
    local attack = JowdayDPS.WeaponVar["Attack"]
    local special = JowdayDPS.WeaponVar["Special"]
    local cast = JowdayDPS.WeaponVar["Cast"]
    local dash = JowdayDPS.WeaponVar["Dash"]

    local color
    local niceLabel

    if source == 'Attack' then
        if attack ~= nil and sources[attack] ~= nil then
            color = colors[attack]
            niceLabel = sources[attack]["Attack"]
            return color, niceLabel
        else
            return colors["Default"]
        end
    end

    if source == 'Special' then
        if special ~= nil and sources[special] ~= nil then
            color = colors[special]
            niceLabel = sources[special]["Special"]
            return color, niceLabel
        else
            return colors["Default"]
        end
    end

    if source == 'Cast' then
        if cast ~= nil and sources[cast] ~= nil then
            color = colors[cast]
            niceLabel = sources[cast]["Cast"]
            return color, niceLabel
        else
            return colors["Default"]
        end
    end

    if source == 'Dash' then
        if dash ~= nil and sources[dash] ~= nil then
            color = colors[dash]
            niceLabel = sources[dash]["Dash"]
            return color, niceLabel
        else
            return colors["Default"]
        end
    end

    -- color in our friends :)
    if source == 'Artemis' then
        return colors["ArtemisAssist"]
    elseif source == 'Nemesis' then
        return colors["NemesisAssist"]
    elseif source == 'Heracles' then
        return colors["HeraclesAssist"]
    elseif source == 'Icarus' then
        return colors["IcarusAssist"]
    elseif source == 'Explosive Intent' then
        return colors["Icarus"]
    elseif source == "Necromantic Influence" or source == "Pylon Spirits" then
        return colors["Shade"]
    elseif source == "Frinos" then
        return colors["Frinos"]
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
        damageInstance.Source = JowdayDPS.getSourceName(triggerArgs, victim)

        JowdayDPS.List.addValue(JowdayDPS.DamageHistory, damageInstance)
    end
end, JowdayDPS)

--[[ on room unlock:
    - stop polling
    - calculate dps
    - clear list ]]
ModUtil.Path.Wrap("DoUnlockRoomExits", function(baseFunc, run, room)
    baseFunc(run, room)
    JowdayDPS.DpsUpdateThread = false
    JowdayDPS.calculateDps(JowdayDPS.DamageHistory)
    JowdayDPS.List.emptyList(JowdayDPS.DamageHistory)
end, JowdayDPS)

--[[ on room start:
    - clear weapon info
    - regenerate list of equipped boons ]]
ModUtil.Path.Wrap("StartRoom", function(baseFunc, run, room)
    baseFunc(run, room)
    JowdayDPS.clearWeaponInfo()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        JowdayDPS.getEquippedBoons(trait)
    end
end, JowdayDPS)

--[[ on run start:
    - start polling
    - regenerate list of equipped boons ]]
ModUtil.Path.Wrap("BeginOpeningEncounter", function(baseFunc)
    baseFunc()
    JowdayDPS.createPollingThread()
    for i, trait in pairs(CurrentRun.Hero.Traits) do
        JowdayDPS.getEquippedBoons(trait)
    end
end, JowdayDPS)

--[[ on player death:
    - stop polling
    - clear weapon info]]
ModUtil.Path.Wrap("KillHero", function(baseFunc, victim, triggerArgs)
    baseFunc(victim, triggerArgs)
    JowdayDPS.DpsUpdateThread = false
    JowdayDPS.clearWeaponInfo()
end, JowdayDPS)


-- set up polling if it isn't already
OnAnyLoad { function()
    -- turn polling on in training room
    local currentHubRoom = ModUtil.Path.Get("CurrentHubRoom.Name")
    if currentHubRoom == 'Hub_PreRun' then JowdayDPS.DpsUpdateThread = false end
    -- turn polling on (almost) everywhere else
    if JowdayDPS.DpsUpdateThread then return end
    JowdayDPS.DpsUpdateThread = true
    JowdayDPS.createPollingThread(currentHubRoom)
end }
