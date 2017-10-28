--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/24/2017
Time: 8:25 AM

Package: area
]]--

function wanez.DGA.area.cPortal(argObjectIdPortal)
    local _parent = wanez.DGA.cBase()

    local portalCharges = 0

    local class = {
        objectIdPortal = argObjectIdPortal;
        isCasual = false;
        
        __constructor = function(self)
            self._Portal = Door.Get(self.objectIdPortal)
            self.coordsHidden = self._Portal:GetCoords()
        end;
        
        movePortal = function(self,argCoords)
            argCoords = argCoords or self.coordsHidden
            self._Portal:SetCoords(argCoords)
        end;
        lockPortal = function(self,argLocked)
            argLocked = argLocked or false
            self._Portal:SetLocked(argLocked)
        end;
        showPortal = function(self,argCoords)
            self:movePortal(argCoords)
            self:lockPortal(false)
    
            portalCharges =  Game.GetNumPlayers()
        end;
        hidePortal = function(self,argOverride)
            argOverride = argOverride or false
            if(self.isCasual == false) then portalCharges = portalCharges - 1 end;
            if(portalCharges == 0 or argOverride) then
                self:movePortal()
                self:lockPortal(true)
            end
        end;
    }
    
    setmetatable(class,{ __index = _parent })
    class:__constructor()
    return class
end

