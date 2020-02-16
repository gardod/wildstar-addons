-----------------------------------------------------------------------------------------------
-- Client Lua Script for MasterLootRandom
-----------------------------------------------------------------------------------------------

require "Apollo"

local MasterLootRandom = {}

local ktClassToIcon =
{
	[GameLib.CodeEnumClass.Medic]       	= "Icon_Windows_UI_CRB_Medic",
	[GameLib.CodeEnumClass.Esper]       	= "Icon_Windows_UI_CRB_Esper",
	[GameLib.CodeEnumClass.Warrior]     	= "Icon_Windows_UI_CRB_Warrior",
	[GameLib.CodeEnumClass.Stalker]     	= "Icon_Windows_UI_CRB_Stalker",
	[GameLib.CodeEnumClass.Engineer]    	= "Icon_Windows_UI_CRB_Engineer",
	[GameLib.CodeEnumClass.Spellslinger]  	= "Icon_Windows_UI_CRB_Spellslinger",
}

function MasterLootRandom:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function MasterLootRandom:Init()
	Apollo.RegisterAddon(self)
end

function MasterLootRandom:OnLoad()
	self:InitializeHooks()
end

function MasterLootRandom:InitializeHooks()
	local crb = Apollo.GetAddon("MasterLoot")
	if crb ~= nil then
		crb.RefreshMasterLootLooterList = self.RefreshMasterLootLooterList
	end	
end

function MasterLootRandom:RefreshMasterLootLooterList(tItem)
	if tItem == nil then
		self.wndMasterLoot:FindChild("Assignment"):Enable(false)
		for idx, wndLooter in pairs(self.wndMasterLoot_LooterList:GetChildren()) do
			wndLooter:Show(false)
		end
		return
	end
	
	local tValidLooters = {}
	
	-- add random
	local randomGuy = tItem.tLooters[ math.random( #tItem.tLooters ) ]
	local strName = " Random"
	tValidLooters[strName] = true

	local wndCurrentLooter = self.tMasterLootLooterWindows[strName]
	if wndCurrentLooter == nil or not wndCurrentLooter:IsValid() then
		wndCurrentLooter = Apollo.LoadForm(self.xmlDoc, "CharacterButton", self.wndMasterLoot_LooterList, self)
		wndCurrentLooter:SetName(strName)
		self.tMasterLootLooterWindows[strName] = wndCurrentLooter
	end
	
	wndCurrentLooter:Show(true)
	wndCurrentLooter:FindChild("CharacterName"):SetText(strName)
	wndCurrentLooter:FindChild("CharacterLevel"):SetText("")
	wndCurrentLooter:FindChild("ClassIcon"):SetSprite("Icon_Windows_UI_CRB_Attribute_Random1")
	wndCurrentLooter:Enable(true)
	
	local tData = { ["unitLooter"] = randomGuy, ["tItem"] = tItem }
	wndCurrentLooter:SetData(tData)
	
	if wndCurrentLooter:IsChecked() then
		self.wndMasterLoot:FindChild("Assignment"):SetData(tData)
		self.wndMasterLoot:FindChild("Assignment"):Enable(true)
	end
	
	-- get people
	for idx, unitLooter in pairs(tItem.tLooters) do
		local strName = unitLooter:GetName()
		tValidLooters[strName] = true
	
		local wndCurrentLooter = self.tMasterLootLooterWindows[strName]
		if wndCurrentLooter == nil or not wndCurrentLooter:IsValid() then
			wndCurrentLooter = Apollo.LoadForm(self.xmlDoc, "CharacterButton", self.wndMasterLoot_LooterList, self)
			wndCurrentLooter:SetName(strName)
			self.tMasterLootLooterWindows[strName] = wndCurrentLooter
		end
		
		wndCurrentLooter:Show(true)
		wndCurrentLooter:FindChild("CharacterName"):SetText(strName)
		wndCurrentLooter:FindChild("CharacterLevel"):SetText(unitLooter:GetBasicStats().nLevel)
		wndCurrentLooter:FindChild("ClassIcon"):SetSprite(ktClassToIcon[unitLooter:GetClassId()])
		wndCurrentLooter:Enable(true)
		
		local tData = { ["unitLooter"] = unitLooter, ["tItem"] = tItem }
		wndCurrentLooter:SetData(tData)
		
		if wndCurrentLooter:IsChecked() then
			self.wndMasterLoot:FindChild("Assignment"):SetData(tData)
			self.wndMasterLoot:FindChild("Assignment"):Enable(true)
		end
	end

	-- get out of range people
	if tItem.tLootersOutOfRange and next(tItem.tLootersOutOfRange) then
		for idx, strLooterOOR in pairs(tItem.tLootersOutOfRange) do
			tValidLooters[strLooterOOR] = true
		
			local wndCurrentLooter = self.tMasterLootLooterWindows[strLooterOOR]
			if wndCurrentLooter == nil or not wndCurrentLooter:IsValid() then
				wndCurrentLooter = Apollo.LoadForm(self.xmlDoc, "CharacterButton", self.wndMasterLoot_LooterList, self)
				wndCurrentLooter:SetName(strLooterOOR)
				self.tMasterLootLooterWindows[strLooterOOR] = wndCurrentLooter
			end
			
			wndCurrentLooter:Show(true)
			wndCurrentLooter:FindChild("CharacterName"):SetText(String_GetWeaselString(Apollo.GetString("Group_OutOfRange"), strLooterOOR))
			wndCurrentLooter:FindChild("CharacterLevel"):SetText(nil)
			wndCurrentLooter:FindChild("ClassIcon"):SetSprite("CRB_GroupFrame:sprGroup_Disconnected")
			wndCurrentLooter:Enable(false)
			
			if wndCurrentLooter:IsChecked() then
				self.wndMasterLoot:FindChild("Assignment"):Enable(false)
			end
			wndCurrentLooter:SetCheck(false)
		end
	end
	
	for idx, wndLooter in pairs(self.wndMasterLoot_LooterList:GetChildren()) do
		local strName = wndLooter:GetName()
		if tValidLooters[strName] ==  nil then
			wndLooter:Destroy()
			self.tMasterLootLooterWindows[strName] = nil
		end
	end
	
	self.wndMasterLoot_LooterList:ArrangeChildrenVert(Window.CodeEnumArrangeOrigin.LeftOrTop, function(a,b)
		return a:FindChild("CharacterName"):GetText() < b:FindChild("CharacterName"):GetText()
	end)
end


local MasterLootRandom_Singleton = MasterLootRandom:new()
MasterLootRandom_Singleton:Init()



