--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/20/2017
Time: 10:43 PM

Package: 
]]--

wanez.Raid.hooks = {}

wanez.Raid.hooks.BossFight = {
    Guardian = {
        --- monster: mod_wanez/_raid/phasinglords/enemies/guardian_lord_01.dbr
        OnDie = function(InEnemyId)
            cRaid:SpawnEventBoss()
        end;
    },
    Lord = {
        --- monster: mod_wanez/_raid/phasinglords/enemies/boss_lord_01_aether.dbr
        OnDie = function(InEnemyId)
            cRaid:DropTreasureKey(InEnemyId)
        
            cRaid:EndEvent()
        end;
        --- trigger: mod_wanez/_raid/phasinglords/placeables/trigger_lord.dbr
        OnEnter = function(InPlayerId, InTriggerId)
            cRaid:StartEvent("Lords")
        end;
        --- scriptentity: mod_wanez/_raid/phasinglords/placeables/script_lord_01_aether.dbr
        OnAddToWorld = function(InObjectId)
            cRaid:__setEvent(InObjectId)
        end;
        
        Triggers = {
            ["01"] = {
                OnEnter = function(InPlayerId)
                    cRaid:StartEvent("Lords", "area01_script_lord")
                end;
            },
            ["02"] = {
                OnEnter = function(InPlayerId)
                    cRaid:StartEvent("Lords", "area02_script_lord")
                end;
            },
            ["03"] = {
                OnEnter = function(InPlayerId)
                    cRaid:StartEvent("Lords", "area03_script_lord")
                end;
            },
            ["04"] = {
                OnEnter = function(InPlayerId)
                    cRaid:StartEvent("Lords", "area04_script_lord")
                end;
            }
        }
    },
    TreasureGuardian = {
        --- monster: mod_wanez/_raid/phasinglords/enemies/boss_warden02.dbr
        OnDie = function(InEnemyId)
            cRaid:DropTreasureKey(InEnemyId)
        
            cRaid:OpenTreasureChamber(InEnemyId)
        end;
    }
}

wanez.Raid.hooks.SetCoordsHome = function(InObjectId)
    cRaid.__setPortalDestination("Home", InObjectId)
end

--- Trigger when the player enters the world (only triggered by Host)
wanez.Raid.hooks.OnLoad = function(InPlayerId)
    BlockPA_Stash = true
    
    cRaid_PhasingLords:OpenEntranceDoor()

    wanez.Raid.main.Dev.GiveKeys()
end

wanez.Raid.hooks.LockedChest = {
    OnInteract = function(InDoorId)
    end;
    OnAddToWorld = function(InDoorId)
    end;
}

wanez.Raid.hooks.Test = {
    OnInteract = function(InChestId)
        UI.Notify("Interacted with Treasure")
    end;
    OnAddToWorld = function(InChestId)
        UI.Notify("Added Treasure to the Game")
    end
}

wanez.Raid.hooks.PhasingLords = {
    Triggers = {
        OnLoad = function(InPlayerId)
            cRaid_PhasingLords:ShowPortalsPath()
        end;
    },
    BossFights = {
        OnDie_Lord = function(InEnemyId)
            --cRaid_PhasingLords.CurrentEvent = false
            cRaid_PhasingLords:EndEvent()
    
            cRaid_PhasingLords:DropTreasureKey(InEnemyId)
        end;
        OnDie_Guardian = function(InEnemyId)
            cRaid_PhasingLords:SpawnEventBoss()
        end;
        OnDie_TreasureGuardian = function(InEnemyId)
            cRaid_PhasingLords:DropTreasureKey(InEnemyId)
        
            cRaid_PhasingLords:OpenTreasureChamber(InEnemyId)
        end;
        OnEnter_Lord = function(InPlayerId, InTriggerId)
            cRaid_PhasingLords:StartEvent("lord_01_aether.dbr")
        end;
        OnEnter_Lord_01_Aether = function(InPlayerId, InTriggerId)
            cRaid_PhasingLords:StartEvent("lord_01_aether.dbr")
        end;
        OnAddToWorld = function(InObjectId)
            --if(cRaid_PhasingLords.CurrentEvent == false) then
                cRaid_PhasingLords:__setEvent(InObjectId)
            --end
        end;
    },
    DefaultWaveEvent = {
        OnAddToWorld = function(InScriptId, InKey)
            Shared.restoreUserData(InScriptId, InKey)
        
            local mUserData = Shared.getUserdata(InScriptId)
        
            if (mUserData ~= nil) then
                if (mUserData.waveEvent.running) then
                    Script.RegisterForUpdate(InScriptId, "cRaid_PhasingLords.UpdateEvent", mUserData.waveEvent.updatePeriod)
                end
            end
        end;
        OnRemoveFromWorld = function(InScriptId)
            local mUserData = Shared.getUserdata(InScriptId)
        
            if (mUserData ~= nil) then
                if (mUserData.waveEvent.running and cRaid_PhasingLords.CurrentEvent ~= false) then
                    Script.UnregisterForUpdate(InScriptId, "cRaid_PhasingLords.UpdateEvent")
                    Shared.persistUserdata(InScriptId, mUserData.waveEvent.key)
                else
                    Shared.setUserdata(InScriptId, nil)
                end
            end
        end
    },
    Portals = {
        -- portals at crossing
        ["00"] = {
            OnAddToWorld = function(InPortalId)
                cRaid_PhasingLords:__setPortalPath(InPortalId)
            end;
            OnInteract = function(InPortalId)
                --UI.Notify("Portal has been interacted with")
                cRaid_PhasingLords:RemovePortalPath(InPortalId)
            end;
        },
        ["01"] = {
            SpawnLocation = function(InScriptId)
                cRaid_PhasingLords:__setPortalPath(InScriptId, 1)
            end;
        },
        ["02"] = {
            SpawnLocation = function(InScriptId)
                cRaid_PhasingLords:__setPortalPath(InScriptId, 2)
            end;
        },
        ["03"] = {
            SpawnLocation = function(InScriptId)
                cRaid_PhasingLords:__setPortalPath(InScriptId, 3)
            end;
        },
        ["04"] = {
            SpawnLocation = function(InScriptId)
                cRaid_PhasingLords:__setPortalPath(InScriptId, 4)
            end;
        }
    },
    Doors = {
        -- start gate
        Entrance = {
            OnAddToWorld = function(InDoorId)
                cRaid_PhasingLords:__setDoorEntrance(InDoorId)
            end;
            OnInteract = function(InDoorId)
                cRaid_PhasingLords:StartNewRaid(true)
            end;
            OnUsePortal = function()
                cRaid_PhasingLords:CloseDoorEntrance()
            end
        },
        TreasureChamber = {
            OnAddToWorld = function(InDoorId)
                cRaid_PhasingLords:__setDoorTreasureChamber(InDoorId)
            end;
        }
    },
    Chests = {
        Treasure = {
            OnInteract = function(InChestId)
                cRaid_PhasingLords:OpenTreasureChest(InChestId)
            end;
            OnAddToWorld = function(InChestId)
                cRaid_PhasingLords:__setTreasureChest(InChestId)
            end;
        }
    },
    Quest = {
        HiddenTreasure = {
            OnInteract = function(InChestId)
                if(bIsDev) then
                    cRaid_PhasingLords:_OpenTreasure(InChestId, "mod_wanez/_raid/phasinglords/chests/quest_hidden_treasure_chest.dbr")
                else
                    local cPlayer = Game.GetLocalPlayer()
    
                    if(cPlayer ~= nil) then
                        if(cPlayer:GetQuestState(0x6C520F00) == QuestState.InProgress) then
                            cRaid_PhasingLords:_OpenTreasure(InChestId, "mod_wanez/_raid/phasinglords/chests/quest_hidden_treasure_chest.dbr")
            
                            --UI.Notify("State: "..cRaid_PhasingLords.bFoundHiddenTreasure)
                            cRaid_PhasingLords.bFoundHiddenTreasure = true
                            --UI.Notify("State: "..cRaid_PhasingLords.bFoundHiddenTreasure)
                        end
                    else
                        UI.Notify("{^r}DEBUG: {^w}An error occured trying to get Player!")
                    end
                end
            end;
            OnAddToWorld = function(InChestId)
                if(bIsDev) then
                    cRaid_PhasingLords:__setQuestHiddenTreasureChest(InChestId, 0)
                else
                    cRaid_PhasingLords:__setQuestHiddenTreasureChest(InChestId, 99)
                end
                
            end;
        }
    }
}
