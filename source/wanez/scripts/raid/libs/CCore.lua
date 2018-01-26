--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/20/2017
Time: 11:10 PM

Inheritance:
CBase
CPortal
CObjectives
CEvent
CCore

Package: 
]]--

wanez.Raid.libs.CCore = function(InRaidName)
    local _parent = wanez.Raid.libs.CEvent()

    local class = {
        __constructor = function(self)
            self.RaidName = InRaidName
            self.bFoundHiddenTreasure = false
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
