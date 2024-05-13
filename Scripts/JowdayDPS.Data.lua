---@meta _

JowdayDPS.NameLookup = {
    WeaponDagger = "Attack",
    WeaponDaggerThrow = "Special",
    WeaponCast = "Cast",
    WeaponCastProjectile = "Cast",
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
    -- sheep?
    WeaponMorphedAttack = "Sheep Attack",
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
    IcarusExplosion = "Explosive Intent",
    -- misc environment
    DestructibleTreeSplinter = "Splinters",
    SteamWallBlast = "Steam Trap",
    SteamTrapFast = "Steam Trap",
    SteamCubeExplosion = "Steam Trap",
    BrambleTrap = "Brambles",
    ThornTreeThorn = "Thorns",
    FieldsDestructiblePillarDestruction = "Collapsing Pillar",
    SpikeTrapWeapon = "Spikes",
    LavaTileWeapon = "Lava",
    BaseCollision = "Wall Slam",
    BeamTrap = "Beam",
    FireBarrelExplosion = "Fire Barrel",
    FireBarrelFireLob = "Fire Barrel",
    PolyphemusBoulderSky = "Polyphemus Boulder",
    OilPuddleFire = "Oil Fire",
    OilPuddleFire02 = "Oil Fire",
    OilPuddleFire03 = "Oil Fire",
    OilPuddleFire04 = "Oil Fire",
    RubbleFall = "Falling Rubble",
    -- also misc
    HeraCastSummonProjectile = "Cast",
    LamiaMiasma = "Enemy",
    LamiaSkyCast_Miniboss = "Enemy",
    MournerRampage = "Enemy",
    LycanSwarmerChomp = "Enemy",
    CorruptedShadeMRam = "Enemy",
    LycanthropeLeapKnockback = "Enemy",
    InfestedCerberusSwipe = "Enemy",
    SatyrLanceThrow = "Enemy",
    ShadeMercSpiritball = "Necromantic Influence",
    FrogFamiliarLand = "Frinos",
    CatFamiliarPounce = "Toula",
    SoulPylonSpiritball = "Pylon Spirits"
}

JowdayDPS.SourceLookup = {
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
        --["HeraCastSummonProjectile"] = "Engagement Ring",
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
        ["SteamBlast"] = "Steam"
    }
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
    Icarus = {
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

JowdayDPS.Icons = {
    Aphrodite = { Name = "BoonSymbolAphroditeIcon" },
    Apollo = { Name = "BoonInfoSymbolApolloIcon" },
    Artemis = { Name = "BoonSymbolArtemisIcon" },
    Demeter = { Name = "BoonInfoSymbolDemeterIcon" },
    Hades = { Name = "Boon_Hades_01" },
    Hera = { Name = "BoonInfoSymbolHeraIcon" },
    Hestia = { Name = "BoonInfoSymbolHestiaIcon" },
    Hephaestus = { Name = "BoonSymbolHephaestusIcon" },
    Poseidon = { Name = "BoonInfoSymbolPoseidonIcon" },
    Selene = { Name = "Boon_Selene_01" },
    Zeus = { Name = "BoonInfoSymbolZeusIcon" }
}
