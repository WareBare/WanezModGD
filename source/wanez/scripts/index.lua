--[[

Wanez - MOD

table ('namespace'):
wanez.x.y
when x starts with upper-case its a submod of wanez - it still requires the main wanez package (wanez.Runes)
when x start with lower-case its a package inside the main wanez package (wanez.scroll)
only classes and array files are using their prefix, packages are a simple lower-case and global function files are considered packages (wanez.scroll._Functions; wanez.scroll.events)

methods starting with __ (double underscore) have acces to local variables inside the file (not the instance) in a way similar to static properties;

files starting with:

submod files are loaded inside the index.lua of the submod

@author: WareBare (warebare89@gmail.com)
@version: 0.5.0

Updated: 01/20/2017

]]

wanez = {}
wanez.MP = {}
wanez.isDev = false
--wanez.isDifficulty = false

---
Script.Load("wanez/scripts/data/index.lua")
Script.Load("wanez/scripts/fn/index.lua")

--- Load LIB
Script.Load("wanez/scripts/lib/index.lua")

--- LOAD FILES
Script.Load("wanez/scripts/main.lua");
Script.Load("wanez/scripts/gd.lua");
Script.Load("wanez/scripts/dga.lua");
Script.Load("wanez/scripts/runes.lua");
Script.Load("wanez/scripts/pa.lua");

Script.Load("wanez/scripts/misc/ln.lua");
Script.Load("wanez/scripts/misc/autopickup.lua");

clientQuestTable = clientQuestTable + wanez.MP
