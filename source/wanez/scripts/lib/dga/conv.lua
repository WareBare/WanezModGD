--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/6/2017
Time: 4:01 AM

Package: 
]]--

--local _cDifficulty = wanez.DGA.cDifficulty()
local addToClientQuestTable = {
    wzDGA_setModeDefault = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_MODE")
        local _cDifficulty = wanez.DGA.cDifficulty()
    end;
    wzDGA_setModeDGA = function()
        GiveTokenToLocalPlayer("WZ_DGA_MODE")
        local _cDifficulty = wanez.DGA.cDifficulty(2)
    end;
    wzDGA_setDifficulty01 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(1)
    end;
    wzDGA_setDifficulty02 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(2)
    end;
    wzDGA_setDifficulty03 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(3)
    end;
    wzDGA_setDifficulty04 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(4)
    end;
    wzDGA_setDifficulty05 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(5)
    end;
    wzDGA_setDifficulty06 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(6)
    end;
    wzDGA_setDifficulty07 = function()
        local _cDifficulty = wanez.DGA.cDifficulty(7)
    end;
    
    wzDGA_setDifficultyNext = function()
        local _cDifficulty = wanez.DGA.cDifficulty(true)
    end;
}

table.insert(wanez.MP,addToClientQuestTable)
