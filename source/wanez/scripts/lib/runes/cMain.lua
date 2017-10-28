--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/21/2017
Time: 7:02 PM

Runic Inscription - Sequence
-- most important class for _runes, everything goes from here
-- * stone starts sequence (instantiates this class)
-- * runes (scroll) used will add to this sequence if the type fits and that rune (ID) wasnt set before (:addRune(...))
--
-- @param argGearType
-- @param argGearSlot
-- @param argSockets

Package:
]]--

function wanez.Runes.cMain(argGearType,argGearSlot,argSockets)
    local _parent = wanez.Runes.cBase()
    
    local gearType = argGearType
    local gearSlot = argGearSlot
    local isGeneric = (argGearSlot == 'generic') and true or false
    local numberSockets = argSockets
    --local runeType = false
    local aRunes = {} -- current sequence
    local aInscriptions = false -- viable inscriptions
    local isFailure = false
    
    local pathRune = "mod_wanez/_runes/items/materia"
    local pathInsc = "mod_wanez/_runes/items/enchants"
    
    local _player = Game.GetLocalPlayer()
    
    local class = {
        __constructor = function(self)
            --UI.Notify("cSequence:__constructor")
        end;
        
        ---
        -- @param argRuneType
        -- @param argRuneId
        -- @param argRuneMaxTier
        -- @return false|Array {bool isComplete,'tag','.dbr'}
        addRune = function(self,argRuneType,argRuneId,argRuneMaxTier)
            local runeDbr = pathRune..'/'..argRuneType.."_"..self:parseIntToString(argRuneId,2)..".dbr"
            local state = false
            
            if(self:__setRuneType(argRuneType)) then --  == argRuneType
                --state = false
                if(aInscriptions == false) then
                    aInscriptions = {}
                    --UI.Notify("about to loop through data")
                    for index,data in pairs(self:__getInscriptionsData()) do
                        --UI.Notify(data.FileName)
                        if(table.getn(data.Runes) == numberSockets) then
                            
                            -- add viable inscription if the type fits
                            if(data.Stone[1] == gearType) then
                                if(isGeneric or data.Stone[2] == gearSlot) then
                                    table.insert(aInscriptions,data)
                                end
                            end
                        
                        end
                    end;
                    -- if no data has been added mark this as failure, but the player cannot know about it
                    if(table.getn(aInscriptions) == 0) then
                        isFailure = true
                    end
                end
                
                if(table.getn(aRunes) == 0) then
                    table.insert(aRunes,argRuneId)
                else
                    local addEntry = true
                    for i=1,table.getn(aRunes) do
                        if(aRunes[i] == argRuneId) then addEntry = false end
                    end;
                    if(addEntry) then
                        table.insert(aRunes,argRuneId)
                    else
                        state = {false,'tagWzRunes_LuaNotify_useRune_runeUsed',runeDbr}
                    end
                end
                if(table.getn(aRunes) == numberSockets) then
                    -- return inscription
                    if(isFailure) then
                        state = {true,'tagWzRunes_LuaNotify_useRune_InscriptionFailure'}
                    else
                        local inscDbr = self:genInscription()
                        if(inscDbr)then
                            state = {true,'tagWzRunes_LuaNotify_useRune_InscriptionSuccess',inscDbr}
                        else
                            state = {true,'tagWzRunes_LuaNotify_useRune_InscriptionWrongSequence'}
                        end
                    
                    end
                
                else
                    state = {false,'tagWzRunes_LuaNotify_useRune_success'}
                end
            else
                -- return the rune with the wrong type to the player and continue Sequence
                state = {false,'tagWzRunes_LuaNotify_useRune_wrongRuneType',runeDbr}
            end
            
            return state
        end;
        
        ---
        -- was successful, return the inscription with a random tier (if gearSlot was identical)
        --
        genInscription = function(self)
            local aViables = {} -- will hold viable inscriptions
            local isViable = false
            local dbr = false
            for index,value in pairs(aInscriptions) do
                isViable = true
                -- check if inscription is still viable (by checking the correct rune-sequence)
                for runeIndex,runeValue in pairs(aRunes) do
                    
                    if(value.Runes[runeIndex] ~= runeValue) then
                        isViable = false
                    end
                
                end;
                -- add viable inscription
                if(isViable)then
                    table.insert(aViables,{index,value.Ratio})
                end
            end;
            
            if(table.getn(aViables) > 0)then
                local randInscription = self:RNG({
                    aDataRatio = aViables
                })
                local maxTier = (isGeneric) and 1 or aInscriptions[randInscription].Tiers
                local aTiers = {}
                --if(aInscriptions[randInscription].Stone[2] == gearSlot) then
                --maxTier = aInscriptions[randInscription].Tiers
                --end
                
                for i=1,maxTier do
                    table.insert(aTiers,wanez.Runes.aData.tierWeights[i])
                end;
                
                dbr = pathInsc.."/"..self:str_replace(aInscriptions[randInscription].FileName,{
                    [1] = self:RNG({
                        aDataRatio = aTiers
                    })
                })..".dbr"
            end
            
            return dbr
        end;
        
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
