--[[
Created by IntelliJ IDEA.
User: Ware
Date: 11/7/2017
Time: 12:14 PM

Package: 
]]--

wanez.WaveEvent = {}


local function End(InObjectId)
    local waveEvent = Shared.getUserdata(InObjectId).waveEvent
    waveEvent.running = false
    
    -- Stop receiving updates
    Script.UnregisterForUpdate(InObjectId, "wanez.WaveEvent.Update")
    
    -- Fire user end callback
    if (waveEvent.endCallback ~= nil) then
        waveEvent.endCallback(InObjectId)
    end
end

local function SpawnNext(InObjectId)
    local waveEvent = Shared.getUserdata(InObjectId).waveEvent
    --UI.Notify("SpawnNext")
    local NewCoords = waveEvent.coords
    if(waveEvent.waveTarget ~= nil)then
        local _Target = Entity.Get(waveEvent.waveTarget)
        if(_Target ~= nil) then
            --UI.Notify("SpawnNext at Target")
            NewCoords = _Target:GetCoords()
        else
            NewCoords = nil
        end
        
    end
    -- Spawn next proxy
    if(NewCoords ~= nil) then
        waveEvent.waveIndex = waveEvent.waveIndex + 1
        waveEvent.proxy = Proxy.Create(waveEvent.waves[waveEvent.waveIndex], waveEvent.coords.origin)
        waveEvent.proxy:SetCoords( NewCoords )
    
        wanez.PhasingEvents.SpawnDifficultyEntity( NewCoords )
        --if(waveEvent.spawnPeriod) then
        waveEvent.timers.spawnTime = Time.Now()
        --end
    else
        End(InObjectId)
    end
end


wanez.WaveEvent.Update = function(InObjectId)
    if Server then
        local waveEvent = Shared.getUserdata(InObjectId).waveEvent
    
        -- Fire user update callback
        if (waveEvent.updateCallback ~= nil) then
            waveEvent.updateCallback(InObjectId)
        end
    
        if(waveEvent.waveTarget ~= nil and Entity.Get(waveEvent.waveTarget) == nil) then
            --UI.Notify("Spirit killed")
            End(InObjectId)
        elseif(waveEvent.despawnTimer ~= nil and (Time.Now() - waveEvent.timers.startTime) >= waveEvent.despawnTimer  ) then
            End(InObjectId)
        elseif (waveEvent.waveIndex < waveEvent.numWaves) then
            if(waveEvent.newUpdater ~= nil) then
                waveEvent.newUpdater(InObjectId)
            elseif(waveEvent.useOnlySpawnPeriod == true) then
                if( (Time.Now() - waveEvent.timers.spawnTime) >= waveEvent.spawnPeriod ) then
                    --UI.Notify("SpawnNext")
                    SpawnNext(InObjectId)
                end
            elseif(waveEvent.proxy:AllKilled()) then
                --UI.Notify("SpawnNext")
                SpawnNext(InObjectId)
            elseif(waveEvent.spawnPeriod ~= nil )then
                if( (Time.Now() - waveEvent.timers.spawnTime) >= waveEvent.spawnPeriod ) then
                    --UI.Notify("SpawnNext")
                    SpawnNext(InObjectId)
                end
            end
            --if(waveEvent.waveTarget ~= nil) then
                --local _Target = Entity.Get(waveEvent.waveTarget)
                --local _Entity = Entity.Get(InObjectId)
                --if(_Target ~= nil and _Entity ~= nil) then
                    --_Entity:SetCoords(_Target:GetCoords())
                --end
            --end
        else
            End(InObjectId)
        end
    
        
    end
end

wanez.WaveEvent.Start = function(InParams)
    if Server then
        --UI.Notify("Start WaveEvent")
        --- default values
        setmetatable(InParams, {__index = {
            scriptEntity = {
                DBR = "mod_wanez/misc/waveevent_scriptentity_default.dbr",
                Coords = Game.GetLocalPlayer():GetCoords()
            },
            waveTarget = nil,
            spawnPeriod = nil,
            despawnTimer = nil,
            useOnlySpawnPeriod = nil,
            updatePeriod = 1000
        }})
    
        --- get or create ScriptEntity for its ID to use for userdata
        local _ScriptEntity = Entity.Get( InParams.scriptEntity )
        local iObjectId = InParams.scriptEntity
    
        if(_ScriptEntity == nil) then -- check if Get() failed and no valid ObjectId was set, if it failed create a new Entity
            --- create ScriptEntity for WaveEvent and place it to the coords set [default: LocalPlayerCoords]
            _ScriptEntity = Entity.Create(InParams.scriptEntity.DBR)
            _ScriptEntity:SetCoords( InParams.scriptEntity.Coords )
        
            iObjectId = _ScriptEntity:GetId()
        end
    
        local mUserData = Shared.getUserdata(iObjectId)
    
        if (mUserData == nil) then
            mUserData = {}
            Shared.setUserdata(iObjectId, mUserData)
        end
    
        mUserData.waveEvent = {}
    
        -- Setup waveEvent table in object userdata
        local waveEvent = mUserData.waveEvent
    
        --waveEvent.data = InParams.data
        waveEvent.coords = _ScriptEntity:GetCoords()
        waveEvent.waveIndex = 0
        waveEvent.waveTarget = InParams.waveTarget
        waveEvent.spawnPeriod = InParams.spawnPeriod
        waveEvent.despawnTimer = InParams.despawnTimer
        waveEvent.timers = {
            startTime = Time.Now()
        }
        waveEvent.useOnlySpawnPeriod = InParams.useOnlySpawnPeriod or nil
        waveEvent.proxy = nil
        waveEvent.waves = InParams.waves
        waveEvent.numWaves = table.getn(InParams.waves)
        waveEvent.newUpdater = InParams.newUpdater or nil
        waveEvent.updateCallback = InParams.updateCallback or nil
        waveEvent.endCallback = InParams.endCallback or wanez.WaveEvent.DefaultEndCallback
        waveEvent.token = InParams.token or nil
        waveEvent.key = InParams.key or "defaultkey_"..iObjectId
        waveEvent.updatePeriod = InParams.updatePeriod or 1000
        waveEvent.running = true
        -- Start receiving updates
        Script.RegisterForUpdate(iObjectId, "wanez.WaveEvent.Update", waveEvent.updatePeriod)
    
        -- Fire user start callback
        if (InParams.startCallback ~= nil) then
            InParams.startCallback(iObjectId)
        end
    
        -- Spawn first wave
        if(waveEvent.newUpdater ~= nil) then
            waveEvent.newUpdater(iObjectId)
        else
            SpawnNext(iObjectId)
        end
        --wanez.WaveEvent.SpawnNext(iObjectId)
        --UI.Notify("Start WaveEvent | numWaves: "..waveEvent.numWaves)
    
        return iObjectId
    end
end



wanez.WaveEvent.DefaultEndCallback = function(InObjectId)
    local waveEvent = Shared.getUserdata(InObjectId).waveEvent
    
    -- Give end token if set
    if (waveEvent.token ~= nil) then
        GiveTokenToLocalPlayer(waveEvent.token)
    end
end

wanez.WaveEvent.Default_OnAddToWorld = function(InObjectId, InKey)
    Shared.restoreUserData(InObjectId, InKey)
    
    local mUserData = Shared.getUserdata(InObjectId)
    
    if (mUserData ~= nil) then
        if (mUserData.waveEvent.running) then
            Script.RegisterForUpdate(InObjectId, "wanez.WaveEvent.Update", mUserData.waveEvent.updatePeriod)
        end
    end
end

wanez.WaveEvent.Default_OnRemoveFromWorld = function(InObjectId)
    local mUserData = Shared.getUserdata(InObjectId)
    
    if (mUserData ~= nil) then
        if (mUserData.waveEvent.running) then
            Script.UnregisterForUpdate(InObjectId, "wanez.WaveEvent.Update")
            Shared.persistUserdata(InObjectId, mUserData.waveEvent.key)
        else
            Shared.setUserdata(InObjectId, nil)
        end
    
    end
end
