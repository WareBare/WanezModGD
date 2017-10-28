--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/1/2017
Time: 8:42 PM

Package: 
]]--

local rewardPoints = {
    {1,2,5,0,0,20,0,0,50}
}
local rewardThresholds = {
    {1000,{0.1,0.33,0.5,0.75,0.95,1.0}}
}
local questReward = false

function wanez.DGA.type.cChallenge()
    local aData = wanez.DGA.aData.dgaTypes.challenge
    local _parent = wanez.DGA.type.cBase(aData.quests)
    
    local class = {
        questType = 'Challenge';
        TypeID = 3;
        __constructor = function(self)
            self:setQuestArea(1)
        end;
        resetReward = function(self)
            questReward = 0
        end;
        reward001 = function(self,argClassId)
            local rewardId = 0
            if(self:__get('questId','protected') == 1 and self:isFinalStep() == false) then -- if it is the final step dont continue
                questReward = questReward + rewardPoints[1][argClassId]
                --UI.Notify("reward")
    
                --- maxPoints to divide from
                local maxPoints = rewardThresholds[1][1]
                --- loop through every entry
                for index,value in pairs(rewardThresholds[1][2]) do
                    --- and check if user has the required points for that threshold
                    if(questReward >= (maxPoints * value) ) then
                        rewardId = self:parseIntToString(index,1)
                    end
                end;
            end
            
            return rewardId
        end;
    }
    
    setmetatable(class,{ __index = _parent})
    class:__constructor()
    return class
end
