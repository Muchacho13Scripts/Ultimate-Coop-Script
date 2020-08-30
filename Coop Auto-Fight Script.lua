--------------------------Coop Auto-Fight Script made by Scriptchacho-------------------------------
-- Be sure to check out the readme: https://bit.ly/CoopScript





----------------------------------------------------------------------------------------------------
-----------------Do Not Change if you don't know what you are doing!!!------------------------------
----------------------------------Attributes--------------------------------------------------------
import ('TemBot.Lua.TemBotLua')
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-------------------------------------Battle Functions-----------------------------------------------
----------------------------------------------------------------------------------------------------

function MainBattle() -- Main Battle Function
	if tblua:CheckLuma() == true then
		LumaSetting()
	end
	WildEncounter()
	EncounterBattle()
end

function EncounterBattle() -- sequences when trainer battle
	while tblua:IsInWorld() == false
	do
		if tblua:IsInFight() == true then
			if Exhausted() == false then
			SimpleAttack()
			end
		else
			SkipExpSkill()
			SwapDeadTem()
		end
	end
end

function WildEncounter() -- run away when possible
	if tblua:GetPixelColor(629, 581) == "0x2A2A2A" and tblua:GetPixelColor(651, 584) == "0x22FDFF" then --maybe wrong pixel and color for now
		runningaway()
	end
end

function SimpleAttack() -- First Attack used on marked Tem
	tblua:Sleep(math.random(666, 999))
    tblua:PressKey(0x31)
	tblua:Sleep(math.random(666, 999))
    tblua:PressKey(0x46)
	tblua:Sleep(math.random(666, 999))
    tblua:PressKey(0x31)
	tblua:Sleep(math.random(666, 999))
    tblua:PressKey(0x46)
	tblua:Sleep(math.random(1820, 3594))
end

function SkipExpSkill() -- Skips Exp Screen and new Attack Screen
	if tblua:GetPixelColor(215, 255) == "0x1CD1D3" then
		tblua:Sleep(math.random(666, 999))
		tblua:PressKey(0x1B)
		tblua:Sleep(math.random(1820, 3594))
	end
	
	if tblua:GetPixelColor(590, 245) == "0x1CD1D3" then
		tblua:Sleep(math.random(666, 999))
		tblua:PressKey(0x1B)
		tblua:Sleep(math.random(1820, 3594))
	end
end

function Exhausted() -- skip turn when exhausted
	if tblua:GetPixelColor(276, 631) == "0xFFFFFF" then
		local sleepy = math.random(74, 132)
		tblua:Sleep(sleepy)
		tblua:PressKey(0x36)
		tblua:Sleep(sleepy)
		tblua:Sleep(sleepy)
		tblua:PressKey(0x36)
		tblua:Sleep(sleepy)
		return true
	else
		return false
	end
end

function SwapDeadTem() -- Swap Tem if dead
	if tblua:GetPixelColor(1180, 455) == "0x1E1E1E" then
		local tem = 2
		local count = 1
		while tblua:GetPixelColor(1180, 455) == "0x1E1E1E"
		do
			while count < tem
			do
				tblua:PressKey(0x28)
                tblua:Sleep(math.random(1320, 1594))
				count = count + 1
			end
			tblua:PressKey(0x46)
			tblua:Sleep(math.random(1320, 1594))
            tem = tem + 1
		end
		return 1
	else
		return 0
	end
end

function runningaway() -- simple runaway function
	-- runaway sequence
		while tblua:IsInWorld() == false
        do
            if tblua:IsInFight() == true then
                tblua:Sleep(math.random(330, 694))
                tblua:PressKey(0x38)
            else
                tblua:Sleep(math.random(455, 1200))
			end
        end 
end

----------------------------------------------------------------------------------------------------
--------------------------------------Luma Functions------------------------------------------------
----------------------------------------------------------------------------------------------------

function LumaSetting() -- Checks the Luma Option chosen
	if tblua:CheckLuma() == true then
		WaitForLuma()
	end
end

function WaitForLuma() -- Waiting for Luma Option
	tblua:SendTelegramMessage("Luma Found! Waiting...")
	tblua:TestMessage("Luma Found! Waiting...")
	tblua:PressKey(0x71)
end


------------------------------------------------------------------------------------------------
---------------------------------------Heal Function--------------------------------------------
function CheckHeal()
	if tblua:GetPixelColor(638, 655) == "0x44666C" or tblua:GetPixelColor(638, 655) == "0x44666B" or tblua:GetPixelColor(638, 655) == "0x44676C" or tblua:GetPixelColor(638, 655) == "0x44676B" or tblua:GetPixelColor(638, 655) == "0x43666C" or tblua:GetPixelColor(638, 655) == "0x43666B" or tblua:GetPixelColor(638, 655) == "0x43676C" or tblua:GetPixelColor(638, 655) == "0x43676B" then
		tblua:Sleep(math.random(530, 1094))
		tblua:KeyDown(0x41) -- move diagonal up/left to healing station
		tblua:Sleep(10)
		tblua:KeyDown(0x57)					
		tblua:Sleep(1700)
		tblua:PressKey(0x57)
		tblua:Sleep(400) 
		tblua:PressKey(0x41)  -- stop pressing W last to look in the right direction
		tblua:Sleep(350)
		tblua:PressKey(0x46) -- start healing and wait a random amount between 7,5s and 10s
		tblua:Sleep(math.random(7500, 10000))
	end
end
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------- Start of Script ------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- Registering the Temtem Window
tblua:RegisterTemTemWindow()
tblua:GetAreaColor()
tblua:Sleep(1000)

if tblua:IsInWorld() == true then
	tblua:TestMessage("This Script is made by Scriptchacho. Please report any bugs to Muchacho13#0901 in Discord! Thanks for using my script and have fun!")

	while(true)
	do
------------------------------Doing Movement Overworld Actions-----------------------------------
		while tblua:IsInWorld() == true 
		do
		CheckHeal()
		tblua:Sleep(750)	
		end 
---------------------------- End of Doing Movement Overworld Actions-----------------------------

------------------------------------------Battle Scripts-----------------------------------------
		while tblua:IsInWorld() == false --loop if minimap not detected
		do
			tblua:StopMovement()            
			if tblua:IsInFight() == true then --if bot is in fight
				MainBattle()
				tblua:Sleep(2500)				
			end               
		end
	end
--------------------------------------------End Of Battle Scripts--------------------------------	
else
	MovementSwitch = 0
	tblua:TestMessage("Error: Not ready to start the script")
end

-------------------------------------------------------------------------------------------------

--------------------------------------------- Special Thanks! -----------------------------------
-- NhMarco for creating TemBot and making it possible to create LUA-Scripts
-- Mae for help making these scripts. Mae's Github: https://github.com/MaeBot
-- Slagathor for help with PixelDetection. Slagathor's Github: https://github.com/tyboe2013
-- The whole TemBot Team and the TemBot Community!
