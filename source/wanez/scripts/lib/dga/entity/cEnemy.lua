--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/30/2017
Time: 11:45 PM

Package: entity
]]--

function wanez.DGA.entity.cEnemy()
    local _parent = wanez.DGA.entity.cBase()
    local class = {
        aClassLvlInc = {
            -1,0,1,2,2,3,3,5,2
        };
        __constructor = function(self)
        end;
        
        createEntities = function(self,argCoords,optEntities,argClass,argLevel)
            self:createEnemies(argCoords,optEntities,argClass,argLevel)
        end;
        
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
