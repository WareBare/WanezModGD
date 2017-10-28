--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/14/2017
Time: 4:53 AM

Package: 
]]--

local pathScrolls = "mod_wanez/_dga/items/scrolls"
local tplScrolls = "dga_scroll{DIFFICULTY}_tier{TIER}{TYPE}.dbr"
local tplOrb = "mod_wanez/_dga/items/currency/a_{NAME}{POTENCY}.dbr"
local tplCurrency = {
    essence = {{"mod_wanez/currency/a_001{POTENCY}.dbr",100}};
    soul = {{"mod_wanez/currency/b_001{POTENCY}.dbr",100}};
}

local aClassMul = {0.15,0.5,1.0, 1.0,1.5,2.0, 2.0,3.0,3.0 }

-- phasing spawns
local entityNames = {
    'manticore',
    'spidergiant',
    'waspgiant',
    'slith',
    'vulture'
}
local aLetterEquiv = {'a','b','c','d','e','e','e','e','e','e','e','e','e','e','e'}
local timeSinceLastKill = Time.Now()
local killRating = 0

function wanez.DGA.cDrop()
    local _parent = wanez.DGA.cBase()
    
    --local randomMax = 1000;
    local typeId;
    local areaTier;
    local entityId;
    local _entity;
    local _areaOwner;
    local dropItems;
    local entityCoords;
    local _pack;
    local classMul;
    local aDataMP;
    local classId = 0;
    local isNotVanilla;
    
    local dropChances;
    local dropMulMP; --> {mulScroll, mulCurrency, mulOrb}

    local class = {
        __constructor = function(self)
            -- get data from area
            local areaProperties = self:getArea():getAreaProperties()
            _areaOwner = areaProperties._areaOwner
            dropItems = _areaOwner:HasToken("WZ_DGA_DROP_ITEM")
            isNotVanilla = _areaOwner:HasToken("WZ_DGA_MODE")
            typeId = areaProperties._cType.TypeID
            dropChances = wanez.DGA.aData.dropChances[typeId]
            areaTier = areaProperties.areaTier
            aDataMP = areaProperties.aDataMP
            -- data not from area
            dropMulMP = self:__getDropMul()
            classMul = 1
        end;
        
        __iniClass = function(self,argObjectId,argClassId)
            classId = argClassId or 1
            classMul = aClassMul[classId]
            -- Entity Instances
            entityId = argObjectId
            _entity = Entity.Get(argObjectId)
            entityCoords = _entity:GetCoords()
            _pack = self:__getPack(argObjectId) or false
        end;
        
        
        --- todo multiple drops
        dropItem = function(self,argDbr,argToOwner)
            argToOwner = argToOwner or false
            if(argToOwner)then
                _areaOwner:GiveItem(argDbr,1,true)
            elseif(dropItems)then -- not possible to set right now (disabled)
                local _item = Entity.Create(argDbr)
                _item:SetCoords(entityCoords)
            else
                Game.GetLocalPlayer():GiveItem(argDbr,1,true)
                --[[
                local numPlayers = Game.GetNumPlayers()
                for i=1,numPlayers do
                    if(self:RNG({
                        aChances = math.ceil(100 / numPlayers)
                    }))then
                        Game.GetPlayer(i):GiveItem(argDbr,1,true)
                    end
                end;
                ]]
            end
        end;
        
        dropScroll = function(self,isEndless)
            local baseChance = (isEndless) and dropChances.endlessScroll or dropChances.regularScroll
            local typeLetter = (isEndless) and "b" or "a"
            --- Scroll Drop
            local dropChance = self:RNG({
                --randomMax = 1000;
                aChances = baseChance * dropMulMP[1] * classMul;
                returnNumber = true
            })
            --UI.Notify("Mul01: "..dropMulMP[1].." | Mul2: "..classMul)
            if(dropChance) then
                local dropIncrease = 2
                if(classId == 2) then
                    dropIncrease = 0
                elseif(classId == 3 or classId == 4) then
                    dropIncrease = 1
                end
                if(isEndless) then
                    dropIncrease = 0
                end
                local maxTier = areaTier + dropIncrease
                for i=1,dropChance do
                    self:dropItem(pathScrolls.."/"..self:str_replace(tplScrolls,{
                        DIFFICULTY = self:parseIntToString((self:__getDifficultyID() == 3) and 3 or 1,1);
                        TIER = self:parseIntToString(self:RNG({
                            randomMax = (maxTier <= 30) and maxTier or 30
                        }),2);
                        TYPE = typeLetter;
                    }),true)
                end;
            end
        end;
        
        dropCurrency = function(self,argCurrencyType,argClassId)
            local aMul = {0.10,0.25,0.5,0.75,1.0,3.0,2.0,3.0,3.0}
            local newClassMul = aMul[argClassId] or classMul
            --UI.Notify("should drop currency")
            if(aDataMP.difficulty.ID ~= 1) then
                --UI.Notify("will drop currency")
                local baseChance = dropChances[argCurrencyType]
                local aPotency = {"a"}
                if(self:__getDifficultyID() == 3)then
                    table.insert(aPotency,"b")
                    if(typeId == 4)then
                        table.insert(aPotency,"c")
                    end
                end
    
                local dropChance = self:RNG({
                    --randomMax = 1000;
                    aChances = baseChance * dropMulMP[2] * newClassMul * (areaTier / 100 * 3 + 1);
                    returnNumber = true
                })
                
                if(dropChance)then
                    for i=1,dropChance do
                        local tpl = self:RNG({aDataRatio = tplCurrency[argCurrencyType]})
                        local potency = self:RNG({aData = aPotency})
                        self:dropItem(self:str_replace(tpl,{
                            POTENCY = potency;
                        }))
                    end;
                end
            end
        end;
        
        giveOrb = function(self,argOrbType)
            argOrbType = argOrbType or 1
            argOrbType = (self:__getDifficultyID() == 3) and argOrbType or 1
        
            --[[
            local orbType = self:RNG({
                aDataRatio = {{1,100},{argOrbType,75}}
            })
            ]]
            local baseChance = 200
            local avgLevel = Game.GetAveragePlayerLevel()
            local potency = 'b'
            local challengeMul = (typeId == 3) and 2.5 or 1.0
    
            local dropChance = self:RNG({
                --randomMax = 1000;
                aChances = baseChance * (avgLevel / 10 + 1) * dropMulMP[1] * classMul * (areaTier / 100 * 3 + 1) * challengeMul;
                returnNumber = true
            })
            if(dropChance)then
                for i=1,dropChance do
                    self:dropItem(self:str_replace(tplOrb,{
                        NAME = self:parseIntToString(self:RNG({
                            aDataRatio = {{1,100},{argOrbType,10}}
                        }),2);
                        POTENCY = potency;
                    }))
                end;
            end
        end;
        
        giveReward = function(self,argRewardType)
            local tier = self:RNG({
                aDataRatio = {{1,300},{2,100},{3,25}}
            })
            local path = "mod_wanez/_dga/scrolls/reward_scroll_{TYPE}{TIER}.dbr"
            
            local baseChance = 10
            if(argRewardType == "a")then
                baseChance = wanez.DGA.aData.dropChances[typeId].rewardDevotion
            end
            local dropChance = self:RNG({
                aChances = baseChance * dropMulMP[3] * (areaTier / 100 * 3 + 1)
            })
            if(dropChance)then
                Game.GetLocalPlayer():GiveItem(self:str_replace(path,{
                    TYPE = argRewardType;
                    TIER = self:parseIntToString(tier,2);
                }),dropChance,true)
            end
        end;
        
        giveReputation = function(self,argClassId,optFactions)
            argClassId = argClassId or 1
            optFactions = optFactions or {"USER14","USER15"}
        
            
            local aRepGain = wanez.DGA.aData.reputationGain[typeId]
            local baseChance = aRepGain.perClass[argClassId]
            
            local tempFaction;
            local tempAmount;
            --UI.Notify("Give Faction")
        
            local _player = Game.GetLocalPlayer()
            for index,value in pairs(optFactions) do
                tempAmount = self:RNG({
                    aChances = baseChance * aRepGain.rankPenalty[self:getFactionRank(value,_player)] * (areaTier / 100 * 5 + 1);
                    returnNumber = true;
                }) or 0
                if(value == "USER15") then
                    tempAmount = tempAmount * -1
                end
    
                _player:GiveFaction(value,tempAmount)
            end;
            --UI.Notify("Given Faction")
            
        end;
        
        
        
        __dropLoot = function(self)
            --- INDIVIDUAL
            --self:dropCurrency('soul')
            if(isNotVanilla) then wanez.DGA.mpDrop(entityId,classId,"wzDGA_dropCurrencySoul") end -- QuestGlobalEvent("wzDGA_dropCurrencySoul")
        
            -- Endless Scroll Drop
            if(typeId == 2 and classId == 7) then
                self:dropScroll(true)
                QuestGlobalEvent("wzDGA_completeQuestType002")
            end
            if(typeId == 3 and classId == 7) then
                --self:giveOrb(2)
            end
            if(classId >= 3)then
                --self:dropCurrency('essence')
                if(isNotVanilla) then wanez.DGA.mpDrop(entityId,classId,"wzDGA_dropCurrencyEssence") end -- QuestGlobalEvent("wzDGA_dropCurrencyEssence")
            end
            if(classId >= 5) then
                --if(isNotVanilla) then QuestGlobalEvent("wzDGA_dropRewardDevotion") end
                --if(isNotVanilla) then QuestGlobalEvent("wzDGA_dropCurrencyEssence") end
                --if(isNotVanilla) then QuestGlobalEvent("wzDGA_dropCurrencyEssence") end
                --if(isNotVanilla) then QuestGlobalEvent("wzDGA_dropCurrencyEssence") end
            end
            if(typeId == 1) then
                if(_areaOwner:GetQuestState(wanez.DGA.aData.dgaTypes.mission.quests[1][1]) and classId == 5) then
                    QuestGlobalEvent("wzDGA_completeQuestType001")
                end
            end
    
            --- PHASING BEASTS
            wanez.gd.onDieEntity(entityId,classId,aDataMP.difficulty.ID)
    
            --- PACK
            if(_pack) then
                _pack:redCounter()
                if(_pack:giveReward() == classId)then
                    --UI.Notify("Killed Pack: ".._pack:giveReward())
                    --if(self:__getDifficultyID() == 3) then
                        wanez.DGA.mpGiveRep(classId)
                    --end
                    if(classId >= 2) then
                        self:dropScroll()
                    end
                end
                self:__unsetPack(_pack:getId())
            end
        end;
    }
    
    setmetatable(class,{ __index = _parent })
    class:__constructor()
    return class
end
