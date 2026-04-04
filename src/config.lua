---@meta _
---@diagnostic disable

local config = {
    version = 1.2,
    PollingInterval = 0.2,
    TrainingRoomClearTime = 5,
    InitialY = 840,
    XPosition = 280,
    YPositionIncrement = -20,
    Margin = 40,
    DisplayWidth = 400,
    BackgroundColor = { 0.090, 0.055, 0.157, 0.6 },
    ShowIcons = true,
    SplitDashStrike = true,
    SplitOmega = true,
    OmegaIndicator = "{!Icons.Omega_NoTooltip}",
    ToggleMeterBind = "Ctrl Y",
    ToggleMeterModifier = "Ctrl",
    ToggleMeterKey = "Y",
    ShowMeter = true,
    CustomSkellyHealth = false,
    SkellyHealthMax = 920,
    CountOverkillDamage = false,
    CarrotMode = false,
    CarrotModeType = "always", -- "always" or "bosses"
    CarrotModeEnabledBoss_Hecate = true,
    CarrotModeEnabledBoss_Scylla = true,
    CarrotModeEnabledBoss_Cerberus = true,
    CarrotModeEnabledBoss_Chronos = true,
    CarrotModeEnabledBoss_Polyphemus = true,
    CarrotModeEnabledBoss_Eris = true,
    CarrotModeEnabledBoss_Prometheus = true,
    CarrotModeEnabledBoss_Typhon = true,
    CarrotModeEnabledBoss_Furies = true,
    CarrotModeEnabledBoss_Hydra = true,
    CarrotModeEnabledBoss_Theseus = true,
    CarrotModeEnabledBoss_Hades = true,
    DetailedHeader = false,
    -- Performance optimization settings
    EnableAdaptivePolling = true,
    EnableChangeDetection = true,
    EnableUIComponentPooling = true,
    MaxUIComponents = 20,
    ChangeDetectionTolerance = 1
}

local configDesc = {
    PollingInterval = "How often to update bars, in seconds.",
    TrainingRoomClearTime = "How soon to clear the window in Skelly's room, in seconds.",
    InitialY = "Y position of meter.",
    XPosition = "X position of meter.",
    YPositionIncrement = "Vertical spacing for each bar, negative number.",
    Margin = "Used for meter background scaling.",
    DisplayWidth = "Width of the meter background.",
    BackgroundColor = "Color of the meter background.",
    ShowIcons = "Show God icons next to ability names.",
    SplitDashStrike = "Show Dash-Strike in separate bar. Turn off to consolidate into Attack.",
    SplitOmega = "Show Omega attacks/specials in separate bars.",
    OmegaIndicator =
    "If SplitOmega is enabled, this will prefix the given attack/special name. Can use plain text if the default icon causes flickering.",
    ToggleMeterBind = "Press this to hide/show the meter.",
    ToggleMeterModifier = "Modifier for meter bind. default is Ctrl",
    ToggleMeterKey = "Key for meter bind. default is Y",
    ShowMeter = "Display the meter. default is true",
    CustomSkellyHealth = "Customize the amount of health Skelly has. default is false",
    SkellyHealthMax = "How much health to give Skelly. default is 920",
    CountOverkillDamage = "Whether or not to count damage that goes over the enemy's health. default is false",
    CarrotMode = "Don't display the damage meter until combat has ended.",
    CarrotModeType = "When to apply Carrot Mode: 'always' (all combat) or 'bosses' (boss fights only).",
    DetailedHeader = "Show detailed DPS stats (Current, Avg, Max) in the header bar.",
    -- Performance optimization settings
    EnableAdaptivePolling = "Enable adaptive polling frequency based on combat activity. Reduces CPU usage during low activity.",
    EnableChangeDetection = "Only update UI when damage data actually changes. Prevents unnecessary redraws.",
    EnableUIComponentPooling = "Reuse UI components instead of creating/destroying them. Eliminates flickering.",
    MaxUIComponents = "Maximum number of UI components to pre-create for pooling.",
    ChangeDetectionTolerance = "Damage tolerance for change detection. Higher values reduce sensitivity to small changes."
}

return config, configDesc
