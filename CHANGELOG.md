# Changelog
**

---
> [v1.2.0](#v1.2.0)
>> [v1.2.1](#v1.2.1)

> [v1.1.0](#v1.1.0)

> [v1.0.0](#v1.0.0)
>> [v1.0.1](#v1.0.1)

---

---
<a name="v1.2.1"></a>
## v1.2.1
### Grim Dawn Update (1.0.3.1)
* Components have been updated to reflect the balance changes (Auto-PickUp is using the files, so they needed to be updated)
* Legendary Items have been updated to reflect the balance changes (Legendary Notify is using the files, so they needed to be updated)
* New Mythical Items have been added to Legendary Notify and Legendary Crafting

### Gifts & Treasures
* Planes-Shifters Gift (aka Leveling Gear)
  * +x to All Skills
    * slightly increased chance to be rolled on all items it can appear on
  * Focus (Off-Hand)
    * +x% Skill Cooldown Reduction
	  * now has a chance of 20% (from 12%) to be rolled
	  * values increased by 100%
  * Amulet
    * +x% Skill Cooldown Reduction
	  * values increased by 50%
  * Medal
    * +x% Skill Cooldown Reduction
	  * values increased by 50%
	  
### Phasing Components
* Part of the Phasing Lords, because they only drop from Phasing Creatures
* This first release basically changes vanilla stats to one of their counterparts (a counterpart made up by me)
  * Damage Types are changed to a new one, with the exception of Aether/Chaos everything has a DoT, so in the special case of Aether/Chaos it both changes to fire, burn changes to Aether/Chaos (the list applies to damage and resistances)
    * Cold => Vitality & Vitality => Cold
    * Lightning => Acid/Poison & Acid/Poison => Lightning
    * Fire => Aether & Aether => Fire
    * Fire => Chaos & Chaos => Fire
    * Physical => Pierce & Pierce => Physical
    * Trauma => Bleeding & Bleeding => Trauma
  * Other stats
    * Offensive Ability => Defensive Ability & Defensive Ability => Offensive Ability
    * Mana (Regen) => Life (Regen) & Life (Regen) => Mana (Regen)
    * Attack Speed => Cast Speed & Cast Speed => Attack Speed
	* +x Attribute => +x% Attribute
* Their Skills change the same way as the Component.
  * Currently the Name, Icon and Effects are the same as the Vanilla version, only the Stats are different.
* Item Icons for partials are a work in progress, but since you won't be having partials with Auto Pick Up on, they are quite low on the list of things to do, probably never gonna happen.
* You can still find Vanilla Components the same way as before and maybe the Phasing Components are a pointless idea in which case their stats get changed a little more to still be based on Vanilla, but different enough to be interesting.
  * Some might be worthless, because there already is a Component for those Damage Types.
  * Others might be amazing, because now you can get a skill you wanted with a different Damage Type (and convert it to something even more interesting).
  * Or something like "Hollowed Fang" with leech is not Vitality but Lightning.
  * When the Mastery Converters are fully implemented all this might change again, it could become better or even less useful.
* They are here to stay, used for crafting Phasing Items, new Runes, etc in the future. Just a matter of what stats they are going to have
  * Runes based on them will be implemented once I have some feedback on their uses or uselessness, simply to prevent issues for Inscriptions later on

### Miscellaneous
* Dynamite was removed from the Vendor in DGA (the same one that can be summoned with the Personal Assistant)
  * Simply not needed anymore, plenty of dynamite to get through Auto-PickUp
* Fixed an issue with Loottables for Phasing Beasts

---
<a name="v1.2.0"></a>
## v1.2.0
### Phasing Lords
* Phasing Beasts are now part of a much larger feature, the core features remain to be the same as before (kill monsters in a certain amount of time to spawn new monsters)
  * Their appearance has slightly changed
  * You can now fight more different beasts
  * In previous versions they were based on common monsters, I'm now using a Hero and scale up its stats, so the easiest of them is nearly as strong as a Hero of that monster and it's only getting worse from there
  * You can find more about them on the [wiki page](https://github.com/WareBare/WanezModGD/wiki/Phasing-Lords)
* They don't drop Rune-Lore pages anymore
* They can now sometimes give you Planar Scraps

### Gifts & Treasures
* Planes-Shifters Gift (aka Leveling Gear)
  * Due to many changes, stats on your items can be different or disappear
    * I'm trying to stay away from big changes that severely impact the player's savegame, but the overhaul hardly made that a possibility. As a result you may find yourself with a useless item that once was perfect for you
  * new Variations and Implicits (bringing it up to 24 base combinations for weapons and armor before affixes/blacksmith bonuses are added and 25 base combinations for accessories and shields/focus before affixes/blacksmith bonuses)
  * Implicits
    * Bonus to Experience Gained has been changed to +x to All Skills
    * Weight adjustments due to the change for Experience Gained
  * Affixes
    * Prefix for +x to All Skills was changed to +x% Experience Gained
	* Attribute Suffixes moved to Prefixes 
	* Suffix can now roll +x to All Attributes (at 25% of what their individual Attribute roll would be)
  * All new Information can be found in the [Wiki Post from before](https://github.com/WareBare/WanezModGD/wiki/Gifts-&-Treasures)

### Mastery
* **Conjurer**
  * Suicidal Spirit
	* Removed **15% Reduction to Enemy's Health**
    * Modifier: Empowered Spirit
	  * Replaced **Total Damage Modified by x%** with **+x% to All Damage** and **+x% Crit Damage**
* **Cleric**
  * Blade Barrier
    * Doubled Damage
	* Increased Cooldown to 2 seconds (from 1 second)
	* Increased Duration to 15 seconds (from 10 seconds)
	* Mana Cost was doubled
	* Added an Explosion to the hit of the blade (Radius: 2)
	* Increased the size of the Blades, so they can hit targets farther away (not visually)

### Bug Fixes and Improvements
* Added mod version number to the Active Quests text
* Experience Gain Equations have been divided by 2 (you will get half the XP per kill as you would without the mod, I keep reading the majority is enjoying double spawns, so it will still result in a faster leveling due to the xp gear and Phasing Beasts)
* Increased Attack/Casting Speed Maximum by +25% (to 225%) and Movement Speed Maximum by +20% (to 155%)
* **Hangman Jarvis**
  * Fixed various issues for the conversation, the changes should be making it more obvious on how to get to the **WanezMod-Settings**
  * Fixed an issue where selecting a difficulty would not work for all enemies
* Reworked how monsters in the Main Campaign are being doubled and tripled
  * The Campaign now already has more monsters, but you can still increase the number of bosses, heroes and all monsters
* Crafting Vanilla Materials will result more often in a material than dynamite and AoM materials have been added to the pool of possible outcomes
* AutoPickUp
  * Multiplayer: Experimental changes
  * Dynamite will now be picked up, it somehow slipped through the script...

---

---
<a name="v1.1.0"></a>
## v1.1.0
<a name="v1.1.0-legendary-notify"></a>
### Legendary Notify
* Epics and Legendaries will show a small icon on the Mini-Map when they drop.
* *more is coming in the future:*
  * Sounds
  * Particle Systems (a beam or a glow)
  * Disable functionality

<a name="v1.1.0-autopickup"></a>
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

| Items | Dynamite Chance |
| :--- | :---: |
| Components | 1% |
| Aether Crystals | 20% |
| Other | 5% |
* Multiplayer should work, but keep an eye out for it
  * never played MP in Grim Dawn (no idea how drops are handled), right now when something with Auto Pick Up drops (for anyone) it will randomly choose which Player to give it to
* once again my Tools were used to gather all items and add the Lua Hooks required, I will make the new Tool Feature as well as a standalone version available in the near future, after the initial testing phase

<a name="v1.1.0-mastery"></a>
### New Mastery (Cleric)
Everything about the new Mastery Concept can be found [here](https://github.com/WareBare/WanezModGD/wiki/Mastery-Concept)

<a name="v1.1.0-legendary-crafting"></a>
### Legendary Crafting
* Upgraded Epics and Legendaries were in a different folder and I missed them, they can now be crafted as well.
* Blank items won't show up anymore
* crafting cost equation was changed to make higher level items more expansive and lower level items less expansive
  * the cost before was not considering Epic items to have a chance on Legendary Essence
  * being able to craft Legendaries and Dismantle them only really became an option with the Gifts & Treasure crafting
  * Blueprints were added to a Blacksmith with Bonuses later during the development of the mod, making them more powerful than what you can find
  * *all this should further prevent hording of Legendaries and make crafting them and collecting Legendary Essences more interesting*
  
<a name="v1.1.0-gifts"></a>
### Gifts & Treasures
* changed when Planes-Shifters Gift becomes Epic and Legendary, because of Legendary Crafting
  * you were able to craft a fairly cheap Legendary and Dismantle it, moving the first Legendary item up by two tiers makes it a little more costly (gonna keep a close eye on this)
* changed the + to All Skill amount, it's now always +1 with the exception of the Level 100 Gear (+2)
  * the new Mastery Modifiers and Passives should be hard to get and an easy +3 All Skills wouldn't make this hard
  
<a name="v1.1.0-bugfixes"></a>
### Bug Fixes
* fixed an issue with AoM Campaign Riftgates
* fixed a bug where monsters in the Main Campaign would spawn to low level, they now scale with player level as the additional monsters (spawned with the setting double/triple spawn)
  * you would have half of the monsters low level and the other half high level, they are the same level now.

---

---
<a name="v1.0.1"></a>
## v1.0.1
* fixed an issue in DGA, where monsters would not spawn in some Modes

---
<a name="v1.0.0"></a>
## v1.0.0
* the very old items (pre v0.5.0) have been removed, so if you still had some of those, they are gone when you load v1.0.0 - you shouldn't have any of them unless you stashed them away for over 6 months.
* Documentation (README) was rewritten and old information removed as well as new information added
* you won't be able to download the Campaign with the mod anymore, there is a .bat you can use to copy the Levels.arc into the mod folder, more information on this is in the new Readme

### Expansion
* *AoM:* Inquisitor and Necromancer have been added
* new Monsters added to DGA spawn pools
* Devotion cap and Level cap changed to the new AoM cap 
* other changes like XP equations, etc changed to the AoM values
* anything I have missed will be fixed later, since I havn't played the Expansion without a mod I can't tell if everything is right (are bosses missing or is something not happening as it should)

### Major Features
* Added Planes-Shifters (aka "Leveling") Gear for levels 85 and 100 where Level 100 Gear is rather expansive compared to the rest. It's quite possible I'll have to make some nerfs to higher gear, I havn't checked with the new items and the scaling algorithm I'm using for them.
* Pylons can now spawn in the Campaign

#### Personal Assistant
* You can get a Scroll from the Settings Ghost (in DGA) or Jailor (Main Campaign)
* that Scroll will summon a ghost when used with several options

![Personal Assistant - Conversation](https://user-images.githubusercontent.com/20875155/32143862-8bd938c0-bcb0-11e7-9de9-41a2d3b1e11b.jpg "Personal Assistant - Conversation")

#### [Legendary Crafting](http://www.grimdawn.com/forums/showthread.php?t=57005)
* Vanilla Epics and Legendaries can be crafted at a new Blacksmith (accessible through the new Personal Assistant)
  * it's a long list, it may take a moment to load and I recommend collapsing everything and only expand the type you want to craft
* They can be crafted for Legendary Essences (from Omega Mod) and Iron Bits
* Dismantling Legendaries will give you Legendary Essences.
  * Epics have a lower chance
* Update from the initial Release of the Standalone version:
  * minor Blueprint cleanup
  * Blacksmiths have been changed to only show these new Blueprints
  * Blacksmiths have the same bonuses as the Gifts & Treasures Blacksmiths (= crafted Legendaries can be slightly better due to an affix being rolled on it)
  
### Minor Features
* Organized Settings NPC a little. e.g. Difficulties are now in a new Sub-Conversation.
* Instead of Salvaging Common Items at the Ghost or Jailor you can now use the Personal Assistant for that and the conversation for it has been replaced to give you the Scroll to summon the Assistant
* DGA Challenge Enemies have been changed to regular enemy strength (it adds too many additional files especially with AoM Enemies = not fun to build the mod when it takes over 3 minutes each time I need to work on it)
* DGA Legendary Drop-Rates increased by roughly 50% more than the AoM increase

### Bug Fixes
* Difficulty could not be set to higher than Elite, it now goes all the way up to Legendary as it's supposed to


