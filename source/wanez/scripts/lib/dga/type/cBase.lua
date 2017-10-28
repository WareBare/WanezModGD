--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/26/2017
Time: 9:51 AM

Package: type
]]--

function wanez.DGA.type.cBase(optQuests)
    local _parent = wanez.DGA.cBase()
    local _parent2 = wanez.cQuest(optQuests)
    setmetatable(_parent,{__index=_parent2})
    
    local class = {
        portalType = false;
        __constructor = function(self)
        end;
        setQuestArea = function(self,argTypeId,argOverride)
            argOverride = argOverride or false
        
            local areaId = self:__get('areaId','protected') or 0
        
            if(areaId == 0 or argOverride) then
                areaId = self:__genRandomAreaID(argTypeId) -- argTypeId
            end
        
            self:__set('areaId',areaId,'protected')
            self:__set('variationId',self:__genRandomVariationID(areaId),'protected')
        end;
        
        spawnBoss = function(self)
            local isFinalStep = true
            if(self.TypeID == 3) then
                isFinalStep = self:isFinalStep()
            end
            return isFinalStep
        end;
    }
    
    setmetatable(class,{ __index = _parent})
    class:__constructor()
    return class
end
