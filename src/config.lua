---@meta _
---@diagnostic disable

local config = {
    version = 1.0,
    PollingInterval = 0.2,
    TrainingRoomClearTime = 5,
    InitialY = 840,
    XPosition = 280,
    YPositionIncrement = -20,
    Margin = 40,
    DisplayWidth = 400,
    BackgroundColor = { 0.090, 0.055, 0.157, 0.6 },
    ShowIcons = true,
    SplitOmega = true,
    OmegaIndicator = "{!Icons.Omega_NoTooltip}",
    ToggleMeterBind = "Ctrl Y"
}

local configDesc = {
    PollingInterval = "How often to update bars, in seconds.",
    TrainingRoomClearTime = "How soon to clear the window in Skelly's room, in seconds.",
    InitialY = "Y position of meter.",
    XPosition = "X position of meter.",
    YPositionIncrement = "Vertical spacing for each bar, negative number.",
    Margin = "Used for meter background scaling.",
    DisplayWidth = "Width of the meter background.",
    BackgroundColor = "Color of the meter background.",
    ShowIcons = "Show God icons next to ability names.",
    SplitOmega = "Show Omega attacks/specials in separate bars.",
    OmegaIndicator =
    "If SplitOmega is enabled, this will prefix the given attack/special name. Can use plain text if the default icon causes flickering.",
    ToggleMeterBind = "Press this to hide/show the meter."
}

return config, configDesc
