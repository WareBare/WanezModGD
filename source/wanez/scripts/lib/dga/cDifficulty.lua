--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 2/8/2017
Time: 4:39 AM

Package: 
]]--

function wanez.DGA.cDifficulty(intDifficulty)
    intDifficulty = intDifficulty or false
    
    local _parent = wanez.DGA.cBase()
    local aMonsterPower = wanez.DGA.aData.monsterPower.difficulties
    local _parent2 = wanez.cQuest({
        {aMonsterPower[1].quest[1],{aMonsterPower[1].quest[2]}},
        {aMonsterPower[2].quest[1],{aMonsterPower[2].quest[2]}},
        {aMonsterPower[3].quest[1],{aMonsterPower[3].quest[2]}},
        {aMonsterPower[4].quest[1],{aMonsterPower[4].quest[2]}},
        {aMonsterPower[5].quest[1],{aMonsterPower[5].quest[2]}},
        {aMonsterPower[6].quest[1],{aMonsterPower[6].quest[2]}},
        {aMonsterPower[7].quest[1],{aMonsterPower[7].quest[2]}}
    })
    setmetatable(_parent,{__index=_parent2})

    local tplToken = "WZ_DGA_MP_DIFFICULTY_{DIFF_ID_2}"
    
    local class = {
        __constructor = function(self)
            if(type(intDifficulty) == 'number') then
                self:unsetDifficulty(intDifficulty)
                self:setDifficulty(intDifficulty)
            elseif(intDifficulty) then
                self:nextDifficulty()
            elseif(intDifficulty == false) then
                self:unsetDifficulty()
            end
            --self:unsetDifficulty(false,true)
        end;
        setDifficulty = function(self,argDifficulty)
            self:startQuest(argDifficulty)
        end;
        nextDifficulty = function(self)
            local _player = Game.GetLocalPlayer()
            for key,value in pairs(aMonsterPower) do
                if(_player:HasToken(value.token) == false) then
                    self:startQuest(key)
                end
            end;
        end;
        unsetDifficulty = function(self,argDifficulty,argRemoveAll)
            argDifficulty = argDifficulty or false
            argRemoveAll = argRemoveAll or false
            --argIsDefault = argIsDefault or false
            for i=1,7 do
                if(argDifficulty == i or argRemoveAll) then
                    RemoveTokenFromLocalPlayer(self:str_replace( tplToken,{ DIFF_ID_2 = self:parseIntToString(argDifficulty,1) } ))
                else
                    GiveTokenToLocalPlayer(self:str_replace( tplToken,{ DIFF_ID_2 = self:parseIntToString(i,1) } ))
                end
            end;
        end;
    }
    
    setmetatable(class,{ __index = _parent})
    class:__constructor()
    return class
end
