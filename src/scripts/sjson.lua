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

local boonIconOrder = {
    'Name',
    'InheritFrom',
    'FilePath'
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

local boonArtemisIcon = sjson.to_object({
    Name = "DpsArtemisIcon",
    InheritFrom = "BoonInfoSymbolBase",
    FilePath = rom.path.combine(_PLUGIN.guid, 'ArtemisIcon')
}, boonIconOrder)

local boonAthenaIcon = sjson.to_object({
    Name = "DpsAthenaIcon",
    InheritFrom = "BoonInfoSymbolBase",
    FilePath = rom.path.combine(_PLUGIN.guid, 'AthenaIcon')
}, boonIconOrder)

local boonDionysusIcon = sjson.to_object({
    Name = "DpsDionysusIcon",
    InheritFrom = "BoonInfoSymbolBase",
    FilePath = rom.path.combine(_PLUGIN.guid, 'DionysusIcon')
}, boonIconOrder)

local boonHadesIcon = sjson.to_object({
    Name = "DpsHadesIcon",
    InheritFrom = "BoonInfoSymbolBase",
    FilePath = rom.path.combine(_PLUGIN.guid, 'HadesIcon')
}, boonIconOrder)

local path = rom.path.combine(rom.paths.Content, 'Game/Animations/GUI_HUD_VFX.sjson')
local iconPath = rom.path.combine(rom.paths.Content, 'Game/Animations/GUI_Screens_VFX.sjson')

sjson.hook(path, function(data)
    table.insert(data.Animations, newdata)
end)

sjson.hook(iconPath, function(data)
    table.insert(data.Animations, boonArtemisIcon)
    table.insert(data.Animations, boonAthenaIcon)
    table.insert(data.Animations, boonDionysusIcon)
    table.insert(data.Animations, boonHadesIcon)
end)