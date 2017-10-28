--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/23/2017
Time: 7:27 PM

Package: entity
]]--

function wanez.DGA.entity.cProxy(argCoordsProxy,argTypeProxy)
    local _parent = wanez.DGA.cBase()

    local aEntities = {}

    local class = {
        __constructor = function(self)
        end;
    
        destoryEntities = function(self)
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
