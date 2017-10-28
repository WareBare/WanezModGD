--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/28/2017
Time: 1:07 AM

Package: 
]]--

function wanez.DGA.entity.cPylon()
    local _parent = wanez.DGA.entity.cBase()
    local class = {
        __constructor = function(self)
        end;
        createEntities = function(self,argCoords,optEntities,argClass)
            self:createPylon(argCoords,optEntities)
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
