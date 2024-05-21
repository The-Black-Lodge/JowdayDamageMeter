---@meta _
---@diagnostic disable

local mod = JowdayDPS

mod.Locales = mod.Locales or {}

function mod.GetLanguageString(path)
    local locale = mod.Locales[GetLanguage()] or mod.Locales.en
    return ModUtil.Path.Get(path, locale) or ModUtil.Path.Get(path, mod.Locales.en)
end

function mod.AddLocale(lang, data)
    mod.Locales[lang] = data
end
