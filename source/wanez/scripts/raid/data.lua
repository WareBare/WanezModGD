--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/21/2017
Time: 4:08 PM

Package: 
]]--

local Quests = {
    PhasingLords = {
        KeyDBR = "mod_wanez/_events/phasing/items/craft_phasingkey.dbr",
        Error_MissingKey = "tagWzRaid_Lua_PhasingLords_MissingKey_NOTIFY",
        MainQuest = {0x080B3B50, 0x196388A0},
        SideQuests = {
            {0xB6383800, 0x24DAA340},
            {0x6C520F00, 0x7F655D00},
            {0xDE6FE700, 0x84C0C800}
        }
    }
}

local Chests = {
    PhasingLords = {
        KeyDBR = "mod_wanez/_raid/phasinglords/key_treasure.dbr",
        TreasureChests = {
            "mod_wanez/_raid/phasinglords/chests/treasure_01_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_01_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_01_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_01_chest.dbr",
            
            "mod_wanez/_raid/phasinglords/chests/treasure_02_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_02_chest.dbr",
            
            "mod_wanez/_raid/phasinglords/chests/treasure_03_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_03_chest.dbr",
            
            "mod_wanez/_raid/phasinglords/chests/treasure_04_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_04_chest.dbr",
            
            "mod_wanez/_raid/phasinglords/chests/treasure_05_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_05_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_05_chest.dbr",
            "mod_wanez/_raid/phasinglords/chests/treasure_05_chest.dbr"
        }
    }
}

local Events = {
    PhasingLords = {
        Lords = {
            WaveData = {
                DBR = "mod_wanez/_raid/phasinglords/placeables/script_waveevent_default.dbr",
                Updater = "cRaid.UpdateEvent",
                Enemies = {
                    Wave = {
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_basilisk_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_basilisk_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_basilisk_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_boar_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_boar_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_boar_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_dermapteran_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_dermapteran_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_dermapteran_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_ghostcrab_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_ghostcrab_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_ghostcrab_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_harpy_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_harpy_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_harpy_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_manticore_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_manticore_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_manticore_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_mosquitogiant_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_mosquitogiant_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_mosquitogiant_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_raptor_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_raptor_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_raptor_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_raptor_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_raptor_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_raptor_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_slith_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_slith_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_slith_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_spider_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_spider_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_spider_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_vulture_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_vulture_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_vulture_01c.dbr",
            
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_waspgiant_01a.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_waspgiant_01b.dbr",
                        "mod_wanez/_events/phasing/creatures/enemies/phasing_waspgiant_01c.dbr"
                    },
                    Guardian = "mod_wanez/_raid/phasinglords/enemies/guardian_lord_01.dbr",
                    Guardian2 = "mod_wanez/_raid/phasinglords/proxies/proxy_boss_guardian.dbr"
                }
            },
            Bosses = {
                "boss_lord_01_aether.dbr",
                "boss_lord_01_chaos.dbr",
                "boss_lord_01_cold.dbr"
            },
            Bosses2 = {
                "boss_lord_01_fire.dbr",
                "boss_lord_01_life.dbr",
                "boss_lord_01_lightning.dbr",
                "boss_lord_01_physical.dbr",
                "boss_lord_01_pierce.dbr",
                "boss_lord_01_poison.dbr"
            }
        }
    }
}

local Portals = {
    PhasingLords = {
        Paths = {
            "WA_RAID_PHASINGLORDS_PATH01",
            "WA_RAID_PHASINGLORDS_PATH02",
            "WA_RAID_PHASINGLORDS_PATH03",
            "WA_RAID_PHASINGLORDS_PATH04"
        }
    }
}

wanez.Raid.data = {
    Quests = Quests,
    Chests = Chests,
    Events = Events,
    Portals= Portals
}
