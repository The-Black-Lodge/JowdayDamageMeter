---@meta _
---@diagnostic disable

local mod = JowdayDPS

mod.NameLookup = {}
mod.SourceLookup = {}

function mod.getLocalizedNames()
    local omegaPrefix = mod.Config.OmegaIndicator
    local oAttackText = omegaPrefix .. GetDisplayName({ Text = "Attack" })
    local oSpecialText = omegaPrefix .. GetDisplayName({ Text = "Special" })
    local oCastText = omegaPrefix .. GetDisplayName({ Text = "Cast" })
    local aphOAttack = omegaPrefix .. GetDisplayName({ Text = "AphroditeWeaponBoon" })
    local aphOSpecial = omegaPrefix .. GetDisplayName({ Text = "AphroditeSpecialBoon" })
    local apoOAttack = omegaPrefix .. GetDisplayName({ Text = "ApolloWeaponBoon" })
    local apoOSpecial = omegaPrefix .. GetDisplayName({ Text = "ApolloSpecialBoon" })
    local apoOCast = omegaPrefix .. GetDisplayName({Text = "ApolloExCastBoon"})
    local demOAttack = omegaPrefix .. GetDisplayName({ Text = "DemeterWeaponBoon" })
    local demOSpecial = omegaPrefix .. GetDisplayName({ Text = "DemeterSpecialBoon" })
    local herOAttack = omegaPrefix .. GetDisplayName({ Text = "HeraWeaponBoon" })
    local herOSpecial = omegaPrefix .. GetDisplayName({ Text = "HeraSpecialBoon" })
    local herOCast = omegaPrefix .. GetDisplayName({Text = "OmegaHeraProjectileBoon"})
    local hesOAttack = omegaPrefix .. GetDisplayName({ Text = "HestiaWeaponBoon" })
    local hesOSpecial = omegaPrefix .. GetDisplayName({ Text = "HestiaSpecialBoon" })
    local hepOAttack = omegaPrefix .. GetDisplayName({ Text = "HephaestusWeaponBoon" })
    local hepOSpecial = omegaPrefix .. GetDisplayName({ Text = "HephaestusSpecialBoon" })
    local posOAttack = omegaPrefix .. GetDisplayName({ Text = "PoseidonWeaponBoon" })
    local posOSpecial = omegaPrefix .. GetDisplayName({ Text = "PoseidonSpecialBoon" })
    local posOCast = omegaPrefix .. GetDisplayName( { Text = "OmegaPoseidonProjectileBoon" } )
    local zeuOAttack = omegaPrefix .. GetDisplayName({ Text = "ZeusWeaponBoon" })
    local zeuOSpecial = omegaPrefix .. GetDisplayName({ Text = "ZeusSpecialBoon" })
    local spellTransformTrait = GetDisplayName({ Text = "SpellTransformTrait" })
    local darkSideAttack = spellTransformTrait .. ' (' .. GetDisplayName({ Text = "Attack" }) .. ')'
    local darkSideSpecial = spellTransformTrait .. ' (' .. GetDisplayName({ Text = "Special" }) .. ')'
    local darkSideBlink = spellTransformTrait .. ' (' .. GetDisplayName({ Text = "Dash" }) .. ')'
    local darkSideCast = spellTransformTrait .. ' (' .. GetDisplayName({ Text = "Cast" }) .. ')'

    mod.NameLookup = {
        -- sheep?
        WeaponMorphedAttack = mod.Locale.SheepAttack,
        -- familiars
        FrogFamiliarLand = "Frinos",
        CatFamiliarPounce = "Toula",
        -- misc environment
        PolyphemusBoulderSky = mod.Locale.Boulder,
        --- traps
        FireBarrelExplosion = "Traps",
        FireBarrelFireLob = "Traps",
        SteamWallBlast = "Traps",
        SteamTrapFast = "Traps",
        SteamTrap = "Traps",
        SteamCubeExplosion = "Traps",
        OilPuddleFire = "Traps",
        OilPuddleFire02 = "Traps",
        OilPuddleFire03 = "Traps",
        OilPuddleFire04 = "Traps",
        DestructibleTreeSplinter = "Traps",
        BrambleTrap = "Traps",
        ThornTreeThorn = "Traps",
        FieldsDestructiblePillarDestruction = "Traps",
        BlastCubeExplosion = "Traps",
        SpikeTrapWeapon = "Traps",
        LavaTileWeapon = "Traps",
        BaseCollision = "Traps",
        BeamTrap = "Traps",
        RubbleFall = "Traps",
        --
        OAttackText = oAttackText,
        OSpecialText = oSpecialText,
        OCastText = oCastText,
        --
        WeaponDagger = "Attack",
        WeaponDaggerThrow = "Special",
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
        LamiaMiasma = mod.Locale.EnemyText,
        LamiaSkyCast_Miniboss = mod.Locale.EnemyText,
        MournerRampage = mod.Locale.EnemyText,
        LycanSwarmerChomp = mod.Locale.EnemyText,
        CorruptedShadeMRam = mod.Locale.EnemyText,
        LycanthropeLeapKnockback = mod.Locale.EnemyText,
        InfestedCerberusSwipe = mod.Locale.EnemyText,
        SatyrLanceThrow = mod.Locale.EnemyText,
        MageRanged = mod.Locale.EnemyText,
        GuardMelee = mod.Locale.EnemyText,
        PolyphemusStomachAche = mod.Locale.EnemyText,
        -- don't translate these
        HeraCastSummonProjectile = "WeaponCast",
        DemeterSprintStorm = "Dash",
        HephSprintBlast = "Dash",
        PoseidonSprintBlast = "Dash",
        ZeusSprintStrike = "Dash",
        PoseidonCastSplashSplinter = "WeaponCast",
        AphroditeCastProjectile = "WeaponCast",
    }

    mod.SourceLookup = {
        Aphrodite = {
            ["Attack"] = "AphroditeWeaponBoon",
            ["OAttack"] = aphOAttack,
            ["Special"] = "AphroditeSpecialBoon",
            ["OSpecial"] = aphOSpecial,
            ["Dash"] = "AphroditeSprintBoon",
            ["WeaponCast"] = "AphroditeCastBoon",
            ["AphroditeBurst"] = "ManaBurstBoon",
        },
        Apollo = {
            ["Attack"] = "ApolloWeaponBoon",
            ["OAttack"] = apoOAttack,
            ["Special"] = "ApolloSpecialBoon",
            ["OSpecial"] = apoOSpecial,
            ["Dash"] = "ApolloSprintBoon",
            ["ApolloSingleCastStrike"] = "ApolloCastBoon",
            ["WeaponCast"] = apoOCast,
            ["ApolloRetaliateStrike"] = "ApolloRetaliateBoon",
            ["ApolloPerfectDashStrike"] = "ApolloMissStrikeBoon",
        },
        Artemis = {
            ["ArtemisSupportingFire"] = "SupportingFireBoon",
            ["ArtemisCastVolley"] = "OmegaCastVolleyBoon"
        },
        Demeter = {
            ["Attack"] = "DemeterWeaponBoon",
            ["OAttack"] = demOAttack,
            ["Special"] = "DemeterSpecialBoon",
            ["OSpecial"] = demOSpecial,
            ["DemeterSprintStorm"] = "DemeterSprintBoon",
            ["WeaponCast"] = "DemeterCastBoon",
            ["DemeterChillKill"] = "InstantRootKill",
        },
        Hades = {
            ["WeaponCastProjectileHades"] = "HadesCastProjectileBoon",
            ["Old Grudge"] = "HadesPreDamageBoon"
        },
        Hera = {
            ["Attack"] = "HeraWeaponBoon",
            ["OAttack"] = herOAttack,
            ["Special"] = "HeraSpecialBoon",
            ["OSpecial"] = herOSpecial,
            ["WeaponCast"] = "HeraCastBoon",
            ["HeraDamageShareProjectile"] = "DamageShareRetaliateBoon",
            ["DamageShareEffect"] = "Link",
            ["DamageShareDeath"] = "LinkedDeathDamageBoon",
            ["ProjectileHeraOmega"] = herOCast,
            ["LinkNova"] = "SpawnCastDamageBoon"
        },
        Hestia = {
            ["Attack"] = "HestiaWeaponBoon",
            ["OAttack"] = hesOAttack,
            ["Special"] = "HestiaSpecialBoon",
            ["OSpecial"] = hesOSpecial,
            ["Dash"] = "HestiaSprintBoon",
            ["WeaponCast"] = "HestiaCastBoon",
            ["BurnNova"] = "BurnExplodeBoon",
            ["BurnEffect"] = "Burn",
            ["ProjectileFireball"] = "FireballManaSpecialBoon",
            ["WeaponCastProjectile"] = "CastProjectileBoon",
            ["HestiaBurnConsumeStrike"] = "BurnConsumeBoon",
            ["HestiaSprintPuddle"] = "BurnSprintBoon"
        },
        Hephaestus = {
            ["Attack"] = "HephaestusWeaponBoon",
            ["OAttack"] = hepOAttack,
            ["Special"] = "HephaestusSpecialBoon",
            ["OSpecial"] = hepOSpecial,
            ["WeaponCast"] = "HephaestusCastBoon",
            ["Dash"] = "HephaestusCastBoon",
            ["MassiveSlamBlast"] = "MassiveSlam_Name",
            ["DelayedKnockbackEffect"] = "MassiveKnockupBoon"
        },
        IcarusBoon = {
            ["IcarusExplosion"] = "OmegaExplodeBoon",
            ["IcarusHazardExplosion"] = "CastHazardBoon",
            ["IcarusArmorExplosion"] = "BreakExplosiveArmorBoon"
        },
        MedeaBoon = {
            ["MedeaCurse"] = "SpawnDamageCurse", -- fallback
            ["SpawnDamageCurse"] = "SpawnDamageCurse",
            ["DeathDefianceRetaliateCurse"] = "DeathDefianceRetaliateCurse",
            ["ArmorPenaltyCurse"] = "ArmorPenaltyCurse"
        },
        OdysseusKeepsake = {
            ["Knuckle Bones"] = "BossPreDamageKeepsake"
        },
        Poseidon = {
            ["Attack"] = "PoseidonWeaponBoon",
            ["OAttack"] = posOAttack,
            ["Special"] = "PoseidonSpecialBoon",
            ["OSpecial"] = posOSpecial,
            ["Dash"] = "PoseidonSprintBoon",
            ["WeaponCast"] = "PoseidonCastBoon",
            ["PoseidonSplashSplinter"] = "PoseidonSplash_Name",
            ["PoseidonCollisionBlast"] = "SlamExplosionBoon",
            ["PoseidonOmegaProjectile"] = posOCast
        },
        Selene = {
            ["WeaponSpellLaser"] = "SpellLaserTrait",
            ["WeaponSpellLeap"] = "SpellLeapTrait",
            ["WeaponSpellMeteor"] = "SpellMeteorTrait",
            ["WeaponTransformAttack"] = darkSideAttack,
            ["WeaponTransformSpecial"] = darkSideSpecial,
            ["WeaponTransformBlink"] = darkSideBlink,
            ["WeaponTransformCast"] = darkSideCast,
        },
        Zeus = {
            ["Attack"] = "ZeusWeaponBoon",
            ["OAttack"] = zeuOAttack,
            ["Special"] = "ZeusSpecialBoon",
            ["OSpecial"] = zeuOSpecial,
            ["Dash"] = "ZeusSprintBoon",
            ["WeaponCast"] = "ZeusCastBoon",
            ["ZeusEchoStrike"] = "Echo",
            ["ProjectileZeusSpark"] = "FocusLightningBoon",
            ["ZeusZeroManaStrike"] = "ZeusManaBoltBoon",
            ["ZeusRetaliateStrike"] = "BoltRetaliateBoon",
            ["WeaponAnywhereCast"] = "CastAnywhereBoon",
            ["ZeusOnSpawn"] = "SpawnKillBoon"
        },
        DuoAphroditeHestia = {
            ["ShadeMercFireball"] = "ShadeMercFireballBoon"
        },
        DuoApolloDemeter = {
            ["DemeterMiniStorm"] = "StormSpawnBoon"
        },
        DuoApolloPosedidon = {
            ["ProjectileSprintBall"] = "PoseidonSplashSprintBoon"
        },
        DuoHephaestusPoseidon = {
            ["MassiveSlamBlastCast"] = "MassiveCastBoon"
        },
        DuoHestiaPoseidon = {
            ["SteamBlast"] = "SteamBoon"
        }
    }
end

mod.AttackEXLookup = {
    "WeaponStaffSwing5", "WeaponDagger5", "WeaponAxeSpin", "ProjectileTorchBallLarge", "ProjectileLobCharged"
}

mod.SpecialEXLookup = {
    "ProjectileStaffBallCharged", "WeaponAxeSpecialSwing", "ProjectileTorchOrbit"
}

mod.DashStrikeLookup = {
    "ProjectileDaggerDash", "ProjectileStaffDash", "ProjectileAxeDash"
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
    DuoApolloDemeter = {
        BarColor = Color.BoonPatchDuo,
        Icons = { "Apollo", "Demeter" }
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
