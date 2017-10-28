--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/29/2017
Time: 10:39 PM

Package: 
]]--

function wanez.DGA.area.cBossRoom()
    local _parent = wanez.DGA.area.cBase(1,0)
    local class = {
        areaType = "BossRoom";
        __constructor = function(self)
        end;
        
        prepBossRoom = function(self,argProperties)
            --local _cArea = self:getArea()
        
            --local prop = _cArea:getAreaProperties()
            local prop = argProperties
        
            --if(prop.allowSpawn == false)then
                self:setAreaId(prop.areaId)
                self:isNewArea(prop._cType.TypeID,prop.areaTier,prop.areaLvL)
                self:__setAreaOwnwer(prop._areaOwner,prop._cType,prop.areaTier)
            --end
            
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
