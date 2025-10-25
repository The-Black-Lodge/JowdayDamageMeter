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

AddLocale('en', {
    TotalDmgText = " Total Damage: ",
    EnemyText = "Enemy",
    WallSlam = "Wall Slam",
    EphyraPylon = "Pylon Spirits",
    SheepAttack = "Sheep Attack",
    Boulder = "Polyphemus Boulder",
    -- practical gods
    ArtemisWeaponBoon = "Deadly Strike",
    ArtemisSpecialBoon = "Deadly Flourish"
})

AddLocale('es', {
    TotalDmgText = " Daño Total: ",
    EnemyText = "Enemigo",
    WallSlam = "Aplastado",
    EphyraPylon = "Pilón de Espíritus",
    SheepAttack = "Ataque de Ovejas",
    Boulder = "Piedra de Polifemo",
    ---
    ArtemisWeaponBoon = "Ataque Mortífero",
    ArtemisSpecialBoon = "Puño Mortífero"
})

AddLocale('fr', {
    TotalDmgText = " Dégâts totaux : ",
    EnemyText = "Ennemis",
    WallSlam = "Choc Contre Les Murs",
    EphyraPylon = "Pylône Spirituel",
    SheepAttack = "Dégâts laineux",
    Boulder = "Polyphème",
    ---
    ArtemisWeaponBoon = "Frappe Mortelle",
    ArtemisSpecialBoon = "Technique Mortelle"
})

AddLocale('pt-BR', {
    TotalDmgText = " Dano Total: ",
    EnemyText = "Inimigo",
    WallSlam = "Contra-Parede",
    EphyraPylon = "Pilão de Espíritos",
    SheepAttack = "Ataque de Ovelha",
    Boulder = "Pedregulho Polífemo",
    ---
    ArtemisWeaponBoon = "Ataque Certeiro",
    ArtemisSpecialBoon = "Floreio Mortal"
})

AddLocale('zh-CN', {
    TotalDmgText = " 总伤害: ",
    EnemyText = "敌人",
    WallSlam = "撞墙",
    EphyraPylon = "晶石",
    SheepAttack = "羊群攻击",
    Boulder = "波吕斐摩斯的碎石",
    ---
    ArtemisWeaponBoon = "致命攻击",
    ArtemisSpecialBoon = "致命乱舞"
})
