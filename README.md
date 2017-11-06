# WanezMod v1.1.0
*[MOD] Grim Dawn: Ashes of Malmouth - v1.0.2.1*

---

> 1 [Introduction](#mod-intro)
>> 1.1 [Installation](#mod-intro-installation)

>> 1.2 [How To Play The Campaign](#mod-intro-campaign)

>> 1.3 *new* [Versioning](#mod-intro-version)

> 2 [Dynamically Generated Areas (DGA)](#mod-dga)
>> 2.1 [Items](#mod-dga-items)

>> 2.2 - [DGA Types](#mod-dga-types)

>> 2.3 - [DGA Affixes](#mod-dga-affixes)

>> 2.4 - [Enemies](#mod-dga-enemies)

>> 2.5 - [Monster Power](#mod-dga-power)

>> 2.6 - [Factions](#mod-dga-factions)

> 3 [Main Campaign](#mod-campaign)
>> 3.1 [Enemies](#mod-campaign-enemies)

>> 3.2 [Misc](#mod-campaign-misc)

> 4 [Vanilla Rebalance & Changes](#mod-changes)
>> 4.1 [Devotion Shrines](#mod-rebalance-devotion-shrines)

> 5 [Masteries](#mod-classes)

> 6 [Gifts & Treasures](#mod-gifts)
>> 6.1 [Planar Scraps](#mod-gifts-scraps)

>> 6.2 [Leveling Gear](#mod-gifts-carto)

>> 6.3 [Artifacts](#mod-gifts-arti)

> 7 [Runic Inscriptions](#mod-runes)
>> 7.1 [Runes](#mod-runes-runes)

>> 7.2 [Stones](#mod-runes-stones)

>> 7.3 [Inscriptions](#mod-runes-inscriptions)

>> 7.4 [Runic Sets](#mod-runes-sets)

>> 7.5 [Runic-Sequence](#mod-runes-sequence)

>> 7.6 [Rune-Lore](#mod-runes-lore)

> 8 [Miscellaneous](#mod-misc)
>> 8.1 [Shrines & Pylons](#mod-misc-pylons)

>> 8.2 [Phasing Beasts](#mod-misc-phasing-beasts)

>> 8.3 [Patrons](#mod-misc-patrons)

>> 8.4 [Legendary Crafting](#mod-misc-legendary-crafting)

>> 8.5 [Personal Assistant](#mod-misc-assistant)

>> 8.6 *new* [Legendary Notify](#mod-misc-legendary-notify)

>> 8.7 *new* [Auto Pick Up](#mod-misc-pickup)

> 9 [Links](#mod-links)
>> 9.1 [Videos](#mod-links-videos)

> 10 [Credits](#mod-credits)
>> 10.1 [Contributors](#mod-credits-contributors)

>> 10.2 [Special Thanks](#mod-credits-thanks)

>> 10.3 [Art](#mod-credits-art)

>> 10.4 [Mods Included](#mod-credits-mods)

---

---
<a name="mod-intro"></a>
## 1 - Introduction
Unofficial Mod for Grim Dawn. This is the full Mod's source with all of its SubMods. This Mod has everything I am working on (DGA, Masteries, Items, etc.), everything will be available in this mod as some kind of Compilation.

<a name="mod-intro-installation"></a>
### 1.1 - Installation
Extract the contents of the .7z into /Grim Dawn/mods/.
You should end up with something like: 
C:/Program Files (x86)/Steam/SteamApps/common/Grim Dawn/mods/WanezMod with the directories "database" and "resources" inside.
When you start the Game, choose "Custom Campaign" and select "WanezMod"

---
<a name="mod-intro-campaign"></a>
### 1.2 - How To Play The Campaign
Inside the WanezMod Folder is a "copyCampaignMap.bat" which will copy the Campaign map into the Mod Folder, you can also do this yourself if you don't trust a strangers bat or it didn't work. Simply go to /Grim Dawn/gdx1/resources/Levels.arc and copy the .arc into /Grim Dawn/mods/WanezMod/resources/
When you start the game you can now select WanezMod - world001.wrl, this is the Campaign

---
<a name="mod-intro-version"></a>
### 1.3 - Versioning
Just doing this section so it becomes a little more clear how it is going to be for me (X.Y.Z)

| Description | X | Y | Z |
| :--- | :--- | :--- | :--- |
| Purpose | Big Changes | New Features, Balance changes | Bug fixes, Crate Update |
| Item/Skill Loss | Likely | Unlikely | very Unlikely |
| Notes | often Overhauls of existing features or Expansions from Crate | minor or major features, or just new maps | Vanilla changes to Monsters or Items will force me to update |

*it is possible the version is stuck in 1.y.z for a long time and goes up to 1.35.0 or something crazy*

* when `z` is 0 it's a new version with new features and bugs can occur, I'll mark them as Pre-Release on GitHub
  * 1.1.0 - is new and a Pre-Release (Beta, Experimental)
  * 1.13.0 - is also a Pre-Release
  * 1.9.1 - is mostly safe to play and major issues should have been found by then
* it's up to you which version you want to use, the more are using the Pre-Release the faster the bugs can be fixed
* it shouldn't take more than a week to get to x.y.1 - if no reports come up I'll remove the Pre-Release on GitHub.

---

---
<a name="mod-dga"></a>
## 2 - Dynamically Generated Areas
Entering the DGA map will give you access to everything the dismantle NPC has to offer. Normal Difficulty will also give you all Inventory bags.

> 2.1 - [Items](#mod-dga-items)
>> 2.1.1 - [DGA-Scrolls](#mod-dga-items-scroll-dga)

>> 2.1.2 - [Area-Scroll](#mod-dga-items-scroll-dga)

>> 2.1.3 - [DGA-Orb](#mod-dga-items-orb-dga)

>> 2.1.4 - [Souls & Essences](#mod-dga-items-souls-essences)

> 2.2 - [DGA Types](#mod-dga-types)
>> 2.2.1 - [Tiers](#mod-dga-types-tiers)

>> 2.2.2 - [Mission](#mod-dga-types-mission)

>> 2.2.3 - [Endless](#mod-dga-types-endless)

>> 2.2.4 - [Challenge](#mod-dga-types-challenge)

>> 2.2.5 - [Uber Mode](#mod-dga-types-uber)

>> 2.2.6 - [Bosses](#mod-dga-types-bosses)

> 2.3 - [DGA Affixes](#mod-dga-affixes)
>> 2.3.1 - [Drop Rate Changes](#mod-dga-affixes-droprate)

>> 2.3.2 - [Types](#mod-dga-affixes-types)

> 2.4 - [Enemies](#mod-dga-enemies)
>> 2.4.1 - [Loot & Drops](#mod-dga-loot)

>> 2.4.2 - [Nemesis](#mod-dga-nemesis)

>> 2.4.3 - [Mini Boss](#mod-dga-boss-mini)

> 2.5 - [Monster Power](#mod-dga-power)
>> 2.5.1 - [Difficulties](#mod-dga-power-difficulties)

>> 2.5.2 - [Modes](#mod-dga-power-modes)

>> 2.5.3 - [Conclusion](#mod-dga-power-conclusion)

> 2.6 - [Factions](#mod-dga-factions)
>> 2.6.1 - [Planes-Shifters](#mod-dga-factions-carto)

>> 2.6.2 - [Planar Invaders](#mod-dga-factions-dga)

---
<a name="mod-dga-items"></a>
### 2.1 - Items
You have the option of enemies having Vanilla Loot Tables or DGA Loot Tables. Vanilla Loot Tables will drop lots of items and they remain on the ground until you start a new Session, this is why you can have DGA Loot Tables, Monsters drop additional items to compensate for the loss and allow you to craft more.

*DGA-Items are moved directly into your inventory*

<a name="mod-dga-items-scroll-dga"></a>
#### 2.1.1 - DGA-Scrolls
* DGA-Scrolls will drop directly, there is no need to craft them
* two different kinds of DGA-Scrolls are available
  * Regular (can open Missions and Challenges)
  * Endless (can open Endless DGA)
* Some of them can be crafted, removing the requirement to find them
  * Tier 0 for Regular Scrolls and Endless Scrolls can be crafted at the Blacksmith
  * Tier 1-15 in Normal/Elite for Regular Scrolls can be crafted at the Blacksmith
* using a DGA-Scroll inside the Summoning-Circle will open a Portal to the new Area
  * using a Scroll will randomly choose the Area it leads to
  * it is possible to predetermine the Area chosen by using a different Scroll <a href="#mod-dga-items-scroll-area">(Area-Scroll)</a>
* Ultimate only: using the Scroll outside the Summoning-Circle will give the player a <a href="#mod-dga-items-orb">DGA-Orb</a>
* Drop-Rates
  * Rather than each Enemy being able to drop DGA-Scrolls, you need to kill the entire pack to get the chance on a Drop
  * Common Enemy Packs cannot drop DGA Scrolls
  * Champion Enemy Packs can drop Tier +0 DGA Scrolls
  * Heroes/Mini-Bosses can drop Tier +1 DGA Scrolls
  * Bosses/Nemesis can drop Tier +2 DGA Scrolls
  * Any lower Tier DGA-Scroll can drop
  * *eg. Killing a Hero Pack in a Tier 9 DGA has the chance of dropping DGA-Scrolls between Tier 1 and 10*

<a name="mod-dga-items-scroll-area"></a>
#### 2.1.2 - Area-Scroll
* You can set the Area for the next DGA-Scroll you are using
* This information will not last until the next session
* When you set an Area, but don't have the quest or use the right scroll that can lead to it, the Area-Scroll was wasted as the value is reset with every DGA-Scroll use
  * Using a Scroll leading to an Area exclusive to Endless and not using an Endless DGA Scroll will reset that value and it's lost

<a name="mod-dga-items-orb-dga"></a>
#### 2.1.3 - DGA-Orb
DGA-Orbs can be obtained by using regular DGA-Scrolls for Ultimate Difficulty while being outside the Summoning-Circle for Portals, this way you can use lower Tiers to create DGA-Orbs required to craft a variety of other DGA-Items:
* Uber-Scrolls to gain access to Uber Mode
* Quest-Scrolls (eg. for Challenges)
* Affix-Scrolls

The number of DGA-Orbs you get is dependent on the DGA Scrolls' Tier:
* Tier 1 will give you 1 DGA-Orb
* Tier 10 will give you 10 DGA-Orbs
* ...

You can also get DGA-Orbs in Normal/Elite by completing DGA-Type Quests (Missions, Endless, Challenges) or by finding a chest in any Difficulty.

<a name="mod-dga-items-souls-essences"></a>
#### 2.1.4 - Souls & Essences
* You can only find them with Default/Vanilla-Mode disabled and they come in three different power levels:
  * Lesser Souls & Essences (starting in Normal/Elite)
  * (Medium) Souls & Essences (starting in Ultimate)
* They can be used to buy:
  * Vanilla Materials (such as Scraps, Blood, etc ...)
  * Vanilla Components
  * new Materials used for new Items (Gifts & Treasures)
  * upgrading new Items
* Souls can be obtained by killing any enemy, while Essences can only be obtained from more powerful enemies

---
*[Back to: 2 - DGA](#mod-dga)*

---
<a name="mod-dga-types"></a>
### 2.2 - DGA Types
DGA-Tiers do not increase DGA-Scroll Drop-Rates, only DGA-Difficulties and DGA-Affixes do, but DGA-Tiers increase the Drop-Rate of Souls, Essences and Orbs.

Difficulties Normal and Elite don't require you to find an item to open a portal, you can craft Tiers 1 to 15 at the Blacksmith for Iron Bits and a Potion. Normal and Elite also stop increasing their Monster Level at 60. The difference between the two difficulties is that you will receive more Iron Bits/Orbs in Elite and Quests will grant much more XP than on Normal. Ultimate requires you to find DGA-Scrolls to access higher DGA-Tiers and only Tier 0 can be crafted at the Blacksmith.

<a name="mod-dga-types-tiers"></a>
#### 2.2.1 - Tiers
* Tiers will increase Monster Level by:
  * 1 additional Monster Level for Tiers 1 - 5
  * 2 additional Monster Levels for Tiers 6 - 10
  * 3 additional Monster Levels for Tiers 11 - 15
  * this adds up to +30 Monster Level at Tier 15 (rather than the previous +15 at Tier 15)
  * and +105 Monster Level at Tier 30. 
  * Endless DGA work a little different, but more about that later
* All difficulties now have 30 Tiers available and Normal/Elite doesn't require drops to craft the higher Tiers
* 3% more Essences/Souls/Orbs per Tier
* Tiers have no influence on DGA-Scroll Drop-Rates

<a name="mod-dga-types-mission"></a>
#### 2.2.2 - Mission
* Using a regular DGA-Scroll will grant you a random Mission if you don't have an active Challenge or Raid
* The Area will be opened for the DGA-Type you are having the Quest for at the time of using your DGA-Scroll

<a name="mod-dga-types-endless"></a>
#### 2.2.3 - Endless
Endless will not follow the regular DGA-Tier mechanics, but instead increase Monster Level by one with every round. Whether you want to increase the Monster Level or not can be decided at the end.
* Defeating the Endless Boss can result in giving you an "Endless DGA-Scroll" of the Tier Range you are in
  * Monster Level 7 will give you an "Endless DGA Scroll (T 6)" (ML 19 would be T12)
* Using the Scroll will open the Portal for that Tier (and the lowest Monster Level for that Tier)
* For the time being you can get Scrolls up to Tier 30 (ML +105... good luck getting there I guess)

<a name="mod-dga-types-challenge"></a>
#### 2.2.4 - Challenge
* Challenges have stronger monsters than Missions and Endless
* You can craft a Quest-Scroll at the Blacksmith for DGA-Orbs
* To avoid confusion only the Blacksmith in Ultimate can make them for you, but they are usable in any difficulty
  * Because Challenges are balanced around Ultimate and you can finish them faster in Ultimate than in Normal/Elite, they have caused more frustration to newer players than joy
* Challenges will either use regular maps (used by missions) or a new map (created for that Challenge)

<a name="mod-dga-types-uber"></a>
#### 2.2.5 - Uber Mode
* Uber will show up as a Quest and is removed when you open the next Portal. 
* Uber Quest-Scrolls can be crafted at the Blacksmith for Planar-Orbs

<a name="mod-dga-types-bosses"></a>
#### 2.2.6 - Bosses
The Boss can be found in a new Area, this allows me to add more features in the future and makes certain DGA-Types less prone to bugs. Inside that room you will find the Boss and a Portal back to the Encampment.

Endless and Challenges will use this room to show you the Portal for your next area after you have killed a Boss (Endless) or Mini-Boss (Challenge). The Portal back to the camp is also available.

---
*[Back to: 2 - DGA](#mod-dga)*

---
<a name="mod-dga-affixes"></a>
### 2.3 - DGA-Affixes
It is possible to make DGA more challenging and increase Drop-Rates - you may have as many as you like and you can afford.

DGA-Affixes will show up as quests and are being removed when you use a scroll to open the portal, therefore it will only affect the area the scroll was used for.

Quests are granted by a Scroll and it is possible to craft a random scroll at the Blacksmith or to find them.

<a name="mod-dga-affixes-droprate"></a>
#### 2.3.1 - Drop-Rate
The following items are being affected by drop-rate increases from DGA Affixes:
* DGA Scrolls - if you want to reach higher Tiers or sustain that Tier you should probably use DGA-Affixes
* Souls & Essences

Increases are being added up and multiplied with the base drop-rate (eg. Base Drop-Rate of a DGA Scroll could be 5% and you have three different affixes giving 10%/25%/30%, this will result in 5% * 65% = 8.25%)

<a name="mod-dga-affixes-types"></a>
#### 2.3.2 - Affix Types
In order to keep Scroll names short, you will find the only the Type rather than a full explanation of it:
* Type (I): Increase Monster Count
* Type (II): Buff Monsters

---
*[Back to: 2 - DGA](#mod-dga)*

---
<a name="mod-dga-enemies"></a>
### 2.4 - Enemies
I added enemies to the tool's functionality, this means I can change data across all files or pick a certain file to change values easily, also every time there is a new Grim Dawn update I can update them aswell. This results in more features that would have been tedious and not worth the time. It also means more customization options for players and up to date enemy files.

<a name="mod-dga-enemies-loot"></a>
#### 2.4.1 - Loot & Drops
You can choose to play "Vanilla-Mode", it means monsters will have their vanilla Loot Tables with their vanilla Drop-Rates (or any changes made to vanilla files from other Mods). This Mode is only available in Normal DGA-Difficulty. If you just want a different endgame experience to vanilla areas, you can choose "Vanilla-Mode" and you will get the same items as you would playing the Campaign. 

*I am giving the option of removing worthless items, because I cant just remove them from the ground, you would have to start a new Session if you are doing the same area multiple times and this is defeating the purpose of DGA.*

Any other DGA-Difficulty will ignore "Vanilla-Mode" and use the DGA Loot Tables and Drop-Rates, if "Vanilla-Mode" is going to be more popular and requested to be part of more DGA-Difficulties I will make it happen, the reason why I don't, is because it will increase the file size for no good reason. Vanilla Legendaries are still dropping in every DGA-Difficulty and the only thing missing are rares, but instead monsters are dropping Souls & Essence which can be used to buy Scraps, Components and other Vanilla Crafting Materials.

<a name="mod-dga-enemies-nemesis"></a>
#### 2.4.2 - Nemesis
* They are dropping a Destructible Orb like Heroes and Bosses (in the Main Campaign).

<a name="mod-dga-enemies-boss-mini"></a>
#### 2.4.3 - Mini Boss
* A Mini Boss is basically a quest monster marked as a Hero from the Main Campaign
* Their purpose in DGA is to trigger several new events
  * create the Portal to the next Area in Endless
  * *Spawn a Boss in later versions*

---
*[Back to: 2 - DGA](#mod-dga)*

---
<a name="mod-dga-power"></a>
### 2.5 - Monster Power
You have the option of making monsters more powerful and certain DGA-Types will inherently have stronger monsters. I'm starting with increasing Enemy Defense and Enemy Offense equally, this may change over time.

*200% Monster Power = 2x Damage/Defense*

*Reflect has not been adjusted, so keep an eye out for it*

<a name="mod-dga-power-difficulties"></a>
#### 2.5.1 - Difficulties
You can choose between 7 different (DGA-)Difficulties, you won't get more Loot, only DGA Items which are moved directly into your inventory are increased by this (due to modding limitations).

| Difficulty | Monster Power | DGA Scrolls | Notes |
| :---       | :---: | :---: | :--- |
| Casual     | 100% | -10%  | Portal will stay until a new one is opened (you may re-enter the map when you die) |
| Normal     | 100% |       | |
| Hard       | 125% | +20%  | |
| Elite      | 150% | +50%  | |
| Ultimate   | 175% | +75%  | |
| Epic       | 200% | +100% | |
| Legendary  | 225% | +125% | I can add more if this is not enough |

*Monster Power describes how hard monsters are in comparison to vanilla monsters (100% is the same as Vanilla)*

<a name="mod-dga-power-modes"></a>
#### 2.5.2 - Modes
Having just two here is plenty, since it doubles the possible choices for the player.
* Standard/Normal/Default (call it what you like)
  * Standard is the Default, as long as you don't have Uber active (via Quest) this is what you get
  * as a result, it doesn't increase drop rates or Monster Power
* Uber
  * 100% more DGA Scrolls
  * 100% more Power Level

<a name="mod-dga-power-conclusion"></a>
#### 2.5.3 - Conclusion

| Mode - Difficulty | Monster Power | DGA Scrolls |
| ---: | :---: | :---: |
| Standard - Normal    | 100% | +  0% |
| Uber - Normal        | 200% | +  0% |
| Standard - Elite     | 150% | + 50% |
| Uber - Elite         | 300% | +100% |
| Standard - Legendary | 225% | +125% |
| Uber - Legendary     | 450% | +250% |

*Tiers still increase Monster Level, in addition to the Monster Power increases. T15 Uber - Legendary would be a +30 Level +450% Offense and Defense*

---
*[Back to: 2 - DGA](#mod-dga)*

---
<a name="mod-dga-factions"></a>
### 2.6 - Factions
<a name="mod-dga-factions-carto"></a>
#### 2.6.1 - Planes-Shifters
* Friendly Faction
* Faction Rank will increase the duration of Shrines
* Faction Rank will increase the values of Blacksmith Bonuses

<a name="mod-dga-factions-dga"></a>
#### 2.6.2 - Planar Invaders
* Hostile Faction
* Spawns Nemesis in DGA
* you can exchange your Reputation for a Token necessary to upgrade Artifacts

---
*[Back to: 2 - DGA](#mod-dga)*

---

---
<a name="mod-campaign"></a>
## 3 - Main Campaign

> 3.1 [Enemies](#mod-campaign-enemies)

> 3.2 [Misc](#mod-campaign-misc)

---
<a name="mod-campaign-enemies"></a>
### 3.1 - Enemies
* You get a new option at the Jailor to change the number of enemies spawned
  * it can be doubled
  * it can be tripled

---
*[Back to: 3 - Main Campaign](#mod-campaign)*

---
<a name="mod-campaign-misc"></a>
### 3.2 - Misc
* **Runic Inscriptions** and **Gifts & Treasures** Blacksmiths can be spawned by using the [Personal Assistant](#mod-misc-assistant)

---
*[Back to: 3 - Main Campaign](#mod-campaign)*

---

---
<a name="mod-rebalance"></a>
## 4 - Vanilla Rebalance & Changes

> 4.1 [Devotion Shrines](#mod-rebalance-devotion-shrines)

---
<a name="mod-rebalance-devotion-shrines"></a>
### 4.1 - Devotion Shrines
* Devotion Shrines now always spawn Monsters to kill
* They are from a Random Pool, which means you could get Monsters from later Acts at the first Shrine

---
*[Back to: 4 - Vanilla Rebalance & Changes](#mod-rebalance)*

---

---
<a name="mod-classes"></a>
## 5 - Masteries
The following lists may not reflect every skill available to that Mastery, it was changing so many times that I lost track at some point. The only reason for it is to give an idea of what a Mastery has to offer.

> 5.1 [Gunslinger](#mod-classes-dga-gunslinger)

> 5.2 [Conjurer](#mod-classes-dga-conjurer)

> 5.3 [Conjurer](#mod-classes-dga-eldritch)

---
<a name="mod-classes-dga-gunslinger"></a>
### 5.1 - [Planes-]Gunslinger
#### Damage Types
* Mainly Cold/Pierce/Bleeding
* Some Chaos

#### Skills
* All attacks and spells require Ranged Attack Weapons (1H Guns, 2H Guns, Crossbows)
* Shoot (Attack)
  * Physical/Pierce/Cold Damage
* Multishot - Relentless Shots (Spell)
  * Physical/Pierce/Cold Damage
* Rain of Projectiles (Spell)
  * Physical/Pierce Damage
  * `Transmuter` converts it to Cold and adds a chance to freeze (Icicle Rain)
* Entangling Shot (Attack)
  * Physical/Pierce Damage
  * Slows Targets
  * `Modifier` traps Targets
  * `Modifier` Causes Bleeding
* Chilling Aura
* Dual Pistols (Weapon Pool)
  * Physical/Pierce/Cold Damage
  * `Modifier` AoE
  * `Modifier` Fragment/Splinter

---
*[Back to: 5 - Masteries](#mod-classes)*

---
<a name="mod-classes-dga-conjurer"></a>
### 5.2 - Spellcaster/Summoner ([Planes-]Conjurer)
#### Damage Types
* Mainly Fire/Chaos
* Some Aether

#### Skills
* Flame Strike (Spell)
  * Aether/Fire Damage
  * `Transmuter` converts Aether to Chaos
* Suicidal Spirit (Spell)
  * Fire/Chaos Damage
  * a spirit is looking for an enemy to explode when it gets there
  * very high damage
* Planar Spirit (Pet)
  * Chaos/Fire Damage
  * temporary pet seeking enemies and attacking them
  * pet limit 20-40 depending on the skill level
  * duration increases from 7 to 18 seconds
* Planar Hound (Pet)
  * Generates Aggro
  * Has a Cleave attack to hit up to 6 enemies
  * barely does any damage, the main purpose is to tank
* Haste (Aura)
  * Movement Speed
  * Attack Speed
  * Casting Speed
* Celerity (Buff-AoE)
  * Movement Speed
  * Attack Speed
  * Casting Speed
  * Cooldown is much higher than the duration
* Passives
  * Pet Attributes
  * Pet Damage
  * Pet Flat Damage
  * Pet Speed
  * Master Physique/Health %

---
*[Back to: 5 - Masteries](#mod-classes)*

---
<a name="mod-classes-dga-eldritch"></a>
### 5.3 - Spellcaster ([Planes-]Eldritch)
#### Damage Types
* Mainly Cold & Chaos

#### Skills
* Planar Bolt (Spell)
  * Chaos/Cold Damage
  * Long Range
  * `Modifier - Explosive Bolt` Explosion
  * `Modifier - Piercing Bolt` Chance to Pierce
  * `Modifier - Empowered Bolt` Critical Damage
  * `Transmuter - Planar Projectiles` Add 2/4 Projectiles
* Vortex (Spell)
  * Ground Effect
  * Cold Damage
  * `Modifier - Chilling Vortex` Add Chill Effect
  * `Modifier - Empowered Vortex` Damage
  * `Transmuter - Chaos Vortex` Convert Cold to Chaos
* Planar Blast (Spell)
  * Chaos/Cold Damage
  * Medium Range
  * Medium AoE
  * `Modifier - Explosive Blast` Increase AoE + Weapon Damage
  * `Modifier - Empowered Blast` Increase Damage
  * `Modifier - Splintering Blast` Splinters
* Planar Beam (Spell)
  * Chaos Damage/Cold Damage
  * `Modifier - Freezing Beam` Add Cold DoT + chance to Freeze
  * `Modifier - Empowered Beam` Weapon Damage + Damage %
  * `Transmuter - Elemental Ray` Convert Chaos to Elemental Damage and add Elemental Damage (Flat + %)
* Planar Mastery (Aura)
  * Mana Regen
  * `Modifier - Planar Infusion` Damage Bonus
  * `Transmuter - Chilling Touch` Conversion (Aether -> Cold) ??
* Planar Grip (Debuff)
  * Reduce Cold/Chaos resist
  * `Modifier - Tightened Grip` Reduce DA + Slow
* Planar Focus (Passive #02)
  * Spirit %
  * OA Flat
* Knowledge of Planes (Passive #01)
  * Casting Speed
  * Total Damage
* Planar Survivalist (Passive #03)
  * Increased Health
  * Reduced Mana
* Defense from Within (Passive #04)
  * Damage Reduction (Cold/Chaos)

---
*[Back to: 5 - Masteries](#mod-classes)*

---

---
<a name="mod-gifts"></a>
## 6 - Gifts & Treasures

> 6.1 [Planar Scraps](#mod-gifts-scraps)

> 6.2 [Leveling Gear](#mod-gifts-carto)
>> 6.2.1 [How To Obtain](#mod-gifts-carto-obtain)

>> 6.2.2 [What Is Special About It](#mod-gifts-carto-special)

>> 6.2.3 [The Goal](#mod-gifts-carto-goal)

>> 6.2.4 [List of Properties](#mod-gifts-carto-properties)

> 6.3 [Artifacts](#mod-gifts-arti)
>> 6.3.1 [How To Obtain](#mod-gifts-arti-obtain)

>> 6.3.2 [What Is Special About It](#mod-gifts-arti-special)

>> 6.3.3 [The Goal](#mod-gifts-arti-goal)

---
<a name="mod-gifts-scraps"></a>
### 6.1 - Planar Scraps
* Crafted from
  * Scraps
* Used for
  * Leveling-Gear
  * Upgrading Artifacts

<a name="mod-gifts-carto"></a>
### 6.2 - Leveling Gear
<a name="mod-gifts-carto-obtain"></a>
#### 6.2.1 - How To Obtain
* Planar Souls and Planar Essences can be used to get Planar-Scraps
* Craftable at the Blacksmith

<a name="mod-gifts-carto-special"></a>
#### 6.2.2 - What Is Special About It
* New pool of Affixes (similar to other ARPGs)
  * Prefix with 1-3 Random properties
  * Suffix with 1-3 Random properties
* Has a new pool of Blacksmith bonuses
* Base item has a useful property
  * eg. Gloves could roll Cast Speed or Attack Speed
* Variations
  * higher armor with a physique requirement
  * lower armor with a spirit requirement
  * weapons with different attack-speed and min/max damage rolls
  * accessories with different rolls useful to different builds (eg. cooldown reduction)
  * a variety of pet-bonuses

<a name="mod-gifts-carto-goal"></a>
#### 6.2.3 - The Goal
* Good rolls should be fairly easy to obtain at lower levels, but more difficult at higher levels
* no need to hoard anything, you can easily craft good enough gear if you have the scraps for it

<a name="mod-gifts-arti"></a>
### 6.3 - Artifacts
<a name="mod-gifts-artifacts-pages"></a>
<a name="mod-gifts-arti-obtain"></a>
#### 6.3.1 - How To Obtain
* Planar-Scraps and Reputation can be used to Obtain Token from the Settings Ghost
* Craftable at the Blacksmith
  * requires a Book (pages are dropping of Phasing Beasts)
  * because Pages are still dropping after you have got the Artifact, but you don't need them to craft anymore, you can sell them
* Upgrading an item to the next Level requires the previous item and a number of Token (increasing with Level of the Item)

<a name="mod-gifts-arti-special"></a>
#### 6.3.2 - What Is Special About It
* The Level Requirement increases as you Upgrade the Item
* As a result of an increased Level Requirement stats are also increasing
* Artifacts start at level 73 and go all the way up to 100
  * until the Expansion the maximum (Artifact-)Level you can upgrade an Artifact to is 5
  * when the Expansion is out you can Upgrade the Artifact to 10 (this will also make use of the new Properties coming with the Expansion)
  * *I will add levels 6-10 later*
* They are using the Blacksmith you are crafting Leveling Items with and as a result Artifacts gain the same Blacksmith Bonuses as Leveling Items do

<a name="mod-gifts-arti-goal"></a>
#### 6.3.3 - The Goal
* add some new aspects to the endgame item hunt
* the first few upgrades should be easy enough for everyone interested in the item, higher upgrades should be almost impossible unless you put in the effort

<a name="mod-gifts-arti-properties"></a>
#### 6.3.4 - List of Properties
#### Affixes
* Prefix
  * Health
  * Energy
  * Life Regen
  * Armor
  * Armor %
  * % All Damage
  * % All Damage (x2)
  * OA
  * DA
  * OA + DA (at 75% of their value)
  * Pet: OA + DA
  * Pet: % All Damage
  * Pet: Movement Speed, Attack Speed
  * \+ All Skills
* Suffix
  * Physique
  * Cunning
  * Spirit
  * Pet: Health
  * Pet: Armor
  * Resistances (chaos/aether is the same suffix)
* Blacksmith
  * Health %
  * Mana %
  * Health Regen % + Mana Regen %
  * Mana Regen
  * Pet: Health Regen (flat + %)
  * OA %
  * DA %
  * Physique %
  * Cunning %
  * Spirit %
  * Increased Exp
  * Pet: Health %
  * Pet: OA % + DA %
  * Pet: CD Reduction

#### Armor Variations
* Heavy: 1.5x Armor (Strength Requirement)
* Light: 1x Armor (Cunning Requirement)
* Caster: 0.5x Armor (Spirit Requirement)

#### Amor Base Stats (Implicit)
* Feet
  * Increased Exp
  * Run Speed (Cast Speed in Beta #05)
  * Total Speed
  * CD Reduction
  * Pet: Total Speed
* Hands
  * Increased Exp
  * Attack Speed
  * Total Speed
  * Projectile Speed
  * Pet: Total Speed
* Head
  * Increased Exp
  * Casting Speed
  * Total Speed
  * CD Reduction
  * Pet: Total Speed
* Legs
  * Increased Exp
  * Dodge (Melee/Ranged)
  * Absorb
  * Pet: Physical, Freeze, Stun Resistance
* Shoulders
  * Increased Exp
  * Dodge (Melee/Ranged)
  * Absorb
  * Pet: Physical, Freeze, Stun Resistance
  * Pet: Armor
* Chest
  * Increased Exp
  * Dodge (Melee/Ranged)
  * Absorb
  * Pet: Armor

#### Accessory
* Belt
  * Variations
    * Physical damage (min-max)
    * Mana Regen % (flat in Beta #05)
    * Life Regen % (flat in Beta #05)
    * Increased Exp
  * Implicit
    * Increased Exp
    * Armor
    * Absorb
    * Pet: Vitality + Poison Resistance
* Amulet
  * Variations
    * Physical damage (min-max)
    * Mana Regen
    * Life Regen
    * Increased Exp
  * Implicit
    * Increased Exp
    * Total Speed
    * CD Reduction
    * % All Damage
    * Pet: Chaos + Aether Resistance
* Rings
  * Variations
    * Physical damage (min-max)
    * Mana Regen
    * Life Regen
    * Increased Exp
  * Implicit
    * Increased Exp
    * Total Speed
    * Mana Cost Reduction
    * Pet: Pierce + Bleeding Resistance
    * Pet: Elemental Resistance
* Medals
  * Variations
    * Total Damage
    * + All Skills
    * Increased Exp
  * Implicit
    * Increased Exp
    * Total Speed
    * Pet: % All Damage (x3)
    * Pet: Total Speed (x3)

#### Shield & Off-Hand
* Shield
  * Variations
    * Armor
    * Armor + Absorb
    * Armor + DA
  * Implicit
    * Increased Exp
    * Armor
    * Absorb
    * Pet: Armor + Health Regen
* Off-Hand
  * Variations
    * % All Damage
    * Casting Speed
    * Spirit
  * Implicit
    * Increased Exp
    * % All Damage
    * CD Reduction
    * Mana Cost Reduction
    * Casting Speed
    * Pet: % All Damage + Total Speed

#### Weapons
3 different attack speed variations and some have a different range of min/max damage (eg. Maces have a lower min and higher max, for swords its closer together)
* Implicits
  * Axes, Maces: bonus physical damage
  * Other Weapons: Total Speed
  * All Weapons: attack speed
  * All Weapons: Physical %
* Scepters
  * 1 Variation for each magical damage type (base damage + damage % + DoT DMG % if there is one)
  * Implicits
  * % Total Damage (x3)
  * Casting Speed
  * Total Speed

---
*[Back to: 6 - Gifts & Treasures](#mod-gifts)*

---

---
<a name="mod-runes"></a>
## 7 - Runic Inscriptions
* Runic Inscriptions come in different sets
* Runes of the same Set can be combined to create Inscriptions
* New Items: "Equipment-Stones", "Rune-Scrolls", "Rune-Components", "Inscriptions"

> 7.1 [Runes](#mod-runes-runes)

> 7.2 [Stones](#mod-runes-stones)

> 7.3 [Inscriptions](#mod-runes-inscriptions)

> 7.4 [Runic Sets](#mod-runes-sets)

> 7.5 [Runic-Sequence](#mod-runes-sequence)

> 7.6 [Lore](#mod-runes-lore)

---
<a name="mod-runes-runes"></a>
### 7.1 - Runes
* Different Rarities (Tiers)
* Two different types of runes (Scrolls & Components)
* Rune-Scrolls
  * Usable Item (Scroll) to create "Rune-Components" and "Inscriptions"
  * Can be crafted at the Blacksmith and found
* Rune-Components
  * Component to use in gear
  * multiple tiers available
  * you can get it by using a Rune-Scroll outside of a Runic-Sequence

---
*[Back to: 7 - Runic Inscriptions](#mod-runes)*

---
<a name="mod-runes-stones"></a>
### 7.2 - Stones
* Usable Item (Scroll)
* used to start a new Runic-Sequence
* Craftable at the Blacksmith
* Stones can be crafted with scraps
  * Common Items (White) can be salvaged with the Personal Assistant for Scraps
* Stones have Rune-Sockets and since Inscriptions are inheriting the consumed Runes' stats, the more sockets a stone has the harder it is to obtain it
  * Note: more runes used to create an Inscription, the more stats the Inscription has

---
*[Back to: 7 - Runic Inscriptions](#mod-runes)*

---
<a name="mod-runes-stones"></a>
### 7.3 - Inscriptions
* Augments to use in gear
* Different Rarities (or Tiers)
* require a Stone and a Runic-Sequence to be created

---
*[Back to: 7 - Runic Inscriptions](#mod-runes)*

---
<a name="mod-runes-sets"></a>
### 7.4 - Runic Sets
This has nothing to do with set bonuses, it simply means these are different types of runes. Only Runes from the same set can be used to create an Inscription
* Runic Empowerment
  * Craftable at a Blacksmith
  * Aether Crystals can be used with a Component to make a Rune
  * The Rune inherits all properties from the Component with increased values (basically the same Component for a higher level)
  * 5 Different Tiers are available (Required Levels: 75, 77, 79, 81, 83)
* Runic Creation
  * No Crafting required, need to find the Rune-Scroll directly
  * No Base Components, the Rune has entirely new stats
  * The Rune-Scroll can only be obtained from Phasing Beasts](#mod-misc-phasing-beasts)

---
*[Back to: 7 - Runic Inscriptions](#mod-runes)*

---
<a name="mod-runes-sequence"></a>
### 7.5 - Runic-Sequence
A quick Tutorial on "How to create an Inscription", a tutorial can also be found in the [Video Section](#mod-links-videos)
* Use an Equipment-Stone to initiate a new Sequence
* You can choose between two different Stones
  * if you are not sure what weapon is possible you can use a Generic Weapon Stone *this cannot result in Tiers higher than 1*
  * if you know exactly what weapon it is, you can use a Specific Weapon Stone (eg. 1H Axe Stone) *this can result in the highest Tier available for that Inscription*
* Use a Rune-Scroll to add Runes to the Sequence
* Use more Rune-Scrolls to add more Runes to the Sequence
* once the number of Runes [used] matches the number of Sockets [of the Stone] it will either fail or succeed in creating an Inscription
  * It will only succeed if the Runes were used in the correct order

---
*[Back to: 7 - Runic Inscriptions](#mod-runes)*

---
<a name="mod-runes-lore"></a>
### 7.6 - Lore
* You can find Lore Pages to help you figure out the Sequence used to create an Inscription
* They drop from Bookstands and [Phasing Beasts](#mod-misc-phasing-beasts)
* They also grant Experience like Lore from the Main Campaign

---
*[Back to: 7 - Runic Inscriptions](#mod-runes)*

---

---
<a name="mod-misc"></a>
## 8 - Miscellaneous

> 8.1 [Shrines & Pylons](#mod-misc-pylons)

> 8.2 [Phasing Beasts](#mod-misc-phasing-beasts)

> 8.3 [Patrons](#mod-misc-patrons)

> 8.4 [Legendary Crafting](#mod-misc-legendary-crafting)

> 8.5 [Personal Assistant](#mod-misc-assistant)

> 8.6 [Legendary Notify](#mod-misc-legendary-notify)

> 8.7 [Auto Pick Up](#mod-misc-pickup)

---
<a name="mod-misc-pylons"></a>
### 8.1 - Shrines & Pylons
* An Obelisk that grants a buff to the player and party members around.
* Duration may vary depending on your Reputation with the Planes-Shifters.
* They can randomly spawn in the Main Campaign and DGA.

#### 8.1.1 - Shrines
* Shrine effects last 1 minute
  * up to 5 minutes at revered (Planes-Shifters)
* Current Shrines in the Mod
  * Shrine of Enlightenment (150% Exp)
  * Shrine of Fleeting (50% Movement Speed)
  * Shrine of Celerity (25% Attack Speed, 25% Casting Speed)
  * Shrine of Quickening (25% Cooldown Reduction, 25% Mana Cost Reduction)
  * Shrine of the Giant - 25% Health; 25% Energy
  * Shrine of Trollblood - 25% Health Regeneration; 15 Health Regeneration; 25% Energy Regeneration; 10 Energy Regeneration
  * Shrine of Precision - 100 Offensive Ability; 25% Offensive Ability
  * Shrine of Avoidance - 100 Defensive Ability; 25% Defensive Ability
  * Shrine of Protection - 25% Armor; 25% Absorption
  * Shrine of Power - +500% All Damage
  * Shrine of Resistance - +5 to all Maximum Resistances
  * Shrine of Force - 50% reduced reflective damage taken

---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---
<a name="mod-misc-phasing-beasts"></a>
### 8.2 - Phasing Beasts
* new monster can spawn in DGA and the Main Campaign
* killing a monster will increase a counter, the value added to the counter is depending on the Monster Classification
  * a Common Monster adds +1 to the counter
  * a Hero Monster adds +5
* upon reaching a certain threshold you can spawn more powerful monsters
* kills have to occur in intervals no longer than 10 seconds, if you kill a monster 11 seconds after you killed the one before, the counter gets set to 0
  * I may add more calculations in the future if this is to hectic for some players or too easy for others
* these monsters can drop [Rune-Lore](#mod-runes-lore) and [Artifact-Pages](#mod-gifts-artifacts-pages)
  * all of them can drop [Rune-Lore](#mod-runes-lore)
  * but only Heros and stronger can drop [Artifact-Pages](#mod-gifts-artifacts-pages)
* balancing is in an early stage, all feedback is appreciated
* Difficulties increase the chance for a Phasing Beast to spawn, this makes them more difficult, because you could end up with multiple bosses at the same time.
* Difficulty also increases the "points" you are getting for each kill, so it will become easier to reach the threshold to spawn a Boss.

---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---
<a name="mod-misc-patrons"></a>
### 8.3 - Patrons
An additional layer of reward system for farming reputation, usually involves sacrificing Reputation in return for something useful and unique. First part is for Planes-Shifters' Artifact system where you can remove all your Reputation in return for a token to upgrade an Artifact, but it can be something else as well, such as Blacksmiths improving with Faction Rank. This will give you a choice between keeping the high rank a little longer or exchange it now to get the token and be able to keep farming Reputation for the next token, but have to wait to be able to craft the best possible outcome at a Blacksmith.


---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---
<a name="mod-misc-legendary-crafting"></a>
### 8.4 - Legendary Crafting
* you can craft Legendaries in return for Omega Mod's ***Legendary Essences***
* to get those Essences you can Dismantle items just like in Omega Mod
  * I added a chance for Epics to result in a Legendary Essence as well (still working on the balance)
* the Crafter can be accessed through the Personal Assistant

---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---
<a name="mod-misc-assistant"></a>
### 8.5 - Personal Assistant
* you are able to get a scroll from both the Jailor in the Main Campaign and the Settings Ghost in DGA
* this Scroll will spawn a new Ghost at the players location
* the Assistant has several services available to you
  * you can sell or stash your items
  * you can craft items
  * you can salvage common (white) items and get scraps out of them (this gives common items a purpose other than cluttering the screen)
* he will disappear when you run away
* Note: only the host in MP can use this feature

![Personal Assistant - Conversation](https://user-images.githubusercontent.com/20875155/32143862-8bd938c0-bcb0-11e7-9de9-41a2d3b1e11b.jpg "Personal Assistant - Conversation")

---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---

<a name="mod-misc-legendary-notify"></a>
### 8.6 - Legendary Notify
* Epics and Legendaries will show a small icon on the Mini-Map when they drop.
* *more is coming in the future:*
  * Sounds
  * Particle Systems (a beam or a glow)
  * Disable functionality

---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---
<a name="mod-misc-pickup"></a>
### 8.7 - Auto Pick Up
### Auto Pick Up
* this is different from Elfe's "People Are Lazy" mod as it doesn't change the items dropped, they are still the same item and as such no changes to loottables. Resulting in less issues and easier maintenance. This version obviously has its own benefits and problems
  * when you drop one of these Items they will be returned to your Inventory, be careful when you are trying to drop a Stack it will return only one of that Item
  * it is possible for me to add an option where you disable this feature (the Personal Assistant has this option)
* Items dropped are being moved into your inventory
  * Components
  * Crafting Materials
  * Scrap Metal
  * Dynamite
* when a Component drops you have a 25% chance to get that Component completed in your Inventory (this makes the chance for 4 piece Components the same and 3 piece Components are slightly harder to get)
  * it's a non-destructive approach and I can change the chance to get a Component or the fact they are Completed at any time
  * you can drop partial Components and they will return Completed into your Inventory
* you have a chance to receive an extra dynamite when you get any "Auto Pick Up Item" and an even higher chance from Aether Crystals
* Multiplayer should work, but keep an eye out for it
  * never played MP in Grim Dawn (no idea how drops are handled), right now when something with Auto Pick Up drops (for anyone) it will randomly choose which Player to give it to
* once again my Tools were used to gather all items and add the Lua Hooks required, I will make the new Tool Feature as well as a standalone version available in the near future, after the initial testing phase

---
*[Back to: 8 - Miscellaneous](#mod-misc)*

---
---
<a name="mod-links"></a>
## 9 - Links
<a name="mod-links-videos"></a>
### 9.1 - Videos
#### Runic Inscriptions
* **Tutorial:** [How To Make Inscriptions](https://youtu.be/aFObq76jXXw "How To Make Inscriptions")

---
*[Back to: 9 - Links](#mod-links)*

---

---
<a name="mod-credits"></a>
## 9 - Credits
<a name="mod-credits-contributors"></a>
### 9.1 - Contributors
#### alexei
* reworked old DGA Maps
  * Canyon
  * Forest: Hills
  * Dungeon
* new Regular DGA Maps
  * Planes of Agony

#### Zaknafein
* Regular DGA Maps
  * Bone Pit Sanctuary
  * King Temple
  * Inferno
  * Torture Chamber

#### hawk4me
* Regular DGA Maps
  * Island of Woe

<a name="mod-credits-thanks"></a>
### 9.2 - Special Thanks To
* PrincessLuna for providing a solution to "de-spawn" monsters, when I started this project
* Everyone who alpha tested v0.5.0 for Multiplayer
* AlienFromBeyond for having the idea of adding "Rune Lore" to help figure out unknown Inscriptions

<a name="mod-credits-art"></a>
### 9.3 - Graphics
#### Bitmaps ####
* various Icons made by {Lorc;Delapouite}. Available on [http://game-icons.net](http://game-icons.net "Link to the Site") - I have made some changes to them (I will list all changes and the name of the items using it later)

<a name="mod-credits-mods"></a>
### 9.4 - Mods Included
*Using Omega Mod Dismantling and Legendary Essences (with my own adjustments for Epics)*

#### Stasher
* Started by rorschachrev and using an updated version by tt300
