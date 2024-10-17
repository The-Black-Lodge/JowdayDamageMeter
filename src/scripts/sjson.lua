---@meta _
---@diagnostic disable

local sjson = rom.mods['SGG_Modding-SJSON']

local order = {
    'Name',
    'FilePath',
    'EndFrame',
    'NumFrames',
    'StartFrame',
    'DieWithOwner',
    'Material',
    'OriginX',
    'OriginY',
    'ScaleX',
    'ScaleY',
    'Scale',
}

local newdata = sjson.to_object({
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
}, order)

local path = rom.path.combine(rom.paths.Content, 'Game/Animations/GUI_HUD_VFX.sjson')

sjson.hook(path, function(data)
    table.insert(data.Animations, newdata)
end)