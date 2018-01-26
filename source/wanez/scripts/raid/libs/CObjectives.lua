--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/21/2017
Time: 4:07 PM

Package: 
]]--


-- MainQuest, SideQuests
local mQuestsData = wanez.Raid.data.Quests
local mChestsData = wanez.Raid.data.Chests
local mPortalsData = wanez.Raid.data.Portals

wanez.Raid.libs.CObjectives = function()
    local _parent = wanez.Raid.libs.CPortal()
    
    local mTrackUsedTreasures = {}
    local mChests = {}
    local mTreasures = {}
    local mDoors = {}
    local mPortals = {} -- keep track of loaded portals
    local aPortals = {} -- to be able to fetch a random portal
    local aPortalLocs = {}
    
    local Quests = {}

    local bPortalsShown = false
    local bDoorWasOpened = false

    local class = {
        __constructor = function(self)
        
        end;
    
        __setQuestHiddenTreasureChest = function(self, InChestId, InChanceToDespawn)
            Quests.HiddenTreasure = Quests.HiddenTreasure or {}
    
            local cChest = Entity.Get(InChestId)
        
            if(cChest ~= nil) then
                local cPlayer = Game.GetLocalPlayer()
            
                if(cPlayer ~= nil) then
                    --if(cPlayer:GetQuestState(0x6C520F00) == QuestState.InProgress) then
            
                        if(Quests.HiddenTreasure[InChestId] == nil) then
                            self:NewRandomSeed()
                            if(random(1, 100) <= InChanceToDespawn) then
                                cChest:Destroy()
                            end
                
                            Quests.HiddenTreasure[InChestId] = true
                        end
                    --else
                        --cChest:Destroy()
                    --end
                else
                    UI.Notify("{^r}DEBUG: {^w}An error occured trying to get Player!")
                end
            else
                UI.Notify("{^r}DEBUG: {^w}An error occured trying to get the Hidden Treasure Chest!")
            end
        end;
        __setChest = function(self, InObjectId)
            local cScript = Entity.Get(InObjectId)
            
            if(cScript ~= nil) then
            
            else
                UI.Notify("{^r}DEBUG: {^w}An error occured trying to get the scriptentity!")
            end
            
        end;
        __setTreasureChest = function(self, InChestId)
            if(mTreasures[InChestId] == nil) then
                local CurrentTreasureIndex = false
                
                while CurrentTreasureIndex == false do
                    self:NewRandomSeed()
                    local RandomTreasureIndex = random(1, table.getn(mChestsData[self.RaidName].TreasureChests))
                    if(mTrackUsedTreasures[RandomTreasureIndex] ~= true) then
                        CurrentTreasureIndex = RandomTreasureIndex
                        mTrackUsedTreasures[RandomTreasureIndex] = true
                    end
                end;
            
                mTreasures[InChestId] = mChestsData[self.RaidName].TreasureChests[CurrentTreasureIndex]
            end
        end;
        
        __setDoorTreasureChamber = function(self, InDoorId)
            if(mDoors.TreasureChamber == nil) then
                local cDoor = Door.Get(InDoorId)
                if(cDoor ~= nil) then
                    mDoors.TreasureChamber = InDoorId
                end
            end
        end;
        __setDoorEntrance = function(self, InDoorId)
            if(mDoors.Entrance == nil) then
                local cDoor = Door.Get(InDoorId)
                if(cDoor ~= nil) then
                    mDoors.Entrance = InDoorId
                end
            end
        end;
        __setPortalPath = function(self, InObjectId, InLocationNumber)
        
            
            if(InLocationNumber ~= nil) then
                if(aPortalLocs[InLocationNumber] == nil) then
                    local PortalToken = mPortalsData[self.RaidName].Paths[InLocationNumber]
    
                    if(PortalToken ~= nil) then
                        local cPlayer = Game.GetLocalPlayer()
                        if(cPlayer ~= nil) then
                            if(cPlayer:HasToken(PortalToken) == false) then
                                local cScriptEntity = Entity.Get(InObjectId)
                
                                if(cScriptEntity ~= nil) then
                                    aPortalLocs[InLocationNumber] = {
                                        Token = PortalToken,
                                        ObjectId = InObjectId,
                                        Coords = cScriptEntity:GetCoords()
                                    }
                                end
                            end
                        end
                    else
                        UI.Notify("{^r}DEBUG: {^w}Could not find Path Token!")
                    end
                end
            else
                if(mPortals[InObjectId] == nil) then
                    local cPortal = Door.Get(InObjectId)
                    
                    if(cPortal ~= nil) then
                        mPortals[InObjectId] = false
                        table.insert(aPortals, InObjectId)
                    else
                        UI.Notify("{^r}DEBUG: {^w}unable to .Get Portal!")
                    end
                end
            end
        end;
    
        _OpenTreasure = function(self, InChestId, InOrbDBR)
            local cChest = Door.Get(InChestId)
        
            if(cChest ~= nil) then
                cChest:Open()
                cChest:SetLocked(false)
            
                local cDestructible = Destructible.Create(InOrbDBR)
                local cDestroyer = Entity.Create("mod_wanez/skills/destroying_entity.dbr")
    
                if(cDestructible ~= nil and cDestroyer ~= nil) then
                    cDestructible:SetCoords( cChest:GetCoords() )
                    cDestroyer:SetCoords( cChest:GetCoords() )
                    --cDestructible:Destroy(nil, 4.0, true)
                
                    --UI.Notify("{^r}DEBUG: {^w}No Crash")
                    --cDestructible:Destroy()
                else
                    UI.Notify("{^r}DEBUG: {^w}Unable to create Destructible")
                end
            else
                UI.Notify("{^r}DEBUG: {^w}Unable to get Chest")
            end
        end;
        
        ShowPortalsPath = function(self)
            
            if(bPortalsShown == false) then
                local bContinueLoop = false
                local PortalId;
                local cPortal;
    
                self:NewRandomSeed()
                for kLocId, vLocData in pairs(aPortalLocs) do
                    bContinueLoop = true
        
                    while bContinueLoop == true do
                        PortalId = aPortals[random(1, table.getn(aPortals))]
            
                        if(mPortals[PortalId] == false) then
                            cPortal = Door.Get(PortalId)
                
                            if(cPortal ~= nil) then
                                cPortal:SetCoords(vLocData.Coords)
                                mPortals[PortalId] = vLocData.Token
                    
                                bContinueLoop = false
                            else
                                UI.Notify("{^r}DEBUG: {^w}unable to .Get Portal!")
                            end
            
                        end
                    end
                end
    
                bPortalsShown = true
            end
            
        end;
        RemovePortalPath = function(self, InPortalId)
            
            local cPortal = Door.Get(InPortalId)
            if(cPortal ~= nil) then
                cPortal:Destroy()
                GiveTokenToLocalPlayer(mPortals[InPortalId])
            else
                UI.Notify("{^r}DEBUG: {^w}unable to .Get Portal!")
            end
        end;
        
        CheckPlayerIsOnMainQuest = function(self)
            local bPlayerIsOnMainQuest;
            
            local cPlayer = Game.GetLocalPlayer()
    
            if(cPlayer ~= nil and mQuestsData[self.RaidName] ~= nil) then
        
                if(cPlayer:GetQuestState(mQuestsData[self.RaidName].MainQuest[1]) == QuestState.InProgress) then
                    bPlayerIsOnMainQuest = true
                else
                    bPlayerIsOnMainQuest = false
                end
            end
            
            return bPlayerIsOnMainQuest
        end;
        GrantPlayerRaidQuests = function(self)
            local cPlayer = Game.GetLocalPlayer()
            
            if(cPlayer ~= nil and mQuestsData[self.RaidName] ~= nil) then
                
                if(cPlayer:HasItem(mQuestsData[self.RaidName].KeyDBR, 1, false)) then
                    -- Remove Token
                    if(mPortalsData[self.RaidName].Paths) then
                        for kKey,vToken in pairs(mPortalsData[self.RaidName].Paths) do
                            RemoveTokenFromLocalPlayer(vToken)
                        end
                    end
                    
                    -- Grant MainQuest
                    cPlayer:GrantQuest(mQuestsData[self.RaidName].MainQuest[1], mQuestsData[self.RaidName].MainQuest[2])
    
                    -- Grant missing SideQuests
                    if(mQuestsData[self.RaidName].SideQuests) then
                        for kSideQuestId, kSideQuestData in pairs(mQuestsData[self.RaidName].SideQuests) do
                            if(cPlayer:GetQuestState(kSideQuestData[1]) ~= QuestState.InProgress) then
                                cPlayer:GrantQuest(kSideQuestData[1], kSideQuestData[2])
                            end
                        end;
                    end
                    
                    cPlayer:TakeItem( mQuestsData[self.RaidName].KeyDBR, 1, false )
                else
                    if(mQuestsData[self.RaidName].Error_MissingKey) then
                        UI.Notify(mQuestsData[self.RaidName].Error_MissingKey)
                    else
                        UI.Notify("{^r}DEBUG: {^w}No Error set for missing key!")
                    end
                    
                end
                
            end
        end;
        OpenEntranceDoor = function(self)
            if( self:CheckPlayerIsOnMainQuest() ) then
                local cDoor = Door.Get(mDoors.Entrance)
                
                if(cDoor ~= nil) then
                    cDoor:SetLocked(false)
                    cDoor:Open()
                    bDoorWasOpened = true
                else
                    UI.Notify("{^r}DEBUG: {^w}Unable to Get Entrance Door!")
                end
            end
        end;
        CloseDoorEntrance = function()
            local cDoor = Door.Get(mDoors.Entrance)
        
            if(cDoor ~= nil) then
                cDoor:SetLocked(true)
                cDoor:Close()
            else
                UI.Notify("{^r}DEBUG: {^w}Unable to Get Entrance Door!")
            end
        end;
        
        StartNewRaid = function(self, bRequiresUltimate)
            local bAllowRaid = false
        
            if(bRequiresUltimate) then
                if(Game.GetGameDifficulty() == Game.Difficulty.Legendary) then
                    bAllowRaid = true
                end
            else
                bAllowRaid = true
            end
            
            if(bAllowRaid) then
                if( self:CheckPlayerIsOnMainQuest() == false and bDoorWasOpened == false ) then
                    self:GrantPlayerRaidQuests()
                    self:OpenEntranceDoor()
                elseif(bDoorWasOpened == true) then
                    UI.Notify("tagWzRaid_Lua_AlreadyOpened_Door_NOTIFY")
                end
            end
        end;
        
        OpenTreasureChamber = function(self, InEnemyId)
            local cDoor = Door.Get(mDoors.TreasureChamber)
        
            if(cDoor ~= nil) then
                cDoor:SetLocked(false)
                cDoor:Open()
            end
        end;
        DropTreasureKey = function(self, InEnemyId)
            local cPlayer = Game.GetLocalPlayer()
            
            if(cPlayer ~= nil)then
                cPlayer:GiveItem(mChestsData[self.RaidName].KeyDBR, 1, true)
                UI.Notify("tagWzRaid_Lua_Received_TreasureKey_NOTIFY")
            else
                UI.Notify("{^r}DEBUG: {^w}An error occurred trying to get the player")
            end
        end;
        
        OpenTreasureChest = function(self, InChestId)
            if(mTreasures[InChestId]) then
                
                if(bIsDev) then
                    self:_OpenTreasure(InChestId, mTreasures[InChestId])
                else
                    local cPlayer = Game.GetLocalPlayer()
    
                    if(cPlayer ~=nil) then
                        if(cPlayer:HasItem(mChestsData[self.RaidName].KeyDBR, 1, true)) then
                            self:_OpenTreasure(InChestId, mTreasures[InChestId])
            
                            cPlayer:TakeItem(mChestsData[self.RaidName].KeyDBR, 1, true)
                        else
                            UI.Notify("tagWzRaid_Lua_Treasure_RequiresKey_NOTIFY")
                        end
                    end
                end
                
                
            elseif(mTreasures[InChestId] == false) then
                UI.Notify("tagWzRaid_Lua_AlreadyOpened_Chest_NOTIFY")
            else
                UI.Notify("{^r}DEBUG: {^w}Unable to find Treasure Data")
            end
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
