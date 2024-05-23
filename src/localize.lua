---@meta _
---@diagnostic disable

Locales = Locales or {}

function GetLanguageString(path)
    local locale = Locales[game.GetLanguage()] or Locales.en
    return ModUtil.Path.Get(path, locale) or ModUtil.Path.Get(path, Locales.en)
end

function AddLocale(lang, data)
    Locales[lang] = data
end
