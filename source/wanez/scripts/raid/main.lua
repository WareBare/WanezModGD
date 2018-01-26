--[[
Created by IntelliJ IDEA.
User: Ware
Date: 12/20/2017
Time: 10:42 PM

Package: 
]]--


-- Raid instance
cRaid_PhasingLords = wanez.Raid.libs.CCore("PhasingLords")

-- dynamically change if there is going to be another Raid
cRaid = cRaid_PhasingLords

wanez.Raid.main = {
    Dev = {
        GiveKeys = function()
            if(bIsDev) then
                local cPlayer = Game.GetLocalPlayer()
    
                if(cPlayer ~= nil) then
                    cPlayer:GiveItem("mod_wanez/_events/phasing/items/craft_phasingkey.dbr", 1, false)
                    cPlayer:GiveItem("records/omega/items/questitems/omega_essence_legendary.dbr", 10, false)
                    
                end
            end
        end;
    },
    Trigger = {
    
    }
}

wanez.Raid.main.QuestChecker = {}
function wanez.Raid.main.QuestChecker.PhasingLords_HiddenTreasure()
    return cRaid_PhasingLords.bFoundHiddenTreasure
end
