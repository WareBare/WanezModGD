--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/20/2017
Time: 11:10 PM

Package: 
]]--

local RandomSeedTime = 0

wanez.Raid.libs.CBase = function()
    
    --local RaidName;
    
    local class = {
        RaidName = false;
        
        __constructor = function(self)
        
        end;
        
        NewRandomSeed = function(self, bInForceUpdate)
            bInForceUpdate = bInForceUpdate or false
            if( (Time.Now() - RandomSeedTime) >= (60000 * 5) or bInForceUpdate == true ) then
                RandomSeedTime = Time.Now()
                math.randomseed( RandomSeedTime );
                --UI.Notify("{^r}DEBUG: {^w}Reset Random Seed")
            end
        end;
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
