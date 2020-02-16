-----------------------------------------------------------------------------------------------
-- Client Lua Script for CommandlineEquipmentManager
-----------------------------------------------------------------------------------------------

require "GameLib"


local CommandlineEquipmentManager = {}

function CommandlineEquipmentManager:new(o)
	o = o or {}
	o.settings = {}
	setmetatable(o, self)
	self.__index = self
    return o
end

function CommandlineEquipmentManager:Init()
    Apollo.RegisterAddon(self)
end

function CommandlineEquipmentManager:OnLoad()
	Apollo.RegisterSlashCommand("cem", "OnSlashCommand", self)
	Apollo.RegisterEventHandler("PlayerEquippedItemChanged", "OnPlayerEquippedItemChanged", self)
end

function CommandlineEquipmentManager:OnSlashCommand(slash, args)
	local arg = args:gmatch([[[^%s]+]])
	local cmd = arg()
	local cmd = cmd and cmd:lower() or ""
	local arg1 = arg()
	local arg1 = arg1 and arg1:lower() or ""
	
	if cmd == "load" then
		if self.settings[arg1] ~= nil then
			self:LoadSet(arg1)
		else
			Print(("Set not found: %s"):format(arg1))
		end
	elseif cmd == "save" then
		self:SaveSet(arg1)
	elseif cmd == "delete" then
		if self.settings[arg1] ~= nil then
			self.settings[arg1] = nil
			Print(("Saved deleted: %s"):format(arg1))
		else
			Print(("Set not found: %s"):format(arg1))
		end
	else
		Print(("/%s [ load | save | delete ] name"):format(slash))
	end
end


function CommandlineEquipmentManager:OnSave(eType)
	if eType ~= GameLib.CodeEnumAddonSaveLevel.Character then
		return
	end

	return self.settings
end

function CommandlineEquipmentManager:OnRestore(eType, tSavedData)
	if eType ~= GameLib.CodeEnumAddonSaveLevel.Character then
		return
	end

	self.settings = tSavedData
end


function CommandlineEquipmentManager:SaveSet(name)
	local items = {}
	for key, item in ipairs(GameLib.GetPlayerUnit():GetEquippedItems()) do
		items[item:GetChatLinkString()] = true
	end
	
	self.settings[name] = items
	Print(("Saved set: %s"):format(name))
end

function CommandlineEquipmentManager:LoadSet(name)
	local set = self.settings[name]
	local bagSlots = {}
	for key, item in ipairs(GameLib.GetPlayerUnit():GetInventoryItems()) do
		local itemInBag = item.itemInBag
		if itemInBag:IsEquippable() and set[itemInBag:GetChatLinkString()] then
			table.insert(bagSlots, item.nBagSlot + 1)
		end
	end
	
	self.bagSlots = bagSlots;
	self.loadSet = name;
	self:EquipSet()
end

function CommandlineEquipmentManager:EquipSet()
	self.isEquipping = true
	
	if #self.bagSlots > 0 then
		GameLib.EquipBagItem( table.remove(self.bagSlots) )
		return
	end
	
	self.isEquipping = false
	Print(("Loaded set: %s"):format(self.loadSet))
end

function CommandlineEquipmentManager:OnPlayerEquippedItemChanged()
	if not self.isEquipping then
		return
	end
	
	self:EquipSet()
end


local CommandlineEquipmentManagerInst = CommandlineEquipmentManager:new()
CommandlineEquipmentManagerInst:Init()
