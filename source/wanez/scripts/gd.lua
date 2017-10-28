--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 4/25/2017
Time: 2:32 PM

Package: 
]]--

wanez.gd = {};
local _cBase = wanez.cBase()

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
-- random(min,max)
local PylonSpawnChance = 3
local PylonSpawnChanceMax = 100

local entityNames = {
    'manticore',
    'slith',
    'spidergiant',
    'waspgiant',
    'vulture'
}
local aLetterEquiv = {'a','b','c','d','e','e','e','e','e','e','e','e','e','e','e','e'}
local timeSinceLastKill = Time.Now()
local killRating = 0
local aRewards = {1,2,5,10,25,25,25,25,25,25,25,25,25,25}
local aRewardsDifficultyMul = {1,1,1,2,2,3,3}
local usedProxy = {}
local createProxy = false
local _trigger = false
local aProxyToken = {
    [1] = "WZ_GD_ENEMY_COUNT_01",
    [2] = "WZ_GD_ENEMY_COUNT_02",
    [3] = "WZ_GD_ENEMY_COUNT_03"
}

local entityToDestroy = false
local coordsChester = false
function wanez.gd.setChesterCoords(argObjectId)
    local entity_ = Entity.Get(argObjectId)
    coordsChester = entity_:GetCoords()
    
    entityToDestroy = entity_;
end
local canCraftRunes = true
function wanez.gd.onAddToWorldCrafterGear(argObjectId)
    local dbr;
    if(canCraftRunes) then
        dbr = "mod_wanez/_gear/creatures/npcs/blacksmith_leveling0".._cBase:getFactionRank("USER14")..".dbr"
        canCraftRunes = false
    else
        dbr = "mod_wanez/_runes/creatures/npcs/blacksmith_runes001a.dbr"
        canCraftRunes = true
    end
    
    local crafter_ = Entity.Create( dbr )
    crafter_:SetCoords(coordsChester)
    
    entityToDestroy:Destroy()
    entityToDestroy = crafter_;
end

local function spawnPlanarInvader(argObjectId,argClassId,argDifficultyId)
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        
        local difficultySpawn = wanez.DGA.aData.monsterPower.difficulties[argDifficultyId].entitySpawn or false
        
        local randomSpawnClass = aLetterEquiv[random(1,argClassId)]
        local randomEntityType = random(1,2)
        local enemyCoords = Entity.Get(argObjectId):GetCoords()
        if(random(1,100) <= 10 * argDifficultyId) then
            --UI.Notify('should spawn')
            local newEnemy = Character.Create('mod_wanez/_campaign/creatures/enemies/phasing_'..entityNames[randomEntityType]..'_'..randomSpawnClass..'01.dbr',Game.GetAveragePlayerLevel() + argClassId,nil)
            newEnemy:SetCoords(enemyCoords)
        
            if(difficultySpawn) then
                local newEnemy = Character.Create(difficultySpawn,Game.GetAveragePlayerLevel() + argClassId,nil)
                newEnemy:SetCoords(enemyCoords)
            end
            --UI.Notify("spawned Planar Invader: "..randomSpawnClass.." | ID: "..argClassId.." | KillRating: "..killRating)
        end
    end
end
function wanez.gd.spawnPlanarInvader(argObjectId,argClassId,argDifficultyId)
    --UI.Notify("working spawn global")
    --spawnPlanarInvader(argObjectId,argClassId,argDifficultyId)
end

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
--- onDie events
local function onDieEntity(argObjectId,argClassId,argDifficultyId)
    
    --local difficultyId = 1
    argDifficultyId = argDifficultyId or getDifficultyId()
    
    --UI.Notify("working onDie")
    
    if(Game.GetLocalPlayer():HasToken("WZ_DGA_NO_PHASING") == false)then
        if(killRating == 0) then
            --math.randomseed(Time.Now());
        end
        if( (Time.Now() - timeSinceLastKill) <= 10000 ) then -- 10 seconds between kills or reset killRating
            killRating = killRating + (aRewards[argClassId] * aRewardsDifficultyMul[argDifficultyId]);
            --UI.Notify('add to Rating')
            if(killRating <= 25) then
                -- spawn common
                spawnPlanarInvader(argObjectId,1,argDifficultyId)
            elseif(killRating <= 250) then
                -- spawn champion
                spawnPlanarInvader(argObjectId,2,argDifficultyId)
            elseif(killRating <= 1000) then
                -- spawn hero
                spawnPlanarInvader(argObjectId,3,argDifficultyId)
            elseif(killRating <= 2500) then
                -- spawn nemesis
                spawnPlanarInvader(argObjectId,4,argDifficultyId)
            else
                -- spawn boss
                spawnPlanarInvader(argObjectId,5,argDifficultyId)
                --UI.Notify("tagWzCampaingLua_SpawnBoss")
            end
        else
            --UI.Notify('reset Rating')
            if(killRating >= 250) then UI.Notify("tagWzCampaingLua_TimeHasRunOut") end;
            killRating = aRewards[argClassId] * aRewardsDifficultyMul[argDifficultyId];
            math.randomseed(Time.Now());
            
        end
        
        timeSinceLastKill = Time.Now()
    end
    --UI.Notify("working onDie")
end
function wanez.gd.onDieEntity(argObjectId,argClassId,argDifficultyId)
    --UI.Notify("working global")
    --UI.Notify(argDifficultyId)
    onDieEntity(argObjectId,argClassId,argDifficultyId)
end

--- move trigger to new location
function wanez.gd.proxyTriggerOnLeave()
    --UI.Notify('onLeave')
    _trigger:SetCoords(Game.GetLocalPlayer():GetCoords())
    --UI.Notify('move trigger')
end
--- create new proxies
function wanez.gd.proxyTriggerOnInside()
    --UI.Notify()
    local noProxyCreated = true
    --UI.Notify('onInside')
    
    if(createProxy) then
        for key,value in pairs(createProxy) do
            --UI.Notify('onInside - create')
            if(value and noProxyCreated) then
                local _proxy = Proxy.Get(key)
                local dbr = _proxy:GetName()
                local newDBR = dbr:gsub(".dbr","_clone.dbr")
                local _newProxy = false;
                
                for number,token in pairs(aProxyToken) do
                    if(Game.GetLocalPlayer():HasToken(token)) then
                        for i=1,number do
                            _newProxy = Proxy.Create(newDBR)
                            _newProxy:SetCoords(_proxy:GetCoords())
                            --createProxy[key] = value + 1
                        end;
                        
                    end
                end;
            
                if(_newProxy == false) then
                    _proxy:Run()
                    --createProxy[key] = false
                else
                    if(Game.GetLocalPlayer():HasToken("WZ_GD_ENEMY_COUNT_0"..value)) then createProxy[key] = false;end;
                end
                createProxy[key] = false
                noProxyCreated = false
                usedProxy[key] = true
            end
        end;
    
        if(noProxyCreated)then
            createProxy = false
            --UI.Notify('reset trigger')
            --if(_trigger) then _trigger:Destroy() end
            --_trigger = false;
            --wanez.gd.proxyTriggerOnLeave()
        end
    end
    
    if(noProxyCreated) then
        --if(_trigger) then _trigger:Destroy() end
        --_trigger = false;
        wanez.gd.proxyTriggerOnLeave()
        --UI.Notify('reset trigger')
    end
    
end
local RandomSeedTime = Time.Now()
function wanez.gd.cloneProxy(argObjectId)
    
    local difficultyId = getDifficultyId()
    local _proxy = Entity.Get(argObjectId)
    local difficultySpawn = wanez.DGA.aData.monsterPower.difficulties[difficultyId].entitySpawn or false
    
    if usedProxy[argObjectId] ~= true then
        local dbr = _proxy:GetName()
        local newDBR = dbr:gsub(".dbr","_clone.dbr")
    
        if(Game.GetLocalPlayer():HasToken("WZ_GD_ENEMY_COUNT_02")) then
            local newProxy = Entity.Create(newDBR)
            newProxy:SetCoords(_proxy:GetCoords())
        end
        if(Game.GetLocalPlayer():HasToken("WZ_GD_ENEMY_COUNT_03")) then
            local newProxy = Entity.Create(newDBR)
            newProxy:SetCoords(_proxy:GetCoords())
        end
        if(difficultySpawn) then
            local newEnemy = Entity.Create(difficultySpawn)
            newEnemy:SetCoords(_proxy:GetCoords())
        end
        
        if( (Time.Now() - RandomSeedTime) <= (60000 * 10) ) then
            RandomSeedTime = Time.Now()
            math.randomseed(RandomSeedTime);
            --UI.Notify("Reset Random Seed")
        end
        if(random(1, PylonSpawnChanceMax) <= PylonSpawnChance) then
            local RandomPylonId = random(1,table.getn(aPylonsData))
            local newPylon = Entity.Create(aPylonsData[RandomPylonId])
            newPylon:SetCoords(_proxy:GetCoords())
        
            --UI.Notify("tagWzPylon_NewPylon")
        end
    
        usedProxy[argObjectId] = true
    end
    
    --if(_trigger == false)then
        --_trigger = Entity.Create("records/proxies/trigger_proxy.dbr")
        --_trigger:SetCoords(Game.GetLocalPlayer():GetCoords())
        --UI.Notify('createTrigger')
    --end
    
    --if usedProxy[argObjectId] ~= true then
        --createProxy = createProxy or {}
        --createProxy[argObjectId] = 0
        --UI.Notify('cloneProxy')
        
        --UI.Notify('Proxy trigger is working');
        --UI.Notify(dbr); -- :gsub('.dbr','_clone.dbr')
        --UI.Notify(newDBR);
        --_proxy:Run();
    
        
        --_proxy:Destroy()
        --UI.Notify('Proxy trigger is working');
    
        --usedProxy[argObjectId] = true
    --end
end

function wanez.gd.clonedProxy(argObjectId)
    --local _proxy = Proxy.Get(argObjectId)
    
    --_proxy:Destroy();
    --UI.Notify('Cloned Proxy trigger is working')
end


--- DBR Hooks
function wanez.gd.onDieCommon(argObjectId)
    onDieEntity(argObjectId,1);
end
function wanez.gd.onDieChampion(argObjectId)
    onDieEntity(argObjectId,2);
end
function wanez.gd.onDieHero(argObjectId)
    onDieEntity(argObjectId,3);
end
function wanez.gd.onDieQuest(argObjectId)
    onDieEntity(argObjectId,4);
end
function wanez.gd.onDieBoss(argObjectId)
    onDieEntity(argObjectId,5);
end

local function onDieBeast(argObjectId,argClassId)
    -- todo
    -- rune drops
    -- artifact scroll drops
    -- artifact base item drops
    
    local _player = Game.GetLocalPlayer()
    local aRep = {0,0,1,3,5}
    local iRep = aRep[argClassId]
    
    _player:GiveFaction("USER14",iRep)
    _player:GiveFaction("USER15",iRep * -1)
end

function wanez.gd.onDieCommonBeast(argObjectId)
    onDieBeast(argObjectId,1)
end
function wanez.gd.onDieChampionBeast(argObjectId)
    onDieBeast(argObjectId,2)
end
function wanez.gd.onDieHeroBeast(argObjectId)
    onDieBeast(argObjectId,3)
end
function wanez.gd.onDieNemesisBeast(argObjectId)
    onDieBeast(argObjectId,4)
end
function wanez.gd.onDieBossBeast(argObjectId)
    onDieBeast(argObjectId,5)
end




