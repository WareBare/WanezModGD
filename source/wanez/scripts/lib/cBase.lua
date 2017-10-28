--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/26/2017
Time: 10:44 AM

Package: 
]]--

--- semi static data, accessible from all instances - because it requires and instance (any instance) its not really static and wanez.cBase():__get(x) would work
local difficultyId = false
local lastSeed = 0
local rngEntries = {}
local aData = {}
--local seedCounter = 0

function wanez.cBase()
    
    --- semi protected properties, accessible only from the same instance (and inheritance)
    local protectedData = {}
    
    local class = {
        __constructor = function(self)
            
        end;
        __get = function(self,argName,argType)
            argType = argType or 'static'
            
            local myData = aData
            if(argType == "protected") then
                myData = protectedData
            end
            
            if(argName) then
                if(myData[argName] ~= nil) then return myData[argName]
                else return false
                end
            else return myData
            end
        end;
        __set = function(self,argName,argValue,argType)
            argType = argType or 'static'
            
            if(argType == "protected") then
                protectedData[argName] = argValue
            else
                aData[argName] = argValue
            end
        end;
        ---
        --- {Array|Boolean} [optRange] - range for a random number [default: {1,100}]
        --- {Mixed} [argChance] - chances, or if string check if a number has been picked before this session [default: false]
        --- {Array} [optData] - array to parse for a random key [default: false]
        --- {Int} [argMaxLoops] - how many times should while save oldEntries [default: 5]
        --- ToDo: support for arrays with mixed numbers (1,3,7,90,...), currently only (1,2,3,4,5,6,...) is supported
        --- {Array} aData - random value out of it {'apple', 'lemon'}
        --- {Boolean} returnArrayValue - will return aData index instead of its value
        --- {Array} aDataRatio - random value out of it using weights/ratios inside {{'apple',50},{'lemon',100}} => more likely to get a lemon
        ---
        ---
        RNG = function(self,opt) -- optRange,argChance,optData,argMaxLoops
            --UI.Notify("RNG :: to declare var")
            opt = opt or {}
            setmetatable(opt,{__index={
                aData = false;
                aDataRatio = false;
                randomMin = 1;
                randomMax = 100;
                aChances = false;
                maxLoops = 5;
                rngEntries = false;
                rngData = false;
                returnArrayValue = true;
                returnNumber = false
            }})
            local optData = opt.aData
            local optRange = {opt.randomMin,(optData) and table.getn(optData) or opt.randomMax}
            --optRange[1] = (optRange) and optRange[1] or 1
            --optRange[2] = (optData) and table.getn(optData) or (optRange[2] or 100)
            local argChance = opt.aChances
            local argMaxLoops = opt.maxLoops
            if(type(argChance) == "number")then
                while(argChance ~= math.ceil(argChance)) do
                    argChance = argChance * 10
                    optRange[2] = optRange[2] * 10
                end
            end
        
            self:newRandomSeed()
        
            --- If data has weights/ratios
            if(opt.aDataRatio) then
                optData = {}
                argChance = {}
                optRange[2] = 0
                for index,value in pairs(opt.aDataRatio) do
                    table.insert(optData,value[1])
                    table.insert(argChance,value[2])
                    optRange[2] = optRange[2] + value[2]
                end;
            end
            
            --- RANDOM NUMBER
            local doWhile = true
            local rand = 0
            
            while(doWhile) do
                doWhile = false
                rand = math.random(optRange[1],optRange[2])
                if(opt.rngEntries) then
                    rngEntries[opt.rngEntries] = rngEntries[opt.rngEntries] or {}
                    local countEntries = table.getn(rngEntries[opt.rngEntries])
                    if(countEntries < optRange[2] and countEntries < argMaxLoops) then
                        --local tempIndex = 1
                        --local tempValue = false
                        for index,value in pairs(rngEntries[opt.rngEntries]) do
                            if(value == rand) then
                                doWhile = true
                            end
                            --tempIndex = index
                        end;
                        if(doWhile == false) then
                            --rngEntries[opt.rngEntries][countEntries + 1] = countEntries
                            table.insert(rngEntries[opt.rngEntries],rand)
                        end
                    else
                        rngEntries[opt.rngEntries] = {}
                    end
                elseif(opt.rngData) then
                    if(table.getn(opt.rngData) < optRange[2]) then
                        --local tempIndex = 1
                        --local tempValue = false
                        if(opt.rngData[optData[rand]] == true)then
                            doWhile = true
                        end
                    end
                end
            end;
            --- CHANCE
            if(type(argChance) == "number")then
                local numberOfResults = math.floor(argChance / optRange[2])
                argChance = argChance - (numberOfResults * optRange[2])
                rand = (rand <= argChance) and true or false
                if(opt.returnNumber) then
                    rand = (rand) and numberOfResults + 1 or ( (numberOfResults ~= 0) and numberOfResults or false )
                end
            elseif(type(argChance) == "table")then
                local totalChances = table.getn(argChance)
                local curChance = 0
                local retRand = 0
                for i=1,totalChances do
                    curChance = curChance + argChance[i]
                    if(rand <= curChance)then
                        if(retRand == 0)then retRand = i;end;
                        --i = totalChances + 1
                    end
                end
                rand = retRand
            end
            
            if(optData and opt.returnArrayValue) then
                rand = optData[rand]
            end
            
            return rand
        end;
        --- if chance is higher than randomMax it will return multiple values
        chanceCount = function(self)
            
        end;
        
        convertIndex = function(self,argValue)
            local toLetter = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z" }
            local useTable = toLetter
            if(type(argValue) ~= "number") then
                local toNumber = {}
        
                for key,value in pairs(toLetter) do
                    toNumber[value] = key
                end
                useTable = toNumber
            end
            return useTable[argValue]
        end;
        parseIntToString = function(self,number,add)
            local arr = {'0000','000','00','0',''}
            local base = 5;
            --number = parseInt($number);
        
        
            return ( (number <= 9) and arr[base - add]..number or (number <= 99) and arr[base + 1 - add]..number or (number <= 999) and arr[base + 2 - add]..number or number );
        end;
        newRandomSeed = function(self)
            if( (Time.Now() - lastSeed) >= 100000) then
                lastSeed = Time.Now()
                math.randomseed(lastSeed)
                --UI.Notify('set new randomseed')
            end
        end;
        --- TODO: argUnique; isMP
        giveItems_old = function(self,optItems,argObjectIdPlayer)
            --isMP = isMP or false
            optItems = (type(optItems) == 'string') and {optItems} or optItems
    
            local _player = (argObjectIdPlayer) and Player.Get(argObjectIdPlayer) or Game.GetLocalPlayer()
            --local _player = Game.GetLocalPlayer()
        
            for key,value in pairs(optItems) do
                _player:GiveItem(value,1,true)
            end;
        end;
        giveItems = function(self,optItems)
            Game.GetLocalPlayer():wzGiveItems(optItems)
        end;
        --- opt - [ {str .dbr,chance,weight} ]
        --- [optRange] {min,max} array keys to use from opt
        giveItemsRNG = function(self,opt,optRange)
            
        end;
        __setDifficultyID = function(self)
            if(difficultyId == false) then
                if(Game.GetGameDifficulty() == Game.Difficulty.Legendary) then
                    difficultyId = 3
                elseif(Game.GetGameDifficulty() == Game.Difficulty.Epic) then
                    difficultyId = 2
                else
                    difficultyId = 1
                end
            end
        end;
        __getDifficultyID = function(self)
            return difficultyId
        end;
        str_replace = function(self,argSubject,optReplacements) -- ToDo
            local newStr_ = argSubject
        
            --for i=1,table.getn(optReplacements) do
                --newStr_ = newStr_:gsub('{'..i..'}',optReplacements[i])
            --end;
            for key,value in pairs(optReplacements) do
                newStr_ = newStr_:gsub('{'..key..'}',value)
            end;
        
            return tostring(newStr_);
        end;
        mathMul = function(self,optValues)
            optValues = (type(optValues) == "number") and {optValues} or optValues
            
            local newMul = 1
            local tempMul = false
    
            for index,value in pairs(optValues) do
                tempMul = value / 100 + 1;
                newMul = newMul * tempMul;
            end;
        
            return newMul
        end;
        
        getFactionRank = function(self,argFaction,argPlayer)
            argPlayer = argPlayer or Game.GetLocalPlayer()
            local factionRating = argPlayer:GetFaction(argFaction)
            local FactionRank = 1
            if(factionRating >= 25000)then FactionRank = 5
            elseif(factionRating <= -20000 or factionRating >= 10000)then FactionRank = 4
            elseif(factionRating <= -8000 or factionRating >= 5000)then FactionRank = 3
            elseif(factionRating <= -1500 or factionRating >= 1500)then FactionRank = 2 end
            
            return FactionRank;
        end;
    }
    
    class:__constructor()
    return class
end
