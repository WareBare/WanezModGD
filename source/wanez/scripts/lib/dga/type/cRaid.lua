--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/3/2017
Time: 8:31 PM

Package: 
]]--


function wanez.DGA.type.cRaid()
    local aData = wanez.DGA.aData.dgaTypes.raid
    local _parent = wanez.DGA.type.cBase(aData.quests)
    
    local class = {
        questType = 'Raid';
        TypeID = 4;
        __constructor = function(self)
            self:setQuestArea(1)
        end;
        
    }
    
    setmetatable(class,{ __index = _parent})
    class:__constructor()
    return class
end
