---@meta _
---@diagnostic disable

-- Track previous values to avoid unnecessary updates
local previousConfig = {
    ShowIcons = nil,
    SplitDashStrike = nil,
    SplitOmega = nil,
    OmegaIndicator = nil,
    CountOverkillDamage = nil,
    ShowMeter = nil,
    CarrotMode = nil,
    CarrotModeType = nil,
    CarrotModeEnabledBoss_Hecate = nil,
    CarrotModeEnabledBoss_Scylla = nil,
    CarrotModeEnabledBoss_Cerberus = nil,
    CarrotModeEnabledBoss_Chronos = nil,
    CarrotModeEnabledBoss_Polyphemus = nil,
    CarrotModeEnabledBoss_Eris = nil,
    CarrotModeEnabledBoss_Prometheus = nil,
    CarrotModeEnabledBoss_Typhon = nil,
    ToggleMeterModifier = nil,
    ToggleMeterKey = nil,
    ToggleMeterBind = nil,
    CustomSkellyHealth = nil,
    SkellyHealthMax = nil,
    TrainingRoomClearTime = nil,
    PollingInterval = nil,
    XPosition = nil,
    InitialY = nil,
    BackgroundColor = nil
}

rom.gui.add_imgui(function()
    if rom.ImGui.Begin("DamageMeter") then
        drawMenu()
        rom.ImGui.End()
    end
end)

rom.gui.add_to_menu_bar(function()
    if rom.ImGui.BeginMenu("Configure") then
        drawMenu()
        rom.ImGui.EndMenu()
    end
end)

function drawMenu()
    if rom.ImGui.CollapsingHeader("Damage Display Options") then
        value, checked = rom.ImGui.Checkbox("Show God icons", config.ShowIcons)
        if checked and value ~= previousConfig.ShowIcons then
            config.ShowIcons = value
            previousConfig.ShowIcons = value
        end

        value, checked = rom.ImGui.Checkbox("Split Dash-Strike", config.SplitDashStrike)
        if checked and value ~= previousConfig.SplitDashStrike then
            config.SplitDashStrike = value
            previousConfig.SplitDashStrike = value
        end

        value, checked = rom.ImGui.Checkbox("Split Omega damage", config.SplitOmega)
        if checked and value ~= previousConfig.SplitOmega then
            config.SplitOmega = value
            previousConfig.SplitOmega = value
        end

        if config.SplitOmega then
            rom.ImGui.Indent(38)
            rom.ImGui.TextWrapped(
            "Visual indicator before the boon name. Set to a text value (i.e. *) if you notice flickering.")
            text, selected = rom.ImGui.InputText("###omega indicator", config.OmegaIndicator, 100)
            if selected and text ~= previousConfig.OmegaIndicator then
                config.OmegaIndicator = text
                previousConfig.OmegaIndicator = text
                getLocalizedNames()
            end
            rom.ImGui.SameLine()
            reset = rom.ImGui.Button("Reset")
            if reset then
                config.OmegaIndicator = "{!Icons.Omega_NoTooltip}"
                previousConfig.OmegaIndicator = config.OmegaIndicator
                getLocalizedNames()
            end
            rom.ImGui.Unindent(38)
        end

        rom.ImGui.Separator()
        rom.ImGui.TextWrapped("Overkill damage is damage beyond the enemy's health/shield. For example, if you hit a 1hp enemy for 100 damage, 99 damage was overkill.")
        value, checked = rom.ImGui.Checkbox("Include overkill damage", config.CountOverkillDamage)
        if checked and value ~= previousConfig.CountOverkillDamage then
            config.CountOverkillDamage = value
            previousConfig.CountOverkillDamage = value
        end

        value, checked = rom.ImGui.Checkbox("Enable detailed header (Shows current and max DPS)", config.DetailedHeader)
        if checked and value ~= previousConfig.DetailedHeader then
            config.DetailedHeader = value
            previousConfig.DetailedHeader = value
        end
    end
    rom.ImGui.Spacing()

    if rom.ImGui.CollapsingHeader("Damage Meter Visibility and Bind") then
        value, checked = rom.ImGui.Checkbox("Show Meter", config.ShowMeter)
        if checked and value ~= previousConfig.ShowMeter then
            -- if this is turned off, also turn off CarrotMode
            if value == false then 
                config.CarrotMode = false
                previousConfig.CarrotMode = false
            end
            -- this needs to be enabled if CarrotMode is enabled
            config.ShowMeter = value
            previousConfig.ShowMeter = value
        end
        rom.ImGui.TextWrapped("Turning this off will also disable Carrot Mode")

        rom.ImGui.TextWrapped("Carrot Mode")
        value, checked = rom.ImGui.Checkbox("Don't show until next Location is available *", config.CarrotMode)
        if checked and value ~= previousConfig.CarrotMode then
            config.CarrotMode = value
            previousConfig.CarrotMode = value
            -- make sure ShowMeter is enabled if CarrotMode is enabled
            if value == true then 
                config.ShowMeter = true
                previousConfig.ShowMeter = true
            end
        end
        rom.ImGui.TextWrapped("* Turning this on will also enable 'Show meter'.")

        if config.CarrotMode then
            rom.ImGui.Indent(38)
            rom.ImGui.TextWrapped("When to apply Carrot Mode:")
            
            if rom.ImGui.RadioButton("Always", config.CarrotModeType == "always") then
                if config.CarrotModeType ~= "always" then
                    config.CarrotModeType = "always"
                    previousConfig.CarrotModeType = "always"
                end
            end
            
            rom.ImGui.SameLine()
            
            if rom.ImGui.RadioButton("Only during boss fights", config.CarrotModeType == "bosses") then
                if config.CarrotModeType ~= "bosses" then
                    config.CarrotModeType = "bosses"
                    previousConfig.CarrotModeType = "bosses"
                end
            end
            rom.ImGui.TextWrapped("EXPERIMENTAL: Please report any bugs on GitHub or Discord!")
            
            if config.CarrotModeType == "bosses" then
                rom.ImGui.Spacing()
                
                if rom.ImGui.CollapsingHeader("Underworld") then
                    rom.ImGui.Indent(20)
                    
                    value, checked = rom.ImGui.Checkbox("Hecate", config.CarrotModeEnabledBoss_Hecate)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Hecate then
                        config.CarrotModeEnabledBoss_Hecate = value
                        previousConfig.CarrotModeEnabledBoss_Hecate = value
                    end
                    
                    value, checked = rom.ImGui.Checkbox("Scylla", config.CarrotModeEnabledBoss_Scylla)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Scylla then
                        config.CarrotModeEnabledBoss_Scylla = value
                        previousConfig.CarrotModeEnabledBoss_Scylla = value
                    end
                    
                    value, checked = rom.ImGui.Checkbox("Cerberus", config.CarrotModeEnabledBoss_Cerberus)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Cerberus then
                        config.CarrotModeEnabledBoss_Cerberus = value
                        previousConfig.CarrotModeEnabledBoss_Cerberus = value
                    end
                    
                    value, checked = rom.ImGui.Checkbox("Chronos", config.CarrotModeEnabledBoss_Chronos)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Chronos then
                        config.CarrotModeEnabledBoss_Chronos = value
                        previousConfig.CarrotModeEnabledBoss_Chronos = value
                    end
                    
                    rom.ImGui.Unindent(20)
                end
                
                if rom.ImGui.CollapsingHeader("Surface") then
                    rom.ImGui.Indent(20)
                    
                    value, checked = rom.ImGui.Checkbox("Polyphemus", config.CarrotModeEnabledBoss_Polyphemus)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Polyphemus then
                        config.CarrotModeEnabledBoss_Polyphemus = value
                        previousConfig.CarrotModeEnabledBoss_Polyphemus = value
                    end
                    
                    value, checked = rom.ImGui.Checkbox("Eris", config.CarrotModeEnabledBoss_Eris)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Eris then
                        config.CarrotModeEnabledBoss_Eris = value
                        previousConfig.CarrotModeEnabledBoss_Eris = value
                    end
                    
                    value, checked = rom.ImGui.Checkbox("Prometheus", config.CarrotModeEnabledBoss_Prometheus)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Prometheus then
                        config.CarrotModeEnabledBoss_Prometheus = value
                        previousConfig.CarrotModeEnabledBoss_Prometheus = value
                    end
                    
                    value, checked = rom.ImGui.Checkbox("Typhon", config.CarrotModeEnabledBoss_Typhon)
                    if checked and value ~= previousConfig.CarrotModeEnabledBoss_Typhon then
                        config.CarrotModeEnabledBoss_Typhon = value
                        previousConfig.CarrotModeEnabledBoss_Typhon = value
                    end
                    
                    rom.ImGui.Unindent(20)
                end
            end
            
            rom.ImGui.Unindent(38)
        end

        rom.ImGui.Separator()

        rom.ImGui.TextWrapped("Sets a bind to toggle the meter during gameplay. ")
        rom.ImGui.Text("Modifier             Key")
        local modifierKeys = { "None", "Alt", "Ctrl", "Shift" }
        rom.ImGui.PushItemWidth(100)
        if rom.ImGui.BeginCombo("###modifier", config.ToggleMeterModifier) then
            for _, option in ipairs(modifierKeys) do
                if rom.ImGui.Selectable(option, (option == config.ToggleMeterModifier)) then
                    if option ~= previousConfig.ToggleMeterModifier then
                        config.ToggleMeterModifier = option
                        previousConfig.ToggleMeterModifier = option
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end
            rom.ImGui.EndCombo()
        end
        rom.ImGui.PopItemWidth()

        rom.ImGui.SameLine()

        rom.ImGui.PushItemWidth(130)
        pressed, value = rom.ImGui.Hotkey("###key", keycodeMap[config.ToggleMeterKey])
        if pressed then
            local key = keycodeMap[value]
            if key ~= previousConfig.ToggleMeterKey then
                config.ToggleMeterKey = key
                previousConfig.ToggleMeterKey = key
            end
        end
        rom.ImGui.PopItemWidth()

        local unsaved = false
        if config.ToggleMeterBind ~= config.ToggleMeterModifier .. " " .. config.ToggleMeterKey then
            unsaved = true
            rom.ImGui.PushStyleColor(rom.ImGuiCol.Button, 0.35, 0, 0, 1)
        end
        rom.ImGui.BeginDisabled(not unsaved)
        save = rom.ImGui.Button("Save")
        rom.ImGui.EndDisabled()
        if save then
            local bind = config.ToggleMeterModifier .. " " .. config.ToggleMeterKey
            if bind ~= previousConfig.ToggleMeterBind then
                config.ToggleMeterBind = bind
                previousConfig.ToggleMeterBind = bind
                setBind()
            end
        end

        if unsaved then
            rom.ImGui.SameLine()
            rom.ImGui.PushStyleColor(rom.ImGuiCol.Text, 0.5, 0, 0, 1)
            rom.ImGui.Text("Binding is not saved!")
        end
        rom.ImGui.PopStyleColor(2)
    end
    rom.ImGui.Spacing()

    if rom.ImGui.CollapsingHeader("Training Dummy and Timer Configuration") then

        value, checked = rom.ImGui.Checkbox("Custom Skelly health", config.CustomSkellyHealth)
        if checked and value ~= previousConfig.CustomSkellyHealth then
            config.CustomSkellyHealth = value
            previousConfig.CustomSkellyHealth = value
            adjustSkellyHealth()
        end

        if config.CustomSkellyHealth == true then
            value, used = rom.ImGui.InputInt("Skelly health", config.SkellyHealthMax, 1, 100000)
            if used and value ~= previousConfig.SkellyHealthMax then
                config.SkellyHealthMax = value
                previousConfig.SkellyHealthMax = value
                adjustSkellyHealth()
            end
        end

        rom.ImGui.TextWrapped("Seconds before clearing the meter in the Training Area.")
        value, used = rom.ImGui.SliderInt("Second(s)##skelly", config.TrainingRoomClearTime, 1, 60)
        if used and value ~= previousConfig.TrainingRoomClearTime then
            config.TrainingRoomClearTime = value
            previousConfig.TrainingRoomClearTime = value
        end

        rom.ImGui.Separator()

        rom.ImGui.TextWrapped("Interval at which the damage meter recalculates. Increase if you are having framerate issues.")
        value, used = rom.ImGui.SliderFloat("Second(s)##polling", config.PollingInterval, 0.1, 2, "%.1f")
        if used and value ~= previousConfig.PollingInterval then
            config.PollingInterval = value
            previousConfig.PollingInterval = value
        end
    end
    rom.ImGui.Spacing()

    if rom.ImGui.CollapsingHeader("Layout Configuration") then
        value, used = rom.ImGui.SliderInt("X", config.XPosition, 0, game.ScreenWidth)
        if used and value ~= previousConfig.XPosition then
            config.XPosition = value
            previousConfig.XPosition = value
        end

        value, used = rom.ImGui.SliderInt("Y (Bottom)", config.InitialY, 0, game.ScreenHeight)
        if used and value ~= previousConfig.InitialY then
            config.InitialY = value
            previousConfig.InitialY = value
        end

        -- value, used = rom.ImGui.SliderInt("Bar Spacing", -config.YPositionIncrement, 20, 50)
        -- if used then config.YPositionIncrement = -value end

        -- value, used = rom.ImGui.SliderInt("Margin", config.Margin, 20, 100)
        -- if used then config.Margin = value end

        -- value, used = rom.ImGui.SliderInt("Width", config.DisplayWidth, 300, 600)
        -- if used then config.DisplayWidth = value end

        color, used = rom.ImGui.ColorEdit4("Background", config.BackgroundColor)
        if used and color ~= previousConfig.BackgroundColor then
            config.BackgroundColor = color
            previousConfig.BackgroundColor = color
        end

        reset = rom.ImGui.Button("Reset Layout")
        if reset then
            config.XPosition = 280
            config.InitialY = 840
            --config.YPositionIncrement = -20
            --config.Margin = 40
            --config.DisplayWidth = 400
            config.BackgroundColor = { 0.09, 0.055, 0.157, 0.6 }
            
            -- Update previous config values to match reset values
            previousConfig.XPosition = config.XPosition
            previousConfig.InitialY = config.InitialY
            previousConfig.BackgroundColor = config.BackgroundColor
        end
    end
end
