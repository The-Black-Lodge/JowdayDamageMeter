# Changelog

## [Unreleased]

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

[unreleased]: https://github.com/The-Black-Lodge/JowdayDamageMeter/compare/2.7.1...HEAD
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
