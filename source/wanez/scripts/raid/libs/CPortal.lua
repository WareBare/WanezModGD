--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/20/2017
Time: 11:21 PM

Package: 
]]--

wanez.Raid.libs.CPortal = function()
    local _parent = wanez.Raid.libs.CBase()
    
    local mPortals = {};
    local mPortalDestinations = {};

    local class = {
        __constructor = function(self)
        
        end;
        
        --- GETTERS & SETTERS
        __setPortal = function(self, InKey, InPortalId, InDestinationKey)
            if(mPortals[InKey]) then
                UI.Notify("{^r}DEBUG: {^w}Portal already saved")
            else
                local _Portal = Door.Get(InPortalId)
                if(_Portal ~= nil) then
                    mPortals[InKey] = {}
                    mPortals[InKey].ObjectId = InPortalId
                    mPortals[InKey].OriginCoords = _Portal:GetCoords()
                    mPortals[InKey].DestinationKey = InDestinationKey
                    mPortals[InKey].bIsAtOrigin = true
                else
                    UI.Notify("{^r}DEBUG: {^w}Portal could not be saved")
                end
            end
        end;
        __setPortalDestination = function(self, InKey, InObjectId)
            if(mPortalDestinations[InKey]) then
                UI.Notify("{^r}DEBUG: {^w}Destination already saved")
            else
                local _Entity = Entity.Get(InObjectId)
                if(_Entity ~= nil) then
                    mPortalDestinations[InKey] = _Entity:GetCoords()
                else
                    UI.Notify("{^r}DEBUG: {^w}Destination could not be saved")
                end
            end
        end;
        
        
        --- EVENTS
        
        --- Move Portal to Origin or Destination coords, also possible to set coords where the portal should be moved to
        -- @param InKey - key used in tables to access data (OriginCoords, bIsAtOrigin, ObjectId, DestinationKey)
        -- @param InOpt - options
        --         > MoveTo - Forces the portal to be moved to these coords
        --         > bForceMoveToOrigin - Forces the portal to be moved to its origin
        MovePortal = function(self, InKey, InOpt, InMoveCoords)
            InMoveCoords = InMoveCoords or false
            InOpt = InOpt or {}
            InOpt["MoveTo"] = false
            InOpt["bForceMoveToOrigin"] = false
        
            local _Portal = Door.Get(mPortals[InKey].ObjectId)
            if(_Portal ~= nil) then
                if(InOpt["MoveTo"] ~= false) then
                    -- Move to param Coords
                    _Portal:SetCoords( InMoveCoords )
                elseif(InOpt["bForceMoveToOrigin"] ~= nil or mPortals[InKey].bIsAtOrigin == false) then
                    -- Move to Origin Coords
                    _Portal:SetCoords( mPortals[InKey].OriginCoords )
                    mPortals[InKey].bIsAtOrigin = true
                else
                    -- Move to Destination Coords
                    _Portal:SetCoords( mPortalDestinations[mPortals[InKey].DestinationKey] )
                    mPortals[InKey].bIsAtOrigin = false
                end
            end
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end

