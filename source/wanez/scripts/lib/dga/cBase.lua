--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/23/2017
Time: 8:22 AM

Package: 
]]--

local aTypes = {
    [1] = {
        1,2,3,4,5,6,7,9,10,12,101,501,502,503,504
    },
    [2] = {
        
    },
    [3] = {
        
    },
    [4] = {
        
    }
}
local aCoords = {}
local aAreas = {}
local aAffixes = {}
local affixMul = 0
local aPacks = {}
local dropMul = {1,1}

function wanez.DGA.cBase()
    local _parent = wanez.cBase()
    
    local class = {
        __constructor = function(self)
            --UI.Notify("cSettings instance")
        end;
        
        --- METHODS: AREA
        resetArea = function(self) -- variationId = 0 results in area is unset, areaId/regionId can be 0 like for BossRoom
            --argHidePortal = argHidePortal or false
            local isSuccess = false
        
            if(self:unsetArea()) then
                self:__set('areaId',0,'protected')
                self:__set('variationId',0,'protected')
                self:__set('regionId',0,'protected')
                -- self:__set('_activeArea',false)
                isSuccess = true
            end
        
            return isSuccess
        end;
        unsetArea = function(self)
            local isSuccess = false
            if(self:__get('_activeArea')) then
                self:__get('_activeArea').cPortal:hidePortal(true) -- todo
                --aData._activeArea = false
                self:__set('_activeArea',false)
            
                isSuccess = true
            end
            return isSuccess
        end;
        nextArea = function(self,argAreaId)
            if(argAreaId) then
                self:__set('areaId',argAreaId,'protected')
                self:__set('variationId',self:__genRandomVariationID(argAreaId),'protected')
            end
        end;
        __setArea = function(self,argTypePortal,argTierDGA,argAreaLvL,optData) -- if variationId > 0 then set new area
            argTypePortal = argTypePortal or 'Default'
            optData = optData or {self:__get('areaId','protected'),self:__get('variationId','protected') }
            argTierDGA = argTierDGA or 0
            argAreaLvL = argAreaLvL or false
            
            local isSuccess = false
            local typeId = self.TypeID or 1
        
            if(optData[2] > 0) then
                self:__set('_activeArea',aAreas[optData[1]][optData[2]])
            
                self:__get('_activeArea'):isNewArea(typeId,argTierDGA,argAreaLvL)
                self:__get('_activeArea'):setPortal(argTypePortal)
                --UI.Notify(self:str_replace('tagWzDGA_Areas_{ID_4}',{ID_4 = self:parseIntToString(self:__get('areaId','protected'),3)}))
                isSuccess = true
            end
    
            return isSuccess
        end;
        getArea = function(self)
            return self:__get('_activeArea')
        end;
        
        --- DGA AFFIX - METHODS
        __setAffixes = function(self,argPlayer)
            local aData = wanez.DGA.aData.affixes
            aAffixes = {}
            affixMul = 0
            for affixType,affixes in pairs(aData) do
                for affixId,quests in pairs(affixes.quests) do
                    if(argPlayer:GetQuestState(quests[1]) == QuestState.InProgress) then
                        aAffixes[self:convertIndex(affixType)..self:parseIntToString(affixId,2)] = true
                        affixMul = affixMul + quests[3]
                    end
                end;
            end;
            QuestGlobalEvent("wzDGA_completeAffixes")
        end;
        __hasAffix = function(self,argSearch)
            local hasAffix = aAffixes[argSearch] or false
            return hasAffix
        end;
        __getAffixes = function(self)
            return aAffixes
        end;
        __getAffixMul = function(self)
            return affixMul
        end;
        
        --- PACK - METHODS
        __addPack = function(self,argObjectId,arg_packCounter)
            aPacks[argObjectId] = arg_packCounter
            --arg_packCounter:setId(argObjectId)
        end;
        __getPack = function(self,argObjectId)
            return aPacks[argObjectId] or false
        end;
        __unsetPack = function(self,argObjectId)
            aPacks[argObjectId] = nil
        end;
        __setDropMul = function(self,optDataMP)
            dropMul = {
                self:mathMul({ optDataMP.type.MulScroll, optDataMP.mode.MulScroll, optDataMP.difficulty.MulScroll, self:__getAffixMul() }),
                self:mathMul({ optDataMP.type.Mul, self:__getAffixMul()}),
                self:mathMul({ optDataMP.type.MulScroll, optDataMP.mode.MulScroll, optDataMP.difficulty.MulScroll }),
            }
        end;
        __getDropMul = function(self)
            return dropMul
        end;
        
        --- `onAddToWorld` on portals/proxies will add the area the portal leads to or the proxy is part of, if it exists it's using the old instance and adds the portal/proxy if it hasnt been added yet
        __addArea = function(self,argObjectId,argType,argAreaId,argVariation,argRegionId)
            local variationId = self:convertIndex(argVariation)
        
            aAreas[argAreaId] = aAreas[argAreaId] or {}
            aAreas[argAreaId][variationId] = aAreas[argAreaId][variationId] or wanez.DGA.area.cArea(argRegionId,argAreaId,argVariation)
        
            if(string.find(Object.Get(argObjectId):GetName(),"/script/portals/")) then
                aAreas[argAreaId][variationId]:addPortal(argObjectId,argType)
                --UI.Notify("Is Portal")
            else
                aAreas[argAreaId][variationId]:addEntityCoords(argObjectId,argType,argRegionId)
                --UI.Notify("Is Entity for: AreaID - "..argAreaId.." | Type - "..argType)
            end
        end;
        __addCoords = function(self,argObjectId,argName)
            -- only set coords if not set
            if(aCoords[argName] == nil) then
                aCoords[argName] = Entity.Get(argObjectId):GetCoords()
                if(argName == "FloorArea0000-00a") then
                    UI.Notify("tagWzDGA_LuaNotify_Welcome")
                    --self:giveItems("mod_wanez/_dga/items/scrolls/dga_scroll03_tier001a.dbr")
                end
            end
            
            --local _player = Game.GetLocalPlayer()
            --_player:GiveItem("mod_wanez/currency/a_001b.dbr",100,true)
            --_player:GiveItem("mod_wanez/currency/b_001b.dbr",100,true)
            --_player:AdjustMoney(1000000)
            --RemoveTokenFromLocalPlayer("WZ_DGA_CHALLENGE_START")
            --RemoveTokenFromLocalPlayer("WZ_DGA_CHALLENGE_COMPLETE")
            --QuestGlobalEvent("wzDGA_completeQuestType003")
            --wanez.DGA.conv.enableModeDefault()
        end;
        __getCoords = function(self,argName)
            return aCoords[argName]
        end;
        
        --- 1: Mission, 2: Endless, 3: Challenge, 4: Raid
        __getTypeData = function(self,argTypeId)
            return aTypes[argTypeId]
        end;
    
        __genRandomAreaID = function(self,argTypeId)
            --UI.Notify(argTypeId)
            --self:__set('areaId',)
            --UI.Notify("__genRandomArea :: finished")
            --return self:RNG(false,'RandomAreaID0'..argTypeId,aTypes[argTypeId])
            return self:RNG({
                rngEntries = 'RandomAreaID'..self:parseIntToString(argTypeId,3);
                aData = aTypes[argTypeId];
                maxLoops = 10;
            })
        end;
        __genRandomVariationID = function(self,argAreaId)
            --return self:RNG({1,table.getn(aAreas[argAreaId])},'RandomVariationID'..self:parseIntToString(argAreaId,2))
            return self:RNG({
                randomMax = table.getn(aAreas[argAreaId]);
                rngEntries = 'RandomVariationID'..self:parseIntToString(argAreaId,2);
            })
        end;
        getModeId = function(self,argPlayer)
            argPlayer = argPlayer or Game.GetLocalPlayer()
        
            local modeId = 1
        
            if(self:hasMode(1,argPlayer)) then
                modeId = 2
            end
        
            return modeId
        end;
        ---
        -- @return Boolean|Array - { questId, taskId }
        hasMode = function(self,argModeId,argPlayer)
            argModeId = argModeId or 1
            argPlayer = argPlayer or Game.GetLocalPlayer()
            local hasMode = false
            local aData = wanez.DGA.aData.mpModes[argModeId]
            local questId = aData.quest[1]
        
            if(argPlayer:GetQuestState(questId) == QuestState.InProgress) then
                hasMode = true
            end
            
            return hasMode
        end;
        setMode = function(self,argModeId)
            argModeId = argModeId or 1
            
            if(self:hasMode(argModeId) == false) then
                local aData = wanez.DGA.aData.mpModes[argModeId]
                local questId = aData.quest[1]
                local taskId = aData.quest[2][1]
                
                local _player = Game.GetLocalPlayer()
                RemoveTokenFromLocalPlayer("WZ_DGA_MODE_"..self:parseIntToString(argModeId,2).."_START")
                RemoveTokenFromLocalPlayer("WZ_DGA_MODE_"..self:parseIntToString(argModeId,2).."_FINISH")
                _player:GrantQuest(questId,taskId)
            end
        end;
        startMode = function(self,argModeId)
            GiveTokenToLocalPlayer("WZ_DGA_MODE_"..self:parseIntToString(argModeId,2).."_START")
        end;
        finishMode = function(self,argModeId)
            GiveTokenToLocalPlayer("WZ_DGA_MODE_"..self:parseIntToString(argModeId,2).."_FINISH")
        end;
        
        getMonsterPower = function(self,argPlayer,argMpTypeId)
            argPlayer = argPlayer or Game.GetLocalPlayer()
            argMpTypeId = argMpTypeId or 1
            local modeId = self:getModeId(argPlayer)
            
            local dataMP = wanez.DGA.aData.monsterPower
            
            local difficultyId = 2
            for key,value in pairs(dataMP.difficulties) do
                
                if(value.quest) then
                    if(argPlayer:GetQuestState(value.quest[1]) == QuestState.InProgress) then
                        difficultyId = key
                    end
                else
                    if(difficultyId == false) then
                        difficultyId = key
                    end
                end
                
            end;
            --local difficultyValue = dataMP.difficulties[difficultyId].name
            local difficultyValue = "normal"
            -- old MonsterPower for Vanilla Mode
            if(argPlayer:HasToken("WZ_DGA_MODE") == false) then
                --difficultyId = 2
                difficultyValue = "default"
            end
        
            return {
                type = {
                    ID = argMpTypeId;
                    Value = dataMP.types[argMpTypeId].name;
                    Mul = dataMP.types[argMpTypeId].mul;
                    MulScroll = dataMP.types[argMpTypeId].mulScroll;
                };
                mode = {
                    ID = modeId;
                    Value = dataMP.modes[modeId].name;
                    MulScroll = dataMP.modes[modeId].mulScroll;
                };
                difficulty = {
                    ID = difficultyId;
                    Value = difficultyValue;
                    MulScroll = dataMP.difficulties[difficultyId].mulScroll;
                };
                entitySpawn = {
                    ID = difficultyId;
                    Value = dataMP.difficulties[difficultyId].entitySpawn or false;
                };
            }
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
