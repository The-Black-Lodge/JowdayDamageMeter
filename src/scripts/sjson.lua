---@meta _
---@diagnostic disable

local newdata = {
    Name = "DpsBarWhite",
    FilePath = "GUI\\HUD\\HealthBarFull",
    EndFrame = 1,
    NumFrames = 1,
    StartFrame = 1,
    DieWithOwner = true,
    Material = "Unlit",
    OriginX = 0.0,
    OriginY = 10.0,
    ScaleX = 1.0,
    ScaleY = 1.0,
    Scale = 1.0,
}

local path = rom.path.combine(rom.paths.Content, 'Game/Animations/GUIAnimations.sjson')

sjson.hook(path, function(data)
    local order = sjson.get_order(select(2, next(data.Animations)))
    table.insert(data.Animations, sjson.to_object(newdata, order))
end)
