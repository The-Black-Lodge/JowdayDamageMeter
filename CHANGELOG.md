# Changelog

## [Unreleased]

## [2.8.29] - 2025-12-04

## Fixed

- Rousing Reception (thanks ParanoidDrone)

## [2.8.28] - 2025-11-28

## Fixed

- Extinction, Freezer Burn (thanks ParanoidDrone)

## [2.8.27] - 2025-11-23

## Fixed

- remove debug print (thanks dwbl)

## [2.8.26] - 2025-11-22

## Fixed

- adjust Circe Morph name

## [2.8.25] - 2025-11-22

## Fixed

- Ephyra Pylons, Circe Morph (thanks ParanoidDrone)

## [2.8.24] - 2025-11-16

## Fixed

- Hephaestus: Cast and Godsent fixed (thanks ParanoidDrone)
- Ares: add Lance of Ares (hopefully)

## [2.8.23] - 2025-11-14

## Fixed

- Hestia: Heat Rush fixed (thanks ParanoidDrone)

## [2.8.22] - 2025-11-09

## Fixed

- Apollo: Prominence Flare/Glorious Disaster (thanks ParanoidDrone)
- Hera: Dying Wish and Hitch damage should properly display now (thanks ParanoidDrone)

## [2.8.21] - 2025-11-02

## Fixed

- Smithy Rush was incorrectly labeled (thank you ParanoidDrone)

## [2.8.20] - 2025-10-27

## Added

- NEW detailed DPS header (thank you wez470)

## [2.8.19] - 2025-10-26

## Fixed

- fixed necromantic influence/anubis aspect shades

## [2.8.18] - 2025-10-26

## Fixed

## [2.8.17] - 2025-10-16

## Fixed omega detection for suit, skull, torch, dagger, coat (thank you ParanoidDrone for the report)

- torch was incorrectly categorizing omega attacks

## [2.8.16] - 2025-10-01

## [2.8.15] - 2025-09-30

## Added

- poseidon dash, circe pet laser

## [2.8.14] - 2025-09-29

## Added

- demeter cast, hades slash

## [2.8.13] - 2025-09-28

## Fixed

- updated ui logic

## Added

- ocean swell

## [2.8.12] - 2025-09-28

## Fixed

- fixed scorch not tracking (hopefully)
- added new damage

## [2.8.11] - 2025-09-26

## [2.8.10] - 2025-06-23

## [2.8.9] - 2025-06-18

## Updated

- added some new abilities

## [2.8.8] - 2025-03-27

## Fixed

- Prominence Flare was not properly tracked

## [2.8.7] - 2025-03-16

## [2.8.6] - 2025-03-01

## Fixed

- fixed Hephaestus icon scaling/bouncing

## [2.8.5] - 2025-03-01

## Added

- EXPERIMENTAL - Carrot mode
  - Hides the meter until after combat and next room(s) are available
  - Thank you TheCarrotGuy for the suggestion!

## [2.8.4] - 2025-02-22

## Added

- Zeus/Demeter boon - Hail Storm

## [2.8.3] - 2025-02-20

## Added

- Ares support

## Updated

- using the shiny new God icons, where available!

## [2.8.2] - 2024-10-24

## Added

- added support for Practical Gods
- added new Thanatos axe special

## [2.8.1] - 2024-10-17

# Updated

- properly filter out NPCs hitting other NPCs
  add Athena and Dionysus

## [2.8.0] - 2024-10-17

## Added

- Artemis sprint boon
- update sjson for october update

## [2.7.1] - 2024-07-23

## Fixed

- ensure updated omega indicator is properly set

## [2.7.0] - 2024-07-21

## Fixed

- Aphrodite sprint fixed
- Better detection of boons added via PonyMenu

## Added

- Turn Skelly into a training dummy!
  - configurable health
- Display overkill damage option

## [2.6.0] - 2024-07-19

## Fixed

- Old Grudge and Knuckle Bones are now properly differentiated
- Medea curses are now properly differentiated
- Nexus Sprint (Hera) fixed
- add ImGui config

## [2.5.4] - 2024-07-17

## Added

- Rousing Reception (new Hera boon)
- es translation with help from Aoro

## [2.5.3] - 2024-06-27

## Fixed

- added/updated boons from 6/26 patch

## [2.5.2] - 2024-06-10

## Fixed

- fix heracles name showing up incorrectly

## [2.5.1] - 2024-06-06

## Fixed

- fixed omega attacks/specials showing up incorrectly

## [2.5.0] - 2024-06-06

## Changed

- now using ~95% in-game localization!
- all trap-type damage is consolidated

## [2.4.2] - 2024-06-03

## Fixed

- fix ModUtil deprecation message

## [2.4.1] - 2024-05-31

## Added

- option to separate out Dash-Strike damage
  - config option is SplitDashStrike

## [2.4.0] - 2024-05-29

## Added

- customizable keybind to toggle mod visibility
  - default is `Ctrl Y` but it can be configured in r2modman

## [2.3.2] - 2024-05-24

## Added

- customizable omega attack/special prefix
  - this is the OmegaIndicator value in configuration
  - the default omega icon will flicker on some PC configurations, so this allows you to set a plain text indicator if needed

## [2.3.1] - 2024-05-24

## Changed

- attempt to fix the "crunchy" looking text by changing font
- removed config value that shouldn't be modified

## [2.3.0] - 2024-05-23

## Added

- localization

- zh-CN translation by Dafeigy

- drop support for modimporter

## [2.2.4] - 2024-05-22

## Added

- omega damage for attack/special now gets separate bars
  - if you don't like this, in the mod configuration change SplitOmega to false
  - omega is not tracked for the following:
    - dagger special
    - skull special

## [2.2.3] - 2024-05-21

## Added

- abilities added (en/fr/pt-BR)
  - medea: corrosion on sight

## [2.2.2] - 2024-05-19

## Added

- improved charm detection
- abilities added (en/fr/pt-BR)
  - medea: suffering on sight
  - hestia: fire extinguisher

## [2.2.1] - 2024-05-16

### Added

- localization
  - pt-BR translation by Seceip
  - add Medea ability for en/fr

## [2.2.0] - 2024-05-15

### Added

- Thunderstore config files
- localization
  - fr translation by Shido
  - pt-BR placeholder

[unreleased]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.29...HEAD
[2.8.29]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.28...2.8.29
[2.8.28]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.27...2.8.28
[2.8.27]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.26...2.8.27
[2.8.26]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.25...2.8.26
[2.8.25]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.24...2.8.25
[2.8.24]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.23...2.8.24
[2.8.23]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.22...2.8.23
[2.8.22]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.21...2.8.22
[2.8.21]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.20...2.8.21
[2.8.20]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.19...2.8.20
[2.8.19]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.18...2.8.19
[2.8.18]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.17...2.8.18
[2.8.17]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.16...2.8.17
[2.8.16]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.15...2.8.16
[2.8.15]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.14...2.8.15
[2.8.14]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.13...2.8.14
[2.8.13]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.12...2.8.13
[2.8.12]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.11...2.8.12
[2.8.11]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.10...2.8.11
[2.8.10]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.9...2.8.10
[2.8.9]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.8...2.8.9
[2.8.8]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.7...2.8.8
[2.8.7]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.6...2.8.7
[2.8.6]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.5...2.8.6
[2.8.5]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.4...2.8.5
[2.8.4]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.3...2.8.4
[2.8.3]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.2...2.8.3
[2.8.2]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.1...2.8.2
[2.8.1]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.8.0...2.8.1
[2.8.0]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.7.1...2.8.0
[2.7.1]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.7.0...2.7.1
[2.7.0]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.6.0...2.7.0
[2.6.0]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.5.4...2.6.0
[2.5.4]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.5.3...2.5.4
[2.5.3]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.5.2...2.5.3
[2.5.2]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.5.1...2.5.2
[2.5.1]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.5.0...2.5.1
[2.5.0]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.4.2...2.5.0
[2.4.2]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.4.1...2.4.2
[2.4.1]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.4.0...2.4.1
[2.4.0]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.3.2...2.4.0
[2.3.2]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.3.1...2.3.2
[2.3.1]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.3.0...2.3.1
[2.3.0]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.2.4...2.3.0
[2.2.4]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.2.3...2.2.4
[2.2.3]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.2.2...2.2.3
[2.2.2]: https://github.com/southpawgeek/JowdayDPS/compare/2.2.1...2.2.2
[2.2.1]: https://github.com/southpawgeek/JowdayDPS/compare/2.2.0...2.2.1
[2.2.0]: https://github.com/southpawgeek/JowdayDPS/compare/b9880c29cae1b113b8fb8ec538ce8e71a8f56e80...2.2.0
