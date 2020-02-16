-----------------------------------------------------------------------------------------------
-- Client Lua Script for IamTank
-- Copyright (c) Andrej Stonewall@Jabbit. All rights reserved
-----------------------------------------------------------------------------------------------
 
require "Window"
 
-----------------------------------------------------------------------------------------------
-- IamTank Module Definition
-----------------------------------------------------------------------------------------------
local IamTank = {} 
 
-----------------------------------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------------------------------
ktSpells = {
	["Bolt Caster"] = "dps",
	["Quick Burst"] = "dps",
	
	["Flak Cannon"] = "tank",
	["Unsteady Miasma"] = "tank",
}

-----------------------------------------------------------------------------------------------
-- Initialization
-----------------------------------------------------------------------------------------------
function IamTank:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here

    return o
end

function IamTank:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {
		-- "UnitOrPackageName",
	}
    Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end
 

-----------------------------------------------------------------------------------------------
-- IamTank OnLoad
-----------------------------------------------------------------------------------------------
function IamTank:OnLoad()
    -- load our form file
	self.xmlDoc = XmlDoc.CreateFromFile("IamTank.xml")
	self.xmlDoc:RegisterCallback("OnDocLoaded", self)
	
	Apollo.RegisterEventHandler("CombatLogDamage", "OnCombatLogDamage", self)
	
	self.tank = 0
	self.dps  = 0
	self.tracking = false
end

-----------------------------------------------------------------------------------------------
-- IamTank OnDocLoaded
-----------------------------------------------------------------------------------------------
function IamTank:OnDocLoaded()

	if self.xmlDoc ~= nil and self.xmlDoc:IsLoaded() then
	    self.wndMain = Apollo.LoadForm(self.xmlDoc, "IamTankForm", nil, self)
		if self.wndMain == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
	    self.wndMain:Show(false, true)

		-- if the xmlDoc is no longer needed, you should set it to nil
		-- self.xmlDoc = nil
		
		-- Register handlers for events, slash commands and timer, etc.
		-- e.g. Apollo.RegisterEventHandler("KeyDown", "OnKeyDown", self)
		Apollo.RegisterSlashCommand("iamtank", "OnIamTankOn", self)


		-- Do additional Addon initialization here
		self.tankdisplay  = self.wndMain:FindChild("tank")
		self.dpsdisplay   = self.wndMain:FindChild("dps")
		self.good  = self.wndMain:FindChild("good")
		self.bad   = self.wndMain:FindChild("bad")
	end
	
end

-----------------------------------------------------------------------------------------------
-- IamTank Functions
-----------------------------------------------------------------------------------------------
-- Define general functions here

-- on SlashCommand "/iamtank"
function IamTank:OnIamTankOn()
	self.wndMain:Invoke() -- show the window
	self.tracking = true
end


-----------------------------------------------------------------------------------------------
-- IamTankForm Functions
-----------------------------------------------------------------------------------------------
-- when the Close button is clicked
function IamTank:OnClose()
	self:OnReset()
	self.tracking = false
	self.wndMain:Close() -- hide the window
end

function IamTank:OnReset()
	self.tank = 0
	self.dps  = 0
	self.tankdisplay:SetText(self.tank)
	self.dpsdisplay:SetText(self.dps)
	self.good:Show(false)
	self.bad:Show(false)
end

function IamTank:OnCombatLogDamage(tEventArgs)
	if self.tracking then
		if tEventArgs.unitCaster:GetName() == GameLib.GetPlayerUnit():GetName() then
			local ability = ktSpells[tEventArgs.splCallingSpell:GetName()]
			if ability == "tank" then
				self.tank = self.tank + 1
				self.tankdisplay:SetText(self.tank)
				if self.tank > self.dps and not self.good:IsShown() then
					self.good:Show(true)
					self.bad:Show(false)
				end
			elseif ability == "dps" then
				self.dps = self.dps + 1
				self.dpsdisplay:SetText(self.dps)
				if self.dps > self.tank and not self.bad:IsShown()then
					self.good:Show(false)
					self.bad:Show(true)
				end
			end
		end
	end
end


-----------------------------------------------------------------------------------------------
-- IamTank Instance
-----------------------------------------------------------------------------------------------
local IamTankInst = IamTank:new()
IamTankInst:Init()
