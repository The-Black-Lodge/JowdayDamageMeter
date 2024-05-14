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
-- these correspond with Id/DisplayName in TraitText.[lang].sjson or HelpText.[lang].sjson
-- aphrodite
mod.AphroditeWeaponBoon = "Flutter Strike"
mod.AphroditeSpecialBoon = "Flutter Flourish"
mod.AphroditeCastBoon = "Rapture Ring"
mod.AphroditeSprintBoon = "Passion Dash"
mod.ManaBurstBoon = "Heart Breaker"
-- apollo
mod.ApolloWeaponBoon = "Nova Strike"
mod.ApolloSpecialBoon = "Nova Flourish"
mod.ApolloCastBoon = "Solar Ring"
mod.ApolloSprintBoon = "Blinding Sprint"
mod.ApolloRetaliateBoon = "Light Smite"
mod.ApolloMissStrikeBoon = "Critical Miss"
-- artemis
mod.SupportingFireBoon = "Support Fire"
mod.OmegaCastVolleyBoon = "Easy Shot"
-- demeter
mod.DemeterWeaponBoon = "Ice Strike"
mod.DemeterSpecialBoon = "Ice Flourish"
mod.DemeterCastBoon = "Arctic Ring"
mod.DemeterSprintBoon = "Frigid Sprint"
mod.InstantRootKill = "Winter Harvest"
-- hades
mod.HadesCastProjectileBoon = "Howling Soul"
mod.HadesPreDamageBoon = "Old Grudge"
-- hera
mod.HeraWeaponBoon = "Sworn Strike"
mod.HeraSpecialBoon = "Sworn Flourish"
mod.HeraCastBoon = "Engagement Ring"
mod.HeraSprintBoon = "Nexus Sprint" -- not currently used
mod.DamageShareRetaliateBoon = "Nasty Comeback"
mod.Link = "Hitch" --HelpText
mod.LinkedDeathDamageBoon = "Dying Wish"
-- hestia
mod.HestiaWeaponBoon = "Flame Strike"
mod.HestiaSpecialBoon = "Flame Flourish"
mod.HestiaSprintBoon = "Soot Sprint"
mod.HestiaCastBoon = "Smolder Ring"
mod.BurnExplodeBoon = "Natural Gas"
mod.Burn = "Scorch" -- HelpText
mod.FireballManaSpecialBoon = "Controlled Burn"
mod.CastProjectileBoon = "Glowing Coal"
-- hephaestus
mod.HephaestusWeaponBoon = "Volcanic Strike"
mod.HephaestusSpecialBoon = "Volcanic Flourish"
mod.HephaestusCastBoon = "Anvil Ring"
mod.HephaestusSprintBoon = "Smithy Sprint"
mod.MassiveSlam_Name = "Blast"
mod.MassiveKnockupBoon = "Furnace Blast"
-- icarus
mod.OmegaExplodeBoon = "Explosive Intent"
mod.CastHazardBoon = "Hazard Boom"
mod.BreakExplosiveArmorBoon = "Destructive Coating"
-- odysseus
mod.BossPreDamageKeepsake = "Knuckle Bones"
-- poseidon
mod.PoseidonWeaponBoon = "Wave Strike"
mod.PoseidonSpecialBoon = "Wave Flourish"
mod.PoseidonCastBoon = "Geyser Ring"
mod.PoseidonSprintBoon = "Breaker Sprint"
mod.PoseidonSplash_Name = "Waves"
mod.SlamExplosionBoon = "Crashing Wave"
-- selene
mod.SpellLaserTrait = "Lunar Ray"
mod.SpellLeapTrait = "Wolf Howl"
mod.SpellMeteorTrait = "Total Eclipse"
mod.SpellTransformTrait = "Dark Side"
-- zeus
mod.ZeusWeaponBoon = "Heaven Strike"
mod.ZeusSpecialBoon = "Heaven Flourish"
mod.ZeusSprintBoon = "Thunder Sprint"
mod.ZeusCastBoon = "Storm Ring"
mod.Echo = "Blitz" -- HelpText
mod.FocusLightningBoon = "Static Shock"
mod.ZeusManaBoltBoon = "Spirit Surge"
mod.BoltRetaliateBoon = "Divine Vengeance"
mod.CastAnywhereBoon = "Lightning Lance"
mod.SpawnKillBoon = "Shocking Loss"
-- duo
mod.ShadeMercFireballBoon = "Burning Desire" -- aphrodite x hestia
mod.PoseidonSplashSprintBoon = "Beach Ball"  -- apollo x poseidon
mod.MassiveCastBoon = "Seismic Hammer"  -- hephaestus x poseidon
mod.SteamBoon = "Scalding Vapor" -- hestia x poseidon

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
    -- don't translate these
    HeraCastSummonProjectile = "Cast",
    DemeterSprintStorm = "Dash",
    HephSprintBlast = "Dash",
    PoseidonSprintBlast = "Dash",
    ZeusSprintStrike = "Dash"
}

mod.SourceLookup = {
    Aphrodite = {
        ["Attack"] = mod.AphroditeWeaponBoon,
        ["Special"] = mod.AphroditeSpecialBoon,
        ["Dash"] = mod.AphroditeSprintBoon,
        ["Cast"] = mod.AphroditeCastBoon,
        ["AphroditeBurst"] = mod.ManaBurstBoon,
    },
    Apollo = {
        ["Attack"] = mod.ApolloWeaponBoon,
        ["Special"] = mod.ApolloSpecialBoon,
        ["Dash"] = mod.ApolloSprintBoon,
        ["Cast"] = mod.ApolloCastBoon,
        ["ApolloRetaliateStrike"] = mod.ApolloRetaliateBoon,
        ["ApolloPerfectDashStrike"] = mod.ApolloMissStrikeBoon
    },
    Artemis = {
        ["ArtemisSupportingFire"] = mod.SupportingFireBoon,
        ["ArtemisCastVolley"] = mod.OmegaCastVolleyBoon
    },
    Demeter = {
        ["Attack"] = mod.DemeterWeaponBoon,
        ["Special"] = mod.DemeterSpecialBoon,
        ["Dash"] = mod.DemeterSprintBoon,
        ["Cast"] = mod.DemeterCastBoon,
        ["DemeterChillKill"] = mod.InstantRootKill,
    },
    Hades = {
        ["WeaponCastProjectileHades"] = mod.HadesCastProjectileBoon,
        ["Old Grudge"] = mod.HadesPreDamageBoon
    },
    Hera = {
        ["Attack"] = mod.HeraWeaponBoon,
        ["Special"] = mod.HeraSpecialBoon,
        ["Cast"] = mod.HeraCastBoon,
        ["HeraDamageShareProjectile"] = mod.DamageShareRetaliateBoon,
        ["DamageShareEffect"] = mod.Link,
        ["DamageShareDeath"] = mod.LinkedDeathDamageBoon
    },
    Hestia = {
        ["Attack"] = mod.HestiaWeaponBoon,
        ["Special"] = mod.HestiaSpecialBoon,
        ["Dash"] = mod.HestiaSprintBoon,
        ["Cast"] = mod.HestiaCastBoon,
        ["BurnNova"] = mod.BurnExplodeBoon,
        ["BurnEffect"] = mod.Burn,
        ["ProjectileFireball"] = mod.FireballManaSpecialBoon,
        ["WeaponCastProjectile"] = mod.CastProjectileBoon
    },
    Hephaestus = {
        ["Attack"] = mod.HephaestusWeaponBoon,
        ["Special"] = mod.HephaestusSpecialBoon,
        ["Cast"] = mod.HephaestusCastBoon,
        ["Dash"] = mod.HephaestusCastBoon,
        ["MassiveSlamBlast"] = mod.MassiveSlam_Name,
        ["DelayedKnockbackEffect"] = mod.MassiveKnockupBoon
    },
    IcarusBoon = {
        ["IcarusExplosion"] = mod.OmegaExplodeBoon,
        ["IcarusHazardExplosion"] = mod.CastHazardBoon,
        ["IcarusArmorExplosion"] = mod.BreakExplosiveArmorBoon
    },
    OdysseusKeepsake = {
        ["Knuckle Bones"] = mod.BossPreDamageKeepsake
    },
    Poseidon = {
        ["Attack"] = mod.PoseidonWeaponBoon,
        ["Special"] = mod.PoseidonSpecialBoon,
        ["Dash"] = mod.PoseidonSprintBoon,
        ["Cast"] = mod.PoseidonCastBoon,
        ["PoseidonSplashSplinter"] = mod.PoseidonSplash_Name,
        ["PoseidonCollisionBlast"] = mod.SlamExplosionBoon,
    },
    Selene = {
        ["WeaponSpellLaser"] = mod.SpellLaserTrait,
        ["WeaponSpellLeap"] = mod.SpellLeapTrait,
        ["WeaponSpellMeteor"] = mod.SpellMeteorTrait,
        ["WeaponTransformSpecial"] = mod.SpellTransformTrait .. ' ' .. mod.SpecialText,
        ["WeaponTransformAttack"] = mod.SpellTransformTrait .. ' ' .. mod.AttackText,
        ["WeaponTransformBlink"] = mod.SpellTransformTrait .. ' ' .. mod.DashText,
        ["WeaponTransformCast"] = mod.SpellTransformTrait .. ' ' .. mod.CastText,
    },
    Zeus = {
        ["Attack"] = mod.ZeusWeaponBoon,
        ["Special"] = mod.ZeusSpecialBoon,
        ["Dash"] = mod.ZeusSprintBoon,
        ["Cast"] = mod.ZeusCastBoon,
        ["ZeusEchoStrike"] = mod.Echo,
        ["ProjectileZeusSpark"] = mod.FocusLightningBoon,
        ["ZeusZeroManaStrike"] = mod.ZeusManaBoltBoon,
        ["ZeusRetaliateStrike"] = mod.BoltRetaliateBoon,
        ["WeaponAnywhereCast"] = mod.CastAnywhereBoon,
        ["ZeusOnSpawn"] = mod.SpawnKillBoon
    },
    DuoAphroditeHestia = {
        ["ShadeMercFireball"] = mod.ShadeMercFireballBoon,
    },
    DuoApolloPosedidon = {
        ["ProjectileSprintBall"] = mod.PoseidonSplashSprintBoon,
    },
    DuoHephaestusPoseidon = {
        ["MassiveSlamBlastCast"] = mod.MassiveCastBoon,
    },
    DuoHestiaPoseidon = {
        ["SteamBlast"] = mod.SteamBoon
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
