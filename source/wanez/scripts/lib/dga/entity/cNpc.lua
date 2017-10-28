--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/30/2017
Time: 11:45 PM

Package: entity
]]--

function wanez.DGA.entity.cNpc()
    local _parent = wanez.DGA.entity.cBase()
    local class = {
        __constructor = function(self)
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
