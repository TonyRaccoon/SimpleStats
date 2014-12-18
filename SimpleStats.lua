--[[
TODO:
	Add class default profiles
	Fix no stats in recipe tooltips
	Fix weapon type localization
	Don't show comparison for second ring/trinket/weapon when hovering over first equipped one
	When hiding comparison when a stat is present, actually show it if there's still a stat you're not hiding (so if you're hiding int, and you look at the seal of wrynn, it shows comparisons because it has str/agi as well)
]]

SimpleStats = LibStub("AceAddon-3.0"):NewAddon("SimpleStats", "AceConsole-3.0", "AceEvent-3.0")
local handled, addedLine, prettyName, curStats, newStats, invTypes, tooltip, order

local defaults = {
	profile = {
		armor = true,
		dps = true,
		metasockets = true,
		prismaticsockets = true,
		cogwheelsockets = true,
		redsockets = true,
		bluesockets = true,
		yellowsockets = true,
		stamina = true,
		agility = true,
		strength = true,
		intellect = true,
		spirit = true,
		crit = true,
		haste = true,
		mastery = true,
		spellpower = true,
		pvppower = true,
		pvpresilience = true,
		resistance = true,
		
		smartarmor = true,
		cloth = true,
		leather = true,
		mail = true,
		plate = true,
		shields = true,
		
		usableweaponsonly = true,
		hideagility = false,
		hidestrength = false,
		hideintellect = false,
		minlevel = false,
		minquality = 1
	}
}

local options = {
	name = "SimpleStats",
	handler = SimpleStats,
	type = "group",
	get = "get",
	set = "set",
	
	args = {
		minquality = {
			type = "select",
			name = "Minimum Quality",
			values = {"Uncommon", "Rare", "Epic"},
			order = 10,
		},
		
		usableweaponsonly = {
			type = "toggle",
			name = "Ignore unusable weapon types",
			order = 20,
			width = "full"
		},
		
		header1 = {type = "header", name = "Armor Types", order = 30},
		
		smartarmor = {
			type = "toggle",
			name = "Automatic based on class",
			order = 35,
			width = "full",
		},
		cloth = {
			type = "toggle",
			name = "Show on cloth",
			order = 40,
		},
		leather = {
			type = "toggle",
			name = "Show on leather",
			order = 50,
		},
		mail = {
			type = "toggle",
			name = "Show on mail",
			order = 60,
		},
		plate = {
			type = "toggle",
			name = "Show on plate",
			order = 70,
		},
		shields = {
			type = "toggle",
			name = "Show on shields",
			order = 80,
		},
		
		header2 = {type = "header", name = "Primary Stats", order = 90},
		
		armor = {
			type = "toggle",
			name = "Armor",
			order = 100,
			width = "half"
		},
		dps = {
			type = "toggle",
			name = "DPS",
			order = 110,
			width = "half"
		},
		stamina = {
			type = "toggle",
			name = "Stamina",
			order = 120,
			width = "half"
		},
		agility = {
			type = "toggle",
			name = "Agility",
			order = 130,
			width = "half"
		},
		strength = {
			type = "toggle",
			name = "Strength",
			order = 140,
			width = "half"
		},
		intellect = {
			type = "toggle",
			name = "Intellect",
			order = 150,
			width = "half"
		},
		
		header3 = {type = "header", name = "Secondary Stats", order = 160},
		
		crit = {
			type = "toggle",
			name = "Crit",
			order = 170,
		},
		haste = {
			type = "toggle",
			name = "Haste",
			order = 180,
		},
		spirit = {
			type = "toggle",
			name = "Spirit",
			order = 190,
		},
		spellpower = {
			type = "toggle",
			name = "Spell Power",
			order = 200,
		},
		mastery = {
			type = "toggle",
			name = "Mastery",
			order = 210,
		},
		multistrike = {
			type = "toggle",
			name = "Multistrike",
			order = 211,
		},
		versatility = {
			type = "toggle",
			name = "Versatility",
			order = 212,
		},
		
		pvppower = {
			type = "toggle",
			name = "PvP Power",
			order = 230,
		},
		
		pvpresilience = {
			type = "toggle",
			name = "PvP Resilience",
			order = 240,
		},
		
		resistance = {
			type = "toggle",
			name = "Resistances",
			order = 250,
		},
		
		header4 = {type = "header", name = "Sockets", order = 270},
		
		metasockets = {
			type = "toggle",
			name = "Meta Sockets",
			order = 280,
		},
		prismaticsockets = {
			type = "toggle",
			name = "Prismatic Sockets",
			order = 290,
		},
		cogwheelsockets = {
			type = "toggle",
			name = "Cogwheel Sockets",
			order = 300,
		},
		redsockets = {
			type = "toggle",
			name = "Red Sockets",
			order = 310,
		},
		bluesockets = {
			type = "toggle",
			name = "Blue Sockets",
			order = 320,
		},
		yellowsockets = {
			type = "toggle",
			name = "Yellow Sockets",
			order = 330,
		},
		
		header5 = {type = "header", name = "Hide When Stat Exists", order = 340},
		
		hideagility = {
			type = "toggle",
			name = "Agility",
			order = 350,
			width = "half"
		},
		hidestrength = {
			type = "toggle",
			name = "Strength",
			order = 360,
			width = "half"
		},
		hideintellect = {
			type = "toggle",
			name = "Intellect",
			order = 370,
			width = "half"
		}
	}
}

function SimpleStats:get(i)
	return self.db.profile[i[1]]
end
function SimpleStats:set(i,v)
	self.db.profile[i[1]] = v
	
	if i[1] == "smartarmor" then
		options.args.cloth.disabled = v
		options.args.leather.disabled = v
		options.args.mail.disabled = v
		options.args.plate.disabled = v
		options.args.shields.disabled = v
	end
end

function SimpleStats:ChatCommand(input)
	input = input:trim()
	if not input or input == "" then
		InterfaceOptionsFrame_OpenToCategory(SimpleStats.optionsFrame)
		InterfaceOptionsFrame_OpenToCategory(SimpleStats.optionsFrame)
	
	elseif (input == "v" or input == "ver" or input == "version") then
		self:Print("Version: "..GetAddOnMetadata("SimpleStats","Version"))
	
	elseif (input == "profile" or input == "profiles") then
		InterfaceOptionsFrame_OpenToCategory(SimpleStats.profileFrame)
		InterfaceOptionsFrame_OpenToCategory(SimpleStats.profileFrame)
	
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(SimpleStats, "ss", "SimpleStats", input)
	end
end

local function sortStats(t)
	local tp = {} -- positives
	local tn = {} -- negatives
	local tf = {} -- final
	
	-- Sort into two piles, positives and negatives
	for k,v in pairs(t) do
		v = v+0
		if v > 0 then
			table.insert(tp,{k,v})
		elseif v < 0 then
			table.insert(tn,{k,v})
		end
	end
	
	-- Now sort each pile by stat name
	for k,v in pairs(tp) do
		local name = v[1]
		local value = math.floor(v[2])
		if order[prettyName[name]] then
			local pos = order[prettyName[name]]
			tf[pos] = {name,value}
		end
	end
	
	for k,v in pairs(tn) do
		local name = v[1]
		local value = math.floor(v[2])
		if order[prettyName[name]] then
			local pos = order[prettyName[name]]+30
			tf[pos] = {name,value}
		end
	end
	
	return tf
end

local function resetTooltip()
	handled = false
	addedLine = false
end

local function statIsEnabled(name)
	if strmatch(name,"Resistance") then
		return SimpleStats.db.profile.resistance
	else
		return SimpleStats.db.profile[name:lower():gsub(" ","")]
	end
end

local function printStats(tnew,tcur,tcur2)
	local tchanged = {}
	
	if tcur2 then -- Comparing two existing items, so merge tcur2 into tcur
		for k,v in pairs(tcur2) do
			if tcur[k] then
				tcur[k] = tcur[k] + v
			else
				tcur[k] = v
			end
		end
	end

	for k,v in pairs(tnew) do
		if tcur[k] then -- Stat exists on both, do subtraction
			tchanged[k] = tnew[k] - tcur[k]
		else -- New stat, just use the value
			tchanged[k] = tnew[k]
		end
	end
	
	for k,v in pairs(tcur) do
		if not tnew[k] then
			tchanged[k] = -v
		end
	end
	
	local stats = sortStats(tchanged)
	
	for k,v in orderedPairs(stats) do
		k = prettyName[k]
		name = v[1]
		val = v[2]+0
		if statIsEnabled(prettyName[name]) then
			if (val > 0) then
				tooltip:AddLine("|cff00ff00+"..val.."|cffffffff "..prettyName[name])
			elseif (val < 0) then
				tooltip:AddLine("|cffff0000"..val.."|cffffffff "..prettyName[name])
			end
		end
	end
	
	if (tooltip:GetName() == "GameTooltip") then
		tooltip:Show()
	end
end

local function hasTwoSlots(loc)
	if (loc == "INVTYPE_TRINKET" or loc == "INVTYPE_FINGER" or loc == "INVTYPE_WEAPON") then
		return true
	else
		return false
	end
end

local function getCurrentStats(link)
	if (link == nil) then
		return {}
	else
		return GetItemStats(link)
	end
end

local function checkWeaponType(type)
	_,class = UnitClass("player")
	
	if class == "DEATHKNIGHT" then
		if type == "One-Handed Axes"
		or type == "One-Handed Maces"
		or type == "One-Handed Swords"
		or type == "Two-Handed Axes"
		or type == "Two-Handed Maces"
		or type == "Two-Handed Swords"
		or type == "Polearms"
		then return true else return false end
	
	elseif class == "DRUID" then
		if type == "Daggers"
		or type == "Fist Weapons"
		or type == "One-Handed Maces"
		or type == "Polearms"
		or type == "Staves"
		or type == "Two-Handed Maces"
		then return true else return false end
		
	elseif class == "HUNTER" then
		if type == "Bows"
		or type == "Crossbows"
		or type == "Daggers"
		or type == "Guns"
		or type == "Fist Weapons"
		or type == "One-Handed Axes"
		or type == "One-Handed Swords"
		or type == "Polearms"
		or type == "Staves"
		or type == "Two-Handed Axes"
		or type == "Two-Handed Swords"
		then return true else return false end
	
	elseif class == "MAGE" then
		if type == "Daggers"
		or type == "Staves"
		or type == "One-Handed Swords"
		or type == "Wands"
		then return true else return false end
	
	elseif class == "PALADIN" then
		if type == "One-Handed Axes"
		or type == "One-Handed Maces"
		or type == "Polearms"
		or type == "One-Handed Swords"
		or type == "Two-Handed Axes"
		or type == "Two-Handed Maces"
		or type == "Two-Handed Swords"
		then return true else return false end
	
	elseif class == "PRIEST" then
		if type == "Daggers"
		or type == "One-Handed Maces"
		or type == "Staves"
		or type == "Wands"
		then return true else return false end
	
	elseif class == "ROGUE" then
		if type == "One-Handed Axes"
		or type == "Daggers"
		or type == "Fist Weapons"
		or type == "One-Handed Maces"
		or type == "One-Handed Swords"
		or type == "Bows"
		or type == "Crossbows"
		or type == "Guns"
		then return true else return false end
	
	elseif class == "SHAMAN" then
		if type == "One-Handed Axes"
		or type == "Daggers"
		or type == "Fist Weapons"
		or type == "One-Handed Maces"
		or type == "Staves"
		or type == "Two-Handed Axes"
		or type == "Two-Handed Maces"
		then return true else return false end
	
	elseif class == "WARLOCK" then
		if type == "Daggers"
		or type == "Staves"
		or type == "One-Handed Swords"
		or type == "Wands"
		then return true else return false end
	
	elseif class == "WARRIOR" then
		if type == "One-Handed Axes"
		or type == "Daggers"
		or type == "Fist Weapons"
		or type == "One-Handed Maces"
		or type == "Polearms"
		or type == "Staves"
		or type == "One-Handed Swords"
		or type == "Two-Handed Axes"
		or type == "Two-Handed Maces"
		or type == "Two-Handed Swords"
		or type == "Bows"
		or type == "Crossbows"
		or type == "Guns"
		then return true else return false end
	
	elseif class == "MONK" then
		if type == "Fist Weapons"
		or type == "One-Handed Axes"
		or type == "One-Handed Maces"
		or type == "One-Handed Swords"
		or type == "Polearms"
		or type == "Staves"
		then return true else return false end
	
	end
end

function checkArmorType(type)
	type = type:lower()
	_,c = UnitClass("player")
	c = c:lower()
	l = UnitLevel("player")
	
	if type == "cloth" then
		if c == "priest" or c == "mage" or c == "warlock"	then return true end
	elseif type == "leather" then
		if (c == "hunter" or c == "shaman") and l < 40		then return true end
		if c == "rogue" or c == "monk" or c == "druid"		then return true end
	elseif type == "mail" then
		if (c == "hunter" or c == "shaman") and l >= 40		then return true end
		if (c == "warrior" or c == "paladin") and l < 40	then return true end
	elseif type == "plate" then
		if (c == "warrior" or c == "paladin") and l >= 40	then return true end
		if c == "deathknight"								then return true end
	elseif type == "shields" then
		if c == "warrior" or c == "paladin" or c == "shaman" then return true end
	end
	
	return false
end

local function handleTooltip(self, ...)
	tooltip = self
	local name, item = tooltip:GetItem()
	if item then -- If this is an item tooltip
		
		local _,link,rarity,_,_,type,subtype,_,loc = GetItemInfo(item)
		
		if not link then return end -- Workaround for obscure bug popping up saying link is nil
		
		local id = tonumber(strmatch(link,"item:(%d+):"))
		local equipid = GetInventoryItemID("player",invTypes[loc])
		
		if type ~= "Armor" and type ~= "Weapon" then return end																-- If it's not armor or a weapon, quit
		if rarity-1 < SimpleStats.db.profile.minquality then return end														-- If it's below the current quality threshold, quit
		if type == "Weapon" and (SimpleStats.db.profile.usableweaponsonly and not checkWeaponType(subtype)) then return end	-- Check weapon type
		if loc == "INVTYPE_TABARD" or loc == "INVTYPE_BODY" then return end													-- Filter out shirts/tabards
		
		if type == "Armor" and subtype ~= "Miscellaneous" and loc ~= "INVTYPE_CLOAK" then									-- Filter out disabled armor types (always show for Misc items and cloaks)
			if SimpleStats.db.profile.smartarmor then
				if not checkArmorType(subtype) then return end
			else
				if not SimpleStats.db.profile[subtype:lower()] then return end
			end
		end
		
		if id == equipid and not hasTwoSlots(loc) then return end															-- If we have the same item equipped, and it's not a trinket/1H wep/ring, quit
		
		local e1link = GetInventoryItemLink("player",invTypes[loc])
		local e2link,firstloc
		
		if invTypes[loc] == 11 or invTypes[loc] == 13 or invTypes[loc] == 16 then
			equipid2 = GetInventoryItemLink("player",invTypes[loc]+1)
		end
		
		if invTypes[loc] == 11 or invTypes[loc] == 13 or invTypes[loc] == 16 then
			e2link = GetInventoryItemLink("player",invTypes[loc]+1)
		end
		
		if invTypes[loc] == 17 or loc == "INVTYPE_WEAPON" then -- If we're looking at an off-hand, get the main-hand type
			if GetInventoryItemLink("player",16) then
				_,_,_,_,_,_,_,_,firstloc = GetItemInfo(GetInventoryItemLink("player",16))
			end
		end
		
		local soloEquipped = false -- true if the weapon cannot be equipped with a second weapon
		if loc == "INVTYPE_2HWEAPON" or loc == "INVTYPE_RANGED" or (loc == "INVTYPE_RANGEDRIGHT" and subtype ~= "Wands") then
			soloEquipped = true
		end
		
		local curSoloEquipped = false -- true if the weapon in first weapon slot cannot be equipped with a second weapon
		if GetInventoryItemLink("player",16) ~= nil then
			local _,_,_,_,_,_,firstwepsubtype,_,firstweptype = GetItemInfo(GetInventoryItemLink("player",16))
			if firstweptype == "INVTYPE_2HWEAPON" or firstweptype == "INVTYPE_RANGED" or (firstweptype == "INVTYPE_RANGEDRIGHT" and firstwepsubtype ~= "Wands") then
				curSoloEquipped = true
			end
		end
		
		-- loc = weapon slot of new item
		-- firstloc = currently equipped weapon, used for comparison
		-- e1link = weapon in slot the new weapon is placed in
		-- e2link = in case of ring, trinket, or weapon: weapon in second ring, trinket, or weapon (offhand) slot
		
		newStats = GetItemStats(link)
		
		for k,v in pairs(newStats) do
			if	(k == "ITEM_MOD_AGILITY_SHORT" and v > 0 and SimpleStats.db.profile.hideagility) or
				(k == "ITEM_MOD_STRENGTH_SHORT" and v > 0 and SimpleStats.db.profile.hidestrength) or
				(k == "ITEM_MOD_INTELLECT_SHORT" and v > 0 and SimpleStats.db.profile.hideintellect) then
				return false end
		end
		
		if (addedLine == false) then addedLine = true; tooltip:AddLine(" ") end
		
		if loc == "INVTYPE_TRINKET" then -- If the item is a trinket, show stat changes for both trinkets
			tooltip:AddLine("Trinket 1:")
			curStats = getCurrentStats(e1link)
			printStats(newStats,curStats)
			tooltip:AddLine(" ")
			tooltip:AddLine("Trinket 2:")
			curStats = getCurrentStats(e2link)
			printStats(newStats,curStats)
			
		elseif loc == "INVTYPE_FINGER" then -- If the item is a ring, show stat changes for both rings
			tooltip:AddLine("Ring 1:")
			curStats = getCurrentStats(e1link)
			printStats(newStats,curStats)
			tooltip:AddLine(" ")
			tooltip:AddLine("Ring 2:")
			curStats = getCurrentStats(e2link)
			printStats(newStats,curStats)
			
		elseif loc == "INVTYPE_WEAPON" then -- If the item is a 1H weapon, show stat changes for both weapon slots
			if curSoloEquipped==false then tooltip:AddLine("Weapon 1:") end
			curStats = getCurrentStats(e1link)
			printStats(newStats,curStats)
			
			if curSoloEquipped==false then -- If the player has a 2H weapon equipped, don't show a second, identical stat change for the second slot
				tooltip:AddLine(" ")
				tooltip:AddLine("Weapon 2:")
				curStats = getCurrentStats(e2link)
				printStats(newStats,curStats)
			end
			
		elseif (soloEquipped==true) and equipid2 then -- Looking at a 2H and two 1H are equipped, so combine their stats
			curStats = getCurrentStats(e1link)
			curStats2 = getCurrentStats(e2link)
			printStats(newStats,curStats,curStats2)
		
		elseif invTypes[loc] == 17 and firstloc == "INVTYPE_2HWEAPON" then -- If comparing an offhand and a 2h weapon, don't act like both can be equipped
			curStats = getCurrentStats(GetInventoryItemLink("player",16))
			printStats(newStats,curStats)
			
		elseif loc == "INVTYPE_HOLDABLE" and curSoloEquipped==true then -- Looking at an off-hand, and a 2h weapon is in the first wep slot, so compare to that
			curStats = getCurrentStats(GetInventoryItemLink("player",16))
			printStats(newStats,curStats)
			
		elseif id ~= equipid then -- else, but only if the item isn't already equipped
			curStats = getCurrentStats(e1link)
			printStats(newStats,curStats)
			
		end
	end
end

local function setupTables()
	invTypes = {}
	invTypes["INVTYPE_HEAD"] = 1
	invTypes["INVTYPE_NECK"] = 2
	invTypes["INVTYPE_SHOULDER"] = 3
	invTypes["INVTYPE_BODY"] = 4
	invTypes["INVTYPE_CHEST"] = 5
	invTypes["INVTYPE_ROBE"] = 5
	invTypes["INVTYPE_WAIST"] = 6
	invTypes["INVTYPE_LEGS"] = 7
	invTypes["INVTYPE_FEET"] = 8
	invTypes["INVTYPE_WRIST"] = 9
	invTypes["INVTYPE_HAND"] = 10
	invTypes["INVTYPE_FINGER"] = 11 -- also 12
	invTypes["INVTYPE_TRINKET"] = 13 -- also 14
	invTypes["INVTYPE_CLOAK"] = 15
	invTypes["INVTYPE_WEAPON"] = 16 -- also 17
	invTypes["INVTYPE_SHIELD"] = 17
	invTypes["INVTYPE_2HWEAPON"] = 16
	invTypes["INVTYPE_WEAPONMAINHAND"] = 16
	invTypes["INVTYPE_WEAPONOFFHAND"] = 17
	invTypes["INVTYPE_HOLDABLE"] = 17
	invTypes["INVTYPE_RANGED"] = 16
	invTypes["INVTYPE_RANGEDRIGHT"] = 16
	invTypes["INVTYPE_TABARD"] = 19
	
	prettyName = {}
	prettyName["RESISTANCE0_NAME"] = "Armor"
	prettyName["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = "DPS"
	prettyName["EMPTY_SOCKET_META"] = "Meta Sockets"
	prettyName["EMPTY_SOCKET_PRISMATIC"] = "Prismatic Sockets"
	prettyName["EMPTY_SOCKET_COGWHEEL"] = "Cogwheel Sockets"
	prettyName["EMPTY_SOCKET_RED"] = "Red Sockets"
	prettyName["EMPTY_SOCKET_BLUE"] = "Blue Sockets"
	prettyName["EMPTY_SOCKET_YELLOW"] = "Yellow Sockets"
	prettyName["ITEM_MOD_STAMINA_SHORT"] = "Stamina"
	prettyName["ITEM_MOD_AGILITY_SHORT"] = "Agility"
	prettyName["ITEM_MOD_STRENGTH_SHORT"] = "Strength"
	prettyName["ITEM_MOD_INTELLECT_SHORT"] = "Intellect"
	prettyName["ITEM_MOD_CRIT_RATING_SHORT"] = "Crit"
	prettyName["ITEM_MOD_MASTERY_RATING_SHORT"] = "Mastery"
	prettyName["ITEM_MOD_HIT_RATING_SHORT"] = "Hit"
	prettyName["ITEM_MOD_SPIRIT_SHORT"] = "Spirit"
	prettyName["ITEM_MOD_HASTE_RATING_SHORT"] = "Haste"
	prettyName["ITEM_MOD_EXPERTISE_RATING_SHORT"] = "Expertise"
	prettyName["ITEM_MOD_DODGE_RATING_SHORT"] = "Dodge"
	prettyName["ITEM_MOD_PARRY_RATING_SHORT"] = "Parry"
	prettyName["ITEM_MOD_SPELL_POWER_SHORT"] = "Spellpower"
	prettyName["ITEM_MOD_SPELL_PENETRATION_SHORT"] = "Spell Penetration"
	prettyName["ITEM_MOD_ATTACK_POWER_SHORT"] = "Attack Power"
	prettyName["ITEM_MOD_PVP_POWER_SHORT"] = "PvP Power"
	prettyName["ITEM_MOD_RESILIENCE_RATING_SHORT"] = "PvP Resilience"
	prettyName["ITEM_MOD_ARCANE_RESISTANCE_SHORT"] = "Arcane Resistance"
	prettyName["ITEM_MOD_SHADOW_RESISTANCE_SHORT"] = "Shadow Resistance"
	prettyName["ITEM_MOD_FROST_RESISTANCE_SHORT"] = "Frost Resistance"
	prettyName["ITEM_MOD_FIRE_RESISTANCE_SHORT"] = "Fire Resistance"
	prettyName["ITEM_MOD_NATURE_RESISTANCE_SHORT"] = "Nature Resistance"
	prettyName["ITEM_MOD_CR_MULTISTRIKE_SHORT"] = "Multistrike"
	prettyName["ITEM_MOD_VERSATILITY"] = "Versatility"
	
	order = {}
	order["Armor"] = 1
	order["DPS"] = 2
	order["Meta Sockets"] = 3
	order["Prismatic Sockets"] = 4
	order["Cogwheel Sockets"] = 5
	order["Red Sockets"] = 6
	order["Blue Sockets"] = 7
	order["Yellow Sockets"] = 8
	order["Stamina"] = 9
	order["Agility"] = 10
	order["Strength"] = 11
	order["Intellect"] = 12
	order["Spirit"] = 13
	order["Hit"] = 14
	order["Crit"] = 15
	order["Haste"] = 16
	order["Expertise"] = 17
	order["Dodge"] = 18
	order["Parry"] = 19
	order["Mastery"] = 20
	order["Spellpower"] = 21
	order["Attack Power"] = 23
	order["Multistrike"] = 24
	order["Versatility"] = 25
	order["PvP Power"] = 26
	order["PvP Resilience"] = 27
	order["Fire Resistance"] = 28
	order["Nature Resistance"] = 29
	order["Frost Resistance"] = 30
	order["Arcane Resistance"] = 31
	order["Shadow Resistance"] = 32
end

local function hideBlizzComparison(self) -- Copied from OldComparison - http://www.wowinterface.com/downloads/fileinfo.php?id=14454
	local old = self.SetHyperlinkCompareItem
	self.SetHyperlinkCompareItem = function(self, link, level, shift, main, ...)
		main = nil
		return old(self, link, level, shift, main, ...)
	end
end

function SimpleStats:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("SimpleStatsDB", defaults, "Default")
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SimpleStats", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SimpleStats","SimpleStats")
	SimpleStats:RegisterChatCommand("ss", "ChatCommand")
	SimpleStats:RegisterChatCommand("simplestats", "ChatCommand")
	
	local options2 = deepcopy(options) -- Required to use Blizzard's addon options tabbing, not Ace's (thanks to InCombatIndicator)
	options2.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(SimpleStats.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SimpleStats Profile", options2.args.profile)
	self.profileFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SimpleStats Profile", "Profiles", "SimpleStats")
	
	-- Disable individual armor options when 'Auto armor' option is checked
	if (self.db.profile.smartarmor) then
		options.args.cloth.disabled = true
		options.args.leather.disabled = true
		options.args.mail.disabled = true
		options.args.plate.disabled = true
		options.args.shields.disabled = true
	end
	
	handled = false
	addedLine = false
	setupTables()
	
	GameTooltip:HookScript("OnTooltipCleared",resetTooltip)
	GameTooltip:HookScript("OnTooltipSetItem",handleTooltip)
	ItemRefTooltip:HookScript("OnTooltipSetItem",handleTooltip)
	
	hideBlizzComparison(ShoppingTooltip1)
	hideBlizzComparison(ShoppingTooltip2)
	hideBlizzComparison(ItemRefShoppingTooltip1)
	hideBlizzComparison(ItemRefShoppingTooltip2)
end

--- Misc Lua Functions ---

if not deepcopy then
function deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end
end
function __genOrderedIndex(t)
    local orderedIndex = {}
    for key in pairs(t) do table.insert( orderedIndex, key ) end
    table.sort( orderedIndex )
    return orderedIndex
end
function orderedNext(t, state)
    if state == nil then
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
        return key, t[key]
    end
    key = nil
    for i = 1,table.getn(t.__orderedIndex) do
        if t.__orderedIndex[i] == state then
            key = t.__orderedIndex[i+1]
        end
    end
    if key then return key, t[key] end
    t.__orderedIndex = nil
    return
end
function orderedPairs(t)
    return orderedNext, t, nil
end