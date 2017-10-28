--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/20/2017
Time: 4:56 PM

lib - library/classes

not using wanez.lib.x because classes are all in here and there have a 'c' prefix


# Class Structure #
* each package has an index.lua where every other file is being loaded
* cBase is the core of that package, even if the other classes are basically empty and only inherit cBase I still prefer to do it that way to avoid conflicts if there is a difference in the future


package: lib
]]

--- classes
Script.Load("wanez/scripts/lib/cBase.lua");
Script.Load("wanez/scripts/lib/cScroll.lua");
Script.Load("wanez/scripts/lib/cQuest.lua");

--- packages
Script.Load("wanez/scripts/lib/dga/index.lua");
Script.Load("wanez/scripts/lib/runes/index.lua");
