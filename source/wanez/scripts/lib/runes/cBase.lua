--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/18/2017
Time: 6:20 AM

Package: 
]]--

--UI.Notify("cBase File")
local gInscriptions = wanez.data.gInscriptions
--UI.Notify("cBase File 2")

function wanez.Runes.cBase()
    local _parent = wanez.cBase()

    local runeType = false
    local aInscriptions = false
    
    
    local class = {
        __constructor = function(self)
        end;
        __setInscriptionsData = function(self,argRuneType,argOverride)
            argOverride = argOverride or false
            if(aInscriptions == false or argOverride) then
                aInscriptions = gInscriptions[argRuneType]
            end
        end;
        __getInscriptionsData = function(self)
            return aInscriptions
        end;
        __setRuneType = function(self,argRuneType,argOverride)
            local isSameType = false
            argOverride = argOverride or false
            if(runeType == false or argOverride) then
                runeType = argRuneType
                self:__setInscriptionsData(runeType)
            end
            if(runeType == argRuneType) then isSameType = true end
            --UI.Notify(runeType)
            
            return isSameType
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
