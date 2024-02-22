# Jowday's DPS Mod

## Hades in-game damage meter

This is an attempt to add more accurate names and some other features to the already excellent [Ello's DPS mod](https://github.com/ellomenop/EllosPunchingBagMod).

_Make sure you only have one JowdayDPS folder in your Mods directory before importing!_

### v1.2 - Feb 21, 2024
**New Features**
- add support for Olympus Extra

**Minor Updates**
- remove decimals from damage reporting

**Bug Fixes**
- prevent crash if a boon from an unknown God is encountered (i.e. mods)

### v1.1.2 - Feb 3, 2024
**Bug fixes**
- fix crash when using Hunter Dash

### v1.1.1 - Jan 20, 2024
**﻿Minor fixes**
- add Dashing Flight (Spear hammer)
- Properly display modifying boon color for the following:
  - Bull Rush (Shield)
  - Dashing Flight (Shield hammer)
  - Hellfire Detonation (Exagryph)
  - Hellfire DoT (Exagryph)
  - Empowered Shot (Exagryph)
  - Raging Rush (Spear)
  - Quake Cutter (Fist)
- add RatSpawn enemy

### v1.1 - Jan. 18, 2024

**New features**
- Boon icons
- Dash damage has correct name and color
- Attack, Dash-Strike, Special, Dash-Upper, etc. are now colored by their modifying Boon
- Charm damage is now its own category
- Deflect damage is properly attributed to Athena
- Enemy Explosive category is when enemies are damaged by mines/etc. (this can happen without Deflect)

_Note on Hunter Dash (Artemis) handling_ \
This is a special case where the Boon buffs Dash-Strike in addition to whatever bonus comes from your attack Boon. When both are present, Dash-Strike will be colored by the primary attack Boon but also have the Artemis icon (similar to how Duo icons display).

- Fixed the following damage sources:
  - Winter Harvest (Demeter)
  - Flaring Spin (Daedalus)
  - Empowered Shot (Exagryph)
- Falling Debris renamed to Falling Rubble (to closer match in-game name)
- Added more Traps
- Added more Enemies
- Flood Flare (Poseidon) and Trippy Flare (Dionysus) now display as such, rather than "Shot"

### v1.0 - Jan. 15, 2024
**Changes from the original**
- Attack is consolidated into a single source
- Special is consolidated into a single source
- Cast, Dash-Strike, Dash-Upper are named as such
- Traps, Magma, and Environmental (falling rubble) each have their own categories now
- ~~Enemy Deflect/Charm category is a potpourri of enemy abilities - in general if a source name looked suspiciously like enemy damage it's because it was caused by deflect or charm~~

**Known issues**
- In the start room in Tartarus, your Cast ability name will not yet reflect a selected cast Boon

**Usage**
- The DPS meter will automatically show up when you deal damage.

**Dependencies**
- [Mod Importer](https://www.nexusmods.com/hades/mods/26)
- [ModUtil](https://www.nexusmods.com/hades/mods/27)

**Instructions**
Follow the video tutorial by PonyWarrior: https://www.youtube.com/watch?v=gLf_vqIYqyo

1. Install [Mod Importer](https://www.nexusmods.com/hades/mods/26)
2. Install [ModUtil](https://www.nexusmods.com/hades/mods/27)
3. Extract the entire `JowdayDPS` folder into﻿ your `Hades/Content/Mods` folder
4. Run **Mod Importer**

**Uninstallation**
1. Delete the `JowdayDPS` folder in your `Hades/Content/Mods` folder
2. Run **Mod Importer** again
