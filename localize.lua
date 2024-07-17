local mod = JowdayDPS

mod.Locales = mod.Locales or {}

function mod.GetLanguageString(path)
    local locale = mod.Locales[GetLanguage()] or mod.Locales.en
    return ModUtil.Path.Get(path, locale) or ModUtil.Path.Get(path, mod.Locales.en)
end

function mod.AddLocale(lang, data)
    mod.Locales[lang] = data
end

mod.AddLocale('en', {
    HeaderText = " DPS / Total Damage: ",
    EnemyText = "Enemy",
    WallSlam = "Wall Slam",
    EphyraPylon = "Pylon Spirits",
    SheepAttack = "Sheep Attack",
    Boulder = "Polyphemus Boulder",
})

mod.AddLocale('es', {
    HeaderText = " DPS / Daño Total: ",
    EnemyText = "Enemigo",
    WallSlam = "Aplastado",
    EphyraPylon = "Pilón de Espíritus",
    SheepAttack = "Ataque de Ovejas",
    Boulder = "Piedra de Polifemo",
})

mod.AddLocale('fr', {
    HeaderText = " DPS / Dégâts totaux : ",
    EnemyText = "Ennemis",
    WallSlam = "Choc Contre Les Murs",
    EphyraPylon = "Pylône Spirituel",
    SheepAttack = "Dégâts laineux",
    Boulder = "Polyphème",
})

mod.AddLocale('pt-BR', {
    HeaderText = " DPS / Dano Total: ",
    EnemyText = "Inimigo",
    WallSlam = "Contra-Parede",
    EphyraPylon = "Pilão de Espíritos",
    SheepAttack = "Ataque de Ovelha",
    Boulder = "Pedregulho Polífemo",
})

mod.AddLocale('zh-CN', {
    HeaderText = " DPS / 总伤害: ",
    EnemyText = "敌人",
    WallSlam = "撞墙",
    EphyraPylon = "晶石",
    SheepAttack = "羊群攻击",
    Boulder = "波吕斐摩斯的碎石",
})
