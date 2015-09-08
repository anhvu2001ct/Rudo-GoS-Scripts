--Updated Sona for Inspired Ver19 and IOW
--------------------------------------------

---- Create a Menu ----
myMenu = Menu("Rx Sona", "sona")

---- Combo ----
myMenu:SubMenu("cb", "Sona Combo")
myMenu.cb:Boolean("QCB", "Use Q", true)
myMenu.cb:Boolean("WCB", "Use W", true)
myMenu.cb:Boolean("ECB", "Use E", true)
myMenu.cb:Boolean("RCB", "Use R", true)
myMenu.cb:Boolean("FQCCB", "Use Frost Queen's Claim", true)

---- Harass Menu ----
myMenu:SubMenu("hr", "Harass")
myMenu.hr:Boolean("HrQ", "Use Q", true)

---- Auto Spell Menu ----
myMenu:SubMenu("AtSpell", "Auto Spell")
myMenu.AtSpell:Boolean("ASEb", "Enable Aut Spell", true)
myMenu.AtSpell:Boolean("ASQ", "Use Q", true)
myMenu.AtSpell:Boolean("ASW", "Use W", true)
myMenu.AtSpell:Boolean("ASE", "Use E", true)
myMenu.AtSpell:Slider("ASMana", "Auto Spell if My %MP >", 10, 0, 80, 1)

---- Drawings Menu ----
myMenu:SubMenu("Draws", "Drawings")
myMenu.Draws:Boolean("DrawsEb", "Enable Drawings", true)
myMenu.Draws:Boolean("DrawQ", "Range Q", true)
myMenu.Draws:Boolean("DrawW", "Range W", true)
myMenu.Draws:Boolean("DrawE", "Range E", true)
myMenu.Draws:Boolean("DrawR", "Range R", true)
myMenu.Draws:Boolean("DrawTest", "Draw Test", true)

---- Misc Menu ----
myMenu:SubMenu("Miscset", "Misc")
myMenu.Miscset:SubMenu("KS", "Kill Steal")
myMenu.Miscset.KS:Boolean("KSEb", "Enable KillSteal", true)
myMenu.Miscset.KS:Boolean("QKS", "KS with Q", true)
myMenu.Miscset.KS:Boolean("RKS", "KS with R", true)
myMenu.Miscset:SubMenu("AntiSkill", "Stop Skill Enemy")
myMenu.Miscset.AntiSkill:Boolean("RAnti", "Stop Skil Enemy with R",true)
myMenu.Miscset:SubMenu("AutoLvlUp", "Auto Level Up")
myMenu.Miscset.AutoLvlUp:Boolean("AutoSkillUpQ", "Auto Lvl Up Q", true)   - <------ Full Q Frist.
myMenu.Miscset.AutoLvlUp:Boolean("AutoSkillUpW", "Auto Lvl Up W", true)   - <------ Full W Frist.

---- Use Items Menu ----
myMenu:SubMenu("Items", "Auto Use Items")
myMenu.Items:SubMenu("PotionHP", "Use Potion HP")
myMenu.Items.PotionHP:Boolean("PotHP", "Enable Use Potion HP", true)
myMenu.Items.PotionHP:Slider("CheckHP", "Auto Use if %HP <", 50, 5, 80, 1)
myMenu.Items:SubMenu("PotionMP", "Use Potion MP")
myMenu.Items.PotionMP:Boolean("PotMP", "Enable Use Potion MP", true)
myMenu.Items.PotionMP:Slider("CheckMP", "Auto Use if %MP <", 45, 5, 80, 1)
myMenu.Items:SubMenu("FrostQC", "Auto Use Frost Queen's Claim")
myMenu.Items.FrostQC:Boolean("FQC" "Enable", true)

---------- End Menu ----------


local info = "Rx Sona Loaded."
local upv = "Upvote if you like it!"
local sig = "Made by Rudo"
local ver = "Version: 0.7"
textTable = {info,upv,sig,ver}
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])
PrintChat(textTable[4])

PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Loaded Success </font><font color='#08F7F3'>Enjoy and have a Good Game :3</font>")) 
notification("RxSona by Rudo loaded.", 10000)

----- End Print -----

-------------------------------------------------------require('DLib')-------------------------------------------------------

-------------------------------------------------------Starting--------------------------------------------------------------

DelayAction(function ()
        for _, imenu in pairs(menuTable) do
                local submenu = menu.addItem(SubMenu.new(imenu.name))
                for _,subImenu in pairs(imenu) do
                        if subImenu.type == SCRIPT_PARAM_ONOFF then
                                local ggeasy = submenu.addItem(MenuBool.new(subImenu.t, subImenu.value))
                                OnLoop(function(myHero) subImenu.value = ggeasy.getValue() end)
                        elseif subImenu.type == SCRIPT_PARAM_KEYDOWN then
                                local ggeasy = submenu.addItem(MenuKeyBind.new(subImenu.t, subImenu.key))
                                OnLoop(function(myHero) subImenu.key = ggeasy.getValue(true) end)
                        elseif subImenu.type == SCRIPT_PARAM_INFO then
                                submenu.addItem(MenuSeparator.new(subImenu.t))
                        end
                end
        end
        _G.DrawMenu = function ( ... )  end
end, 1000)


global_ticks = 0
currentTicks = GetTickCount()


require('IOW')
CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["FiddleSticks"]                = {_R},
    ["Galio"]                       = {_R},
    ["Lucian"]                      = {_R},
    ["MissFortune"]                 = {_R},
    ["VelKoz"]                      = {_R},
    ["Nunu"]                        = {_R},
    ["Shen"]                        = {_R},
    ["Karthus"]                     = {_R},
    ["Malzahar"]                    = {_R},
    ["Pantheon"]                    = {_R},
    ["Warwick"]                     = {_R},
    ["Xerath"]                      = {_R},
    ["Ezreal"]                      = {_R},
	["Kennen"]                      = {_R},
    ["Rengar"]                      = {_R},
    ["Twisted Fate"]                = {_R},
	["Tahm Kench"]                  = {_R},
    ["Ezreal"]                      = {_R},
}

local callback = nil
 
OnProcessSpell(function(unit, spell)    
    if not callback or not unit or GetObjectType(unit) ~= Obj_AI_Hero  or GetTeam(unit) == GetTeam(GetMyHero()) then return end
    local unitChanellingSpells = CHANELLING_SPELLS[GetObjectName(unit)]
 
        if unitChanellingSpells then
            for _, spellSlot in pairs(unitChanellingSpells) do
                if spell.name == GetCastName(unit, spellSlot) then callback(unit, CHANELLING_SPELLS) end
            end
		end
end)
 
function addAntiSkillCallback( callback0 )
        callback = callback0
end

addAntiSkillCallback(function(target, spellType)
local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2400,250,1000,150,false,true)
  if IsInDistance(target, 1000) and CanUseSpell(myHero,_R) == READY and myMenu.Miscset.AntiSkill.RAnti:Value() and spellType == CHANELLING_SPELLS then
    CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
  end
end)

OnLoop(function(myHero)
    local target = IOW:GetTarget()
	------ Start Combo ------
    if IOW:Mode() == "Combo" then
	
		if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 845) and myMenu.cb.QCB:Value() then
		CastSpell(_Q)
        end
					
		if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 840) and myMenu.cb.WCB:getValue() then
		CastSpell(_W)
		end
				
		if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 1000) and myMenu.cb.ECB:Value() then
		CastSpell(_E)
		end
		
		local RPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),2400,300,1000,150,false,false)
        if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and ValidTarget(target, 950) and Config.R then
        CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
        end
		
		if myMenu.cb.FQCCB:Value() then
			local frostquc = GetItemSlot(myHero, 3096)
		if frostquc >= 0 then
			local FPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,200,880,270,false,true)
		if CanUseSpell(GetItemSlot(myHero, 3096)) == READY and ValidTarget(target, 880) and FPred.HitChance == 1 then  
		        CastSkillShot(GetItemSlot(myHero, 3096,FPred.PredPos.x,FPred.PredPos.y,FPred.PredPos.z));
		end
		end
		end	
					
	elseif IOW:Mode() == "Harass" then
	------ Start Harass ------
        if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 845) and myMenu.hr.HrQ:Value() then
		CastSpell(_Q)
        end	
	end
	
if myMenu.AtSpell.ASEb:Value() then
	AutoSpell()
	end
	
if myMenu.Miscset.KS.KSEb:Value() then
	KillSteal()
	end
		
if myMenu.Miscset.AutoLvlUp.AutoSkillUpQ:Value() then
	UpFullQ()
	end
	
if myMenu.Miscset.AutoLvlUp.AutoSkillUpW:Value() then
	UpFullW()
	end
	
if myMenu.Items.PotionHP.PotHP:Value() then	
	UsePotHP()
	end
	
if myMenu.Items.PotionMP.PotMP:Value() then	
	UsePotMP()
	end
	
if myMenu.Items.FrostQC.FQC:Value() then
	UseFQC()
	end
	
if myMenu.Draws.DrawsEb:Value() then
	Drawings()
	end
end)
 
 
IOW:EnableAutoAttacks()
IOW:DisableAutoAttacks()
IOW:EnableMovement()
IOW:DisableMovement()
IOW:EnableOrbwalking()
IOW:DisableOrbwalking()

------------------------------------------------------- Start Function -------------------------------------------------------

	------ Start Auto Spell ------
function AutoSpell()
 if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > myMenu.AtSpell.ASMana:Value() then
               for i,enemy in pairs(GetEnemyHeroes()) do				  
	local target = GetCurrentTarget()
      if CanUseSpell(myHero, _Q) == READY and ValidTarget(target, 845) and myMenu.AtSpell.ASQ:Value() then
	  CastSpell(_Q)
 end
 end
  if CanUseSpell(myHero, _W) == READY and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.55 and myMenu.AtSpell.ASW:Value() then
    CastSpell(_W)
 end
 if CanUseSpell(myHero, _E) == READY and (GetMoveSpeed(myHero))<0.6 and myMenu.AtSpell.ASE:Value() then
    CastSpell(_E)
 end
 end
 end
 
 	------ Start Kill Steal ------
function KillSteal()
for i,enemy in pairs(GetEnemyHeroes()) do
		
        -- Kill Steal --
	  local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
		ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
	if CanUseSpell(myHero, _Q) and ValidTarget(enemy, 845) and myMenu.Miscset.KS.QKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.5*GetBonusAP(myHero) + ExtraDmg) then
		CastSpell(_Q)
	elseif CanUseSpell(myHero, _R) and ValidTarget(enemy, 960) and myMenu.Miscset.KS.RKS:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 20 + 110*GetCastLevel(myHero,_R) + 0.5*GetBonusAP(myHero) + ExtraDmg) then
        CastSpell(_R)
	end
end
end

 	------ Start Auto Level Up _Full Q Frist_ ------
function UpFullQ()
  if myMenu.Miscset.AutoLvlUp.AutoSkillUpQ:Value() then  
local leveltable = { _Q, _W, _E, _Q, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W, _E, _E, _R, _E, _E} -- <<< Max Q first - Thank Inferno for this code
LevelSpell(leveltable[GetLevel(myHero)]) 
  end
 end
 
  	------ Start Auto Level Up _Full W Frist_ ------
function UpFullW()
  if myMenu.Miscset.AutoLvlUp.AutoSkillUpW:Value() then  
local leveltable = { _W, _Q, _E, _W, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- <<< Max W first - Thank Inferno
LevelSpell(leveltable[GetLevel(myHero)]) 
  end
end

 	------ Start Use Items _Use Health Potion_ ------
function UsePotHP()
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2003)
					if potionslot > 0 then
						if (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < myMenu.Items.PotionHP.CheckHP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2003))
						end
					end
				end
			end
			
 	------ Start Use Items _Use Mana Potion_ ------
function UsePotMP()
local myHero = GetMyHero()
local target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
			if (global_ticks + 15000) < currentTicks then
				local potionslot = GetItemSlot(myHero, 2004)
					if potionslot > 0 then
						if (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 < myMenu.Items.PotionMP.CheckMP:Value() then  
						global_ticks = currentTicks
						CastSpell(GetItemSlot(myHero, 2004))
						end
					end
				end
			end
			
 	------ Start Drawings ------
function Drawings()
 local HeroPos = GetOrigin(myHero)
if myMenu.Draws.DrawQ:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,880,3,100,0xff00ff00) end
if myMenu.Draws.DrawW:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,550,3,100,0xff00ff00) end
if myMenu.Draws.DrawE:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,975,3,100,0xff00ff00) end
if myMenu.Draws.DrawR:Value() then DrawCircle(HeroPos.x,HeroPos.y,HeroPos.z,550,3,100,0xff00ff00) end
 if myMenu.Draws.DrawTest:Value() then
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
		    local enemyPos = GetOrigin(enemy)
			local drawpos = WorldToScreen(1,enemyPos.x, enemyPos.y, enemyPos.z)
			local enemyText, color = GetDrawText(enemy)
			DrawText(enemyText, 20, drawpos.x, drawpos.y, color)
		end
	end
 end
end

------------------------------------------------------- End Function -------------------------------------------------------

require ('deLibrary')

------------------------------------------------------------------------------------------------------------------
-- You can change everything below this line
------------------------------------------------------------------------------------------------------------------

-- Assigned buttons
local Button = {
Show_Help =                                 Keys.F1,
Draw_HUD =                                  Keys.F4,
AutoHeal =                                  Keys.F2,
DrawHealCircles =                           Keys.F3,
SwitchNaviSystem =                          Keys.F5,
}

-- Settings for control champion features
-- Peace/Battle Form
local FormControl = {
RangeToChange =             1250,
BattleMinimumHoldTime =     3000,
BattleRandomHoldTime =      2000,
}
-- W AutoHeal
local AutoHealControl = {
OurHealthCap =      20,
InPeaceMode =       50,
InBattleMode =      80,
--Untested next
UseNaviSystem =     false,
MaxDistForNavi =    1100,
DoCheckDistNavi =   false,
}

-- Configurable delays (If your fps don't drop, can lower this values.)
local UpdateBattleMode_RepeatTimer = 120
local DoLoop_RepeatTimer = 20

------------------------------------------------------------------------------------------------------------------
-- You can change everything above this line
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Inside Function Control -- STARTED
------------------------------------------------------------------------------------------------------------------

-- Button Toggles/Settings
local Setting = {
Show_Help =                                         true,
Draw_HUD =                                          true,
AutoHeal =                                          true,
DrawHealCircles =                                   true,
}

-- Switches
local Switch = {
BattleMode = false,
}

local ButtonFunction = {
Show_Help =                                         function() Setting.Show_Help        = not Setting.Show_Help         end,
Draw_HUD =                                          function() Setting.Draw_HUD         = not Setting.Draw_HUD          end,
AutoHeal =                                          function() Setting.AutoHeal         = not Setting.AutoHeal          end,
DrawHealCircles =                                   function() Setting.DrawHealCircles  = not Setting.DrawHealCircles   end,
SwitchNaviSystem =                                  function() AutoHealControl.UseNaviSystem  = not AutoHealControl.UseNaviSystem   end,
}

------------------------------------------------------------------------------------------------------------------
-- Inside Function Control -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Key Control -- STARTED
------------------------------------------------------------------------------------------------------------------

local KPC = attachKeyPressor()
KPC.AddEventSingle(Button.Show_Help,            ButtonFunction.Show_Help)
KPC.AddEventSingle(Button.Draw_HUD,             ButtonFunction.Draw_HUD)
KPC.AddEventSingle(Button.AutoHeal,             ButtonFunction.AutoHeal)
KPC.AddEventSingle(Button.DrawHealCircles,      ButtonFunction.DrawHealCircles)
if AutoHealControl.UseNaviSystem then KPC.AddEventSingle(Button.SwitchNaviSystem,     ButtonFunction.SwitchNaviSystem) end

------------------------------------------------------------------------------------------------------------------
-- Key Control -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Drawings (Every plugin) -- STARTED
------------------------------------------------------------------------------------------------------------------

-- Help Window
function Draw_Help()
    local borders = 2
    local offset = {x = 10+borders, y = 10+borders}
    local size = {x = 210+borders*2, y = 70+borders*2}
    
    -- Borders/Background
    FillRect(offset.x-borders,offset.y-borders,size.x,size.y,TColors.Black(0xA0))
    -- Top text
    DrawTextSmall("SONA HELPER",                          60+offset.x,    0+offset.y, Colors.Lime)
    DrawTextSmall("BY INFERNO",                             108+offset.x,   7+offset.y, Colors.Red)
    -- Mid text
    DrawTextSmall("KEYS TO OPERATE SCRIPT:",                6+offset.x,     21+offset.y, Colors.White)
    DrawTextSmall("F1: SHOW/HIDE THIS WINDOW",              12+offset.x,    28+offset.y, Colors.White)
    DrawTextSmall("F2: TOGGLE AUTOHEAL ON/OFF",             12+offset.x,    35+offset.y, Colors.White)
    DrawTextSmall("F3: TOGGLE AUTOHEAL HELPER ON/OFF",      12+offset.x,    42+offset.y, Colors.White)
    DrawTextSmall("F4: TOGGLE HUD ON/OFF",                  12+offset.x,    49+offset.y, Colors.White)
    -- Postfix
    DrawTextSmall("HEAL YOUR ELO!",                         126+offset.x,   63+offset.y, Colors.Yellow)
end

function Draw_HUD()
    DrawTextSmall("Autoheal: "..(Setting.AutoHeal and "On" or "Off"), 396, 942, Setting.AutoHeal and Colors.Lime or Colors.Red)
    if AutoHealControl.UseNaviSystem then
        DrawTextSmall("N.A.V.I", 396, 935, Colors.Green)
    end
end

------------------------------------------------------------------------------------------------------------------
-- Drawings (Every plugin) -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Drawings (This plugin) -- STARTED
------------------------------------------------------------------------------------------------------------------
local function GetHealPotential(target, percent)
    local hp = GetPercentHP(target)
    local dist = GetDistance(target)
    if hp >= percent or hp == 0 or dist >= AutoHealControl.MaxDistForNavi then
        return 0
    else
        return 1 / ((AutoHealControl.MaxDistForNavi - dist) / (percent - hp))
    end
end

local function getCircleColor(target, percent, colorfrom, colorto)
    local StartR, StartG, StartB = colorfrom[1], colorfrom[2], colorfrom[3]
    local EndR, EndG, EndB = colorto[1], colorto[2], colorto[3]
    local Multiplier = GetPercentHP(target) / percent -- It should be Percent - 0 / HealHP - 0, but since it is 0...
    
    -- Protection from stupidity
    Multiplier = Multiplier > 1 and 1 or Multiplier
    Multiplier = Multiplier < 0 and 0 or Multiplier
    -- Done

    local ResR, ResG, ResB = Multiplier * (StartR - EndR) + EndR, Multiplier * (StartG - EndG) + EndG, Multiplier * (StartB - EndB) + EndB
    return ARGB(0xFF, ResR, ResG, ResB)
end

function doDrawHealCircles(potential)
    local DrawPercent = AutoHealControl.InBattleMode
    local AllyList = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, 2500, false) and GetPercentHP(a) < DrawPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetPercentHP(a) < GetPercentHP(b) end)
    -- This is valid function that will return table of allies that is sorted by health.
    -- Because AllyHeroes don't check for 'alive/dead' and so on, we checking everyting inside function.
    if (AllyList == nil) then return end

    local cStart =  Switch.BattleMode and {0,255,0} or {0,128,0}
    local cEnd =    Switch.BattleMode and {255,0,0} or {128,0,0}
    
    for i=1, #AllyList do
        DrawCircle(GetOrigin(AllyList[i]), 1000, 2, 0, getCircleColor(AllyList[i], DrawPercent, cStart, cEnd))
    end
    
    if potential then
        local PrimaryTarget = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, AutoHealControl.MaxDistForNavi, false) and GetPercentHP(a) < DrawPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetHealPotential(a, DrawPercent) > GetHealPotential(b, DrawPercent) end)
        if PrimaryTarget ~= nil then
            DrawCircle(GetOrigin(PrimaryTarget[1]), 125, 5, 0, getCircleColor(PrimaryTarget[1], DrawPercent, cStart, cEnd))
        end
    end
end
------------------------------------------------------------------------------------------------------------------
-- Drawings (This plugin) -- ENDED
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
-- Functions and Actions (This plugin) -- STARTED
------------------------------------------------------------------------------------------------------------------
local function CastW(target, checkDist)
    if (checkDist and GetDistance(target) > 1000) then return end
    if (CanUseSpell(myHero, _W) == READY) and (GetCurrentMana(myHero)/GetMaxMana(myHero))*100 > ASMana.getValue() then
        CastTargetSpell(target, _W)
    end
end

function doAutoHeal(potential)
    -- Don't cast W if we hurted badly.
    if GetPercentHP(myHero) <= AutoHealControl.OurHealthCap then return end

    -- Set HealPercent depending on current mode
    local HealPercent = Switch.BattleMode and AutoHealControl.InBattleMode or AutoHealControl.InPeaceMode

    local AllyList
    if not potential then
    AllyList = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, 1000, false) and GetPercentHP(a) < HealPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetPercentHP(a) < GetPercentHP(b) end)
    else
    AllyList = HeroManager.AllyHeroes(function(a) return IsValidTarget(a, AutoHealControl.MaxDistForNavi, false) and GetPercentHP(a) < HealPercent and GetNetworkID(a) ~= GetNetworkID(myHero) end, function(a,b) return GetHealPotential(a, HealPercent) > GetHealPotential(b, HealPercent) end)
    end
    -- This is valid function that will return table of allies that is sorted by health.
    -- Because AllyHeroes don't check for 'alive/dead' and so on, we checking everyting inside function.
    if (AllyList == nil) then return end
    
    if not potential then
        for i=1, #AllyList do
            CastW(AllyList[i])
        end
    else
        CastW(AllyList[1], AutoHealControl.DoCheckDistNavi)
    end
end

local UpdateBattleMode_NextUpdate = 0
local UpdateBattleMode_LastBattle = 0
function UpdateBattleMode()
    -- FPS Protection Part
    local cTick = GetTickCount()
    if cTick < UpdateBattleMode_NextUpdate then return end
    UpdateBattleMode_NextUpdate = cTick + UpdateBattleMode_RepeatTimer
    -- All code below will be delayed
    
    if (HeroManager.EnemyHeroes(function(a) return IsValidTarget(a, FormControl.RangeToChange) end) ~= nil) then
        UpdateBattleMode_LastBattle = cTick + math.random(FormControl.BattleMinimumHoldTime,FormControl.BattleMinimumHoldTime+FormControl.BattleRandomHoldTime)
    end
    Switch.BattleMode = cTick < UpdateBattleMode_LastBattle
end
------------------------------------------------------------------------------------------------------------------
-- Functions and Actions (This plugin) -- ENDED
------------------------------------------------------------------------------------------------------------------

local DoLoop_NextCheckTime = 0
function DoLoop()
    -- Drawings
        if Setting.Show_Help            then Draw_Help()                end
        if Setting.DrawHealCircles      then doDrawHealCircles(AutoHealControl.UseNaviSystem) end
        if Setting.Draw_HUD             then Draw_HUD()                 end
    -- End drawings

    -- FPS Protection Part
        local cTick = GetTickCount()
        if cTick < DoLoop_NextCheckTime then return end
        DoLoop_NextCheckTime = cTick + DoLoop_RepeatTimer
    -- All code below will be delayed.

    -- Actual action code
        UpdateBattleMode()
        if not IsDead(myHero) and not IsRecalling(myHero) then --If Hero is ready
            if Setting.AutoHeal         then doAutoHeal(AutoHealControl.UseNaviSystem) end
        end
    -- End of script
end
OnLoop(function(arg) DoLoop() end) 

function GetDrawText(enemy)
	local ExtraDmg = 0
	if Ignite and CanUseSpell(myHero, Ignite) == READY then
	ExtraDmg = ExtraDmg + 20*GetLevel(myHero)+50
	end
	
	local ExtraDmg2 = 0
	if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	ExtraDmg2 = ExtraDmg2 + 0.1*GetBonusAP(myHero) + 100
	end
	
	if CanUseSpell(myHero,_Q) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 20 + 110*GetCastLevel(myHero,_R) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'R = Kill!', ARGB(255, 200, 160, 0)
	elseif CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.50*GetBonusAP(myHero) + 20 + 110*GetCastLevel(myHero,_R) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + R = Kill!', ARGB(255, 200, 160, 0)
	elseif ExtraDmg > 0 and CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_R) == READY and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 5 + 49*GetCastLevel(myHero,_Q) + 0.50*GetBonusAP(myHero) + 20 + 110*GetCastLevel(myHero,_R) + 0.50*GetBonusAP(myHero) + ExtraDmg2) then
		return 'Q + R + Ignite = Kill!', ARGB(255, 200, 160, 0)
	else
		return 'Cant Kill Yet', ARGB(255, 200, 160, 0)
	end
end
