--[[
Created by IntelliJ IDEA.
User: Ware
Date: 11/7/2017
Time: 12:16 PM

Package: 
]]--

wanez.Campaign = {}

--- SHRINES & PYLONS
local PylonSpawnChance = 2
local PylonSpawnChanceMax = 100
local aPylonsData = {
    "mod_wanez/_dga/pylons/pylon_a001.dbr",
    "mod_wanez/_dga/pylons/pylon_a002.dbr",
    "mod_wanez/_dga/pylons/pylon_a003.dbr",
    "mod_wanez/_dga/pylons/pylon_a004.dbr",
    "mod_wanez/_dga/pylons/pylon_a005.dbr",
    "mod_wanez/_dga/pylons/pylon_a006.dbr",
    "mod_wanez/_dga/pylons/pylon_a007.dbr",
    "mod_wanez/_dga/pylons/pylon_a008.dbr",
    "mod_wanez/_dga/pylons/pylon_a009.dbr",
    "mod_wanez/_dga/pylons/pylon_a010.dbr",
    "mod_wanez/_dga/pylons/pylon_a011.dbr",
    "mod_wanez/_dga/pylons/pylon_a012.dbr"
};

local mDataWaveEvent = false

local bAllowNewWaveEvent = true
local iLastCreatedProxyId = false

--- SPAWNS
local mSpawnTokenPerId = {
    "WZ_CAMPAIGN_SPAWNS_VANILLA",
    "WZ_CAMPAIGN_SPAWNS_DOUBLE"
}
local mSpawnTokenPowerfuls = {
    "WZ_CAMPAIGN_SPAWNS_POWERFUL_TWINS",
    "WZ_CAMPAIGN_SPAWNS_POWERFUL_TRIPLETS"
}
local tokenSpawnsGlobal = "WZ_CAMPAIGN_SPAWNS_GLOBAL"
local tokenSpawnsBoss = "WZ_CAMPAIGN_SPAWNS_BOSS"
local tokenSpawnsPowerful = "WZ_CAMPAIGN_SPAWNS_POWERFUL"

--- DIFFICULTY
local tokenPerId = {false,false,"WZ_GD_DIF_01","WZ_GD_DIF_02","WZ_GD_DIF_03","WZ_GD_DIF_04","WZ_GD_DIF_05"}
local function getDifficultyId()
    local newId = 1;
    local _player = Game.GetLocalPlayer()
    
    for id,token in pairs(tokenPerId) do
        if(_player:HasToken(token)) then
            newId = id;
        end
    end
    
    return newId;
end
wanez.Campaign.GetDifficultyId = function()
    return getDifficultyId()
end


local function AddToDataWaveEvent(InProxyId)
    local _Proxy = Proxy.Get(InProxyId)
    --mDataWaveEvent[_Proxy:GetName()] = _Proxy:GetCoords()
    local dbr = _Proxy:GetName()
    local newDBR = dbr:gsub(".dbr","_clone.dbr")
    mDataWaveEvent = mDataWaveEvent or {}
    table.insert(mDataWaveEvent, {
        name = newDBR,
        coords = _Proxy:GetCoords()
    })
    
end

local mUsedProxies = {}
wanez.Campaign.Proxy_OnAddToWorld = function(InProxyId)
    if Server then
        if(mUsedProxies[InProxyId]) then
        else
            local _Player = Game.GetLocalPlayer()
    
            if(_Player ~= nil) then
                if(_Player:HasToken("WZ_CAMPAIGN_SPAWNS_BOSS")) then
                    local _Proxy = Proxy.Get(InProxyId)
                    local dbr = _Proxy:GetName()
                    local newDBR = dbr:gsub(".dbr","_clone.dbr")
                    local _NewProxy = Proxy.Create(newDBR, _Proxy:GetCoords().origin)
            
                    if(_NewProxy ~= nil) then
                        _NewProxy:SetCoords( _Proxy:GetCoords() )
                    end
                end
            end
        end
    
        mUsedProxies[InProxyId] = 1
    end
end
wanez.Campaign.Proxy_OnAddToWorld_old = function(InProxyId)
    if(Server) then
        if(mUsedProxies[InProxyId]) then
    
        else
            --UI.Notify("Proxy_OnAddToWorld")
        
            local _Player = Game.GetLocalPlayer()
            local iCounter = 2
            local bHasToken = true
        
            if( _Player:HasToken("WZ_GD_ENEMY_COUNT_02") or _Player:HasToken("WZ_GD_ENEMY_COUNT_03") or _Player:HasToken("WZ_GD_ENEMY_COUNT_04") or _Player:HasToken("WZ_GD_ENEMY_COUNT_05") or _Player:HasToken("WZ_GD_ENEMY_COUNT_06") or _Player:HasToken("WZ_GD_ENEMY_COUNT_07") or _Player:HasToken("WZ_GD_ENEMY_COUNT_08") or _Player:HasToken("WZ_GD_ENEMY_COUNT_09") ) then
                bHasToken = false
            end
        
            while bHasToken == false do
                AddToDataWaveEvent(InProxyId)
            
                bHasToken = _Player:HasToken("WZ_GD_ENEMY_COUNT_0"..iCounter)
                iCounter = iCounter + 1
            end
    
            wanez.GlobalRandomSeed();
            if(random(1, PylonSpawnChanceMax) <= PylonSpawnChance) then
                local RandomPylonId = random(1,table.getn(aPylonsData))
                local newPylon = Entity.Create(aPylonsData[RandomPylonId])
                newPylon:SetCoords(Proxy.Get(InProxyId):GetCoords())
            
                --UI.Notify("tagWzPylon_NewPylon")
            end
            
            local difficultySpawn = wanez.DGA.aData.monsterPower.difficulties[getDifficultyId()].entitySpawn or false
            if(difficultySpawn) then
                local _Proxy = Entity.Get(InProxyId)
                local _DifficultyEntity = Character.Create(difficultySpawn, Game.GetAveragePlayerLevel(), nil)
                _DifficultyEntity:SetCoords( _Proxy:GetCoords() )
            end
        
            mUsedProxies[InProxyId] = 1
        end
    end
end

local iScriptEntityId = false
local function StartWaveEvent()
    if(mDataWaveEvent ~= false and bAllowNewWaveEvent == true) then
        --local startTime = Time.Now()
        local mTempDataWaveEvent = {}
        for index, value in pairs(mDataWaveEvent) do
            table.insert(mTempDataWaveEvent, {
                name = value.name,
                coords = value.coords
            })
        end
        -- iScriptEntityId =
        wanez.WaveEvent.Start({
            --key = "Proxy_OnRemoveFromWorld_"..InObjectId,
            newUpdater = wanez.Campaign.WaveEvent.newUpdater,
            waves = mTempDataWaveEvent,
            updatePeriod = 10,
            endCallback = wanez.Campaign.WaveEvent.endCallback
        })
        mDataWaveEvent = false
        bAllowNewWaveEvent = false
    
        --UI.Notify("Time: "..(Time.Now() - startTime))
    else
        --UI.Notify("not enough entries for a new WaveEvent")
    end
    
end

local function SpawnAdditionalEnemy(InEnemyId, bInPowerfulOnly)
    bInPowerfulOnly = bInPowerfulOnly or nil
    
    local _Enemy = Character.Get(InEnemyId)
    local EnemyDBR = _Enemy:GetName()
    
    local _NewEnemy;
    
    if( string.find(EnemyDBR, "/boss&quest/") ) then
        _NewEnemy = Character.Create(EnemyDBR, Game.GetAveragePlayerLevel() + 4, nil)
    elseif( string.find(EnemyDBR, "/hero/") ) then
        _NewEnemy = Character.Create(EnemyDBR, Game.GetAveragePlayerLevel() + 2, nil)
    elseif( bInPowerfulOnly == nil ) then
        _NewEnemy = Character.Create(EnemyDBR, Game.GetAveragePlayerLevel(), nil)
    end
    
    if(_NewEnemy ~= nil) then
        _NewEnemy:SetCoords( _Enemy:GetCoords() )
    end
end
wanez.Campaign.Proxy_OnSpawn = function(InEnemyId)
    if(Server) then
        if(bAllowNewWaveEvent) then
            --StartWaveEvent()
        else
            --local mUserData = Shared.getUserdata(iScriptEntityId)
            --if(mUserData ~= nil) then
                --if(mUserData.waveEvent.running) then
                --else
                    --StartWaveEvent()
                --end
            --else
                --StartWaveEvent()
            --end
        end
        
        local _Player = Game.GetLocalPlayer()
        if(_Player) then -- _Player:HasToken("WZ_GD_ENEMY_COUNT_02")
    
            if(_Player:HasToken("WZ_CAMPAIGN_SPAWNS_GLOBAL")) then
                SpawnAdditionalEnemy(InEnemyId)
            end
            if(_Player:HasToken("WZ_CAMPAIGN_SPAWNS_POWERFUL")) then
                SpawnAdditionalEnemy(InEnemyId, true)
            end
            if(_Player:HasToken("WZ_CAMPAIGN_SPAWNS_POWERFUL_TRIPLE")) then
                SpawnAdditionalEnemy(InEnemyId, true)
                SpawnAdditionalEnemy(InEnemyId, true)
            end
        end
    end
end

wanez.Campaign.Proxy_OnRemoveFromWorld = function(InProxyId)
    --UI.Notify("Proxy_OnSpawn")
    if(mUsedProxies[InProxyId] == 1) then
        mUsedProxies[InProxyId] = Time.Now()
    end
end

wanez.Campaign.Proxy_OnDestroy = function(InObjectId)
    --UI.Notify("Proxy_OnDestroy")
end


--- Enemy
wanez.Campaign.Enemy = {}

--- LUA HOOKS

wanez.Campaign.Enemy.OnDie_Common = function(InEnemyId)
    wanez.PhasingEvents.onDieEntity(InEnemyId, 1, getDifficultyId());
end
wanez.Campaign.Enemy.OnDie_Champion = function(InEnemyId)
    wanez.PhasingEvents.onDieEntity(InEnemyId, 2, getDifficultyId());
end
wanez.Campaign.Enemy.OnDie_Hero = function(InEnemyId)
    wanez.PhasingEvents.onDieEntity(InEnemyId, 3, getDifficultyId());
end
wanez.Campaign.Enemy.OnDie_Quest = function(InEnemyId)
    wanez.PhasingEvents.onDieEntity(InEnemyId, 4, getDifficultyId());
end
wanez.Campaign.Enemy.OnDie_Boss = function(InEnemyId)
    wanez.PhasingEvents.onDieEntity(InEnemyId, 5, getDifficultyId());
end

--- WAVE EVENT
wanez.Campaign.WaveEvent = {}

wanez.Campaign.WaveEvent.newUpdater = function(InObjectId)
    iScriptEntityId = InObjectId
    
    local waveEvent = Shared.getUserdata(InObjectId).waveEvent
    
    waveEvent.waveIndex = waveEvent.waveIndex + 1
    local _Proxy = Proxy.Create(waveEvent.waves[waveEvent.waveIndex].name, waveEvent.waves[waveEvent.waveIndex].coords.origin)
    _Proxy:SetCoords(waveEvent.waves[waveEvent.waveIndex].coords)
end

wanez.Campaign.WaveEvent.endCallback = function(InObjectId)
    bAllowNewWaveEvent = true
    StartWaveEvent()
end
