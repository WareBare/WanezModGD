--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/30/2017
Time: 11:45 PM

Package: entity
]]--

function wanez.DGA.entity.cContainer()
    local _parent = wanez.DGA.entity.cBase()
    local class = {
        __constructor = function(self)
        end;
        createEntities = function(self,argCoords,optEntities,argClass)
            self:createContainer(argCoords,optEntities,argClass)
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
