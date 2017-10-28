--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/3/2017
Time: 8:31 PM

Package: 
]]--


function wanez.DGA.type.cEndless()
    local aData = wanez.DGA.aData.dgaTypes.challenge
    local _parent = wanez.DGA.type.cBase(aData.quests)
    
    local class = {
        questType = 'Endless';
        TypeID = 2;
        __constructor = function(self)
            self:setQuestArea(1)
        end;
        
    }
    
    setmetatable(class,{ __index = _parent})
    class:__constructor()
    return class
end
