JowdayDPS.NameLookup = {
    WeaponDagger = "Attack",
    WeaponDaggerThrow = "Special",
    WeaponCast = "Cast",
    WeaponCastProjectile="Cast",
    WeaponBlink = "Dash",
    --
    WeaponStaffSwing = "Attack",
    WeaponStaffBall = "Special",
    -- artemis assist
    ArtemisSniperBolt = "Artemis",
    -- misc environment
    DestructibleTreeSplinter = "Tree Splinters",
    BaseCollision = "Wall Slam"
}
-- TODO use EnemySets.lua to identify enemies
JowdayDPS.EnemyBucket = {
    "HeavyRangedWeapon",
    "LightRanged",
    "DisembodiedHand",
    "PunchingBag",
    "HeavyMelee",
    "Wretch",
    "Harpy",      -- sisters
    "FreezeShot", -- gorgon stone
    "SpreadShot",
    "Bloodless",
    "RangedBurrower",
    "Hydra",
    "SplitShotUnit",
    "SplitShotWeapon",
    "ChariotRam",
    "Shade",
    "Minotaur",
    "Theseus",
    "Crawler",
    "HadesBident",
    "HadesAmmo",
    "HadesGrasping",
    "HadesCast",
    "Swarmer",
    "StyxPoison",
    "RatThug",
    "RatSpawn",
    "Grenadier",
    "Satyr",
    "FlurrySpawner", -- butterfly ball
    "CharonMelee",
    "CharonWave"
}

JowdayDPS.SourceLookup = {
    Aphrodite = {
        ["Attack"] = "Flutter Strike",
        ["Special"] = "Flutter Flourish",
        ["Dash"] = "Passion Dash",
        ["Cast"] = "Rapture Ring",
        ["AphroditeBurst"] = "Passion Dash"
    },
    Apollo = {
        ["Attack"] = "Nova Strike",
        ["Special"] = "Nova Flourish",
        ["Dash"] = "Blinding Sprint",
        ["Cast"] = "Solar Ring",
        ['ApolloRetaliateStrike'] = "Light Smite",
        ['ApolloPerfectDashStrike'] = "Critical Miss?"
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
        ["DemeterSprintStorm"] = "Frigid Sprint"
    },
    Hestia = {
        ["Attack"] = "Flame Strike",
        ["Special"] = "Flame Flourish",
        ["Dash"] = "Soot Sprint",
        ["Cast"] = "Smolder Ring",
        ["BurnNova"] = "Natural Gas",
        ["BurnEffect"] = "Scorch"
    },
    Hephaestus = {
        ["Attack"] = "Volcanic Strike",
        ["Special"] = "Volcanic Flourish",
        ["Cast"] = "Anvil Ring",
        ["Dash"] = "Smithy Sprint",
        ["MassiveSlamBlast"] = "Blast",
        ["HephSprintBlast"] = "Smithy Sprint"
    },
    Poseidon = {
        ["Attack"] = "Wave Strike",
        ["Special"] = "Wave Flourish",
        ["Dash"] = "Breaker Sprint",
        ["Cast"] = "Geyser Ring",
        ["PoseidonSplashSplinter"] = "Poseidon Waves",
        ["PoseidonSprintBlast"] = "Breaker Sprint",
        ["PoseidonCollisionBlast"] = "Crashing Wave"
    },
    Selene = {
        ["WeaponSpellLaser"] = "Lunar Ray",
        ["WeaponSpellLeap"] = "Wolf Howl",
        ["WeaponSpellMeteor"] = "Meteor"
    },
    Zeus = {
        ["Attack"] = "Heaven Strike",
        ["Special"] = "Heaven Flourish",
        ["Dash"] = "Thunder Sprint",
        ["Cast"] = "Storm Ring",
        ["ZeusEchoStrike"] = "Blitz",
        ["ProjectileZeusSpark"] = "Zeus Spark Thing",
        ["ZeusZeroManaStrike"] = "Spirit Surge",
        ["ZeusRetaliateStrike"] = "Divine Vengeance",
    },
}

JowdayDPS.Attacks = {
    ["Attack"] = true,
    ["Dash-Strike"] = true,
    ["Spin Attack"] = true,
    ["Bull Rush"] = true,
    ["Empowered Shot"] = true
}

JowdayDPS.Specials = {
    ["Special"] = true,
    ["Dash-Upper"] = true,
    ["Recall"] = true,
    ["Raging Rush"] = true,
    ["Dashing Flight"] = true,
    ["Hellfire Detonation"] = true,
    ["Hellfire DoT"] = true,
    ["Quake Cutter"] = true
}

JowdayDPS.DpsColors = {
    Aphrodite = {
        BarColor = Color.AphroditeDamage,
        Icons = { "Aphrodite" }
    },
    Artemis = {
        BarColor = Color.ArtemisDamage,
        Icons = { "Artemis" }
    },
    Apollo = {
        BarColor = Color.ApolloDamageLight
    },
    Athena = {
        BarColor = Color.AthenaDamageLight,
        Icons = { "Athena" }
    },
    Demeter = {
        BarColor = Color.DemeterDamage,
        Icons = { "Demeter" }
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
        BarColor = Color.SeleneVoice
    },
    Zeus = {
        BarColor = Color.ZeusDamageLight,
        Icons = { "Zeus" }
    },
    Default = {
        BarColor = Color.White
    }
}
