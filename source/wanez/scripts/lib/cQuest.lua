--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/8/2017
Time: 4:30 AM

Package: 
]]--

function wanez.cQuest(optQuests)
    local _parent = wanez.cBase()
    
    local aQuests = optQuests or {}
    
    local questInfo = {0,0}
    
    local class = {
        __constructor = function(self)
            self:__set('questId',0,'protected')
            self:__set('taskId',0,'protected')
        
            self:setQuestInfo()
        end;
        setQuestInfo = function(self)
            questInfo = self:getQuestInfo() or questInfo
    
            self:__set('questId',questInfo[1],'protected')
            self:__set('taskId',questInfo[2],'protected')
        end;
        
        --- @return {array|boolean} { questId, taskId } false if no quest is set
        getQuestInfo = function(self)
            local retData = false
            local _player = Game.GetLocalPlayer()
            for questId,quest in pairs(aQuests) do
                
                if(_player:GetQuestState(quest[1]) == QuestState.InProgress) then
                    for taskId,task in pairs(quest[2]) do
                        
                        if(_player:GetQuestTaskState(quest[1],task) == QuestState.InProgress) then
                            retData = {questId,taskId}
                        end
                    
                    end;
                end
            
            end;
            return retData
        end;
        newQuest = function(self)
            QuestGlobalEvent("wzDGA_grantQuestType"..self:parseIntToString(self.TypeID,2))
        end;
        startQuest = function(self,argQuestId)
            argQuestId = argQuestId or false
            -- check if player has any mission, only grant mission if false
            if(self:getQuestInfo() == false) then
                local newQuestData = false
                -- get new quest data (random) with inherited RNG method
                if(argQuestId) then
                    newQuestData = aQuests[argQuestId]
                else
                    newQuestData = self:RNG({
                        aData = aQuests
                    })
                end
                
                local _player = Game.GetLocalPlayer()
                -- make sure the player doesnt have the quest
                if(_player:GetQuestState(newQuestData[1]) ~= QuestState.InProgress) then
                    _player:GrantQuest(newQuestData[1],newQuestData[2][1])
                end
            end
        end;
        --- @return {Array} { uint32 QuestUID, uint32 TaskUID, int|false AreaID } if no AreaID is set, generate a random AreaID
        __getQuest = function(self,argQuest,argTask)
            return {aQuests[argQuest][1],aQuests[argQuest][2][argTask],aQuests[argQuest][3] or false}
        end;
        
        hasQuest = function(self)
            local hasQuest = true
            
            if(questInfo[1] == 0) then hasQuest = false end
            
            return hasQuest
        end;
        
        isFinalStep = function(self)
            self:setQuestInfo() -- needs to set data each time to check which step the user is on
            local isFinal = false
            local questId = self:__get('questId','protected')
            local taskId = self:__get('taskId','protected')
    
            if( table.getn(aQuests[questId][2]) == taskId ) then
                isFinal = true
            end
            return isFinal
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
