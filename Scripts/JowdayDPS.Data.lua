---@meta _

local mod = JowdayDPS

mod.HeaderText = " DPS / Total Damage: "
mod.AttackText = "Attack"
mod.SpecialText = "Special"
mod.CastText = "Cast"
mod.DashText = "Dash"
mod.WallSlam = "Wall Slam"
mod.EnemyText = "Enemy"
-- npc assists
mod.ArtemisName = "Artemis"
mod.NemesisName = "Nemesis"
mod.HeraclesName = "Heracles"
mod.IcarusName = "Icarus"
-- familiars
mod.Frinos = "Frinos"
mod.Toula = "Toula"
-- traps
mod.SteamTrap = "Steam Trap"
mod.OilFire = "Oil Fire"
mod.FireBarrel = "Fire Barrel"
mod.SpikeTrap = "Spike Trap"
mod.BrambleTrap = "Brambles"
mod.ThornTrap = "Thorns"
mod.Splinters = "Splinters"
mod.BeamTrap = "Beam"
mod.Pillar = "Collapsing Pillar"
mod.Lava = "Lava"
mod.Rubble = "Falling Rubble"
mod.GenericTrap = "Trap"
--  misc
mod.SheepAttack = "Sheep Attack"
mod.Boulder = "Polyphemus Boulder"
mod.ShadeSprint = "Necromantic Influence"
mod.EphyraPylon = "Pylon Spirits"

mod.NameLookup = {
    -- sheep?
    WeaponMorphedAttack = mod.SheepAttack,
    -- familiars
    FrogFamiliarLand = mod.Frinos,
    CatFamiliarPounce = mod.Toula,
    -- misc environment
    PolyphemusBoulderSky = mod.Boulder,
    ShadeMercSpiritball = mod.ShadeSprint,
    SoulPylonSpiritball = mod.EphyraPylon,
    --- traps
    FireBarrelExplosion = mod.FireBarrel,
    FireBarrelFireLob = mod.FireBarrel,
    SteamWallBlast = mod.SteamTrap,
    SteamTrapFast = mod.SteamTrap,
    SteamTrap = mod.SteamTrap,
    SteamCubeExplosion = mod.SteamTrap,
    OilPuddleFire = mod.OilFire,
    OilPuddleFire02 = mod.OilFire,
    OilPuddleFire03 = mod.OilFire,
    OilPuddleFire04 = mod.OilFire,
    DestructibleTreeSplinter = mod.Splinters,
    BrambleTrap = mod.BrambleTrap,
    ThornTreeThorn = mod.ThornTrap,
    FieldsDestructiblePillarDestruction = mod.Pillar,
    BlastCubeExplosion = mod.GenericTrap,
    SpikeTrapWeapon = mod.SpikeTrap,
    LavaTileWeapon = mod.Lava,
    BaseCollision = mod.WallSlam,
    BeamTrap = mod.BeamTrap,
    RubbleFall = mod.Rubble,
    --
    WeaponDagger = mod.AttackText,
    WeaponDaggerThrow = mod.SpecialText,
    WeaponCast = mod.CastText,
    WeaponCastProjectile = mod.CastText,
    WeaponBlink = mod.DashText,
    --
    WeaponStaffSwing = mod.AttackText,
    WeaponStaffBall = mod.SpecialText,
    --
    WeaponTorch = mod.AttackText,
    WeaponTorchSpecial = mod.SpecialText,
    --
    WeaponAxe = mod.AttackText,
    WeaponAxeSpecialSwing = mod.SpecialText,
    WeaponAxeDash = mod.AttackText,
    WeaponAxeSpin = mod.AttackText,
    WeaponAxeBlock2 = mod.SpecialText,
    --
    WeaponLob = mod.AttackText,
    WeaponLobSpecial = mod.SpecialText,
    WeaponLobPulse = mod.AttackText,
    --
    HeraCastSummonProjectile = mod.CastText,
    -- artemis assist
    ArtemisSniperBolt = mod.ArtemisName,
    ArtemisVolleyShot = mod.ArtemisName,
    -- nemesis assist
    NemesisSpecial = mod.NemesisName,
    NemesisAttack1 = mod.NemesisName,
    NemesisAttack2 = mod.NemesisName,
    NemesisAttack3 = mod.NemesisName,
    NemesisDash = mod.NemesisName,
    -- heracles assist
    HeraclesLeap = mod.HeraclesName,
    HeraclesArcRight = mod.HeraclesName,
    -- icarus assist / boon
    IcarusBombardment = mod.IcarusName,
    IcarusBombardment_Large = mod.IcarusName,
    --
    LamiaMiasma = mod.EnemyText,
    LamiaSkyCast_Miniboss = mod.EnemyText,
    MournerRampage = mod.EnemyText,
    LycanSwarmerChomp = mod.EnemyText,
    CorruptedShadeMRam = mod.EnemyText,
    LycanthropeLeapKnockback = mod.EnemyText,
    InfestedCerberusSwipe = mod.EnemyText,
    SatyrLanceThrow = mod.EnemyText,
}

mod.SourceLookup = {
    Aphrodite = {
        ["Attack"] = "Flutter Strike",
        ["Special"] = "Flutter Flourish",
        ["Dash"] = "Passion Dash",
        ["Cast"] = "Rapture Ring",
        ["AphroditeBurst"] = "Heart Breaker",
    },
    Apollo = {
        ["Attack"] = "Nova Strike",
        ["Special"] = "Nova Flourish",
        ["Dash"] = "Blinding Sprint",
        ["Cast"] = "Solar Ring",
        ['ApolloRetaliateStrike'] = "Light Smite",
        ['ApolloPerfectDashStrike'] = "Critical Miss"
    },
    Artemis = {
        ["ArtemisSupportingFire"] = "Support Fire",
        ["ArtemisCastVolley"] = "Easy Shot"
    },
    Demeter = {
        ["Attack"] = "Ice Strike",
        ["Special"] = "Ice Flourish",
        ["Dash"] = "Frigid Sprint",
        ["Cast"] = "Arctic Ring",
        ["DemeterSprintStorm"] = "Frigid Sprint",
        ["DemeterChillKill"] = "Winter Harvest",
    },
    Hades = {
        ["WeaponCastProjectileHades"] = "Howling Soul",
        ["Old Grudge"] = "Old Grudge"
    },
    Hera = {
        ["Attack"] = "Sworn Strike",
        ["Special"] = "Sworn Flourish",
        ["Cast"] = "Engagement Ring",
        ["HeraDamageShareProjectile"] = "Nasty Comeback",
        ["DamageShareEffect"] = "Hitch",
        ["DamageShareDeath"] = "Dying Wish"
    },
    Hestia = {
        ["Attack"] = "Flame Strike",
        ["Special"] = "Flame Flourish",
        ["Dash"] = "Soot Sprint",
        ["Cast"] = "Smolder Ring",
        ["BurnNova"] = "Natural Gas",
        ["BurnEffect"] = "Scorch",
        ["ProjectileFireball"] = "Controlled Burn"
    },
    Hephaestus = {
        ["Attack"] = "Volcanic Strike",
        ["Special"] = "Volcanic Flourish",
        ["Cast"] = "Anvil Ring",
        ["Dash"] = "Smithy Sprint",
        ["MassiveSlamBlast"] = "Blast",
        ["HephSprintBlast"] = "Smithy Sprint",
        ["DelayedKnockbackEffect"] = "Furnace Blast"
    },
    IcarusBoon = {
        ["IcarusExplosion"] = "Explosive Intent",
    },
    OdysseusKeepsake = {
        ["Knuckle Bones"] = "Knuckle Bones"
    },
    Poseidon = {
        ["Attack"] = "Wave Strike",
        ["Special"] = "Wave Flourish",
        ["Dash"] = "Breaker Sprint",
        ["Cast"] = "Geyser Ring",
        ["PoseidonSplashSplinter"] = "Poseidon Waves",
        ["PoseidonSprintBlast"] = "Breaker Sprint",
        ["PoseidonCollisionBlast"] = "Crashing Wave",
    },
    Selene = {
        ["WeaponSpellLaser"] = "Lunar Ray",
        ["WeaponSpellLeap"] = "Wolf Howl",
        ["WeaponSpellMeteor"] = "Meteor",
        ["WeaponTransformSpecial"] = "Dark Side Special",
        ["WeaponTransformAttack"] = "Dark Side Attack",
        ["WeaponTransformBlink"] = "Dark Side Sprint",
        ["WeaponTransformCast"] = "Dark Side Cast",
    },
    Zeus = {
        ["Attack"] = "Heaven Strike",
        ["Special"] = "Heaven Flourish",
        ["Dash"] = "Thunder Sprint",
        ["Cast"] = "Storm Ring",
        ["ZeusEchoStrike"] = "Blitz",
        ["ProjectileZeusSpark"] = "Static Shock",
        ["ZeusZeroManaStrike"] = "Spirit Surge",
        ["ZeusRetaliateStrike"] = "Divine Vengeance",
        ["WeaponAnywhereCast"] = "Lightning Lance",
        ["ZeusSprintStrike"] = "Thunder Sprint",
        ["ZeusOnSpawn"] = "Shocking Loss"
    },
    DuoAphroditeHestia = {
        ["ShadeMercFireball"] = "Burning Desire",
    },
    DuoApolloPosedidon = {
        ["ProjectileSprintBall"] = "Beach Ball",
    },
    DuoHephaestusPoseidon = {
        ["MassiveSlamBlastCast"] = "Seismic Hammer",
    },
    DuoHestiaPoseidon = {
        ["SteamBlast"] = "Scalding Vapor"
    }
}

mod.DpsColors = {
    Aphrodite = {
        BarColor = Color.AphroditeDamage,
        Icons = { "Aphrodite" }
    },
    Artemis = {
        BarColor = Color.ArtemisDamage,
        Icons = { "Artemis" }
    },
    ArtemisAssist = {
        BarColor = Color.ArtemisDamageLight,
        LabelColor = Color.ArtemisDamageLight,
        Icons = { "Artemis" }
    },
    Apollo = {
        BarColor = Color.ApolloDamageLight,
        Icons = { "Apollo" }
    },
    Athena = {
        BarColor = Color.AthenaDamageLight,
        Icons = { "Athena" }
    },
    Demeter = {
        BarColor = Color.DemeterDamage,
        Icons = { "Demeter" }
    },
    Hades = {
        BarColor = Color.HadesVoice,
        Icons = { "Hades" }
    },
    Hera = {
        BarColor = Color.HeraDamage,
        Icons = { "Hera" }
    },
    Hestia = {
        BarColor = Color.HestiaDamageLight,
        Icons = { "Hestia" }
    },
    Hephaestus = {
        BarColor = Color.HephaestusDamage,
        Icons = { "Hephaestus" }
    },
    Poseidon = {
        BarColor = Color.PoseidonDamage,
        Icons = { "Poseidon" }
    },
    Selene = {
        BarColor = Color.SeleneVoice,
        Icons = { "Selene" }
    },
    Zeus = {
        BarColor = Color.ZeusDamageLight,
        Icons = { "Zeus" }
    },
    DuoAphroditeHestia = {
        BarColor = Color.BoonPatchDuo,
        Icons = { "Aphrodite", "Hestia" }
    },
    DuoApolloPosedidon = {
        BarColor = Color.BoonPatchDuo,
        Icons = { "Apollo", "Poseidon" }
    },
    DuoHephaestusPoseidon = {
        BarColor = Color.BoonPatchDuo,
        Icons = { "Hephaestus", "Poseidon" }
    },
    DuoHestiaPoseidon = {
        BarColor = Color.BoonPatchDuo,
        Icons = { "Hestia", "Poseidon" }
    },
    NemesisAssist = {
        BarColor = Color.NemesisVoice,
        LabelColor = Color.NemesisVoice
    },
    HeraclesAssist = {
        BarColor = Color.HeraclesVoice,
        LabelColor = Color.HeraclesVoice
    },
    IcarusBoon = {
        BarColor = Color.IcarusVoice
    },
    IcarusAssist = {
        BarColor = Color.IcarusVoice,
        LabelColor = Color.IcarusVoice
    },
    OdysseusKeepsake = {
        BarColor = Color.OdysseusVoice,
        LabelColor = Color.OdysseusVoice
    },
    Shade = {
        BarColor = { 51, 222, 160, 255 },
        LabelColor = { 51, 222, 160, 255 }
    },
    Frinos = {
        BarColor = { 143, 229, 131, 255 },
        LabelColor = { 143, 229, 131, 255 }
    },
    Toula = {
        BarColor = Color.LightGold,
        LabelColor = Color.LightGold
    },
    Default = {
        BarColor = { 195, 175, 175, 255 }
    }
}

mod.Icons = {
    Aphrodite = { Name = "BoonInfoSymbolAphroditeIcon", Scale = 0.15 },
    Apollo = { Name = "BoonInfoSymbolApolloIcon", Scale = 0.2 },
    Artemis = { Name = "GUI\\Screens\\BoonSelectSymbols\\Artemis2", Scale = 0.075 },
    Demeter = { Name = "BoonInfoSymbolDemeterIcon", Scale = 0.21 },
    Hades = { Name = "GUI\\Icons\\Hades_Symbol_01", Scale = 0.09 },
    Hera = { Name = "BoonInfoSymbolHeraIcon", Scale = 0.2 },
    Hestia = { Name = "BoonInfoSymbolHestiaIcon", Scale = 0.2 },
    Hephaestus = { Name = "BoonSymbolHephaestusIcon", Scale = 0.2 },
    Poseidon = { Name = "BoonInfoSymbolPoseidonIcon", Scale = 0.2 },
    Selene = { Name = "Items\\Loot\\SpellDrop_Preview", Scale = 0.2 },
    Zeus = { Name = "BoonInfoSymbolZeusIcon", Scale = 0.2 }
}
