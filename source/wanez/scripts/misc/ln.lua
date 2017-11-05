--[[
Created by IntelliJ IDEA.
User: Ware
Date: 10/30/2017
Time: 11:01 PM

Package: LN (Legendary Notify)
]]--


wanez.LN = {}

local tracker = {}

--[[
create a new Entity for MapNugget
@param InCoords Item Coords
@param InClassificationId - Legendary: 1; Epic: 2

@return mapEntity ID to destroy it if item is picked up
]]
local function createMapEntity(InCoords, InClassificationId)
    local _mapEntity;
    
    if(InClassificationId == 1) then
        _mapEntity = Entity.Create("mod_wanez/_ln/entity_notify_legendary.dbr")
    elseif(InClassificationId == 2) then
        _mapEntity = Entity.Create("mod_wanez/_ln/entity_notify_epic.dbr")
    else
        _mapEntity = Entity.Create("mod_wanez/_ln/entity_notify_legendary.dbr")
    end

    _mapEntity:SetCoords(InCoords)
    
    return _mapEntity
end

--[[
When Item drops it is added to the world and this function is called
@param InObjectId Item ID
@param InClassificationId - Legendary: 1; Epic: 2
]]
local function OnAddToWorld(InObjectId, InClassificationId)
    if(tracker[InObjectId]) then
        -- things to do if item was added to the list before
    else
        local _item = Entity.Get(InObjectId)
        local coords = _item:GetCoords()
    
        local _entity = createMapEntity(coords,InClassificationId)
        tracker[InObjectId] = _entity:GetId()
    end

end

--[[
When Item is picked up the MapNugget is destroyed (using onRemoveFromWorld)
@param InObjectId Item ID
]]
local function OnPickUp(InObjectId)
    if(tracker[InObjectId]) then
        Entity.Get(tracker[InObjectId]):Destroy()
        tracker[InObjectId] = nil
    end
end


wanez.LN.OnAddToWorld_Legendary = function(InObjectId)
    OnAddToWorld(InObjectId, 1)
end
wanez.LN.OnAddToWorld_Epic = function(InObjectId)
    OnAddToWorld(InObjectId, 2)
end


wanez.LN.OnPickUp_Legendary = function(InObjectId)
    OnPickUp(InObjectId)
end
wanez.LN.OnPickUp_Epic = function(InObjectId)
    OnPickUp(InObjectId)
end
