--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/7/2017
Time: 10:40 PM

Package: 
]]--

function wanez.cScroll(optActions,fnCallback)
    local _parent = wanez.cBase()
    
    --local aActions = optActions or {}
    optActions = optActions or {}
    
    local class = {
        __constructor = function(self)
        
        end;
        __callback = fnCallback;
        entityOnDie = function(self,argObjectId)
            --argCallbackFn()
            local aActions = self.__callback(self) or {}
            
            setmetatable(aActions,{__index = optActions})
            
            if(aActions.giveItems)then
                self:giveItems(aActions.giveItems)
            end
            if(aActions.notify)then
                UI.Notify(aActions.notify)
            end
        end
    }
    
    setmetatable(class,{__index = _parent})
    class:__constructor()
    return class
end
