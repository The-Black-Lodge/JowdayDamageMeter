---@meta _
---@diagnostic disable

local mods = rom.mods

---@module 'SGG_Modding-ENVY-auto'
mods['SGG_Modding-ENVY'].auto()

_PLUGIN = _PLUGIN

---@module 'SGG_Modding-Hades2GameDef-Globals'
game = rom.game

---@module 'game-import'
import_as_fallback(game)

---@module 'SGG_Modding-ModUtil'
modutil = mods['SGG_Modding-ModUtil']

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]
---@module 'SGG_Modding-ReLoad'
reload = mods['SGG_Modding-ReLoad']

---@module 'config'
config = chalk.auto 'config.lua'
public.config = config

CurrentBind = nil
ZagreusJourneyMod = nil

local function on_ready()
    if config.enabled == false then return end

    local package = rom.path.combine(_PLUGIN.plugins_data_mod_folder_path, _PLUGIN.guid)
    modutil.mod.Path.Wrap("SetupMap", function(base)
        LoadPackages({ Name = package })
        base()
    end)

    local mods = rom.mods
    local zagMod = mods['Nikkel-ZagreusJourney']
    if zagMod then
        ZagreusJourneyMod = zagMod
    end

    import 'scripts/sjson.lua'
    import 'scripts/JowdayDPS.Data.lua'
    import 'localize.lua'
    import 'scripts/JowdayDPS.Main.lua'
end

local function on_reload()
    import 'func.lua'
    import 'imgui.lua'
    setBind()
    adjustSkellyHealth()
end

-- this allows us to limit certain functions to not be reloaded.
local loader = reload.auto_single()

-- this runs only when modutil and the game's lua is ready
modutil.once_loaded.game(function()
    loader.load(on_ready, on_reload)
end)
