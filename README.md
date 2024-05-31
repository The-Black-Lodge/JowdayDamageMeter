# Hades II

## Jowday's Damage Meters

Adds a damage meter that displays automatically in each room.

Need to know exactly what's causing damage? Does Blitz even do anything? How much did Artemis help out? Did Toula even wake up? Find out what's working, and what isn't!

Available languages are English, French, Brazilian Portuguese, Chinese. It will work based on your in-game language selection. \
_* You may need to quit and reload your save if you change languages while playing._

### Config options you may be interested in:
 - `ToggleMeterBind` sets a bind to toggle the display on/off (default is `Ctrl Y`)
 - `SplitDashStrike` separates out Dash-Strike damage into its own bar. enabled by default
 - `SplitOmega` separates Omega attack/special into their own bars. enabled by default
 - `ShowIcons` displays god icons next to ability names. enabled by default
 - `OmegaIndicator` sets a custom prefix for Omega attacks

These values can be changed in the r2modman config editor.

## Example configurations
#### SplitDashStrike enabled:
```ini
SplitDashStrike = true # default
```
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/aa4bcaa5-7b0d-49a9-8065-456a2590e344)

---

#### SplitDashStrike disabled:
```ini
SplitDashStrike = false # custom value
```
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/90dfe10b-ab6a-47ce-a614-968c0cb89e8a)

---

#### SplitOmega and ShowIcons enabled:
```ini
SplitOmega = true # default
ShowIcons = true # default
OmegaIndicator = {!Icons.Omega_NoTooltip} # default
```
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/d8e63eeb-df7f-46f0-b610-50bf0d5752f8)

---

#### SplitOmega and ShowIcons disabled:
```ini
SplitOmega = false # custom value
ShowIcons = false # custom value
```
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/b9b516a7-3d34-4c9e-bb3a-b0d561fec5a3)

---

#### SplitOmega and custom OmegaIndicator:
```ini
SplitOmega = true # default
OmegaIndicator = ?! # custom value
```
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/a77f17e3-fe5e-4bc1-a13e-403dabef4bf8)

---

#### Duo Boon display:
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/334cbbdd-2797-406c-9d86-1b30b85582bb)

---

### Additional Languages:

#### fr:
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/6466a924-97ce-4327-8a8a-4e3f4c5f2273)

#### pt-BR:
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/12de43b6-3c63-4740-b606-31f088dfa4e0)

#### zh-CN:
![image](https://github.com/The-Black-Lodge/JowdayDamageMeter/assets/7319207/c320ebab-02fa-4316-b431-fd268dd493ed)



- Credit to Magic_Gonads and PonyWarrior for the localization code.
- Thank you to Shido for the French translation.
- Thank you to Seceip for the Brazilian Portuguese translation.
- Thank you to Dafeigy for the Chinese translation.

Please join the [Hades Modding Discord](https://discord.gg/KuMbyrN) for support. Contact me there if you are interested in contributing additional translations!
