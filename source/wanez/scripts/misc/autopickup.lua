--[[
Created by IntelliJ IDEA.
User: Ware
Date: 10/31/2017
Time: 6:15 AM

Package: AutoPickUp
]]--

wanez.AutoPickUp = {}

local AutoPickUpToken = "WZ_AUTOPICKUP_DISABLED"
local bMaySetPlayer = false
local _PlayerToGetItem = false
local ItemDBR = false
wanez.AutoPickUp.OnDrop = function(InDropperId, InItemId)
    --local _Item = Entity.Get(InItemId)
    --UI.Notify("OnDrop -|- ".._Item:GetName())
    
    if(Game.GetLocalPlayer():HasToken(AutoPickUpToken) == false) then
        _PlayerToGetItem = false;
    
        if(bMaySetPlayer) then _PlayerToGetItem = Player.Get(InDropperId) end
    
        bMaySetPlayer = false
    end
end

wanez.AutoPickUp.OnPickUp = function(InLooterId, InItemId)
    --local _Item = Entity.Get(InItemId)
    --UI.Notify("OnPickUp -|- ".._Item:GetName())
    if(Game.GetLocalPlayer():HasToken(AutoPickUpToken) == false) then
    end
end

wanez.AutoPickUp.OnAddToWorld = function(InItemId)
    if(Game.GetLocalPlayer():HasToken(AutoPickUpToken) == false) then
        _PlayerToGetItem = false;
        bMaySetPlayer = true;
        --local PlayerCount = Game.GetNumPlayers();
        local _Item = Entity.Get(InItemId)
        --UI.Notify("OnAddToWorld -|- ".._Item:GetName())
        ItemDBR = _Item:GetName();
    
        --_PlayerToGetItem = Game.GetPlayer(random(1,PlayerCount) - 1)
    
        _Item:Destroy();
    end
end

--[[

]]
wanez.AutoPickUp.OnDestroy = function()
    if(Game.GetLocalPlayer():HasToken(AutoPickUpToken) == false) then
        if(ItemDBR and _PlayerToGetItem) then
            _PlayerToGetItem:GiveItem(ItemDBR,1,true);
        elseif(ItemDBR) then
            local bGiveItem = false
            local bGiveDynamite = false
        
            wanez.GlobalRandomSeed();
            if(ItemDBR == "records/items/materia/compa_aethercrystal.dbr") then
                bGiveItem = true;
                if(random(1,100) <= 20) then
                    bGiveDynamite = true
                end
            elseif(string.find(ItemDBR, "records/items/materia/comp")) then
                if(random(1,100) <= 25) then
                    bGiveItem = true;
                    if(random(1,100) <= 1) then
                        bGiveDynamite = true
                    end
                else
                    --UI.Notify("Chance roll failed for Component :(")
                end
            else
                bGiveItem = true;
                if(random(1,100) <= 5) then
                    bGiveDynamite = true
                end
            end
        
            if(bGiveItem) then
                local PlayerCount = Game.GetNumPlayers();
                _PlayerToGetItem = Game.GetPlayer(random(1,PlayerCount) - 1)
                _PlayerToGetItem:GiveItem(ItemDBR,1,true);
            
                UI.Notify("tagWzAutoPickUp_Lua_ReceivedItem")
            
                if(ItemDBR == "records/items/materia/compa_aethercrystal.dbr") then
                    _PlayerToGetItem:GiveItem("records/items/questitems/quest_dynamite.dbr",1,false)
                end
            end
    
        end
    
        _PlayerToGetItem = false
        ItemDBR = false
    end
end

function wanez.AutoPickUp.ChangeState(bInEnable)
    if(bInEnable) then
        RemoveTokenFromLocalPlayer(AutoPickUpToken)
    else
        GiveTokenToLocalPlayer(AutoPickUpToken)
    end
end
