---@meta _

local config = {
    DpsInterval = 99999999,
    PollingInterval = 1, -- how often to update bars
    TrainingRoomClearTime = 5, -- how many seconds before clearing dps in skelly's room
    InitialY = 840,
    XPosition = 270,
    YPositionIncrement = -20,
    Margin = 40,
    DisplayWidth = 400,
    BackgroundColor = { 0.090, 0.055, 0.157, 0.6 },
    ShowIcons = true
}
JowdayDPS.Config = config
return config
