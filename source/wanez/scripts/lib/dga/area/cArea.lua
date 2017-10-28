--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/27/2017
Time: 2:38 PM

Package: area
]]--


function wanez.DGA.area.cArea(argRegionId,argAreaId,argVariation,optData)
    local _parent = wanez.DGA.area.cBase(argRegionId,argAreaId,optData)
    
    local class = {
        areaType = "Default";
        __constructor = function(self)
        end;
    }
    
    setmetatable(class,{__index=_parent})
    class:__constructor()
    return class
end
