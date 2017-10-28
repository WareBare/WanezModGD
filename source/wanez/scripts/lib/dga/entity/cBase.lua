--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/30/2017
Time: 11:46 PM

Package: entity
]]--

local function packCounter(argClass)
    argClass = argClass or 1
    local counter = 0
    local objectId = false
    
    local class = {
        __constructor = function(self)
            
        end;
        setId = function(self,argObjectId)
            if(objectId == false)then
                objectId = argObjectId
            end
        end;
        getId = function(self)
            return objectId
        end;
        incCounter = function(self)
            counter = counter + 1
        end;
        redCounter = function(self)
            counter = counter - 1
        end;
        giveReward = function(self)
            local isDead = false
            if(counter == 0) then
                isDead = argClass
            end
            
            return isDead
        end;
    }
    class:__constructor()
    return class
end

function wanez.DGA.entity.cBase()
    local _parent = wanez.DGA.cBase()

    --local spawnCoords = argCoordsProxy
    --local entityCoords = argCoordsProxy
    --local entityData = (type(optDataEntity) == 'string') and {optDataEntity} or optDataEntity
    --local entityLevel = argConstructorLevel
    local aEntities = {}
    
    local aDataMP = false
    local monsterLevel = Game.GetAveragePlayerLevel()

    local _packCounter = false

    local class = {
        __constructor = function(self)
            --self:createEntities()
        end;
        
        setDataEntity = function(self,optDataMP,argMonsterLevel)
            aDataMP = optDataMP
            monsterLevel = argMonsterLevel
        end;
        
        createEnemies = function(self,argCoords,optEntities,argClass,argLevel)
            --UI.Notify("Spawn: ini spawn")
            argCoords = argCoords or Game.GetLocalPlayer()
            optEntities = (type(optEntities) == 'string') and {optEntities} or optEntities
            argLevel = argLevel or monsterLevel
            
            argLevel = argLevel + self.aClassLvlInc[argClass]
            --local tplPath = "mod_wanez/_dga/difficulties/{TYPE}_{MODE}_{DIFFICULTY}/enemies/{CLASS}"
            local tplPath = "mod_wanez/_dga/difficulties/{TYPE}_{MODE}_{DIFFICULTY}/enemies/{CLASS}"
            --UI.Notify("Spawn: gen path")
            --UI.Notify(aDataMP.mode.Value)
            -- todo dynamic path
            local path = self:str_replace(tplPath,{
                TYPE = aDataMP.type.Value,
                MODE = aDataMP.mode.Value,
                DIFFICULTY = aDataMP.difficulty.Value,
                CLASS = wanez.DGA.aData.monsterClassifications[argClass]:lower()
            })
            _packCounter = _packCounter or packCounter(argClass)
            --UI.Notify("Spawn: create enemies | "..path)
            for key,dbr in pairs(optEntities) do
                --UI.Notify("Spawn: start spawn - "..dbr)
                local newEntity;
                if string.find(dbr, "mod_wanez") then
                    newEntity = Character.Create(dbr,argLevel,nil)
                else
                    newEntity = Character.Create(path.."/"..dbr,argLevel,nil)
                end
                
                --UI.Notify("Spawn: entity created")
                newEntity:SetCoords(argCoords)
                self:__addPack(newEntity:GetId(),_packCounter)
                _packCounter:incCounter()
                --UI.Notify("Spawn: setCoords")
                table.insert(aEntities,newEntity)
            end;
        
            if(aDataMP.entitySpawn.Value) then
                local newEntity;
                newEntity = Character.Create(aDataMP.entitySpawn.Value,argLevel,nil)
                
                newEntity:SetCoords(argCoords)
            end;
            --UI.Notify("Spawn: finished spawn")
            
        end;
        
        createContainer = function(self,argCoords,optEntities)
            argCoords = argCoords or Game.GetLocalPlayer()
            optEntities = (type(optEntities) == 'string') and {optEntities} or optEntities
        
            local tplPath = "mod_wanez/_dga/difficulties/{TYPE}_{MODE}_{DIFFICULTY}/lootchests"
            -- todo dynamic path
            local path = self:str_replace(tplPath,{
                TYPE = aDataMP.type.Value,
                MODE = aDataMP.mode.Value,
                DIFFICULTY = aDataMP.difficulty.Value
            })
    
            for key,dbr in pairs(optEntities) do
                local newEntity = Entity.Create(path.."/"..dbr)
                --UI.Notify("Spawn: entity created")
                newEntity:SetCoords(argCoords)
                --UI.Notify("Spawn: setCoords")
                table.insert(aEntities,newEntity)
            end;
            
        end;
        
        createPylon = function(self,argCoords,optEntities)
            argCoords = argCoords or Game.GetLocalPlayer()
        
            local newEntity = Entity.Create(optEntities)
            newEntity:SetCoords(argCoords)
            table.insert(aEntities,newEntity)
        end;
        
        destoryEntities = function(self)
            for key,_entity in pairs(aEntities) do
                _entity:Destroy()
                --_entity:wzUnsetPack()
            end
            aEntities = {}
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
