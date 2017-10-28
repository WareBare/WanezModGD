--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/25/2017
Time: 7:20 PM

Package: 
]]--


_cScroll = false

-- used to combine new entries to clientQuestTable without editing core files
setmetatable(clientQuestTable, {
    __add = function(coreTable, newTable)
        
        for index,subTable in pairs(newTable) do
            for key,value in pairs(subTable) do
                coreTable[key] = value
            end
        end;
        return coreTable
    end
})

function wanez.scrollEntityOnDie(argObjectId)
    _cScroll:entityOnDie(argObjectId)
end

function Player:wzGiveItems(optItems)
    --UI.Notify("its working")
    --self:GiveItem(argItem,1,true)
    optItems = (type(optItems) == 'string') and {optItems} or optItems
    
    --local _player = (argObjectIdPlayer) and Player.Get(argObjectIdPlayer) or Game.GetLocalPlayer()
    --local _player = Game.GetLocalPlayer()
    
    for key,value in pairs(optItems) do
        self:GiveItem(value,1,true)
    end;
end

--- argIsComplete [default: true]
function Player:wzHasItem(argItem,argAmount,argIsComplete)
    argAmount = argAmount or 1
    argIsComplete = (argIsComplete == nil) and true or argIsComplete
    
    local hasItems = self:HasItem(argItem,argAmount,argIsComplete)
    -- check if player has exact amount of items
    if(hasItems == false)then
        local hasAmount = argAmount
        -- if thats not the case check how many items player has and give the difference to player
        while(hasItems == false) do
            hasAmount = hasAmount - 1
            if(self:HasItem(argItem,hasAmount,argIsComplete)) then
                hasItems = true
            end
        end;
        self:GiveItem(argItem,argAmount - hasAmount,argIsComplete)
    end
end
