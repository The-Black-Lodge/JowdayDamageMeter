---@meta _
---@diagnostic disable

NameLookup = {
    -- sheep?
    WeaponMorphedAttack = Locale.SheepAttack,
    -- familiars
    FrogFamiliarLand = "Frinos",
    CatFamiliarPounce = "Toula",
    -- misc environment
    PolyphemusBoulderSky = Locale.Boulder,
    --- traps
    FireBarrelExplosion = Locale.FireBarrel,
    FireBarrelFireLob = Locale.FireBarrel,
    SteamWallBlast = Locale.SteamTrap,
    SteamTrapFast = Locale.SteamTrap,
    SteamTrap = Locale.SteamTrap,
    SteamCubeExplosion = Locale.SteamTrap,
    OilPuddleFire = Locale.OilFire,
    OilPuddleFire02 = Locale.OilFire,
    OilPuddleFire03 = Locale.OilFire,
    OilPuddleFire04 = Locale.OilFire,
    DestructibleTreeSplinter = Locale.Splinters,
    BrambleTrap = Locale.BrambleTrap,
    ThornTreeThorn = Locale.ThornTrap,
    FieldsDestructiblePillarDestruction = Locale.Pillar,
    BlastCubeExplosion = Locale.GenericTrap,
    SpikeTrapWeapon = Locale.SpikeTrap,
    LavaTileWeapon = Locale.Lava,
    BaseCollision = Locale.WallSlam,
    BeamTrap = Locale.BeamTrap,
    RubbleFall = Locale.Rubble,
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
    LamiaMiasma = Locale.EnemyText,
    LamiaSkyCast_Miniboss = Locale.EnemyText,
    MournerRampage = Locale.EnemyText,
    LycanSwarmerChomp = Locale.EnemyText,
    CorruptedShadeMRam = Locale.EnemyText,
    LycanthropeLeapKnockback = Locale.EnemyText,
    InfestedCerberusSwipe = Locale.EnemyText,
    SatyrLanceThrow = Locale.EnemyText,
    MageRanged = Locale.EnemyText,
    GuardMelee = Locale.EnemyText,
    PolyphemusStomachAche = Locale.EnemyText,
    -- don't translate these
    HeraCastSummonProjectile = "Cast",
    DemeterSprintStorm = "Dash",
    HephSprintBlast = "Dash",
    PoseidonSprintBlast = "Dash",
    ZeusSprintStrike = "Dash"
}

AttackEXLookup = {
    "WeaponStaffSwing5", "WeaponDagger5", "WeaponAxeSpin", "ProjectileTorchBallLarge", "ProjectileLobCharged"
}

SpecialEXLookup = {
    "ProjectileStaffBallCharged", "WeaponAxeSpecialSwing", "ProjectileTorchOrbit"
}

DashStrikeLookup = {
    "ProjectileDaggerDash", "ProjectileStaffDash", "ProjectileAxeDash"
}

SourceLookup = {
    Aphrodite = {
        ["Attack"] = Locale.AphroditeWeaponBoon,
        ["Special"] = Locale.AphroditeSpecialBoon,
        ["Dash"] = Locale.AphroditeSprintBoon,
        ["Cast"] = Locale.AphroditeCastBoon,
        ["AphroditeBurst"] = Locale.ManaBurstBoon,
    },
    Apollo = {
        ["Attack"] = Locale.ApolloWeaponBoon,
        ["Special"] = Locale.ApolloSpecialBoon,
        ["Dash"] = Locale.ApolloSprintBoon,
        ["Cast"] = Locale.ApolloCastBoon,
        ["ApolloRetaliateStrike"] = Locale.ApolloRetaliateBoon,
        ["ApolloPerfectDashStrike"] = Locale.ApolloMissStrikeBoon
    },
    Artemis = {
        ["ArtemisSupportingFire"] = Locale.SupportingFireBoon,
        ["ArtemisCastVolley"] = Locale.OmegaCastVolleyBoon
    },
    Demeter = {
        ["Attack"] = Locale.DemeterWeaponBoon,
        ["Special"] = Locale.DemeterSpecialBoon,
        ["Dash"] = Locale.DemeterSprintBoon,
        ["Cast"] = Locale.DemeterCastBoon,
        ["DemeterChillKill"] = Locale.InstantRootKill,
    },
    Hades = {
        ["WeaponCastProjectileHades"] = Locale.HadesCastProjectileBoon,
        ["Old Grudge"] = Locale.HadesPreDamageBoon
    },
    Hera = {
        ["Attack"] = Locale.HeraWeaponBoon,
        ["Special"] = Locale.HeraSpecialBoon,
        ["Cast"] = Locale.HeraCastBoon,
        ["HeraDamageShareProjectile"] = Locale.DamageShareRetaliateBoon,
        ["DamageShareEffect"] = Locale.Link,
        ["DamageShareDeath"] = Locale.LinkedDeathDamageBoon
    },
    Hestia = {
        ["Attack"] = Locale.HestiaWeaponBoon,
        ["Special"] = Locale.HestiaSpecialBoon,
        ["Dash"] = Locale.HestiaSprintBoon,
        ["Cast"] = Locale.HestiaCastBoon,
        ["BurnNova"] = Locale.BurnExplodeBoon,
        ["BurnEffect"] = Locale.Burn,
        ["ProjectileFireball"] = Locale.FireballManaSpecialBoon,
        ["WeaponCastProjectile"] = Locale.CastProjectileBoon,
        ["HestiaBurnConsumeStrike"] = Locale.BurnConsumeBoon
    },
    Hephaestus = {
        ["Attack"] = Locale.HephaestusWeaponBoon,
        ["Special"] = Locale.HephaestusSpecialBoon,
        ["Cast"] = Locale.HephaestusCastBoon,
        ["Dash"] = Locale.HephaestusCastBoon,
        ["MassiveSlamBlast"] = Locale.MassiveSlam_Name,
        ["DelayedKnockbackEffect"] = Locale.MassiveKnockupBoon
    },
    IcarusBoon = {
        ["IcarusExplosion"] = Locale.OmegaExplodeBoon,
        ["IcarusHazardExplosion"] = Locale.CastHazardBoon,
        ["IcarusArmorExplosion"] = Locale.BreakExplosiveArmorBoon
    },
    MedeaBoon = {
        ["MedeaCurse"] = Locale.SpawnDamageCurse, -- fallback
        ["SpawnDamageCurse"] = Locale.SpawnDamageCurse,
        ["DeathDefianceRetaliateCurse"] = Locale.DeathDefianceRetaliateCurse,
        ["ArmorPenaltyCurse"] = Locale.ArmorPenaltyCurse
    },
    OdysseusKeepsake = {
        ["Knuckle Bones"] = Locale.BossPreDamageKeepsake
    },
    Poseidon = {
        ["Attack"] = Locale.PoseidonWeaponBoon,
        ["Special"] = Locale.PoseidonSpecialBoon,
        ["Dash"] = Locale.PoseidonSprintBoon,
        ["Cast"] = Locale.PoseidonCastBoon,
        ["PoseidonSplashSplinter"] = Locale.PoseidonSplash_Name,
        ["PoseidonCollisionBlast"] = Locale.SlamExplosionBoon,
    },
    Selene = {
        ["WeaponSpellLaser"] = Locale.SpellLaserTrait,
        ["WeaponSpellLeap"] = Locale.SpellLeapTrait,
        ["WeaponSpellMeteor"] = Locale.SpellMeteorTrait,
        ["WeaponTransformSpecial"] = Locale.SpellTransformTrait .. ' (' .. Locale.SpecialText .. ')',
        ["WeaponTransformAttack"] = Locale.SpellTransformTrait .. ' (' .. Locale.AttackText .. ')',
        ["WeaponTransformBlink"] = Locale.SpellTransformTrait .. ' (' .. Locale.DashText .. ')',
        ["WeaponTransformCast"] = Locale.SpellTransformTrait .. ' (' .. Locale.CastText .. ')',
    },
    Zeus = {
        ["Attack"] = Locale.ZeusWeaponBoon,
        ["Special"] = Locale.ZeusSpecialBoon,
        ["Dash"] = Locale.ZeusSprintBoon,
        ["Cast"] = Locale.ZeusCastBoon,
        ["ZeusEchoStrike"] = Locale.Echo,
        ["ProjectileZeusSpark"] = Locale.FocusLightningBoon,
        ["ZeusZeroManaStrike"] = Locale.ZeusManaBoltBoon,
        ["ZeusRetaliateStrike"] = Locale.BoltRetaliateBoon,
        ["WeaponAnywhereCast"] = Locale.CastAnywhereBoon,
        ["ZeusOnSpawn"] = Locale.SpawnKillBoon
    },
    DuoAphroditeHestia = {
        ["ShadeMercFireball"] = Locale.ShadeMercFireballBoon,
    },
    DuoApolloPosedidon = {
        ["ProjectileSprintBall"] = Locale.PoseidonSplashSprintBoon,
    },
    DuoHephaestusPoseidon = {
        ["MassiveSlamBlastCast"] = Locale.MassiveCastBoon,
    },
    DuoHestiaPoseidon = {
        ["SteamBlast"] = Locale.SteamBoon
    }
}

DpsColors = {
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
    MedeaBoon = {
        BarColor = Color.MedeaVoice
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

Icons = {
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
