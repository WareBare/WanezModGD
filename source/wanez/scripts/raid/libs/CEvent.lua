--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/21/2017
Time: 10:10 PM

Package: 
]]--

local mEventData = wanez.Raid.data.Events
--local mBlockedSpawns = {}

wanez.Raid.libs.CEvent = function()
    local _parent = wanez.Raid.libs.CObjectives()
    
    local CurrentEvent = false
    local CurrentWaveData = false
    local mData = {}

    local class;

    class = {
        __constructor = function(self)
        end;
        __setEvent = function(self, InObjectId)
            
            --if(mBlockedSpawns[InObjectId] == nil) then
                local _Entity = Entity.Get(InObjectId)
                local Key;
                local bIsTrigger = false
    
                if(_Entity ~= nil) then
                    local DBR = _Entity:GetName()
                    -- check for script first, because it is more likely to be one
                    Key = DBR:gsub("mod_wanez/_raid/"..self.RaidName:lower().."/placeables/","")
                    -- Key should be different than DBR or it was not a script
                    --if(Key == DBR) then
                    --Key = DBR:gsub("mod_wanez/_raid/"..InType.."/placeables/trigger_","")
                    --bIsTrigger = true
                    --else
                    Key = Key:gsub(".dbr", "")
                    --UI.Notify(Key)
                    --end
                end
    
                if(Key ~= nil) then
                    mData[Key] = mData[Key] or {}
        
                    mData[Key].Scripts = mData[Key].Scripts or {}
        
                    local bHasEntry = false
                    for key,value in pairs(mData[Key].Scripts) do
                        if(value == InObjectId) then
                            bHasEntry = key
                        end
                    end
                    if(bHasEntry == false) then
                        table.insert(mData[Key].Scripts, InObjectId)
                    else
                        mData[Key].Scripts[bHasEntry] = InObjectId
                    end
                    --mBlockedSpawns[InObjectId] = true
                end
            --end
            
        end;
        StartEvent = function(self, InEventDataKey, InScriptDataKey)
            --UI.Notify("Start Event")
            CurrentWaveData = mEventData[self.RaidName][InEventDataKey].WaveData
        
            -- get script data
            --CurrentWaveData.BossDBR = mEventData[self.RaidName][InEventDataKey].Bosses[ random(1, table.getn(mEventData[self.RaidName][InEventDataKey].Bosses)) ]
        
            -- WaveEvent Start for Boss Fights
    
            -- only start if no other event is running; CurrentEvent == false and
            if(mData[InScriptDataKey].bIsFinished == nil) then
                UI.Notify("tagWzRaid_Lua_WaveEvent_Start_NOTIFY")
    
                CurrentEvent = mData[InScriptDataKey]
                CurrentEvent.bIsFinished = false
    
                local _Script = Entity.Create( CurrentWaveData.DBR )
                local cPlayer = Game.GetLocalPlayer()
    
                if(_Script ~= nil and cPlayer ~= nil) then
                    self:NewRandomSeed()
                    CurrentEvent.BossDBR = "mod_wanez/_raid/"..self.RaidName.."/enemies/"..mEventData[self.RaidName][InEventDataKey].Bosses[ random(1, table.getn(mEventData[self.RaidName][InEventDataKey].Bosses)) ]
                    _Script:SetCoords( cPlayer:GetCoords() )
        
                    local ScriptId = _Script:GetId()
                    local mUserData = Shared.getUserdata(ScriptId)
        
                    if (mUserData == nil) then
                        mUserData = {}
                        Shared.setUserdata(ScriptId, mUserData)
                    end
        
                    mUserData.waveEvent = {}
        
                    local waveEvent = mUserData.waveEvent
        
                    waveEvent.key = "RaidBossEvent_"..self.RaidName.."-"..InScriptDataKey
                    waveEvent.updatePeriod = 3000
                    waveEvent.running = true
                    waveEvent.type = self.RaidName
                    waveEvent.bHasSpawnedBoss = false
        
                    Script.RegisterForUpdate(ScriptId, CurrentWaveData.Updater, waveEvent.updatePeriod)
    
                    self:NewRandomSeed()
                    local iCount = 0
                    local cTarget;
                    while cTarget == nil and iCount <= 100 do
                        cTarget = Entity.Get( CurrentEvent.Scripts[ random(1,table.getn(CurrentEvent.Scripts)) ] )
                        iCount = iCount + 1
                    end;
                    --UI.Notify("Get Spawn Loc Count {^G}: "..iCount)
                
                    if(cTarget ~= nil) then
                        --UI.Notify("{^r}DEBUG: {^w}Create Guardian!")
                        --local _Guardian = Character.Create( CurrentWaveData.Enemies.Guardian[random(1,table.getn(CurrentWaveData.Enemies.Guardian))], Game.GetAveragePlayerLevel() + 3, nil )
                        local _Guardian = Entity.Create( CurrentWaveData.Enemies.Guardian )
                        --UI.Notify("{^r}DEBUG: {^w}Guardian Created!")
                        if(_Guardian ~= nil) then
                            _Guardian:SetCoords( cTarget:GetCoords() )
                        else
                            UI.Notify("{^r}DEBUG: {^w}An error occured trying to create a Guardian!")
                        end
                    else
                        UI.Notify("{^r}DEBUG: {^w}An error occured trying to get spawn location for Guardian!")
                    end
        
                    self:SpawnEvent(ScriptId)
                    self:SpawnEvent(ScriptId)
                    self:SpawnEvent(ScriptId)
                    self:SpawnEvent(ScriptId)
                else
                    UI.Notify("{^r}DEBUG: {^w}An error occured trying to create the event!")
                end
                
            end
        end;
        EndEvent = function()
            CurrentEvent.bIsFinished = true
            CurrentEvent = false
            --UI.Notify("{^r}DEBUG: {^w}End Event")
        end;
        FinishEvent = function(self, InScriptId)
            local waveEvent = Shared.getUserdata(InScriptId).waveEvent
            waveEvent.running = false
    
            -- Stop receiving updates
            Script.UnregisterForUpdate(InScriptId, CurrentWaveData.Updater)
    
            -- Fire user end callback
            if (waveEvent.endCallback ~= nil) then
                --waveEvent.endCallback(InScriptId)
            end
    
        end;
        
        UpdateEvent = function(InScriptId)
    
            local waveEvent = Shared.getUserdata(InScriptId).waveEvent
    
            -- Fire user update callback
            if (waveEvent.updateCallback ~= nil) then
                --waveEvent.updateCallback(InScriptId)
            end
    
            if(CurrentEvent ~= false) then
                class:SpawnEvent(InScriptId)
            else
                class:FinishEvent(InScriptId)
            end
            
        end;
        SpawnEvent = function(self, InScriptId)
            if(CurrentEvent ~= false) then
                local waveEvent = Shared.getUserdata(InScriptId).waveEvent
                if(waveEvent ~= nil)then
                    local RandomIndex;
                    -- random Target via ScriptId
                    self:NewRandomSeed()
                    local iCount = 0
                    local cTarget;
                    while cTarget == nil and iCount <= 100 do
                        RandomIndex = random(1,table.getn(CurrentEvent.Scripts))
                        cTarget = Entity.Get( CurrentEvent.Scripts[RandomIndex]  )
                        if(cTarget == nil) then
                            CurrentEvent.Scripts[RandomIndex] = nil
                        end
                        iCount = iCount + 1
                    end;
                    --UI.Notify("Get Spawn Loc Count {^G}: "..iCount)
                    
                    if(cTarget ~= nil) then
                        
                        local _Enemy = Character.Create( CurrentWaveData.Enemies.Wave[random(1,table.getn(CurrentWaveData.Enemies.Wave))], Game.GetAveragePlayerLevel() + 1, nil );
                        
                        if(_Enemy ~= nil) then
                            _Enemy:SetCoords( cTarget:GetCoords() )
                        else
                            UI.Notify("{^r}DEBUG: {^w}Event was unable to create Character!")
                        end
                        
                    else
                        UI.Notify("{^r}DEBUG: {^w}Event was unable to find a location for the next spawn!")
                    end
                    
                end
            else
                UI.Notify("{^r}DEBUG: {^w}Event wasn't stopped properly!")
                self:FinishEvent(InScriptId)
            end
            
        end;
        SpawnEventBoss = function(self)
            if(CurrentEvent and CurrentEvent.BossDBR ~= nil) then
                --local _Trigger = Entity.Get( CurrentEvent.Scripts[ random(1,table.getn(CurrentEvent.Scripts)) ] )
    
                self:NewRandomSeed()
                local iCount = 0
                local cTarget;
                while cTarget == nil and iCount <= 100 do
        
                    cTarget = Entity.Get( CurrentEvent.Scripts[ random(1,table.getn(CurrentEvent.Scripts)) ] )
                    if(cTarget == nil) then
                    end
                    iCount = iCount + 1
                end;
                --UI.Notify("Get Spawn Loc Count {^G}: "..iCount)
            
                if(cTarget ~= nil) then
                    --local _Boss = Character.Create( CurrentEvent.BossDBR, Game.GetAveragePlayerLevel() + 5, nil )
                    local _Boss = Proxy.Create("mod_wanez/_raid/phasinglords/proxies/proxy_boss_lord.dbr")
                    
                    if(_Boss ~= nil) then
                        _Boss:SetCoords( cTarget:GetCoords() )
                        CurrentEvent.BossDBR = nil
                    else
                        UI.Notify("{^r}DEBUG: {^w}Event was unable to create Boss!")
                    end
                    
                else
                    UI.Notify("{^r}DEBUG: {^w}Event was unable to get boss spawn location!")
                end
                
            end
        end
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
