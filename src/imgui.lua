---@meta _
---@diagnostic disable

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
        if checked then
            config.ShowIcons = value
        end

        value, checked = rom.ImGui.Checkbox("Split Dash-Strike", config.SplitDashStrike)
        if checked then
            config.SplitDashStrike = value
        end

        value, checked = rom.ImGui.Checkbox("Split Omega damage", config.SplitOmega)
        if checked then
            config.SplitOmega = value
        end

        if config.SplitOmega then
            rom.ImGui.Indent(38)
            rom.ImGui.TextWrapped("Visual indicator before the boon name. Set to a text value (i.e. *) if you notice flickering.")
            text, selected = rom.ImGui.InputText("###omega indicator", config.OmegaIndicator, 100)
            if selected then
                config.OmegaIndicator = text
            end
            rom.ImGui.SameLine()
            reset = rom.ImGui.Button("Reset")
            if reset then
                config.OmegaIndicator = "{!Icons.Omega_NoTooltip}"
            end
            rom.ImGui.Unindent(38)
        end
    end
    rom.ImGui.Spacing()

    if rom.ImGui.CollapsingHeader("Damage Meter Visibility Bind") then
        value, checked = rom.ImGui.Checkbox("Show meter", config.ShowMeter)
        if checked then
            config.ShowMeter = value
        end

        rom.ImGui.Separator()

        rom.ImGui.TextWrapped("Sets a bind to toggle during gameplay. ")
        rom.ImGui.Text("Modifier             Key")
        local modifierKeys = { "None", "Alt", "Ctrl", "Shift" }
        rom.ImGui.PushItemWidth(100)
        if rom.ImGui.BeginCombo("###modifier", config.ToggleMeterModifier) then
            for _, option in ipairs(modifierKeys) do
                if rom.ImGui.Selectable(option, (option == config.ToggleMeterModifier)) then
                    config.ToggleMeterModifier = option
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
            config.ToggleMeterKey = key
        end
        rom.ImGui.PopItemWidth()

        local saveWarning = false
        if config.ToggleMeterBind ~= config.ToggleMeterModifier .. " " .. config.ToggleMeterKey then 
            saveWarning = true 
            rom.ImGui.PushStyleColor(rom.ImGuiCol.Button, 0.35, 0, 0, 1)
        end
        save = rom.ImGui.Button("Save")
        if save then
            local bind = config.ToggleMeterModifier .. " " .. config.ToggleMeterKey
            config.ToggleMeterBind = bind
            setBind()
        end

        if saveWarning then
            rom.ImGui.SameLine()
            rom.ImGui.PushStyleColor(rom.ImGuiCol.Text, 0.5, 0, 0, 1)
            rom.ImGui.Text("Binding is not saved!")
        end
        rom.ImGui.PopStyleColor(2)
    end
    rom.ImGui.Spacing()

    if rom.ImGui.CollapsingHeader("Timer Configuration") then
        rom.ImGui.TextWrapped("Interval at which the damage meter recalculates. Increase if you are having framerate issues.")
        value, used = rom.ImGui.SliderFloat("Second(s)##polling", config.PollingInterval, 0.1, 2, "%.1f")
        if used then
            config.PollingInterval = value
        end

        rom.ImGui.TextWrapped("Seconds before clearing the meter in the Training Area.")
        value, used = rom.ImGui.SliderInt("Second(s)##skelly", config.TrainingRoomClearTime, 1, 60)
        if used then
            config.TrainingRoomClearTime = value
        end
    end
    rom.ImGui.Spacing()

    if rom.ImGui.CollapsingHeader("Layout Configuration") then
        value, used = rom.ImGui.SliderInt("X", config.XPosition, 0, game.ScreenWidth)
        if used then config.XPosition = value end

        value, used = rom.ImGui.SliderInt("Y (Bottom)", config.InitialY, 0, game.ScreenHeight)
        if used then config.InitialY = value end

        -- value, used = rom.ImGui.SliderInt("Bar Spacing", -config.YPositionIncrement, 20, 50)
        -- if used then config.YPositionIncrement = -value end

        -- value, used = rom.ImGui.SliderInt("Margin", config.Margin, 20, 100)
        -- if used then config.Margin = value end

        -- value, used = rom.ImGui.SliderInt("Width", config.DisplayWidth, 300, 600)
        -- if used then config.DisplayWidth = value end

        color, used = rom.ImGui.ColorEdit4("Background", config.BackgroundColor)
        if used then
            config.BackgroundColor = color
        end

        reset = rom.ImGui.Button("Reset Layout")
        if reset then
            config.XPosition = 280
            config.InitialY = 840
            --config.YPositionIncrement = -20
            --config.Margin = 40
            --config.DisplayWidth = 400
            config.BackgroundColor = { 0.09, 0.055, 0.157, 0.6 }
        end
    end
end
