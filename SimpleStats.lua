--[[
TODO:
	Add class default profiles
	Fix no stats in recipe tooltips
	Fix weapon type localization
	Don't show comparison for second ring/trinket/weapon when hovering over first equipped one
	When hiding comparison when a stat is present, actually show it if there's still a stat you're not hiding (so if you're hiding int, and you look at the seal of wrynn, it shows comparisons because it has str/agi as well)
]]

SimpleStats = LibStub("AceAddon-3.0"):NewAddon("SimpleStats", "AceConsole-3.0", "AceEvent-3.0")
local localized, resistanceNames, noNumberStats, curStats, newStats, invTypes, tooltip, order

local defaults = {
	profile = {
		RESISTANCE0_NAME = true,
		ITEM_MOD_DAMAGE_PER_SECOND_SHORT = true,
		ITEM_MOD_STAMINA_SHORT = true,
		ITEM_MOD_AGILITY_SHORT = true,
		ITEM_MOD_STRENGTH_SHORT = true,
		ITEM_MOD_INTELLECT_SHORT = true,
		ITEM_MOD_SPIRIT_SHORT = true,
		ITEM_MOD_CRIT_RATING_SHORT = true,
		ITEM_MOD_HASTE_RATING_SHORT = true,
		ITEM_MOD_MASTERY_RATING_SHORT = true,
		ITEM_MOD_SPELL_POWER_SHORT = true,
		ITEM_MOD_PVP_POWER_SHORT = true,
		ITEM_MOD_RESILIENCE_RATING_SHORT = true,
		ITEM_MOD_CR_STURDINESS_SHORT = true,
		resistance = true,
		sockets = true,
		
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
		
		RESISTANCE0_NAME = {
			type = "toggle",
			name = "Armor",
			order = 100,
			width = "half"
		},
		ITEM_MOD_DAMAGE_PER_SECOND_SHORT = {
			type = "toggle",
			name = "DPS",
			order = 110,
			width = "half"
		},
		ITEM_MOD_STAMINA_SHORT = {
			type = "toggle",
			name = "Stamina",
			order = 120,
			width = "half"
		},
		ITEM_MOD_AGILITY_SHORT = {
			type = "toggle",
			name = "Agility",
			order = 130,
			width = "half"
		},
		ITEM_MOD_STRENGTH_SHORT = {
			type = "toggle",
			name = "Strength",
			order = 140,
			width = "half"
		},
		ITEM_MOD_INTELLECT_SHORT = {
			type = "toggle",
			name = "Intellect",
			order = 150,
			width = "half"
		},
		
		header3 = {type = "header", name = "Secondary Stats", order = 160},
		
		ITEM_MOD_CRIT_RATING_SHORT = {
			type = "toggle",
			name = "Crit",
			order = 170,
		},
		ITEM_MOD_HASTE_RATING_SHORT = {
			type = "toggle",
			name = "Haste",
			order = 180,
		},
		ITEM_MOD_SPIRIT_SHORT = {
			type = "toggle",
			name = "Spirit",
			order = 190,
		},
		ITEM_MOD_SPELL_POWER_SHORT = {
			type = "toggle",
			name = "Spell Power",
			order = 200,
		},
		ITEM_MOD_MASTERY_RATING_SHORT = {
			type = "toggle",
			name = "Mastery",
			order = 210,
		},
		ITEM_MOD_CR_MULTISTRIKE_SHORT = {
			type = "toggle",
			name = "Multistrike",
			order = 211,
		},
		ITEM_MOD_VERSATILITY = {
			type = "toggle",
			name = "Versatility",
			order = 212,
		},
		ITEM_MOD_PVP_POWER_SHORT = {
			type = "toggle",
			name = "PvP Power",
			order = 230,
		},
		ITEM_MOD_RESILIENCE_RATING_SHORT = {
			type = "toggle",
			name = "PvP Resilience",
			order = 240,
		},
		
		resistance = {
			type = "toggle",
			name = "Resistances",
			order = 250,
		},
		
		header4 = {type = "header", name = "Tertiary Stats", order = 270},
		
		sockets = {
			type = "toggle",
			name = "Gem Sockets",
			order = 280,
		},
		ITEM_MOD_CR_STURDINESS_SHORT = {
			type = "toggle",
			name = "Indestructible",
			order = 290,
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

local function convertResistanceName(name)
	return resistanceNames[name] or name
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
		if order[name] then
			local pos = order[name]
			tf[pos] = {name,value}
		end
	end
	
	for k,v in pairs(tn) do
		local name = v[1]
		local value = math.floor(v[2])
		if order[name] then
			local pos = order[name]+30
			tf[pos] = {name,value}
		end
	end
	
	return tf
end

local function resetTooltip()
	
end

local function statIsEnabled(name)
	if strmatch(name,"RESISTANCE_SHORT") then
		return SimpleStats.db.profile.resistance
	elseif strmatch(name, "EMPTY_SOCKET") then
		return SimpleStats.db.profile.sockets
	else
		return SimpleStats.db.profile[name]
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
		name = v[1]
		
		-- If it's a resistance, the localized strings are wrong and need to be converted to a second style to work
		convertedName = convertResistanceName(name)
		
		val = v[2]+0
		if statIsEnabled(name) then
			if (val > 0) then
				if noNumberStats[convertedName] then
					tooltip:AddLine("|cff00ff00+".._G[convertedName])
				else
					tooltip:AddLine("|cff00ff00+"..val.."|cffffffff ".._G[convertedName])
				end
			elseif (val < 0) then
				if noNumberStats[convertedName] then
					tooltip:AddLine("|cffff0000-".._G[convertedName])
				else
					tooltip:AddLine("|cffff0000"..val.."|cffffffff ".._G[convertedName])
				end
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
		if type == localized.weapons.onehandedaxes
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.twohandedaxes
		or type == localized.weapons.twohandedmaces
		or type == localized.weapons.twohandedswords
		or type == localized.weapons.polearms
		then return true else return false end
	
	elseif class == "DRUID" then
		if type == localized.weapons.daggers
		or type == localized.weapons.fistweapons
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.polearms
		or type == localized.weapons.staves
		or type == localized.weapons.twohandedmaces
		then return true else return false end
		
	elseif class == "HUNTER" then
		if type == localized.weapons.bows
		or type == localized.weapons.crossbows
		or type == localized.weapons.daggers
		or type == localized.weapons.guns
		or type == localized.weapons.fistweapons
		or type == localized.weapons.onehandedaxes
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.polearms
		or type == localized.weapons.staves
		or type == localized.weapons.twohandedaxes
		or type == localized.weapons.twohandedswords
		then return true else return false end
	
	elseif class == "MAGE" then
		if type == localized.weapons.daggers
		or type == localized.weapons.staves
		or type == localized.weapons.swords
		or type == localized.weapons.wands
		then return true else return false end
	
	elseif class == "PALADIN" then
		if type == localized.weapons.onehandedaxes
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.polearms
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.twohandedaxes
		or type == localized.weapons.twohandedmaces
		or type == localized.weapons.twohandedswords
		then return true else return false end
	
	elseif class == "PRIEST" then
		if type == localized.weapons.daggers
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.staves
		or type == localized.weapons.wands
		then return true else return false end
	
	elseif class == "ROGUE" then
		if type == localized.weapons.onehandedaxes
		or type == localized.weapons.daggers
		or type == localized.weapons.fistweapons
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.bows
		or type == localized.weapons.crossbows
		or type == localized.weapons.guns
		then return true else return false end
	
	elseif class == "SHAMAN" then
		if type == localized.weapons.onehandedaxes
		or type == localized.weapons.daggers
		or type == localized.weapons.fistweapons
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.staves
		or type == localized.weapons.twohandedaxes
		or type == localized.weapons.twohandedmaces
		then return true else return false end
	
	elseif class == "WARLOCK" then
		if type == localized.weapons.daggers
		or type == localized.weapons.staves
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.wands
		then return true else return false end
	
	elseif class == "WARRIOR" then
		if type == localized.weapons.onehandedaxes
		or type == localized.weapons.daggers
		or type == localized.weapons.fistweapons
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.polearms
		or type == localized.weapons.staves
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.twohandedaxes
		or type == localized.weapons.twohandedmaces
		or type == localized.weapons.twohandedswords
		or type == localized.weapons.bows
		or type == localized.weapons.crossbows
		or type == localized.weapons.guns
		then return true else return false end
	
	elseif class == "MONK" then
		if type == localized.weapons.fistweapons
		or type == localized.weapons.onehandedaxes
		or type == localized.weapons.onehandedmaces
		or type == localized.weapons.onehandedswords
		or type == localized.weapons.polearms
		or type == localized.weapons.staves
		then return true else return false end
	
	end
end

function checkArmorType(type)
	_,c = UnitClass("player")
	l = UnitLevel("player")
	
	if type == localized.armor.cloth then
		if c == "PRIEST" or c == "MAGE" or c == "WARLOCK"	then return true end
	elseif type == localized.armor.leather then
		if (c == "HUNTER" or c == "SHAMAN") and l < 40		then return true end
		if c == "ROGUE" or c == "MONK" or c == "DRUID"		then return true end
	elseif type == localized.armor.mail then
		if (c == "HUNTER" or c == "SHAMAN") and l >= 40		then return true end
		if (c == "WARRIOR" or c == "PALADIN") and l < 40	then return true end
	elseif type == localized.armor.plate then
		if (c == "WARRIOR" or c == "PALADIN") and l >= 40	then return true end
		if c == "DEATHKNIGHT"								then return true end
	elseif type == localized.armor.shields then
		if c == "WARRIOR" or c == "PALADIN" or c == "SHAMAN" then return true end
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
		
		if type ~= localized.armor_name and type ~= localized.weapon_name then return end									-- If it's not armor or a weapon, quit
		if rarity-1 < SimpleStats.db.profile.minquality then return end														-- If it's below the current quality threshold, quit
		if type == localized.weapon_name and (SimpleStats.db.profile.usableweaponsonly and not checkWeaponType(subtype)) then return end	-- Check weapon type
		if loc == "INVTYPE_TABARD" or loc == "INVTYPE_BODY" then return end													-- Filter out shirts/tabards
		
		if type == localized.armor_name and subtype ~= localized.armor.miscellaneous and loc ~= "INVTYPE_CLOAK" then		-- Filter out disabled armor types (always show for Misc items and cloaks)
			if SimpleStats.db.profile.smartarmor then
				if not checkArmorType(subtype) then return end
			else
				local english_name = localized.reverse.armor[subtype]
				if not SimpleStats.db.profile[english_name] then return end
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
		if loc == "INVTYPE_2HWEAPON" or loc == "INVTYPE_RANGED" or (loc == "INVTYPE_RANGEDRIGHT" and subtype ~= localized.weapons.wands) then
			soloEquipped = true
		end
		
		local curSoloEquipped = false -- true if the weapon in first weapon slot cannot be equipped with a second weapon
		if GetInventoryItemLink("player",16) ~= nil then
			local _,_,_,_,_,_,firstwepsubtype,_,firstweptype = GetItemInfo(GetInventoryItemLink("player",16))
			if firstweptype == "INVTYPE_2HWEAPON" or firstweptype == "INVTYPE_RANGED" or (firstweptype == "INVTYPE_RANGEDRIGHT" and firstwepsubtype ~= localized.weapons.wands) then
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
		
		tooltip:AddLine(" ")
		
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
	invTypes = {
		INVTYPE_HEAD = 1,
		INVTYPE_NECK = 2,
		INVTYPE_SHOULDER = 3,
		INVTYPE_BODY = 4,
		INVTYPE_CHEST = 5,
		INVTYPE_ROBE = 5,
		INVTYPE_WAIST = 6,
		INVTYPE_LEGS = 7,
		INVTYPE_FEET = 8,
		INVTYPE_WRIST = 9,
		INVTYPE_HAND = 10,
		INVTYPE_FINGER = 11, -- also 12
		INVTYPE_TRINKET = 13, -- also 14
		INVTYPE_CLOAK = 15,
		INVTYPE_WEAPON = 16, -- also 17
		INVTYPE_SHIELD = 17,
		INVTYPE_2HWEAPON = 16,
		INVTYPE_WEAPONMAINHAND = 16,
		INVTYPE_WEAPONOFFHAND = 17,
		INVTYPE_HOLDABLE = 17,
		INVTYPE_RANGED = 16,
		INVTYPE_RANGEDRIGHT = 16,
		INVTYPE_TABARD = 19,
	}
	
	local order_inverted = {
		"RESISTANCE0_NAME",
		"ITEM_MOD_DAMAGE_PER_SECOND_SHORT",
		"ITEM_MOD_STAMINA_SHORT",
		"ITEM_MOD_AGILITY_SHORT",
		"ITEM_MOD_STRENGTH_SHORT",
		"ITEM_MOD_INTELLECT_SHORT",
		"ITEM_MOD_SPIRIT_SHORT",
		"ITEM_MOD_HIT_RATING_SHORT",
		"ITEM_MOD_CRIT_RATING_SHORT",
		"ITEM_MOD_HASTE_RATING_SHORT",
		"ITEM_MOD_EXPERTISE_RATING_SHORT",
		"ITEM_MOD_DODGE_RATING_SHORT",
		"ITEM_MOD_PARRY_RATING_SHORT",
		"ITEM_MOD_MASTERY_RATING_SHORT",
		"ITEM_MOD_SPELL_POWER_SHORT",
		"ITEM_MOD_SPELL_PENETRATION_SHORT",
		"ITEM_MOD_ATTACK_POWER_SHORT",
		"ITEM_MOD_CR_MULTISTRIKE_SHORT",
		"ITEM_MOD_VERSATILITY",
		"ITEM_MOD_PVP_POWER_SHORT",
		"ITEM_MOD_RESILIENCE_RATING_SHORT",
		"ITEM_MOD_FIRE_RESISTANCE_SHORT",
		"ITEM_MOD_NATURE_RESISTANCE_SHORT",
		"ITEM_MOD_FROST_RESISTANCE_SHORT",
		"ITEM_MOD_ARCANE_RESISTANCE_SHORT",
		"ITEM_MOD_SHADOW_RESISTANCE_SHORT",
		"EMPTY_SOCKET_META",
		"EMPTY_SOCKET_PRISMATIC",
		"EMPTY_SOCKET_COGWHEEL",
		"EMPTY_SOCKET_RED",
		"EMPTY_SOCKET_BLUE",
		"EMPTY_SOCKET_YELLOW",
		"ITEM_MOD_CR_STURDINESS_SHORT",
	}
	
	-- The following stats should not show a number (+Indestructible instead of +57 Indestructible, for example)
	noNumberStats = {
		ITEM_MOD_CR_STURDINESS_SHORT = true,
	}
	
	order = {}
	for k,v in pairs(order_inverted) do
		order[v] = k
	end
	
	
	-- Create mapping between two different resistance names used
	resistanceNames = {
		ITEM_MOD_HOLY_RESISTANCE_SHORT   = "RESISTANCE1_NAME",
		ITEM_MOD_FIRE_RESISTANCE_SHORT   = "RESISTANCE2_NAME",
		ITEM_MOD_NATURE_RESISTANCE_SHORT = "RESISTANCE3_NAME",
		ITEM_MOD_FROST_RESISTANCE_SHORT  = "RESISTANCE4_NAME",
		ITEM_MOD_SHADOW_RESISTANCE_SHORT = "RESISTANCE5_NAME",
		ITEM_MOD_ARCANE_RESISTANCE_SHORT = "RESISTANCE6_NAME",
		RESISTANCE1_NAME                 = "ITEM_MOD_HOLY_RESISTANCE_SHORT",
		RESISTANCE2_NAME                 = "ITEM_MOD_FIRE_RESISTANCE_SHORT",
		RESISTANCE3_NAME                 = "ITEM_MOD_NATURE_RESISTANCE_SHORT",
		RESISTANCE4_NAME                 = "ITEM_MOD_FROST_RESISTANCE_SHORT",
		RESISTANCE5_NAME                 = "ITEM_MOD_SHADOW_RESISTANCE_SHORT",
		RESISTANCE6_NAME                 = "ITEM_MOD_ARCANE_RESISTANCE_SHORT"
	}
	
	-- Exract localized armor and weapon type strings from Auction House functions (no global strings for them are available)
	local itemClasses = {GetAuctionItemClasses()}
	local weaponTypes = {GetAuctionItemSubClasses(1)}
	local armorTypes = {GetAuctionItemSubClasses(2)}
	
	local names = {
		weapons = {
			"onehandedaxes",
			"twohandedaxes",
			"bows",
			"guns",
			"onehandedmaces",
			"twohandedmaces",
			"polearms",
			"onehandedswords",
			"twohandedswords",
			"staves",
			"fistweapons",
			"miscellaneous",
			"daggers",
			"thrown",
			"crossbows",
			"wands",
			"fishingpoles"
		},
		armor = {
			"miscellaneous",
			"cloth",
			"leather",
			"mail",
			"plate",
			"cosmetic",
			"shields"
		}
	}
	
	localized = {
		weapon_name = itemClasses[1],
		armor_name = itemClasses[2],
		weapons = {},
		armor = {},
		reverse = {
			armor = {}
		}
	}
	
	for i,name in pairs(names.weapons) do
		localized.weapons[name] = weaponTypes[i]
	end
	
	for i,name in pairs(names.armor) do
		localized.armor[name] = armorTypes[i]
	end
	
	for engname,locname in pairs(localized.armor) do
		localized.reverse.armor[locname] = engname
	end
	
	lemur = localized
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
	
	setupTables()
	
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