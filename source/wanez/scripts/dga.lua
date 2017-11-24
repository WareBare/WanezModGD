--[[
Created by IntelliJ IDEA.
User: WareBare
Date: 1/20/2017
Time: 4:54 PM


can be used from _cSettings, or any other instance
    static _activeArea => wanez.DGA.cBase:getArea()

requires: _cMission; _cEndless; _cChallenge; _cRaid
    protected areaId
    protected variationId
    protected questId
    protected taskId

SubMod: DGA
]]--
local _cSettings = wanez.DGA.cSettings()
--local _cMission = false
--local _cChallenge = false
--local _cRaid = false
local _cType = false
local _cBossRoom = wanez.DGA.area.cBossRoom()
local tokenPortalDefault = 'WZ_DGA_ALLOW_PORTAL_DEFAULT'
local portalOpener = false
local rewardId = 0
local nextAreaId = 0
--local mapTier = 0

local function devOnlyFn()
    if(wanez.isDev)then
        local player = Game.GetLocalPlayer()
        local playerCoords = player:GetCoords()
        local mainPath = 'mod_wanez/dev/'
        local godModeItems = {
            '0000_accessoryset_necklace',
            '0000_accessoryset_ring01',
            '0000_accessoryset_ring02',
            '0000_accessoryset_waist',
            '0000_armourset_feet',
            '0000_armourset_hands',
            '0000_armourset_head',
            '0000_armourset_legs',
            '0000_armourset_shoulders',
            '0000_armourset_torso',
            '0000_armourset_waist',
            '0000_weapon_scepter001',
            '0000_weapon_focus001'
        }
        for i=1,table.getn(godModeItems) do
            local newItem = Entity.Create(mainPath..godModeItems[i]..'.dbr')
            newItem:SetCoords(playerCoords)
        end
        player:GiveItem("mod_wanez/_dga/items/currency/a_001b.dbr",100,true)
        player:GiveItem("mod_wanez/currency/a_001b.dbr",100,true)
        player:GiveItem("mod_wanez/currency/b_001b.dbr",100,true)
    end
end
local function giveComponents(argPlayer)
    local aMateria = {
        'records/items/materia/compa_aethersoul.dbr',
        'records/items/materia/compa_aethersteelalloy.dbr',
        'records/items/materia/compa_aethersteelbolts.dbr',
        'records/items/materia/compa_amber.dbr',
        'records/items/materia/compa_ballisticplating.dbr',
        'records/items/materia/compa_batteredshell.dbr',
        'records/items/materia/compa_blacktallow.dbr',
        'records/items/materia/compa_blessedsteel.dbr',
        'records/items/materia/compa_bristlyfur.dbr',
        'records/items/materia/compa_chilledsteel.dbr',
        'records/items/materia/compa_chippedclaw.dbr',
        'records/items/materia/compa_coldstone.dbr',
        'records/items/materia/compa_consecratedwrappings.dbr',
        'records/items/materia/compa_corpsedust.dbr',
        'records/items/materia/compa_crackedlodestone.dbr',
        'records/items/materia/compa_deathchillbolts.dbr',
        'records/items/materia/compa_densefur.dbr',
        'records/items/materia/compa_ectoplasm.dbr',
        'records/items/materia/compa_festeringblood.dbr',
        'records/items/materia/compa_flint.dbr',
        'records/items/materia/compa_flintcorebolts.dbr',
        'records/items/materia/compa_focusingprism.dbr',
        'records/items/materia/compa_frozenheart.dbr',
        'records/items/materia/compa_gallstone.dbr',
        'records/items/materia/compa_hellbaneammo.dbr',
        'records/items/materia/compa_hollowedfang.dbr',
        'records/items/materia/compa_imbuedsilver.dbr',
        'records/items/materia/compa_leatheryhide.dbr',
        'records/items/materia/compa_markofillusions.dbr',
        'records/items/materia/compa_markofthetraveler.dbr',
        'records/items/materia/compa_moltenskin.dbr',
        'records/items/materia/compa_mutagenicichor.dbr',
        'records/items/materia/compa_mutatedscales.dbr',
        'records/items/materia/compa_polishedemerald.dbr',
        'records/items/materia/compa_purifiedsalt.dbr',
        'records/items/materia/compa_radiantgem.dbr',
        'records/items/materia/compa_reinforcedshell.dbr',
        'records/items/materia/compa_resilientchestplate.dbr',
        'records/items/materia/compa_restlessremains.dbr',
        'records/items/materia/compa_riftstone.dbr',
        'records/items/materia/compa_rigidshell.dbr',
        'records/items/materia/compa_rottenheart.dbr',
        'records/items/materia/compa_runestone.dbr',
        'records/items/materia/compa_sanctifiedbone.dbr',
        'records/items/materia/compa_scalyhide.dbr',
        'records/items/materia/compa_scavengedplating.dbr',
        'records/items/materia/compa_searingember.dbr',
        'records/items/materia/compa_serratedspike.dbr',
        'records/items/materia/compa_severedclaw.dbr',
        'records/items/materia/compa_silkswatch.dbr',
        'records/items/materia/compa_soulshard.dbr',
        'records/items/materia/compa_spinedcarapace.dbr',
        'records/items/materia/compa_vengefulwraith.dbr',
        'records/items/materia/compa_venomtippedammo.dbr',
        'records/items/materia/compa_viciousjawbone.dbr',
        'records/items/materia/compa_viciousspikes.dbr',
        'records/items/materia/compa_viscousvenom.dbr',
        'records/items/materia/compa_voidtouchedammo.dbr',
        'records/items/materia/compa_wardstone.dbr',
        'records/items/materia/compa_whetstone.dbr',
        'records/items/materia/compa_wrathstone.dbr',
        'records/items/materia/compb_ancientarmorplate.dbr',
        'records/items/materia/compb_arcanediamond.dbr',
        'records/items/materia/compb_arcanelens.dbr',
        'records/items/materia/compb_arcanespark.dbr',
        'records/items/materia/compb_beronath.dbr',
        'records/items/materia/compb_bindingsofbysmiel.dbr',
        'records/items/materia/compb_bloodywhetstone.dbr',
        'records/items/materia/compb_chainsofoleron.dbr',
        'records/items/materia/compb_deviltouchedammo.dbr',
        'records/items/materia/compb_dreadskull.dbr',
        'records/items/materia/compb_hallowedground.dbr',
        'records/items/materia/compb_hauntedsteel.dbr',
        'records/items/materia/compb_kilriansoul.dbr',
        'records/items/materia/compb_lodestone.dbr',
        'records/items/materia/compb_markofdreeg.dbr',
        'records/items/materia/compb_markofmogdrogen.dbr',
        'records/items/materia/compb_markofthemyrmidon.dbr',
        'records/items/materia/compb_oleronblood.dbr',
        'records/items/materia/compb_silvercorebolts.dbr',
        'records/items/materia/compb_spellwoventhreads.dbr',
        'records/items/materia/compb_symbolofsolael.dbr',
        'records/items/materia/compb_unholyinscription.dbr'
    }
    
    for index,dbr in pairs(aMateria) do
        argPlayer:wzHasItem(dbr,1)
    end;
end
local function removeOldItems(argPlayer)
    
    local pathOrbDGA = 'mod_wanez/_dga/items/currency/a_001b.dbr'
    local pathOrbPlanar = 'mod_wanez/_dga/items/currency/a_002b.dbr'
    local pathEssence = 'mod_wanez/currency/a_001b.dbr'
    local pathSoul = 'mod_wanez/currency/b_001b.dbr'
    local planarScrap = 'mod_wanez/_gear/materials/a_001a.dbr'
    
    local aItems = {
        {'mod_wanez/items/dga/comp_elite_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/comp_elite_02.dbr',{pathOrbDGA,2}},
        {'mod_wanez/items/dga/comp_elite_03.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/comp_elite_04.dbr',{pathOrbDGA,4}},
        {'mod_wanez/items/dga/comp_elite_05.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/comp_elite_06.dbr',{pathOrbDGA,6}},
        {'mod_wanez/items/dga/comp_elite_07.dbr',{pathOrbDGA,7}},
        {'mod_wanez/items/dga/comp_elite_08.dbr',{pathOrbDGA,8}},
        {'mod_wanez/items/dga/comp_elite_09.dbr',{pathOrbDGA,9}},
        {'mod_wanez/items/dga/comp_elite_10.dbr',{pathOrbDGA,10}},
        {'mod_wanez/items/dga/comp_normal_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/comp_normal_02.dbr',{pathOrbDGA,2}},
        {'mod_wanez/items/dga/comp_normal_03.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/comp_normal_04.dbr',{pathOrbDGA,4}},
        {'mod_wanez/items/dga/comp_normal_05.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/comp_ultimate_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/comp_ultimate_02.dbr',{pathOrbDGA,2}},
        {'mod_wanez/items/dga/comp_ultimate_03.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/comp_ultimate_04.dbr',{pathOrbDGA,4}},
        {'mod_wanez/items/dga/comp_ultimate_05.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/comp_ultimate_06.dbr',{pathOrbDGA,6}},
        {'mod_wanez/items/dga/comp_ultimate_07.dbr',{pathOrbDGA,7}},
        {'mod_wanez/items/dga/comp_ultimate_08.dbr',{pathOrbDGA,8}},
        {'mod_wanez/items/dga/comp_ultimate_09.dbr',{pathOrbDGA,9}},
        {'mod_wanez/items/dga/comp_ultimate_10.dbr',{pathOrbDGA,10}},
        {'mod_wanez/items/dga/key_elite_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/key_elite_02.dbr',{pathOrbDGA,2}},
        {'mod_wanez/items/dga/key_elite_03.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/key_elite_04.dbr',{pathOrbDGA,4}},
        {'mod_wanez/items/dga/key_elite_05.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/key_elite_06.dbr',{pathOrbDGA,6}},
        {'mod_wanez/items/dga/key_elite_07.dbr',{pathOrbDGA,7}},
        {'mod_wanez/items/dga/key_elite_08.dbr',{pathOrbDGA,8}},
        {'mod_wanez/items/dga/key_elite_09.dbr',{pathOrbDGA,9}},
        {'mod_wanez/items/dga/key_elite_10.dbr',{pathOrbDGA,10}},
        {'mod_wanez/items/dga/key_normal_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/key_normal_02.dbr',{pathOrbDGA,2}},
        {'mod_wanez/items/dga/key_normal_03.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/key_normal_04.dbr',{pathOrbDGA,4}},
        {'mod_wanez/items/dga/key_normal_05.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/key_ultimate_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/key_ultimate_02.dbr',{pathOrbDGA,2}},
        {'mod_wanez/items/dga/key_ultimate_03.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/key_ultimate_04.dbr',{pathOrbDGA,4}},
        {'mod_wanez/items/dga/key_ultimate_06.dbr',{pathOrbDGA,6}},
        {'mod_wanez/items/dga/key_ultimate_05.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/key_ultimate_07.dbr',{pathOrbDGA,7}},
        {'mod_wanez/items/dga/key_ultimate_08.dbr',{pathOrbDGA,8}},
        {'mod_wanez/items/dga/key_ultimate_09.dbr',{pathOrbDGA,9}},
        {'mod_wanez/items/dga/key_ultimate_10.dbr',{pathOrbDGA,10}},
        {'mod_wanez/items/dga/key_reward_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/key_reward_02.dbr',{pathOrbDGA,3}},
        {'mod_wanez/items/dga/key_reward_03.dbr',{pathOrbDGA,5}},
        {'mod_wanez/items/dga/misc_omega_lvlup.dbr',{pathOrbPlanar,1}},
        {'mod_wanez/items/dga/special_01_comp.dbr',{pathOrbPlanar,1}},
        {'mod_wanez/items/dga/special_01_key.dbr',{pathOrbPlanar,1}},
        {'mod_wanez/items/dga/special_01b_comp.dbr',{pathOrbPlanar,1}},
        {'mod_wanez/items/dga/special_01b_key.dbr',{pathOrbPlanar,1}},
        {'mod_wanez/items/dga/special_01b_material.dbr',{pathOrbPlanar,1}},
        {'mod_wanez/items/dga/upgrade_token_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/upgrade_token_elite_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/upgrade_token_normal_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/dga/upgrade_token_ultimate_01.dbr',{pathOrbDGA,1}},
        {'mod_wanez/items/token/souls/soul_aethercrystal.dbr',{pathSoul,1}},
        {'mod_wanez/items/token/souls/soul_boss.dbr',{pathSoul,3}},
        {'mod_wanez/items/token/souls/soul_champion.dbr',{pathSoul,1}},
        {'mod_wanez/items/token/souls/soul_common.dbr',{pathSoul,1}},
        {'mod_wanez/items/token/souls/soul_hero.dbr',{pathSoul,2}},
        {'mod_wanez/items/token/souls/soul_nemesis.dbr',{pathSoul,3}},
        {'mod_wanez/items/token/souls/soul_raid.dbr',{pathSoul,5}},
        {'mod_wanez/items/token/souls/soul_souleater.dbr',{pathSoul,5}},
        {'mod_wanez/items/token/souls/soul_uber.dbr',{pathSoul,5}},
        {'mod_wanez/items/token/upgrade_token_beginner.dbr',{planarScrap,1}},
        {'mod_wanez/items/token/currency_normal_01.dbr',{planarScrap,1}},
        {'mod_wanez/items/token/currency_normal_02.dbr',{planarScrap,2}},
        {'mod_wanez/items/token/currency_normal_03.dbr',{planarScrap,3}},
        {'mod_wanez/items/token/currency_normal_04.dbr',{planarScrap,4}},
        {'mod_wanez/items/token/currency_normal_05.dbr',{planarScrap,5}},
        {'mod_wanez/items/token/currency_normal_tradable.dbr',{planarScrap,1}}
    }
    
    local isWhile = true
    local showNotify = false

    for index,data in pairs(aItems) do
        isWhile = true
    
        while(isWhile) do
            if(argPlayer:HasItem(data[1],1,true))then
                argPlayer:TakeItem(data[1],1,true)
                argPlayer:GiveItem(data[2][1],data[2][2],true)
                showNotify = true
            else
                isWhile = false
            end
        end;
        
    end;
    
    if(showNotify)then
        UI.Notify("tagWzDGA_LuaNotify_RemovedOldItems")
    end
end

function wanez.DGA.useDGA_Scroll(argObjectId,argDifficultyGD,argTierDGA,argTypeDGA)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedScrollDGA_failure";
    },function(self)
        local aActions = {
            giveItems = "mod_wanez/_dga/items/scrolls/DGA_Scroll"..self:parseIntToString(argDifficultyGD,1).."_Tier"..self:parseIntToString(argTierDGA,2)..argTypeDGA..".dbr";
        }
        portalOpener = Game.GetLocalPlayer()
        local difficultyId = (self:__getDifficultyID() == 3) and 3 or 1
        local typeId = self:convertIndex(argTypeDGA)
        
        if(difficultyId ~= argDifficultyGD) then
            aActions.notify = "tagWzDGA_LuaNotify_Difficulty_failure"
        elseif(portalOpener:HasToken(tokenPortalDefault)) then
            _cSettings:resetArea()
            _cSettings:__setAffixes(portalOpener)
            local chooseArea = false
            --mapTier = argTierDGA
            
            --local _cType = false
            --- everything is fine, time to prepare the area
            -- check for raid
            if(typeId == 1) then
                _cType = wanez.DGA.type.cRaid()
                chooseArea = (nextAreaId >= 3001 and nextAreaId <= 4000) and nextAreaId or false
            elseif(typeId == 2) then
                _cType = wanez.DGA.type.cEndless()
                chooseArea = (nextAreaId >= 1001 and nextAreaId <= 2000) and nextAreaId or false
            end
        
            -- check for challenge
            if(_cType:hasQuest() == false and typeId == 1) then
                _cType = wanez.DGA.type.cChallenge()
                chooseArea = (nextAreaId >= 2001 and nextAreaId <= 3000) and nextAreaId or false
                _cType:resetReward()
            end
    
            -- check for mission
            if(_cType:hasQuest() == false and typeId == 1) then
                _cType = wanez.DGA.type.cMission()
                chooseArea = (nextAreaId >= 1 and nextAreaId <= 1000) and nextAreaId or false
            end
            
            -- grant mission or endless
            if(_cType:hasQuest() == false and typeId == 1) then
                _cType:newQuest()
            end
            _cType:nextArea(chooseArea)
            _cType:__setArea('Default',argTierDGA)
    
            -- open portal for mission
            _cSettings:openArea('FloorArea0000-00a',portalOpener,_cType)
        
            nextAreaId = 0
        
            --aActions.notify = "tagWzDGA_LuaNotify_usedScrollDGA_success"
            aActions.notify = false
            -- giveBackItem while in developement
            if(argTierDGA ~= 0) then aActions.giveItems = false end
        elseif(difficultyId == 3 and difficultyId == argDifficultyGD) then
            portalOpener:GiveItem('mod_wanez/_dga/items/currency/a_001b.dbr',argTierDGA,true)
        
            aActions.notify = false
            -- giveBackItem while in developement
            if(argTierDGA ~= 0) then aActions.giveItems = false end
        end
        
        --UI.Notify(Entity.Get(argObjectId):GetName())
        
        return aActions
    end)
end

function wanez.DGA.setPortalLoc(argObjectId,argTypePortal,argAreaId,argVariation,argRegionId)
    _cSettings:__addArea(argObjectId,argTypePortal,argAreaId,argVariation,argRegionId)
end
function wanez.DGA.setEntityLoc(argObjectId,argTypeEntity,argAreaId,argVariation,argRegionId)
    _cSettings:__addArea(argObjectId,argTypeEntity,argAreaId,argVariation,argRegionId)
end

function wanez.DGA.boxTriggerDefault(argObjectId)
    
    --_cSettings:getArea():spawnEntities(argObjectId)
    _cSettings:spawnEntities(argObjectId,_cBossRoom)
end
function wanez.DGA.boxTriggerRegion(argObjectId,argRegionId,argType)
    argRegionId = argRegionId or 1
    argType = argType or "a"
    --UI.Notify('region trigger 2')
    _cSettings:spawnEntities(argObjectId,_cBossRoom,argRegionId)
end
function wanez.DGA.boxTriggerBossRoom(argObjectId)
    --_cBossRoom:isNewArea()
    _cBossRoom:spawnEntities(argObjectId,_cType)
end
function wanez.DGA.regPortalBossRoom(argObjectId)
    --_cSettings:__addArea(argObjectId,'BossRoom',1,'a',1)
end
function wanez.DGA.regProxyBossRoom_Default(argObjectId)
    _cBossRoom:addEntityCoords(argObjectId,'Default',1)
end
local SessionStarted = true
function wanez.DGA.onEnterTriggerCampOnLoad(argObjectId)
    local _player = Player.Get(argObjectId)
    
    wanez.DGA.dbr.onLeaveTriggerSummonPortal(argObjectId)
    
    _player:GiveToken("WZ_DGA_CHALLENGE_COMPLETE")
    _player:GiveToken("WZ_DGA_MODE_001_FINISH") -- finishes uber

    -- first load per difficulty
    if(_player:HasToken("DISMANTLING_UNLOCKED") == false)then
        _player:GiveToken("DISMANTLING_UNLOCKED")
        _player:UnlockFaction("USER14")
        _player:UnlockFaction("USER15")
        if(Game.GetGameDifficulty() == Game.Difficulty.Normal) then
            --_player:wzHasItem("records/items/misc/potions/potion_healtha01.dbr",30)
            _player:wzHasItem("records/items/misc/inventorybag.dbr",5)
            _player:AdjustMoney(3000)
        end
    end
    
    if SessionStarted then
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_01")
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_02")
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_03")
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_04")
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_05")
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_06")
        --_player:GiveToken("WZ_DGA_MP_DIFFICULTY_07")
        
        SessionStarted = false
    end
    
    --_player:wzHasItem("mod_wanez/_gear/items/artifacts/003_artifact_05.dbr",1)
    --_player:wzHasItem("mod_wanez/_runes/items/materia/runec_002.dbr",1)
	
	--_player:wzHasItem("mod_wanez/_events/phasing/items/modifier/comp_modifier_20_01.dbr",1)
    --_player:wzHasItem("mod_wanez/_events/phasing/items/converter/comp_converter_20_01.dbr",1)

    --- AREA Testing
    --_player:wzHasItem("mod_wanez/_dga/items/scrolls/area_scroll_0008.dbr",1)
    --_player:wzHasItem("mod_wanez/_dga/items/scrolls/area_scroll_0501.dbr",1)
    --_player:wzHasItem("mod_wanez/_dga/items/scrolls/area_scroll_0502.dbr",1)
    --_player:wzHasItem("mod_wanez/_dga/items/scrolls/area_scroll_0503.dbr",1)
    --_player:wzHasItem("mod_wanez/_dga/items/scrolls/area_scroll_0504.dbr",1)
    
    --- DEV: Mastery Testing
    --_player:GiveSkillPoints(1000)
    --_player:GiveLevels(100)
    --_player:AdjustMoney(9999999)
    --_player:wzHasItem("mod_wanez/currency/a_001c.dbr",1000)
    --_player:wzHasItem("mod_wanez/currency/b_001c.dbr",1000)
    --_player:wzHasItem("records/items/gearweapons/caster/d119_scepter.dbr",1)
    --_player:wzHasItem("mod_wanez/misc/d119_scepter.dbr",1)
    

    --- DEV: Runes
    --_player:wzHasItem("mod_wanez/_dga/items/affixes/b003.dbr",1)
    --_player:wzHasItem("mod_wanez/_runes/items/lore/loreobj_runeb001_000.dbr",1)
    
    --_player:wzHasItem("mod_wanez/_runes/items/stones/stone_accessory_medal04.dbr",1)
    --_player:wzHasItem("records/items/materia/compb_chainsofoleron.dbr",1)
    --_player:wzHasItem("records/items/materia/compb_beronath.dbr",1)
    --_player:wzHasItem("records/items/materia/compa_blessedsteel.dbr",1)
    --_player:wzHasItem("records/items/materia/compa_radiantgem.dbr",1)
    --_player:GiveFaction("USER14",100)
    --_player:GiveFaction("USER15",-12000)
    --UI.Notify(_player:GetFaction("USER15"))
    --_player:GiveItem("mod_wanez/_dga/items/scrolls/reward_scroll_a001.dbr",1,true)
    --wanez.DGA.dbr.onLeaveTriggerOrbConversion(argObjectId)

    --removeOldItems(_player)
end
function wanez.DGA.onEnterTriggerMapMP(argObjectId)
    local _player = Player.Get(argObjectId)
    if(_player:HasToken("WZ_DGA_ALLOW_PORTAL_DEFAULT")) then
        _player:RemoveToken("WZ_DGA_ALLOW_PORTAL_DEFAULT")
    end
    _player:GiveToken("WZ_DGA_MODE_001_START") -- finishes uber
    if(_cType) then
        --- start challenge for the player entering
        if(_cType.TypeID == 3) then
            --UI.Notify("GiveToken: CHALLENGE START")
            --_player:RemoveToken("WZ_DGA_CHALLENGE_COMPLETE")
            for i=1,9 do
                _player:RemoveToken("WZ_DGA_CHALLENGE_FINISH_0"..i)
            end;
            _player:GiveToken("WZ_DGA_CHALLENGE_START")
        end
    end
end

--[[
-- Floor onAddToWorld to show portals in camp after using scroll
 ]]
function wanez.DGA.regFloorArea0000_00a(argObjectId) -- Encampment
    devOnlyFn()
    _cSettings:__addCoords(argObjectId,'FloorArea0000-00a')
end
function wanez.DGA.regFloorArea0000_00b(argObjectId) -- BossRoom
    _cSettings:__addCoords(argObjectId,'FloorArea0000-00b')
end

function wanez.DGA.onInteractPortalBack(argObjectId)
    --_cSettings:resetArea()
end
function wanez.DGA.onInteractPortalBossRoom(argObjectId)
    --QuestGlobalEvent("wzDGA_completeQuestType001")
end

function wanez.DGA.onInteractPortalDefault(argObjectId)
    _cSettings:getArea().cPortal:hidePortal()
end
function wanez.DGA.onInteractPortalChallenge(argObjectId)
    _cSettings:getArea().cPortal:hidePortal()
end

function wanez.DGA.crafterDGA(argObjectId)
    local entity_ = Entity.Get(argObjectId)
    
    local crafter_ = Entity.Create( (_cSettings:__getDifficultyID() == 3) and "mod_wanez/_dga/npcs/blacksmith_dga_ultimate.dbr" or "mod_wanez/_dga/npcs/blacksmith_dga_normal.dbr" )
    crafter_:SetCoords(entity_:GetCoords())
    
    --UI.Notify(wanez.fn.convertIndex(4))
    --wanez.DGA.cArea():Notify()
    --wanez.DGA.area.cArea()
end

function wanez.DGA.onAddToWorldCrafterGear(argObjectId)
    local entity_ = Entity.Get(argObjectId)
    local dbr = "mod_wanez/_gear/creatures/npcs/blacksmith_leveling0".._cSettings:getFactionRank("USER14")..".dbr"
    --UI.Notify(dbr)
    local crafter_ = Entity.Create( dbr )
    crafter_:SetCoords(entity_:GetCoords())

    entity_:Destroy()
end

function wanez.DGA.useReward_Scroll(argObjectId,argTier,argType)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedReward_Scroll";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/scrolls/reward_scroll_"..argType..self:parseIntToString(argTier,2)..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions;
        
        return aActions
    end)
end
function wanez.DGA.useArea_Scroll(argObjectId,argAreaId)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedReward_Scroll";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/scrolls/area_scroll_"..self:parseIntToString(argAreaId,3)..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions = {
            notify = "tagWzDGA_AreasNext_"..self:parseIntToString(argAreaId,3)
        }
    
        nextAreaId = argAreaId
        
        return aActions
    end)
end

local endlessNPC = false -- declare endlessNPC to later destroy it when the portal is being created
function wanez.DGA.openNextEndless(argObjectId,argInc)
    -- open next portal
    _cType:setQuestArea(1,true)
    _cType:__setArea('Challenge',_cBossRoom:getTier(),_cBossRoom:getAreaLvL() + argInc)
    _cSettings:openArea('FloorArea0000-00b',portalOpener,_cType)
    
    -- destroy endlessNPC, he isnt required anymore
    endlessNPC:Destroy()
    endlessNPC = false
    
end

local PylonBufferDBR = false
local PylonId = false
function wanez.DGA.onInteractPylon(argObjectId,argType,argId)
    if (Server) then
        PylonId = argObjectId
        local _Pylon = Entity.Get(argObjectId)
        local coords = _Pylon:GetCoords()
    
        PylonBufferDBR = "mod_wanez/_dga/pylons/pylon_"..argType.._cSettings:parseIntToString(argId,2).."_entity_".._cSettings:parseIntToString(_cSettings:getFactionRank("USER14"),1)..".dbr"
        --local buffNpc = Entity.Create("mod_wanez/_dga/pylons/pylon_"..argType.._cSettings:parseIntToString(argId,2).."_entity_".._cSettings:parseIntToString(_cSettings:getFactionRank("USER14"),1)..".dbr")
        --buffNpc:SetCoords(coords)
        QuestGlobalEvent("wzDGA_SpawnPylonBuff")
        
        local _Player = Game.GetLocalPlayer()
        if(Game.GetGameDifficulty() == Game.Difficulty.Legendary) then
            if(_Player:HasItem("mod_wanez/_events/phasing/items/craft_phasingcrystal.dbr",1,true)) then
                local _Entity = Entity.Create("mod_wanez/_events/phasing/creatures/spirits/waveevent_scriptentity_alpha.dbr")
                if(_Entity) then
                    _Entity:SetCoords(coords);
                    _Player:TakeItem("mod_wanez/_events/phasing/items/craft_phasingcrystal.dbr",1,true)
                end
            
                
            end
        end
    
        _Pylon:Destroy()
    end
end

function wanez.DGA.onDie(argObjectId,argClassId)
    local _enemy = Entity.Get(argObjectId)
    local typeId = _cType.TypeID or 1
    
    --- REWARD SYSTEM
    if(typeId == 2) then
        if(argClassId == 7) then
            --UI.Notify("Endless still needs work, but here is a Portal")
            --_cType:setQuestArea(1,true)
            --_cType:__setArea('Challenge',_cBossRoom:getTier(),_cBossRoom:getAreaLvL())
            --_cSettings:openArea('FloorArea0000-00b',portalOpener,_cType)
            -- spawn Endless NPC
            if(endlessNPC == false)then
                endlessNPC = Entity.Create("mod_wanez/_dga/npcs/endless_a001.dbr")
                endlessNPC:SetCoords(_cSettings:__getCoords("FloorArea0000-00b"))
                UI.Notify("tagWzDGA_LuaNotify_BossRoomEndlessNPC")
            end
        end
    end
    if(typeId == 3)then
        rewardId = _cType:reward001(argClassId)
        QuestGlobalEvent("wzDGA_questType003_Finish")
        if(argClassId == 4) then
            _cType:setQuestArea(1,true)
            _cType:__setArea('Challenge',_cBossRoom:getTier(),_cBossRoom:getAreaLvL())
            _cSettings:openArea('FloorArea0000-00b',portalOpener,_cType)
            UI.Notify("tagWzDGA_LuaNotify_BossRoomChallengeNPC")
        end
        if(argClassId == 7)then
            QuestGlobalEvent("wzDGA_completeQuestType003")
        end
    end
    
    --- DROP & LOOT
    local _cDrop = wanez.DGA.cDrop()
    _cDrop:__iniClass(argObjectId,argClassId) -- ,typeId,portalOpener
    _cDrop:__dropLoot()
end

--- functions using local var to set data for MP fn call
local toSetAffix = false
function wanez.DGA.useDGA_Affix(argObjectId,argType,argAffix)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedDGA_Affix";
    },function(self)
        local itemDbr = "mod_wanez/_dga/items/affixes/"..argType..self:parseIntToString(argAffix,2)..".dbr"
        --[[
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions;
        
        local aData = wanez.DGA.aData.affixes[self:convertIndex(argType)]
        local aQuests = aData.quests[argAffix]
        local _player = Game.GetLocalPlayer()
    
        if(_player:GetQuestState(aQuests[1]) == QuestState.InProgress) then
            UI.Notify("Has Quest Already")
            aActions.giveItems = itemDbr
        else
            toSetAffix = {self:convertIndex(argType),argAffix }
            QuestGlobalEvent("wzDGA_grantAffix")
        end
        
        return aActions
    end)
end

local modeId = false
function wanez.DGA.useMode_Scroll(argTypeId)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedDGA_ModeScroll_failure";
    },function(self)
        local aActions = {
            notify = false;
        };
    
        if(_cSettings:hasMode(argTypeId) == false) then
            modeId = argTypeId
            QuestGlobalEvent("wzDGA_setMode")
        end
        
        return aActions
    end)
end

local questData = false
function wanez.DGA.useQuest_Scroll(argQuestId,argType)
    _cScroll = wanez.cScroll({
        notify = "tagWzDGA_LuaNotify_usedDGA_QuestScroll_failure";
    },function(self)
        --[[
        local itemDbr = "mod_wanez/_dga/items/scrolls/quest_type"..self:parseIntToString(argQuestId,2)..argType..".dbr"
        local aActions = {
            giveItems = itemDbr;
        }
        ]]
        local aActions;
        
        local typeId = self:convertIndex(argType)
        local aTypes = {
            "cMission",
            "cEndless",
            "cChallenge",
            "cRaid"
        }
    
        local _cQuest = wanez.DGA.type[aTypes[typeId]]()
        
        if(_cQuest:hasQuest()) then
            --UI.Notify("useQuest_Scroll: hasQuest()")
            aActions.notify = "tagWzDGA_LuaNotify_usedDGA_QuestScroll_hasAlready"..self:parseIntToString(typeId,2)
        else
            questData = argQuestId
            QuestGlobalEvent("wzDGA_grantQuestType"..self:parseIntToString(typeId,2))
            aActions.notify = "tagWzDGA_LuaNotify_usedDGA_QuestScroll_success"
        end
    
        questData = false
    
        return aActions
    end)
end

local entityClassId = false
local entityObjectId = false
---
-- @param argObjectId Enemy ObjectId
-- @param argClassId {int} Enemy Classification Id (Wanez)
-- @param argEvent {str} QuestGlobalEvent()
--
function wanez.DGA.mpDrop(argObjectId,argClassId,argEvent)
    entityObjectId = argObjectId or false
    entityClassId = argClassId or 1
    
    QuestGlobalEvent(argEvent)
end
local factionClassId = false
function wanez.DGA.mpGiveRep(argClassId)
    factionClassId = argClassId or 1
    
    QuestGlobalEvent("wzDGA_giveRep")
end

--- Global Events, addition to QuestGlobalEvent()
local addToClientQuestTable = {
    wzDGA_grantQuestType001 = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_MISSION_COMPLETE")
        local _cQuest = wanez.DGA.type.cMission()
        _cQuest:startQuest()
    end;
    wzDGA_completeQuestType001 = function()
        GiveTokenToLocalPlayer("WZ_DGA_MISSION_COMPLETE")
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    wzDGA_cancelQuestType001 = function()
        GiveTokenToLocalPlayer("WZ_DGA_MISSION_COMPLETE")
    end;
    wzDGA_completeQuestType002 = function()
        GiveTokenToLocalPlayer("WZ_DGA_ENDLESS_COMPLETE")
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    wzDGA_grantQuestType003 = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_CHALLENGE_START")
        RemoveTokenFromLocalPlayer("WZ_DGA_CHALLENGE_COMPLETE")
        local _cQuest = wanez.DGA.type.cChallenge()
        --UI.Notify("QuestID: "..questData[1].." | TaskID: "..questData[2][1])
        _cQuest:startQuest(questData)
    end;
    wzDGA_completeQuestType003 = function()
        GiveTokenToLocalPlayer("WZ_DGA_CHALLENGE_COMPLETE")
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    wzDGA_completeAffixes = function()
        local aData = wanez.DGA.aData.affixes
        for index,value in pairs(aData) do
            GiveTokenToLocalPlayer(value.token)
        end;
    end;
    wzDGA_grantAffix = function()
        if(toSetAffix ~= false)then
            -- declare var
            local aData = wanez.DGA.aData.affixes[toSetAffix[1]]
            local aQuests = aData.quests[toSetAffix[2]]
            local _player = Game.GetLocalPlayer()
            
            -- remove Token and GrantQuest
            RemoveTokenFromLocalPlayer(aData.token)
            if(_player:GetQuestState(aQuests[1]) ~= QuestState.InProgress) then
                _player:GrantQuest(aQuests[1],aQuests[2][1])
            end
            
        end
    end;
    
    --- MODES
    -- modeId [default: 1] -> Epic/Uber
    wzDGA_setMode = function()
        _cSettings:setMode(modeId)
    end;
    wzDGA_startMode = function()
        _cSettings:startMode(modeId)
    end;
    wzDGA_finishMode = function()
        _cSettings:finishMode(modeId)
    end;
    
    wzDGA_setDifficulty00 = function()
        RemoveTokenFromLocalPlayer("WZ_DGA_MP_DIFFICULTY_00")
    end;
    
    
    wzDGA_questType003_Finish = function()
        if(rewardId ~= 0)then
            GiveTokenToLocalPlayer("WZ_DGA_CHALLENGE_FINISH_"..rewardId)
        end
    end;
    
    wzDGA_dropCurrencySoul = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:dropCurrency('soul',entityClassId)
    end;
    wzDGA_dropCurrencyEssence = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:dropCurrency('essence',entityClassId)
    end;
    wzDGA_dropPlanarOrb = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveOrb(2)
    end;
    
    wzDGA_giveRep = function()
        local _cDrop = wanez.DGA.cDrop()
        _cDrop:giveReputation(factionClassId)
    end;
    
    
    wzDGA_SpawnPylonBuff = function()
        local _Pylon = Entity.Get(PylonId)
        local _Buffer = Entity.Create(PylonBufferDBR)
        
        if(_Pylon and _Buffer) then
            _Buffer:SetCoords(_Pylon:GetCoords())
        end
    end
}

table.insert(wanez.MP,addToClientQuestTable)
