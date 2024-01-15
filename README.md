# Jowday's DPS Mod

## Hades in-game damage meter

This is an attempt to add more accurate names and some other features to the already excellent [Ello's DPS mod](https://github.com/ellomenop/EllosPunchingBagMod).

This was done by lots of tedious hunting down of ability names, and the addition of some lookup tables.

Changes from the original:

- Attack is consolidated into a single source
- Special is consolidated into a single source
- Cast, Dash-Strike, Dash-Upper are named as such
- Traps, Magma, and Environmental (falling rubble) each have their own categories now
- Enemy Deflect/Charm category is a potpourri of enemy abilities - in general if a source name looked suspiciously like enemy damage it's because it was caused by deflect or charm

Known issues:

- Some abilities may not show pretty names yet
- Some damage is incorrectly tracked as Enemy Deflect/Charm
