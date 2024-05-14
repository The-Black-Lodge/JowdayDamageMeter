---@meta _

local mod = JowdayDPS

mod.NameLookup = {
    -- sheep?
    WeaponMorphedAttack = mod.Locale.SheepAttack,
    -- familiars
    FrogFamiliarLand = "Frinos",
    CatFamiliarPounce = "Toula",
    -- misc environment
    PolyphemusBoulderSky = mod.Locale.Boulder,
    ShadeMercSpiritball = mod.Locale.ShadeSprint,
    SoulPylonSpiritball = mod.Locale.EphyraPylon,
    --- traps
    FireBarrelExplosion = mod.Locale.FireBarrel,
    FireBarrelFireLob = mod.Locale.FireBarrel,
    SteamWallBlast = mod.Locale.SteamTrap,
    SteamTrapFast = mod.Locale.SteamTrap,
    SteamTrap = mod.Locale.SteamTrap,
    SteamCubeExplosion = mod.Locale.SteamTrap,
    OilPuddleFire = mod.Locale.OilFire,
    OilPuddleFire02 = mod.Locale.OilFire,
    OilPuddleFire03 = mod.Locale.OilFire,
    OilPuddleFire04 = mod.Locale.OilFire,
    DestructibleTreeSplinter = mod.Locale.Splinters,
    BrambleTrap = mod.Locale.BrambleTrap,
    ThornTreeThorn = mod.Locale.ThornTrap,
    FieldsDestructiblePillarDestruction = mod.Locale.Pillar,
    BlastCubeExplosion = mod.Locale.GenericTrap,
    SpikeTrapWeapon = mod.Locale.SpikeTrap,
    LavaTileWeapon = mod.Locale.Lava,
    BaseCollision = mod.Locale.WallSlam,
    BeamTrap = mod.Locale.BeamTrap,
    RubbleFall = mod.Locale.Rubble,
    --
    WeaponDagger = "Attack",
    WeaponDaggerThrow = "Special",
    WeaponCast = "Cast",
    WeaponBlink = "Dash",
    --
    WeaponStaffSwing = "Attack",
    WeaponStaffBall = "Special",
    --
    WeaponTorch = "Attack",
    WeaponTorchSpecial = "Special",
    --
    WeaponAxe = "Attack",
    WeaponAxeSpecialSwing = "Special",
    WeaponAxeDash = "Attack",
    WeaponAxeSpin = "Attack",
    WeaponAxeBlock2 = "Special",
    --
    WeaponLob = "Attack",
    WeaponLobSpecial = "Special",
    WeaponLobPulse = "Attack",
    -- artemis assist
    ArtemisSniperBolt = "Artemis",
    ArtemisVolleyShot = "Artemis",
    -- nemesis assist
    NemesisSpecial = "Nemesis",
    NemesisAttack1 = "Nemesis",
    NemesisAttack2 = "Nemesis",
    NemesisAttack3 = "Nemesis",
    NemesisDash = "Nemesis",
    -- heracles assist
    HeraclesLeap = "Heracles",
    HeraclesArcRight = "Heracles",
    -- icarus assist / boon
    IcarusBombardment = "Icarus",
    IcarusBombardment_Large = "Icarus",
    --
    LamiaMiasma = mod.Locale.EnemyText,
    LamiaSkyCast_Miniboss = mod.Locale.EnemyText,
    MournerRampage = mod.Locale.EnemyText,
    LycanSwarmerChomp = mod.Locale.EnemyText,
    CorruptedShadeMRam = mod.Locale.EnemyText,
    LycanthropeLeapKnockback = mod.Locale.EnemyText,
    InfestedCerberusSwipe = mod.Locale.EnemyText,
    SatyrLanceThrow = mod.Locale.EnemyText,
    -- don't translate these
    HeraCastSummonProjectile = "Cast",
    DemeterSprintStorm = "Dash",
    HephSprintBlast = "Dash",
    PoseidonSprintBlast = "Dash",
    ZeusSprintStrike = "Dash"
}

mod.SourceLookup = {
    Aphrodite = {
        ["Attack"] = mod.Locale.AphroditeWeaponBoon,
        ["Special"] = mod.Locale.AphroditeSpecialBoon,
        ["Dash"] = mod.Locale.AphroditeSprintBoon,
        ["Cast"] = mod.Locale.AphroditeCastBoon,
        ["AphroditeBurst"] = mod.Locale.ManaBurstBoon,
    },
    Apollo = {
        ["Attack"] = mod.Locale.ApolloWeaponBoon,
        ["Special"] = mod.Locale.ApolloSpecialBoon,
        ["Dash"] = mod.Locale.ApolloSprintBoon,
        ["Cast"] = mod.Locale.ApolloCastBoon,
        ["ApolloRetaliateStrike"] = mod.Locale.ApolloRetaliateBoon,
        ["ApolloPerfectDashStrike"] = mod.Locale.ApolloMissStrikeBoon
    },
    Artemis = {
        ["ArtemisSupportingFire"] = mod.Locale.SupportingFireBoon,
        ["ArtemisCastVolley"] = mod.Locale.OmegaCastVolleyBoon
    },
    Demeter = {
        ["Attack"] = mod.Locale.DemeterWeaponBoon,
        ["Special"] = mod.Locale.DemeterSpecialBoon,
        ["Dash"] = mod.Locale.DemeterSprintBoon,
        ["Cast"] = mod.Locale.DemeterCastBoon,
        ["DemeterChillKill"] = mod.Locale.InstantRootKill,
    },
    Hades = {
        ["WeaponCastProjectileHades"] = mod.Locale.HadesCastProjectileBoon,
        ["Old Grudge"] = mod.Locale.HadesPreDamageBoon
    },
    Hera = {
        ["Attack"] = mod.Locale.HeraWeaponBoon,
        ["Special"] = mod.Locale.HeraSpecialBoon,
        ["Cast"] = mod.Locale.HeraCastBoon,
        ["HeraDamageShareProjectile"] = mod.Locale.DamageShareRetaliateBoon,
        ["DamageShareEffect"] = mod.Locale.Link,
        ["DamageShareDeath"] = mod.Locale.LinkedDeathDamageBoon
    },
    Hestia = {
        ["Attack"] = mod.Locale.HestiaWeaponBoon,
        ["Special"] = mod.Locale.HestiaSpecialBoon,
        ["Dash"] = mod.Locale.HestiaSprintBoon,
        ["Cast"] = mod.Locale.HestiaCastBoon,
        ["BurnNova"] = mod.Locale.BurnExplodeBoon,
        ["BurnEffect"] = mod.Locale.Burn,
        ["ProjectileFireball"] = mod.Locale.FireballManaSpecialBoon,
        ["WeaponCastProjectile"] = mod.Locale.CastProjectileBoon
    },
    Hephaestus = {
        ["Attack"] = mod.Locale.HephaestusWeaponBoon,
        ["Special"] = mod.Locale.HephaestusSpecialBoon,
        ["Cast"] = mod.Locale.HephaestusCastBoon,
        ["Dash"] = mod.Locale.HephaestusCastBoon,
        ["MassiveSlamBlast"] = mod.Locale.MassiveSlam_Name,
        ["DelayedKnockbackEffect"] = mod.Locale.MassiveKnockupBoon
    },
    IcarusBoon = {
        ["IcarusExplosion"] = mod.Locale.OmegaExplodeBoon,
        ["IcarusHazardExplosion"] = mod.Locale.CastHazardBoon,
        ["IcarusArmorExplosion"] = mod.Locale.BreakExplosiveArmorBoon
    },
    OdysseusKeepsake = {
        ["Knuckle Bones"] = mod.Locale.BossPreDamageKeepsake
    },
    Poseidon = {
        ["Attack"] = mod.Locale.PoseidonWeaponBoon,
        ["Special"] = mod.Locale.PoseidonSpecialBoon,
        ["Dash"] = mod.Locale.PoseidonSprintBoon,
        ["Cast"] = mod.Locale.PoseidonCastBoon,
        ["PoseidonSplashSplinter"] = mod.Locale.PoseidonSplash_Name,
        ["PoseidonCollisionBlast"] = mod.Locale.SlamExplosionBoon,
    },
    Selene = {
        ["WeaponSpellLaser"] = mod.Locale.SpellLaserTrait,
        ["WeaponSpellLeap"] = mod.Locale.SpellLeapTrait,
        ["WeaponSpellMeteor"] = mod.Locale.SpellMeteorTrait,
        ["WeaponTransformSpecial"] = mod.Locale.SpellTransformTrait .. ' (' .. mod.Locale.SpecialText .. ')',
        ["WeaponTransformAttack"] = mod.Locale.SpellTransformTrait .. ' (' .. mod.Locale.AttackText .. ')',
        ["WeaponTransformBlink"] = mod.Locale.SpellTransformTrait .. ' (' .. mod.Locale.DashText .. ')',
        ["WeaponTransformCast"] = mod.Locale.SpellTransformTrait .. ' (' .. mod.Locale.CastText .. ')',
    },
    Zeus = {
        ["Attack"] = mod.Locale.ZeusWeaponBoon,
        ["Special"] = mod.Locale.ZeusSpecialBoon,
        ["Dash"] = mod.Locale.ZeusSprintBoon,
        ["Cast"] = mod.Locale.ZeusCastBoon,
        ["ZeusEchoStrike"] = mod.Locale.Echo,
        ["ProjectileZeusSpark"] = mod.Locale.FocusLightningBoon,
        ["ZeusZeroManaStrike"] = mod.Locale.ZeusManaBoltBoon,
        ["ZeusRetaliateStrike"] = mod.Locale.BoltRetaliateBoon,
        ["WeaponAnywhereCast"] = mod.Locale.CastAnywhereBoon,
        ["ZeusOnSpawn"] = mod.Locale.SpawnKillBoon
    },
    DuoAphroditeHestia = {
        ["ShadeMercFireball"] = mod.Locale.ShadeMercFireballBoon,
    },
    DuoApolloPosedidon = {
        ["ProjectileSprintBall"] = mod.Locale.PoseidonSplashSprintBoon,
    },
    DuoHephaestusPoseidon = {
        ["MassiveSlamBlastCast"] = mod.Locale.MassiveCastBoon,
    },
    DuoHestiaPoseidon = {
        ["SteamBlast"] = mod.Locale.SteamBoon
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
