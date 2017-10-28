--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/25/2017
Time: 5:15 PM



Package: 
]]--


function wanez.DGA.cSettings()
    local _parent = wanez.DGA.cBase()
    

    local class = {
        __constructor = function(self)
            self:resetArea()
            self:__setDifficultyID()
        end;
    
        openArea = function(self,argCoordsPortal,argPlayer,_argType,argTier)
            local _cArea = self:getArea()
            _cArea.cPortal:showPortal(self:__getCoords(argCoordsPortal))
            _cArea:__setAreaOwnwer(argPlayer,_argType) -- ,argTier
        end;
        spawnEntities = function(self,argObjectIdPlayer,iBossRoom,argRegionId)
            argRegionId = argRegionId or 1
            local _cArea = self:getArea()
            _cArea:spawnEntities(argObjectIdPlayer,iBossRoom,argRegionId)
        end;
    }
    
    setmetatable(class,{ __index = _parent })
    class:__constructor()
    return class
end
