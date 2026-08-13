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
configChalk = chalk.auto 'config.lua'
-- ^ this updates our `.cfg` file in the config folder!
-- public.config = config -- so other mods can access our config

local function DeepCopyTable( orig )
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		-- slightly more efficient to call next directly instead of using pairs
		for k,v in next, orig, nil do
			copy[k] = DeepCopyTable(v)
		end
	else
		copy = orig
	end

	return copy
end

local function DeepConfigMetatable( orig, origCopy )
	local orig_type = type(orig)
	local proxy
	if orig_type == 'table' then
		proxy = {}
        local mt = {
            __newindex = function (t,k,v)
                orig[k] = v
                origCopy[k] = v
            end,

            __index = function (t,k)
                return origCopy[k]
            end
        }
        setmetatable(proxy, mt)
		for k,v in pairs(orig) do
			rawset(proxy, k, DeepConfigMetatable(v, origCopy[k]))
		end
	end
	return proxy
end

configCopy = DeepCopyTable(configChalk)

config = DeepConfigMetatable(configChalk, configCopy)

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
    local zagMod = mods['NikkelM-Zagreus_Journey']
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
