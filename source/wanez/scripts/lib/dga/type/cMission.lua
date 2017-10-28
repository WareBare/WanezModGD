--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/7/2017
Time: 11:05 PM

Package: 
]]--

function wanez.DGA.type.cMission()
    local aData = wanez.DGA.aData.dgaTypes.mission
    local _parent = wanez.DGA.type.cBase(aData.quests)

    local class = {
        questType = 'Mission';
        TypeID = 1;
        __constructor = function(self)
            self:setQuestArea(1)
        end;
    }
    
    setmetatable(class,{ __index = _parent})
    class:__constructor()
    return class
end
