--[[
Created by IntelliJ IDEA.
User: Ware
Date: 11/11/2017
Time: 5:40 PM

Package: PhasingEvents
]]--

wanez.PhasingEvents = {}

local PlanarScrapDBR = "mod_wanez/_gear/materials/a_001a.dbr"
local mPlanarChancesPerId = { -- random(1, 1000)
    10,   -- Common
    50,   -- Champion
    100,  -- Hero
    500,  -- Guardian
    750,  -- Alpha
    1000  -- Lord
}
--- BEAST PROPERTIES
local entityNames = {
    "phasing_manticore_01",
    "phasing_slith_01",
    "phasing_boar_01",
    "phasing_basilisk_01",
    "phasing_dermapteran_01",
    "phasing_ghostcrab_01",
    "phasing_harpy_01",
    "phasing_mosquitogiant_01",
    "phasing_raptor_01",
    "phasing_rifthound_01",
    "phasing_spider_01",
    "phasing_vulture_01",
    "phasing_waspgiant_01"
}
local killRating = 0
local timeSinceLastKill = Time.Now()
local aRewards = {1,2,5,10,25,25,25,25,25,25,25,25,25,25}
local aRewardsDifficultyMul = {1,1,1,2,2,3,3}
local PathToPhasingEnemies = "mod_wanez/_events/phasing/creatures/enemies/"

--- SPIRIT PROPERTIES
local mChanceToSpawnSpirit = {
    2,
    4,
    8,
    15,
    25,
    100
}

--- WAVE_EVENT PROPERTIES

--- @return uint
local function GetPlanarInvaderLevel(InMonsterClassificationId)
    local iInvaderLevel = Game.GetAveragePlayerLevel() + InMonsterClassificationId
    
    return iInvaderLevel
end

--- @return boolean
local function IsInvaderAllowedToSpawn(InDifficultyId)
    wanez.GlobalRandomSeed()
    local iRandomChance = random(1,100)
    local iChance = 4 * InDifficultyId

    if(Game.GetGameDifficulty() == Game.Difficulty.Legendary) then
        iChance = iChance * 2
    end
    
    local bIsAllowed = iRandomChance <= iChance
    
    
    return bIsAllowed
end

local DifficultySpawnDBR = false
local function spawnPlanarInvader(InEnemyId, InMonsterClassificationId, InDifficultyId)
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        
        local difficultySpawn = wanez.DGA.aData.monsterPower.difficulties[InDifficultyId].entitySpawn or false
        DifficultySpawnDBR = difficultySpawn
        
        local randomSpawnClass = wanez.GetLetterForId( random(1,InMonsterClassificationId) )
        local randomEntityType = random(1, 13)
        local enemyCoords = Entity.Get(InEnemyId):GetCoords()
        if( IsInvaderAllowedToSpawn(InDifficultyId) ) then
            local newEnemy = Character.Create(PathToPhasingEnemies..entityNames[randomEntityType]..randomSpawnClass..".dbr", GetPlanarInvaderLevel(InMonsterClassificationId), nil)
            newEnemy:SetCoords(enemyCoords)
            
            --if(difficultySpawn) then
                --local newEnemy = Character.Create(difficultySpawn,Game.GetAveragePlayerLevel() + InMonsterClassificationId,nil)
                --newEnemy:SetCoords(enemyCoords)
            --end
            wanez.PhasingEvents.SpawnDifficultyEntity(enemyCoords)
        end
    end
end
wanez.PhasingEvents.SpawnDifficultyEntity = function(InCoords)
    if(InCoords ~= nil and Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false) then
        if(DifficultySpawnDBR) then
            local _DifficultyEntity = Character.Create(DifficultySpawnDBR, Game.GetAveragePlayerLevel(), nil)
            _DifficultyEntity:SetCoords(InCoords)
        end
    end
end

local function SummonSpirit(InBeastId, InMonsterClassificationId)
    local bHasSummonedSpirit = false
    
    if( killRating > 50 and random(1,100) <= 2 ) then
        --if( (Time.Now() - timeSinceLastKill) <= 10000 ) then
        local _Beast = Entity.Get(InBeastId)
        --  and killRating >= 10
        if(_Beast ~= nil)then
            local SpawnCoords = _Beast:GetCoords()
            
            local ScriptSpiritDBR = "mod_wanez/_events/phasing/creatures/spirits/waveevent_scriptentity_spirit.dbr"
            local _ScriptEntity = Entity.Create(ScriptSpiritDBR)
            _ScriptEntity:SetCoords(SpawnCoords)
            --killRating = 1
            bHasSummonedSpirit = true
        end
        --else
        --killRating = 1
        --end
    end
    
    return bHasSummonedSpirit
end
local function onDieEntity(InEnemyId, InMonsterClassificationId, InDifficultyId)
    
    InDifficultyId = InDifficultyId or 1
    
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        if(killRating == 0) then
            --math.randomseed(Time.Now());
        end
        if( random(1, 100) <= 1 ) then
            local cChest = Entity.Create("mod_wanez/_events/phasing/chests/chest_01.dbr")
            
            if(cChest ~= nil) then
                local cTargetEntity = Entity.Get(InEnemyId)
                
                if(cTargetEntity ~= nil) then
                    cChest:SetCoords( cTargetEntity:GetCoords() )
                else
                    UI.Notify("{^r}DEBUG: {^w}An error occured trying to get the spawn target for Phasing Chest!")
                end
            else
                UI.Notify("{^r}DEBUG: {^w}An error occured trying to create Phasing Chest!")
            end
        end
        if( (Time.Now() - timeSinceLastKill) <= 10000 ) then -- 10 seconds between kills or reset killRating
    
            if(SummonSpirit(InEnemyId, InMonsterClassificationId) == false) then
                killRating = killRating + (aRewards[InMonsterClassificationId] * aRewardsDifficultyMul[InDifficultyId]);
                --UI.Notify('add to Rating')
                if(killRating <= 75) then
                    -- spawn common
                    spawnPlanarInvader(InEnemyId, 1, InDifficultyId)
                elseif(killRating <= 250) then
                    -- spawn champion
                    spawnPlanarInvader(InEnemyId, 2, InDifficultyId)
                else
                    -- spawn hero
                    spawnPlanarInvader(InEnemyId, 3, InDifficultyId)
                end
            end
        else
            --UI.Notify('reset Rating')
            if(killRating >= 100) then UI.Notify("tagWzCampaingLua_TimeHasRunOut") end;
            killRating = aRewards[InMonsterClassificationId] * aRewardsDifficultyMul[InDifficultyId];
            math.randomseed(Time.Now());
        
        end
        
        timeSinceLastKill = Time.Now()
    end
    --UI.Notify("working onDie")
end
function wanez.PhasingEvents.onDieEntity(InObjectId, InClassId, InDifficultyId)
    if(Server) then
        onDieEntity(InObjectId, InClassId, InDifficultyId)
    end
    
end

local function GivePhasingKey()
    local _Player = Game.GetLocalPlayer()
    
    if(_Player) then
        _Player:GiveItem("mod_wanez/_events/phasing/items/craft_phasingkey.dbr", 1, true)
    end
end
local ReputationClassId = 1 -- used in: QuestGlobalEvent
local function GiveReputation_OnDie(InBeastId, InClassId)
    if(Server) then
        ReputationClassId = InClassId
        QuestGlobalEvent("wzPhasingEvents_GiveReputationToPlayer")
    
        timeSinceLastKill = Time.Now()
        --onDieEntity(InObjectId, InClassId, 1)
    end
end

-- delete if MP is working correctly
local function GiveReputation_OnDie_OLD(InObjectId, InClassId)
    local aRep = {0,0,1,3,5}
    local iRep = aRep[InClassId]
    local PlayerCount = Game.GetNumPlayers();
    
    local _Player;
    for i=1,PlayerCount do
        _Player = Game.GetPlayer(i - 1)
        
        _Player:GiveFaction("USER14",iRep)
        _Player:GiveFaction("USER15",iRep * -1)
    end;
end

wanez.PhasingEvents.Enemy = {}
wanez.PhasingEvents.Enemy.OnDie_Common = function(InObjectId)
    GiveReputation_OnDie(InObjectId, 1)
end
wanez.PhasingEvents.Enemy.OnDie_Champion = function(InObjectId)
    GiveReputation_OnDie(InObjectId, 2)
end
wanez.PhasingEvents.Enemy.OnDie_Hero = function(InObjectId)
    GiveReputation_OnDie(InObjectId, 3)
end
wanez.PhasingEvents.Enemy.OnDie_Guardian = function(InObjectId)
    GiveReputation_OnDie(InObjectId, 4)
end
wanez.PhasingEvents.Enemy.OnDie_Alpha = function(InObjectId)
    GiveReputation_OnDie(InObjectId, 5)
    
    GivePhasingKey()
end
wanez.PhasingEvents.Enemy.OnDie_Lord = function(InObjectId)
    GiveReputation_OnDie(InObjectId, 6)
end

wanez.PhasingEvents.Enemy.OnDie_Spirit = function(InSpiritId)
    local _Player = Game.GetLocalPlayer()
    --UI.Notify("Spirit Died, give item")
    if(_Player and (random(1,100) <= 25) ) then
        _Player:GiveItem("mod_wanez/_events/phasing/items/craft_phasingcrystal.dbr", 1, true)
    end
    
end

--- WAVE_EVENT
wanez.PhasingEvents.WaveEvent = {}

--- SPIRIT
local mSpirits = {
    "spirit_wraith_01",
    "spirit_wraith_01"
}
local function NewSpiritEvent(InEntityId)
    local RandomSpiritId = random(1, 2)
    local SpiritDBR = "mod_wanez/_events/phasing/creatures/spirits/"..mSpirits[RandomSpiritId]..".dbr"
    
    local _Spirit = Character.Create(SpiritDBR, GetPlanarInvaderLevel(5), nil)
    _Spirit:SetCoords( Entity.Get(InEntityId):GetCoords() )

    wanez.WaveEvent.Start({
        scriptEntity = InEntityId,
        waveTarget = _Spirit:GetId(),
        spawnPeriod = 30000,
        despawnTimer = 31000,
        useOnlySpawnPeriod = true,
        endCallback = wanez.PhasingEvents.WaveEvent.EndCallback_Spirit,
        waves = {
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr"
        }
    })
end
wanez.PhasingEvents.WaveEvent.OnAddToWorld_Spirit = function(InEntityId, InKey)
    if(Server) then
        local mUserData = Shared.getUserdata(InEntityId)
        if (mUserData == nil) then
            NewSpiritEvent(InEntityId)
            --UI.Notify("spawned spirit")
        end
    end
end
wanez.PhasingEvents.WaveEvent.OnRemoveFromWorld_Spirit = function(InEntityId)
    if Server then
        local mUserData = Shared.getUserdata(InEntityId)
        
        if (mUserData ~= nil) then
            if (mUserData.waveEvent.running) then
                Script.UnregisterForUpdate(InEntityId, "wanez.WaveEvent.Update")
                --Shared.persistUserdata(InEntityId, mUserData.waveEvent.key)
            else
                Shared.setUserdata(InEntityId, {})
            end
        end
    end
    
    --local _Entity = Entity.Get(InEntityId)
    --if(_Entity) then
        --UI.Notify("toDestroy Entity")
        --_Entity:Destroy()
    --end
end
wanez.PhasingEvents.WaveEvent.EndCallback_Spirit = function(InEntityId)
    local waveEvent = Shared.getUserdata(InEntityId).waveEvent

    local _Target = Entity.Get( waveEvent.waveTarget )

    --UI.Notify("Destroy Spirit")
    if(_Target ~= nil)then
        _Target:Destroy()
    end
end

--- ALPHA
local function NewAlphaEvent(InEntityId)
    wanez.WaveEvent.Start({
        scriptEntity = InEntityId,
        --spawnPeriod = 20000,
        waves = {
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave01.dbr",
            "mod_wanez/_events/phasing/proxies/proxy_wave02.dbr"
        }
    })
end
wanez.PhasingEvents.WaveEvent.OnAddToWorld_Alpha = function(InEntityId, InKey)
    if(Server) then
        local mUserData = Shared.getUserdata(InEntityId)
        if (mUserData == nil) then
            NewAlphaEvent(InEntityId)
        end
    end
end
wanez.PhasingEvents.WaveEvent.OnRemoveFromWorld_Alpha = function(InEntityId)
    if Server then
        local mUserData = Shared.getUserdata(InEntityId)
    
        if (mUserData ~= nil) then
            if (mUserData.waveEvent.running) then
                Script.UnregisterForUpdate(InEntityId, "wanez.WaveEvent.Update")
                --Shared.persistUserdata(InEntityId, mUserData.waveEvent.key)
            else
                Shared.setUserdata(InEntityId, {})
            end
        end
    end
    --local mUserData = Shared.getUserdata(InEntityId)
    
    --if (mUserData ~= nil) then
        --Shared.setUserdata(InEntityId, nil)
    --end

    --local _Entity = Entity.Get(InEntityId)
    --if(_Entity) then
        --UI.Notify("toDestroy Entity")
        --_Entity:Destroy()
    --end
    
end



--- Global Events, addition to QuestGlobalEvent()
local addToClientQuestTable = {
    wzPhasingEvents_GiveReputationToPlayer = function()
        local _Player = Game.GetLocalPlayer()
    
        local aRep = {0,1,3,5,15,50}
        local iRep = aRep[ReputationClassId]
    
        if(_Player) then
            _Player:GiveFaction("USER14",iRep)
            _Player:GiveFaction("USER15",iRep * -1)
        
            -- Also Give Planar Scrap
            local BasicItemsFirst = mPlanarChancesPerId[ReputationClassId] / 100
            local BasicItems = math.floor(BasicItemsFirst)
            local RemainingChance = mPlanarChancesPerId[ReputationClassId] - (BasicItems * 100)
            --UI.Notify("Basics: "..BasicItems)
            if( RemainingChance > 0) then
                if( random(1, 100) <= RemainingChance ) then
                    BasicItems = BasicItems + 1
                end
                --UI.Notify("Basics #002: "..BasicItems)
            end
            if(BasicItems > 0) then
                --UI.Notify("Give: "..BasicItems)
                _Player:GiveItem(PlanarScrapDBR, BasicItems, true)
            end
        end
    end;
}

table.insert(wanez.MP,addToClientQuestTable)

