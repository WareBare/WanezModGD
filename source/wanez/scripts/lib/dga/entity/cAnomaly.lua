--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/4/2017
Time: 10:33 PM

Package: 
]]--

function wanez.DGA.entity.cAnomaly()
    local _parent = wanez.DGA.entity.cBase()
    local class = {
        aClassLvlInc = {
            -1,0,1,2,2,3,3,5
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
