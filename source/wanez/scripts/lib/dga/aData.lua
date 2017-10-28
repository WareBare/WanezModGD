--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/22/2017
Time: 7:16 PM

Package: 
]]--

wanez.DGA.aData = {
    Inhabitants = {
        [1] = "pack_harpy",
        [2] = "pack_mosquitogiant",
        [3] = "pack_skeleton",
        [4] = "pack_humanoutlaw",
        [5] = "pack_chthonianfiend",
        [6] = "pack_humanchthonic",
        [7] = "pack_yeti",
        [8] = "",
        [9] = "pack_chthoniandevourer",
        [10] = "pack_zombie",
        [11] = "",
        [12] = "pack_ghoul",
        [13] = "pack_chthoniandreadguard",
        [14] = "",
        [15] = "",
        [16] = "",
        [17] = "",
        [18] = "",
        [19] = "",
        [20] = "",
        [101] = "pack_boar",
        [501] = "pack_manticore",
        [502] = "pack_trollhalfswamp",
        [503] = "pack_groblea",
        [504] = "pack_vulture"
    };
    bossSpawn = {
        [1] = "banditminiboss_pitmaster",
        [2] = "slith_slithlab01",
        [3] = "skeleton_floodedpassageruins_01",
        [4] = "humanpossessed_necrocatalyst01",
        [5] = "chthonian_chthonicroguelike_02",
        [6] = "cultist_cultleader_01",
        [7] = "yeti_asterkarnmountains_01",
        [8] = "",
        [9] = "cultistdungeon_sectleader",
        [10] = "skeletalgolem_uroboruuksearch_01",
        [11] = "",
        [12] = "ghost_maninneed_01",
        [13] = "chthonianfiend_trappedandalone_01",
        [14] = "",
        [15] = "",
        [16] = "",
        [17] = "",
        [18] = "",
        [19] = "",
        [20] = "",
        [101] = "golemrock_miniboss_cave_02",
        [501] = "banditminiboss_coastcaveboss",
        [502] = "troll_swampking",
        [503] = "spidergiant_mountaindeeps_01",
        [504] = "smugglerbasin_dranghoul"
    };
    monsterClassifications = {
        [1] = "Common",
        [2] = "Champion",
        [3] = "Hero",
        [4] = "BossMini",
        [5] = "BossDefault",
        [6] = "Nemesis",
        [7] = "BossChallenge",
        [8] = "BossRaid",
        [9] = "BossSpecial",
        --[9] = "Anomaly"
    };
    entityTypes = {
        -- Mission
        {
            {"Enemy",95},
            {"Container",3},--, {"Anomaly",100}
            {"Pylon",2}
        };
        -- Endless
        {
            {"Enemy",95},
            {"Container",3},--, {"Anomaly",100}
            {"Pylon",2}
        };
        -- Challenge
        {
            {"Enemy",93},
            {"Container",5},--, {"Anomaly",100}
            {"Pylon",2}
        };
        -- Raid
        {
            {"Enemy",88},
            {"Container",10},--, {"Anomaly",100}
            {"Pylon",2}
        };
    };
    enemyTypes = {
        -- Mission
        {
            inhabitantChance = 20; -- {unsigned Int} chance to spawn inhabited enemies
            useProxies = 60; -- {unsigned Int} chance to use available proxies 50% will result in ~half of the available spawn locations
            commonCount = {4,5,7}; -- may not go below 3
            championCount = {3,4,6}; -- chance for max champions per pack, may not go below 3
            championChance = {25,30,50}; -- combination of heroChance and championChance may not go beyond 100
            heroCount = {1,2,3}; -- chance for max heroes per pack, may not go below 1
            heroChance = {15,20,40}; -- combination of heroChance and championChance may not go beyond 100
            heroReq = 15; -- level requirement for heroes, not before player level {x}
            championReq = 10; -- level requirement for champions, not before player level {x}
            nemesisChance = {0,25,75,300}; -- nemesis spawn chance per faction rank
        };
        -- Endless
        {
            inhabitantChance = 15;
            useProxies = 60;
            commonCount = {4,5,7};
            championCount = {3,4,6};
            championChance = {25,30,50};
            heroCount = {1,2,3};
            heroChance = {15,20,40};
            heroReq = 15;
            championReq = 10;
            nemesisChance = {0,25,75,300};
        };
        -- Challenge
        {
            inhabitantChance = 5;
            useProxies = 60;
            commonCount = {4,5,7};
            championCount = {3,4,6};
            championChance = {25,30,50};
            heroCount = {1,2,3};
            heroChance = {15,20,40};
            heroReq = 15;
            championReq = 10;
            nemesisChance = {0,100,200,400};
        };
        -- Raid
        {
            inhabitantChance = 50;
            useProxies = 50;
            commonCount = {4,5,7};
            championCount = {3,4,6};
            championChance = {25,30,50};
            heroCount = {1,2,3};
            heroChance = {15,20,40};
            heroReq = 15;
            championReq = 10;
            nemesisChance = {0,25,75,300};
        };
    };
    reputationGain = {
        -- Mission
        {
            perClass = {5,25,50,50,75,100,150,150,150};
            rankPenalty = {10.0,3.0,1.00,0.25,0.25}
        };
        -- Endless
        {
            perClass = {5,25,50,50,75,100,150,150,150};
            rankPenalty = {10.0,3.0,1.00,0.25,0.25}
        };
        -- Challenge
        {
            perClass = {5,25,50,50,75,100,150,150,150};
            rankPenalty = {10.0,3.0,1.00,0.25,0.25}
        };
        -- Raid
        {
            perClass = {5,25,50,50,75,100,150,150,150};
            rankPenalty = {10.0,3.0,1.00,0.25,0.25}
        };
    };
    containers = {
        -- Mission
        {
            {'chest_dga_01.dbr',25},
            {'chest_dga_02.dbr',100},
            {'chest_dga_03.dbr',150},
            {'lorechest_runes_001.dbr',100}
        };
        -- Endless
        {
            {'chest_dga_01.dbr',25},
            {'chest_dga_02.dbr',100},
            {'chest_dga_03.dbr',150},
            {'lorechest_runes_001.dbr',100}
        };
        -- Challenge
        {
            {'chest_dga_01.dbr',25},
            {'chest_dga_02.dbr',100},
            {'chest_dga_03.dbr',150},
            {'lorechest_runes_001.dbr',100}
        };
        -- Raid
        {
            {'chest_dga_01.dbr',25},
            {'chest_dga_02.dbr',100},
            {'chest_dga_03.dbr',150},
            {'lorechest_runes_001.dbr',100}
        };
    };
    monsterPower = {
        difficulties = {
            {
                name = "normal"; -- casual
                token = "WZ_DGA_MP_DIFFICULTY_01";
                quest = {0x6173C180,0xF69F4800};
                mulScroll = -10;
            }, {
                name = "normal";
                token = "WZ_DGA_MP_DIFFICULTY_02";
                quest = {0xDF3A1A00,0xF69F4800};
                mulScroll = 0;
            }, {
                name = "hard";
                token = "WZ_DGA_MP_DIFFICULTY_03";
                entitySpawn = "mod_wanez/skills/difficulty_entity_01.dbr";
                quest = {0x5F6EF180,0xF69F4800};
                mulScroll = 20;
            }, {
                name = "elite";
                token = "WZ_DGA_MP_DIFFICULTY_04";
                entitySpawn = "mod_wanez/skills/difficulty_entity_02.dbr";
                quest = {0x6CB2C580,0xF69F4800};
                mulScroll = 50;
            }, {
                name = "ultimate";
                token = "WZ_DGA_MP_DIFFICULTY_05";
                entitySpawn = "mod_wanez/skills/difficulty_entity_03.dbr";
                quest = {0x18E18680,0xF69F4800};
                mulScroll = 100;
            }, {
                name = "epic";
                token = "WZ_DGA_MP_DIFFICULTY_06";
                entitySpawn = "mod_wanez/skills/difficulty_entity_04.dbr";
                quest = {0x5A476300,0xF69F4800};
                mulScroll = 150;
            }, {
                name = "legendary";
                token = "WZ_DGA_MP_DIFFICULTY_07";
                entitySpawn = "mod_wanez/skills/difficulty_entity_05.dbr";
                quest = {0xEAB0D600,0xF69F4800};
                mulScroll = 200;
            }
        };
        types = {
            {
                name = "a"; -- Mission
                mul = 0;
                mulScroll = 0;
            }, {
                name = "a"; -- Endless
                mul = 10;
                mulScroll = 0;
            }, {
                name = "a"; -- Challenge => b
                mul = 30;
                mulScroll = 0;
            }, {
                name = "a"; -- Raid => c
                mul = 75;
                mulScroll = 0;
            }
        };
        modes = {
            {
                name = "heroic";
                mulScroll = 0;
            }, {
                name = "epic";
                mulScroll = 100;
            }
        };
    };
    affixes = {
        {
            token = "WZ_DGA_AFFIX_01_COMPLETE",
            quests = {
                {0x34FEE280,{0x49CBF400},15},
                {0x87D2A800,{0x49CBF400},5},
                {0x17244760,{0x49CBF400},15},
                {0x4ECC8C00,{0x49CBF400},10},
                {0x56FC8300,{0x49CBF400},5}
            }
        },
        {
            token = "WZ_DGA_AFFIX_01_COMPLETE";
            quests = {
                {0x4FB55F00,{0x49CBF400},5},
                {0x0C5FB820,{0x49CBF400},5},
                {0x6031C680,{0x49CBF400},5},
                {0x63E0B900,{0x49CBF400},5},
                {0x36817880,{0x49CBF400},5},
                {0x6E0CAD80,{0x49CBF400},5}
            }
        }
    };
    affixEvents = {
        enemyCount = {
            [2] = {{'a004',4}},
            [3] = {{'a003',2}},
            [5] = {{'a001',1}},
            [6] = {{'a002',1}},
            [7] = {{'a001',1}},
            [8] = {{'a001',1}},
        };
        entityChances = {
            proxies = {{'a005',25}}
        };
        buffDbr = {
            {{'b001',"mod_wanez/_dga/items/affixes/b001_entity_01.dbr"}},
            {{'b002',"mod_wanez/_dga/items/affixes/b002_entity_01.dbr"}},
            {{'b003',"mod_wanez/_dga/items/affixes/b003_entity_01.dbr"}},
            {{'b004',"mod_wanez/_dga/items/affixes/b004_entity_01.dbr"}},
            {{'b005',"mod_wanez/_dga/items/affixes/b005_entity_01.dbr"}},
            {{'b006',"mod_wanez/_dga/items/affixes/b006_entity_01.dbr"}}
        };
    };
    mpModes = {
        -- EPIC
        {
            quest = {0x72D02680,{0xBF980D00,0x978ECA00}}
        }
    };
    dgaTypes = {
        mission = {
            quests = {
                {0xDF346300,{0xE8500700}}
            }
        },
        endless = {
            quests = {
        
            }
        };
        challenge = {
            quests = {
                {0x1F0334C0,{0x64832E80,0xCB769800,0x49541200,0x5954D400,0x87400200,0x0382CFD8,0x3505CD80,0xFD9B3E00}}
            }
        };
        raid = {
            quests = {
                
            }
        };
    };
    dropChances = {
        -- Mission
        {
            regularScroll = 5;
            endlessScroll = 0;
            soul = 5;
            essence = 20;
            rewardDevotion = 50;
            repDrop = 5;
        };
        -- Endless
        {
            regularScroll = 1;
            endlessScroll = 10;
            soul = 1;
            essence = 6;
            rewardDevotion = 50;
            repDrop = 1;
        };
        -- Challenge
        {
            regularScroll = 2;
            endlessScroll = 0;
            soul = 5;
            essence = 20;
            rewardDevotion = 50;
            repDrop = 5;
        };
        -- Raid
        {
            regularScroll = 10;
            endlessScroll = 0;
            soul = 5;
            essence = 20;
            rewardDevotion = 50;
            repDrop = 10;
        };
    };
}


