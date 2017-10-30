--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/23/2017
Time: 7:27 PM

Package: area
Requires: wanez.DGA.area.cPortal()
]]--

local _areaOwner = false
--- spawnBossRaid => true
---
local specialSpawn = {}

local aTypeIdToBossType = {5,7,7,8}
local aEnemies = wanez.data.gEnemies
local aNameToId = wanez.data.gNameToId
--local aDataBase = wanez.DGA.aData
local regionCount = {
    [101]=3,
    [201]=5,
    [501]=5,
    [502]=5,
    [503]=5,
    [504]=8
}

function wanez.DGA.area.cBase(argRegionId,argAreaId,optData)
    local _parent = wanez.DGA.cBase()
    --local cVariation = wanez.DGA.cVariation()
    --setmetatable(cBase,{ __index = cVariation })
    optData = optData or wanez.DGA.aData

    --- :addPortal(argObjectId,argType), :getPortal()
    local aPortals = {}
    local aEntityCoords = {}
    local aEntities = {}
    local timeEntityIni = {}
    local allowNewEntityCoords = true
    local allowSpawn = true
    local baseRegion = argRegionId
    local curRegion = 1
    local areaId = argAreaId
    local aDataArea = {}
    local mpTypeId = 1
    local aDataMP = {} --- { Difficulty; Type; isUber }
    local areaTier = 0
    local monsterLevel = 1
    local areaLvL = false
    local tryCount = 0
    local aUseCoords = false;
    local coordCount = 1;

    local regionalSpawns;

    local _cType = false

    local class = {
        cPortal = false;
        aMods = {};
        __constructor = function(self)
            --UI.Notify("AreaID: "..self.areaId.." | Variation: ")
            self:isNewArea()
            --self:setDataArea()
            --- Inhabitants
            aDataArea.Inhabitants = aEnemies.aPacks[aNameToId.Enemies[optData.Inhabitants[areaId]]]
        end;
        setDataArea = function(self,argMpTypeId)
            aDataArea.bossSpawn = (argMpTypeId == 1 and wanez.DGA.aData.bossSpawn[areaId]) and wanez.DGA.aData.bossSpawn[areaId]..".dbr" or self:RNG({
                --aData = (specialSpawn.spawnBossRaid) and aEnemies.aBossRaid or aEnemies['a'..wanez.DGA.aData.monsterClassifications[aTypeIdToBossType[argMpTypeId]]]
                aData = aEnemies.aBossChallenge
            })
        
            aDataArea.entityTypes = wanez.DGA.aData.entityTypes[argMpTypeId]
            aDataArea.containers = wanez.DGA.aData.containers[argMpTypeId]
    
            local enemyTypes = wanez.DGA.aData.enemyTypes[argMpTypeId]
            aDataArea.areaSettings = enemyTypes
            local enemyData = enemyTypes
            enemyData.aClassChance = {
                100 - enemyTypes.championChance[self:__getDifficultyID()] - enemyTypes.heroChance[self:__getDifficultyID()],
                enemyTypes.championChance[self:__getDifficultyID()],
                enemyTypes.heroChance[self:__getDifficultyID()]
            }
            enemyData.aClassCount = {
                enemyTypes.commonCount[self:__getDifficultyID()],
                enemyTypes.championCount[self:__getDifficultyID()],
                enemyTypes.heroCount[self:__getDifficultyID()]
            }
            
            aDataArea.spawnData = {
                Enemy = enemyData
            }
            
            --aDataArea
        end;
        
        addSpecialSpawn = function(self,optData)
            optData = optData or {}
            
            for key,value in pairs(optData) do
                specialSpawn[key] = value
            end;
        end;
        
        -- used on boxTrigger (spawn)
        isNewArea = function(self,argMpTypeId,argTier,argAreaLvL)
            curRegion = curRegion or baseRegion
            allowSpawn = {}
            mpTypeId = argMpTypeId or mpTypeId
            areaLvL = argAreaLvL or self:convertTier(argTier)
            areaTier = self:convertLvL(argTier)
            tryCount = 0
    
            self:setMonsterLevel()
        end;
        
        setRegionalEntities = function(self)
            --UI.Notify("setRegionalEntities: Start")
            regionalSpawns = {}
            local curRegionCount = regionCount[areaId] or 1
            for i=1,curRegionCount do
                regionalSpawns[i] = {}
            end;
            --UI.Notify("setRegionalEntities: Regions set")
            --- NEMESIS
            local spawnNemesis = 0
            if(_areaOwner:HasToken("WZ_DGA_NO_NEMESIS_SPAWN") == false) then
                local factionRank = self:getFactionRank('USER15')
                --UI.Notify("setRegionalEntities: got faction rank")
                --if(factionRank > 0) then
                spawnNemesis = self:RNG({
                    aChances = aDataArea.areaSettings.nemesisChance[factionRank];
                    returnNumber = true;
                }) or 0
                --end
                --UI.Notify(spawnNemesis)
            end
            
            --UI.Notify("setRegionalEntities: RNG set | "..spawnNemesis)
            local incCount = self.aMods.enemyCount[6] or 0
            --local incCount = 0
            local nemesisCount = spawnNemesis + incCount
            --UI.Notify("setRegionalEntities: count increased")
            if(nemesisCount > 0) then
                --UI.Notify("setRegionalEntities: start loop")
                for i=1,nemesisCount do
                    local randRegion = self:RNG({randomMax = curRegionCount})
                    --UI.Notify("setRegionalEntities: loop 001 | "..randRegion)
                    regionalSpawns[randRegion].Nemesis = regionalSpawns[randRegion].Nemesis or 0
                    --UI.Notify("setRegionalEntities: loop 002")
                    regionalSpawns[randRegion].Nemesis = regionalSpawns[randRegion].Nemesis + 1
                end;
                --UI.Notify("setRegionalEntities: finish loop")
            end
    
            --UI.Notify("setRegionalEntities: Finish")
        end;
        
        convertTier = function(self,argTier)
            argTier = argTier or areaTier
            --- calculate new monster level
            local mul = argTier / 5
            local mulFloor = math.floor(mul)
            local mulRemain = (mul - mulFloor) / 0.2
            local lvlInc = 0
    
            for i=0,mulFloor do
                lvlInc = lvlInc + (i * 5)
            end;
            return lvlInc + (mulRemain * (mulFloor + 1))
        end;
        convertLvL = function(self,argTier,argLvL)
            argTier = argTier or areaTier
            argLvL = argLvL or areaLvL
            
            while( self:convertTier(argTier) < argLvL ) do
                argTier = argTier + 1
            end;
            
            return argTier
        end;
        
        setMonsterLevel = function(self,argTier)
            --[[
            argTier = argTier or areaTier
            --- calculate new monster level
            local mul = argTier / 5
            local mulFloor = math.floor(mul)
            local mulRemain = (mul - mulFloor) / 0.2
            local lvlInc = 0
    
            for i=0,mulFloor do
                lvlInc = lvlInc + (i * 5)
            end;
            lvlInc = lvlInc + (mulRemain * (mulFloor + 1))
            ]]
            local baseLevel = Game.GetAveragePlayerLevel()
            if(self:__getDifficultyID() == 1 and baseLevel > 50)then
                baseLevel = 50
            elseif(self:__getDifficultyID() == 2 and baseLevel > 60)then
                baseLevel = 60
            end
            monsterLevel = baseLevel + areaLvL
        end;
        
        setAffixData = function(self)
            local aAffixes = wanez.DGA.aData.affixEvents
            local tempData
            
            for affixType,aData in pairs(aAffixes) do
                self.aMods[affixType] = {}
                for typeId,data in pairs(aData) do
                    for index,values in pairs(data) do
                        if(self:__hasAffix(values[1])) then
                            if(type(values[2]) == "number")then
                                tempData = self.aMods[affixType][typeId] or 0
                                self.aMods[affixType][typeId] = tempData + values[2]
                            else
                                self.aMods[affixType][typeId] = values[2]
                            end
                        end
                    end;
                end;
            end;
            
        end;
        setDropMul = function(self)
            self:__setDropMul(aDataMP)
        end;
        
        -- used on opening portal on useScroll
        __setAreaOwnwer = function(self,argPlayer,_argType,argTier)
            argPlayer = argPlayer or Game.GetLocalPlayer()
    
            mpTypeId = _argType.TypeID
            curRegion = baseRegion
            --areaTier = argTier or 0
            --- Set DGA-Affixes
            self.incCount = {}
            self.incChances = {}
            self.aMods = {}
            self:setAffixData()
            
            --UI.Notify("New MonsterLevel: "..monsterLevel)
            if(curRegion == 1) then
                specialSpawn = {}
            
                _areaOwner = argPlayer
                _cType = _argType
                aDataMP = self:getMonsterPower(argPlayer,mpTypeId)
                for key,value in pairs(aPortals) do
                    value.isCasual = (aDataMP.difficulty.ID == 1 and mpTypeId == 1 and aDataMP.mode.ID == 1) and true or false
                end;
            end
            --- set data dependant on MonsterPower or Tier
            self:setDataArea(mpTypeId)
            self:setDropMul()
            
            if(curRegion == 1) then
                self:setRegionalEntities()
            end
        end;
        __getAreaOwner = function(self)
            return _areaOwner
        end;
        setAreaId = function(self,argAreaId)
            areaId = argAreaId
        end;
        returnMonsterPower = function(self)
            return aDataMP
        end;
        getAreaProperties = function(self)
            return {
                _cType = _cType;
                areaTier = areaTier;
                _areaOwner = _areaOwner;
                areaId = areaId;
                aDataMP = aDataMP;
                --allowSpawn = allowSpawn;
            }
        end;
    
        __getAllowSpawn = function(self)
            local isAllowed = true
            
            if(allowSpawn[curRegion])then
                isAllowed = false
            end
        
            return isAllowed;
        end;
        __setAllowSpawn = function(self)
            allowSpawn[curRegion] = true
        end;
        getTier = function(self)
            return areaTier
        end;
        getAreaLvL = function(self)
            return areaLvL
        end;
        
        setPortal = function(self,argTypePortal)
            self.cPortal = aPortals[argTypePortal]
        end;
        
        --- ini portals (from camp[default] or bossRoom[challenge])
        addPortal = function(self,argObjectId,argType)
            aPortals[argType] = aPortals[argType] or wanez.DGA.area.cPortal(argObjectId)
        end;
        --- ini proxies, to get spawn coords (default, ...)
        addEntityCoords = function(self,argObjectId,argType,argRegionId)
            -- check if region has generated coords yet and set allowNewEntityCoords to true if not
            if(aEntityCoords[argRegionId] == nil) then
                aEntityCoords[argRegionId] = {}
                --allowNewEntityCoords = true
                timeEntityIni[argRegionId] = Time.Now()
            end
            -- if allowed add coords for entities
        -- todo add time to check if allowed to add new proxies
            if( (Time.Now() - timeEntityIni[argRegionId]) <= 5000) then -- allowNewEntityCoords
                aEntityCoords[argRegionId][argType] = aEntityCoords[argRegionId][argType] or {}
                table.insert(aEntityCoords[argRegionId][argType], Entity.Get(argObjectId):GetCoords())
                timeEntityIni[argRegionId] = Time.Now()
            else
                --UI.Notify("Dont Add Entities: "..argType)
            end
        end;
        
        --- trigger inside area
        spawnEntities = function(self,argObjectPlayer,iBossRoom,argRegionId,argType)
            iBossRoom = iBossRoom or false
            argRegionId = argRegionId or 1
            curRegion = argRegionId
            
            if(self:__getAllowSpawn()) then
            
                tryCount = tryCount + 1
            
                if(aUseCoords == false) then
                    --UI.Notify("ProxyCount: "..table.getn(aEntityCoords[curRegion].Default))
					
                    self:removeEntities()
                    local _tempProxy = false
                    local usedCoords = {}
                
                    local incSpawnChance = self.aMods.entityChances.proxies or 0
                    local spawnChance = aDataArea.areaSettings.useProxies + incSpawnChance
        
                    if(self.areaType == "BossRoom") then
                        local bossCoords = self:RNG({
                            aData = aEntityCoords[curRegion].Default
                        })
            
                        _tempProxy = wanez.DGA.entity.cEnemy()
                        _tempProxy:setDataEntity(aDataMP,monsterLevel)
            
                        if(iBossRoom) then
        
                            local incCount = self.aMods.enemyCount[aTypeIdToBossType[mpTypeId]] or 0
                            local totalCount = 1 + incCount
                            for i=1,totalCount do
                                if( iBossRoom:spawnBoss() )then
                                    _tempProxy:createEntities(bossCoords,aDataArea.bossSpawn,aTypeIdToBossType[mpTypeId])
                                else
                                    _tempProxy:createEntities(bossCoords,self:RNG({aData = aEnemies.aBossMini}),4)
                                end
                            end;
                            
                            table.insert(aEntities[curRegion],_tempProxy)
                        end
                        usedCoords[bossCoords] = true
                    else
                        --- set BossRoom Data
                        iBossRoom:prepBossRoom({
                            _cType = _cType;
                            areaTier = areaTier;
                            _areaOwner = _areaOwner;
                            areaId = areaId;
                            areaLvL = areaLvL;
                        })
						
                        --- NEMESIS
                        if(regionalSpawns[curRegion].Nemesis) then
                            --UI.Notify("spawn "..regionalSpawns[curRegion].Nemesis.." Nemesis")
                            for i=1,regionalSpawns[curRegion].Nemesis do
                                
                                local nemesisDbr = self:RNG({
                                    aData = aEnemies.aNemesis
                                })
                                local nemesisCoords = self:RNG({
                                    aData = aEntityCoords[curRegion].Default;
                                    rngData = usedCoords;
                                })
                                _tempProxy = wanez.DGA.entity.cEnemy()
                                _tempProxy:setDataEntity(aDataMP,monsterLevel)
                                _tempProxy:createEntities(nemesisCoords,nemesisDbr,6)
                                table.insert(aEntities[curRegion],_tempProxy)
        
                                usedCoords[nemesisCoords] = true
                            end;
                        end
						
                    end
                    
                    for key,entityCoords in pairs(aEntityCoords[curRegion].Default) do
                        -- add instance to the list
                        if(self:RNG({
                            aChances = spawnChance
                        }) and usedCoords[entityCoords] ~= true) then
                            --table.insert(aEntities[curRegion],self:rollEntities(entityCoords))
                            aUseCoords = aUseCoords or {}
                            table.insert(aUseCoords,entityCoords)
                        end
                        
                    end;
                    
                end
            
                self:newEntities()
                --self:__setAllowSpawn()
                --UI.Notify("Trigger finished on Try: "..tryCount)
                --if(curRegion == 1 and self.areaType ~= "BossRoom") then UI.Notify("tagWzDGA_LuaNotify_SpawnedEntities") end
            end
            
        end;
    
        newEntities = function(self)
            if(aUseCoords[coordCount]) then
                table.insert(aEntities[curRegion],self:rollEntities(aUseCoords[coordCount]))
                coordCount = coordCount + 1
            else
                --- reset
                aUseCoords = false
                coordCount = 1
                --- methods
                self:__setAllowSpawn()
                --- Notify
                --UI.Notify("Trigger finished on Try: "..tryCount)
                if(curRegion == 1 and self.areaType ~= "BossRoom") then UI.Notify("tagWzDGA_LuaNotify_SpawnedEntities") end
            end
        end;
        
        removeEntities = function(self)
            if(aEntities[curRegion])then
                for key,_cProxy in pairs(aEntities[curRegion]) do
        
                    _cProxy:destoryEntities()
    
                end;
            end
            aEntities[curRegion] = {}
        end;
        
        genEntityDbr = function(self,argEntityClassId,optEntityPool)
            local randomMin = {4,3,1}
            local aEnemiesToSpawn = {}
            local incCount = self.aMods.enemyCount[argEntityClassId] or 0
            --local incCount = 0
            
            local entityCount = self:RNG({
                randomMin = randomMin[argEntityClassId] + incCount or 1;
                randomMax = aDataArea.spawnData.Enemy.aClassCount[argEntityClassId] + incCount
            })
            
            for i=1,entityCount do
                table.insert(aEnemiesToSpawn,self:RNG({
                    aData = optEntityPool[wanez.DGA.aData.monsterClassifications[argEntityClassId]]
                }))
            end;
        
            if(self.aMods.buffDbr)then
                for index,value in pairs(self.aMods.buffDbr)do
                    table.insert(aEnemiesToSpawn,value)
                end;
            end
            
            return aEnemiesToSpawn
        end;
        
        rollEntities = function(self,argEntityCoords)
            local _tempProxy = false
            local aEntityPool = false
            local aEntitiesToSpawn = false
            local entityClass = false
            --local isHero = false
            --local entityCount = 0
            --local randomMin = {4,3,1}
            --UI.Notify("rollEntities: start creation")
            -- todo type of entity to spawn (Enemy; Container; NPC)
            local entityType = self:RNG({
                aDataRatio = aDataArea.entityTypes
            })
            --UI.Notify("rollEntities: start creation")
            if(entityType == "Enemy") then
                --UI.Notify("rollEntities: Enemy")
                _tempProxy = wanez.DGA.entity.cEnemy()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
                aEntityPool = self:RNG({
                    aData = aEnemies.aPacks;
                    --returnArrayValue = false
                })
                
                -- inhabitant or random enemies
                if(self.areaType ~= "BossRoom") then
                    if(self:RNG({
                        aChances = aDataArea.spawnData.Enemy.inhabitantChance
                    }))then
                        aEntityPool = aDataArea.Inhabitants
                    end
                end
                
                
                --- enemy Classification
                entityClass = self:RNG({aChances = aDataArea.spawnData.Enemy.aClassChance})
                if(entityClass == 2) then
                    if(aDataArea.areaSettings.championReq >= monsterLevel)then
                        entityClass = 1
                    end
                elseif(entityClass == 3) then -- special case for Heroes
                    if(aDataArea.areaSettings.heroReq <= monsterLevel) then
                        _tempProxy:createEntities(argEntityCoords,self:genEntityDbr(entityClass,aEntityPool),entityClass)
                    end
                    entityClass = 1
                end
    
            elseif(entityType == "Container") then
                --UI.Notify("rollEntities: Container")
                aEntitiesToSpawn = self:RNG({
                    aDataRatio = aDataArea.containers
                })
                --UI.Notify("rollEntities: "..aEntitiesToSpawn)
                _tempProxy = wanez.DGA.entity.cContainer()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
            
                entityClass = 1
            elseif(entityType == "Pylon")then
                -- todo more dynamic
                aEntitiesToSpawn = self:RNG({
                    aData = {
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
                    rngEntries = "Pylons";
                    maxLoops = 8;
                })
            
                _tempProxy = wanez.DGA.entity.cPylon()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
                entityClass = 1
                
                --[[
            elseif(entityType == "Anomaly") then
                _tempProxy = wanez.DGA.entity.cEnemy()
                _tempProxy:setDataEntity(aDataMP,monsterLevel)
    
                aEntityPool
                ]]
            end
    
            
            --_tempProxy:createEntities(argEntityCoords,aEnemiesToSpawn,entityClass)
            _tempProxy:createEntities(argEntityCoords,aEntitiesToSpawn or self:genEntityDbr(entityClass,aEntityPool),entityClass)
            --UI.Notify("rollEntities: finish creation")
            
            return _tempProxy
        end;
        --[[
        openArea = function(self,argCoordsPortal,argPlayer)
            
        end;
        ]]
    }
    
    setmetatable(class,{ __index = _parent })
    class:__constructor()
    return class
end

