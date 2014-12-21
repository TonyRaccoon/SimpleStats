SimpleStats = LibStub("AceAddon-3.0"):NewAddon("SimpleStats", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

SimpleStats.defaults = {												-- Default settings
	profile = {
		RESISTANCE0_NAME = false,
		ITEM_MOD_DAMAGE_PER_SECOND_SHORT = false,
		ITEM_MOD_STAMINA_SHORT = true,
		ITEM_MOD_AGILITY_SHORT = true,
		ITEM_MOD_STRENGTH_SHORT = true,
		ITEM_MOD_INTELLECT_SHORT = true,
		ITEM_MOD_SPIRIT_SHORT = true,
		ITEM_MOD_CRIT_RATING_SHORT = true,
		ITEM_MOD_HASTE_RATING_SHORT = true,
		ITEM_MOD_MASTERY_RATING_SHORT = true,
		ITEM_MOD_CR_MULTISTRIKE_SHORT = true,
		ITEM_MOD_VERSATILITY = true,
		ITEM_MOD_CR_LIFESTEAL_SHORT = true,
		ITEM_MOD_CR_AVOIDANCE_SHORT = true,
		ITEM_MOD_CR_SPEED_SHORT = true,
		--ITEM_MOD_CR_AMPLIFY_SHORT = true,
		--ITEM_MOD_CR_CLEAVE_SHORT = true,
		ITEM_MOD_SPELL_POWER_SHORT = true,
		ITEM_MOD_PVP_POWER_SHORT = true,
		ITEM_MOD_RESILIENCE_RATING_SHORT = true,
		ITEM_MOD_CR_STURDINESS_SHORT = true,
		resistance = true,
		sockets = true,
		
		usableweapons = 4,
		usablearmor = 3,
		hideagility = false,
		hidestrength = false,
		hideintellect = false,
		minquality = 1,
		showitemlevel = true,
	}
}
SimpleStats.options = {													-- Settings GUI table
	name = "SimpleStats",
	handler = SimpleStats,
	type = "group",
	get = "get",
	set = "set",
	
	args = {
		minquality = {
			type = "select",
			name = "Minimum Quality",
			desc = "Controls the minimum item quality that stat comparisons will be shown on",
			values = {"Uncommon", "Rare", "Epic"},
			order = 10,
			width = "double",
		},
		usableweapons = {
			type = "select",
			name = "Show on weapon types:",
			desc = "Controls which types of weapons stat comparisons will be shown on",
			values = {"All", "Only usable", "Only useful to current class", "Only useful to current specialization"},
			order = 20,
			width = "double",
		},
		usablearmor = {
			type = "select",
			name = "Show on armor types:",
			desc = "Controls which types of armor stat comparisons will be shown on",
			values = {"All", "Only wearable", "Only useful to current class"},
			order = 30,
			width = "double",
		},
		
		header2 = {type = "header", name = "Primary Stats", order = 90},
		
		ITEM_MOD_AGILITY_SHORT = {
			type = "toggle",
			name = "Agility",
			order = 100,
			width = "half"
		},
		ITEM_MOD_STRENGTH_SHORT = {
			type = "toggle",
			name = "Strength",
			order = 110,
			width = "half"
		},
		ITEM_MOD_INTELLECT_SHORT = {
			type = "toggle",
			name = "Intellect",
			order = 120,
			width = "half"
		},
		ITEM_MOD_STAMINA_SHORT = {
			type = "toggle",
			name = "Stamina",
			order = 130,
			width = "double"
		},
		RESISTANCE0_NAME = {
			type = "toggle",
			name = "Armor",
			order = 140,
			width = "half"
		},
		ITEM_MOD_DAMAGE_PER_SECOND_SHORT = {
			type = "toggle",
			name = "DPS",
			order = 150,
			width = "half"
		},
		showitemlevel = {
			type = "toggle",
			name = "Item Level",
			order = 155,
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
		ITEM_MOD_MASTERY_RATING_SHORT = {
			type = "toggle",
			name = "Mastery",
			order = 190,
		},
		ITEM_MOD_CR_MULTISTRIKE_SHORT = {
			type = "toggle",
			name = "Multistrike",
			order = 200,
		},
		ITEM_MOD_VERSATILITY = {
			type = "toggle",
			name = "Versatility",
			order = 210,
		},
		ITEM_MOD_SPIRIT_SHORT = {
			type = "toggle",
			name = "Spirit",
			order = 220,
		},
		ITEM_MOD_SPELL_POWER_SHORT = {
			type = "toggle",
			name = "Spell Power",
			order = 230,
		},
		ITEM_MOD_PVP_POWER_SHORT = {
			type = "toggle",
			name = "PvP Power",
			order = 240,
		},
		ITEM_MOD_RESILIENCE_RATING_SHORT = {
			type = "toggle",
			name = "PvP Resilience",
			order = 250,
		},
		resistance = {
			type = "toggle",
			name = "Resistances",
			order = 260,
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
		ITEM_MOD_CR_LIFESTEAL_SHORT = {
			type = "toggle",
			name = "Leech",
			order = 300,
		},
		ITEM_MOD_CR_AVOIDANCE_SHORT = {
			type = "toggle",
			name = "Avoidance",
			order = 310,
		},
		ITEM_MOD_CR_SPEED_SHORT = {
			type = "toggle",
			name = "Speed",
			order = 300,
		},
		--[[ITEM_MOD_CR_AMPLIFY_SHORT = {
			type = "toggle",a
			name = "Amplify",
			order = 310,
		},
		ITEM_MOD_CR_CLEAVE_SHORT = {
			type = "toggle",
			name = "Cleave",
			order = 320,
		},]]
		
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
function SimpleStats:get(key)											-- Getter function for settings, used by options table
	return self.db.profile[key[1]]
end
function SimpleStats:set(key,value)										-- Setter function for settings, used by options table
	self.db.profile[key[1]] = value
end

function SimpleStats:ChatCommand(input)									-- Chat command handler
	input = input:trim()
	if not input or input == "" then
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	
	elseif (input == "v" or input == "ver" or input == "version") then
		self:Print("Version: "..GetAddOnMetadata("SimpleStats","Version"))
	
	elseif (input == "profile" or input == "profiles") then
		InterfaceOptionsFrame_OpenToCategory(self.profileFrame)
		InterfaceOptionsFrame_OpenToCategory(self.profileFrame)
	
	else
		LibStub("AceConfigCmd-3.0").HandleCommand(self, "ss", "SimpleStats", input)
	end
end

function SimpleStats:SortStats(changedStats)							-- Takes a table of stat changes, returns a new table sorted by logical stat order and with positives first
	local increasedStats = {}	-- positive increases
	local decreasedStats = {}	-- negative increases
	local sortedStats = {}		-- final returned table
	
	-- Sort into two tables, positives and negatives
	for statName,statChange in pairs(changedStats) do
		if statChange > 0 then
			increasedStats[statName] = statChange
		elseif statChange < 0 then
			decreasedStats[statName] = statChange
		end
	end
	
	-- Add the positive stat changes, in the correct position based on the 'order' table, to the final table
	for statName,statChange in pairs(increasedStats) do
		statChange = math.floor(statChange)
		if self.order[statName] then
			local pos = self.order[statName]
			sortedStats[pos] = {statName,statChange}
		end
	end
	
	-- Finally, do the same thing for the negative stat changes, except offset them by #self.order so they always appear after the positive changes
	for statName,statChange in pairs(decreasedStats) do
		statChange = math.floor(statChange)
		if self.order[statName] then
			local pos = self.order[statName] + self.order.count
			sortedStats[pos] = {statName,statChange}
		end
	end
	
	-- Compress the table indexes
	local cleanStats = {}
	for k,stat in orderedPairs(sortedStats) do
		tinsert(cleanStats, stat)
	end
	
	return cleanStats
end

function SimpleStats:StatIsEnabled(statName)							-- Returns whether the given stat should be shown. Resistances and gem sockets are handled specially
	if strmatch(statName,"RESISTANCE_SHORT") then
		return self.db.profile.resistance
	elseif strmatch(statName, "EMPTY_SOCKET") then
		return self.db.profile.sockets
	else
		return self.db.profile[statName]
	end
end

function SimpleStats:GetStatChangeLines(newStats,currentStats, doIndent)-- Takes new stats, existing stats, and whether to indent (optional) and returns the stat change lines
	local statChanges = {}
	
	-- Add each new stat into the statChanges table
	for statName,statValue in pairs(newStats) do
		if currentStats[statName] then -- Stat exists on both, do subtraction
			statChanges[statName] = newStats[statName] - currentStats[statName]
		else -- New stat, just use the value
			statChanges[statName] = newStats[statName]
		end
	end
	
	-- For each current stat that doesn't exist on new, add a -xxx stat change to the statChanges table
	for statName,statValue in pairs(currentStats) do
		if not newStats[statName] then
			statChanges[statName] = -statValue
		end
	end
	
	-- Sort the stats in the proper order (primary first, then secondary, etc.)
	statChanges = self:SortStats(statChanges)
	
	-- If there's no stat changes, don't bother printing anything
	if #statChanges == 0 then return false end
	
	local lines = {}
	local indent = doIndent and "  " or ""
	
	-- Add the itemlevel change line, if it's enabled
	--if self.db.profile.showitemlevel then
	--	tinsert(lines, indent.."")
	--end
	
	for k,stat in orderedPairs(statChanges) do
		statName = stat[1]
		
		-- If it's a resistance, the localized strings are wrong and need to be converted to a second style to work
		convertedName = self.resistanceNames[statName] or statName
		
		statValue = stat[2]+0
		if self:StatIsEnabled(statName) then
			if (statValue > 0) then
				if self.noNumberStats[convertedName] then
					table.insert(lines, indent.."|cff00ff00+".._G[convertedName])
				else
					table.insert(lines, indent.."|cff00ff00+"..statValue.."|cffffffff ".._G[convertedName])
				end
			elseif (statValue < 0) then
				if self.noNumberStats[convertedName] then
					table.insert(lines, indent.."|cffff0000-".._G[convertedName])
				else
					table.insert(lines, indent.."|cffff0000"..statValue.."|cffffffff ".._G[convertedName])
				end
			end
		end
	end
	
	return lines
end

function SimpleStats:CombineItemStats(itemLink1,itemLink2)				-- Returns a table containing the combined stat bonuses of zero, one, or two items
	local combinedStats = {}
	if itemLink1 then
		combinedStats = GetItemStats(itemLink1)
		
		if itemLink2 then
			for statName,statValue in pairs(GetItemStats(itemLink2)) do
				if combinedStats[statName] then
					combinedStats[statName] = combinedStats[statName] + statValue
				else
					combinedStats[statName] = statValue
				end
			end
		end
	end
	
	return combinedStats
end

function SimpleStats:CheckWeaponType(weaponType)						-- Determines whether this weapon type should have stats printed for it (taking into account settings)
	local _,class = UnitClass("player")
	local specSlot = GetSpecialization()
	local usability, specID
	
	if specSlot then
		local specID = GetSpecializationInfo(specSlot)
		if self.usableWeapons[class][specID] and self.usableWeapons[class][specID][weaponType] then
			usability = self.usableWeapons[class][specID][weaponType]
			-- weapon matches our spec and is usable
		else
			usability = self.usableWeapons[class][weaponType]
			-- weapon doesn't match our spec, but is still usable
		end
	else
		usability = self.usableWeapons[class][weaponType]
		-- we don't have a spec, weapon is usable
	end
	
	if not usability and self.db.profile.usableweapons > 1 then
		return false
	end
	
	if self.db.profile.usableweapons == 1 then -- Show on all weapons
		return true
	elseif self.db.profile.usableweapons == 2 then -- Show on usable weapons
		return usability >= 1
	elseif self.db.profile.usableweapons == 3 then -- Show on useful weapons
		return usability >= 2
	elseif self.db.profile.usableweapons == 4 then -- Show on weapons useful to current spec
		return usability == 3 or (usability == 2 and not specID)
	end
end

function SimpleStats:CheckArmorType(armorType)							-- Determines whether this armor type should have stats printed for it (taking into account settings)
	if armorType == self.localized.armor.miscellaneous then
		return true -- If it's misc. armor (trinket, ring, etc.), always show
	end
	
	local _,class = UnitClass("player")
	local level = UnitLevel("player")
	local usability
	
	if self.usableArmor[class]["pre40"] and level < 40 then
		usability = self.usableArmor[class]["pre40"][armorType]
	elseif self.usableArmor[class]["pre40"] then
		usability = self.usableArmor[class]["post40"][armorType]
	else
		usability = self.usableArmor[class][armorType]
	end
	
	if not usability and self.db.profile.usablearmor > 1 then
		return false
	end
	
	if self.db.profile.usablearmor == 1 then -- Show on all armor
		return true
	elseif self.db.profile.usablearmor == 2 then -- Show on wearable armor
		return usability >= 1
	elseif self.db.profile.usablearmor == 3 then -- Show on useful armor
		return usability == 2
	end
end

function SimpleStats:IsWeapon2H(itemLink)								-- Returns whether the given weapon takes up both weapon slots
	if itemLink then
		local _,_,_,_,_,_,subType,_,invType = GetItemInfo(itemLink)
		
		-- RANGEDRIGHT requires an additional check since wands are RANGEDRIGHT but CAN be wielded with an off-hand
		if invType == "INVTYPE_2HWEAPON"
		or invType == "INVTYPE_RANGED"
		or (invType == "INVTYPE_RANGEDRIGHT" and subType ~= self.localized.weapons.wands) then
			return true
		end
	end
	
	return false
end

function SimpleStats:AreIdentical(itemLink1, itemLink2)					-- Determines whether two items are identical (takes into account id, suffix, difficulty, and bonuses)
	-- If either item is missing, they're obviously not identical
	if not itemLink1 or not itemLink2 then
		return false
	end
	
	-- Convert itemLinks to itemStrings
	itemLink1 = string.match(itemLink1, "item[%-?%d:]+")
	itemLink2 = string.match(itemLink2, "item[%-?%d:]+")
	
	local _, id1, _, _, _, _, _, suffix1, _, _, _, diff1, nbonus1 = strsplit(":", itemLink1)
	local _, id2, _, _, _, _, _, suffix2, _, _, _, diff2, nbonus2 = strsplit(":", itemLink2)
	
	local bonus1 = string.match(itemLink1, "item:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:(.+)")
	local bonus2 = string.match(itemLink2, "item:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+:(.+)")
	
	if  id1     == id2
	and suffix1 == suffix2
	and diff1   == diff2
	and bonus1  == bonus2 then
		return true
	else
		return false
	end
end

function SimpleStats:GetItemLevelDiff(tooltip, itemLevel1, itemLevel2)	-- Returns the item level difference between two items, if enabled
	local iLevelDifference = (itemLevel1 or 0) - (itemLevel2 or 0)
	
	if iLevelDifference > 0 then
		tooltip:AddLine("|cff00ff00+"..iLevelDifference.." |cffffe100ItemLevel")
	elseif iLevelDifference < 0 then
		tooltip:AddLine("|cffff0000"..iLevelDifference.." |cffffe100ItemLevel")
	end
end

function SimpleStats:MergeTooltipLines(lines, newLines, headerLine)		-- Takes a table of lines and a (possibly blank) table of new lines and appends them, adding an optional header line if there's any new lines
	if newLines then
		if headerLine then
			tinsert(lines, headerLine)
		end
		
		for k,line in pairs(newLines) do
			tinsert(lines, line)
		end
	end
	return lines
end

function SimpleStats:CanDualWield()										-- Determines whether the character can dual-wield
	local _,class = UnitClass("player")
	local level = UnitLevel("player")
	local specSlot = GetSpecialization()
	local specID
	
	if specSlot then
		specID = GetSpecializationInfo(specSlot)
	end
	
	if class == "HUNTER"											-- Hunters can always DW
	or class == "DEATHKNIGHT"										-- DKs can always DW
	or class == "ROGUE"												-- Rogues can always DW
	or (class == "WARRIOR" and specID == 72)						-- Fury warriors can DW
	or (class == "SHAMAN" and specID == 263)						-- Enhance shamans can DW
	or (class == "MONK" and (specID == 268 or specID == 269)) then	-- Brewmaster and Windwalker monks can DW
		return true
	else
		return false
	end
end

function SimpleStats:HandleTooltip(self, ...)							-- Tooltip handler, parses a tooltip and modifies it with the stat changes
	local _,itemLink = self:GetItem()
	if not itemLink then return end -- Quit if this isn't an item tooltip
	
	local _,_,rarity,itemLevel,_,itemType,itemSubType,_,invType = GetItemInfo(itemLink)
	local itemID = tonumber(strmatch(itemLink,"item:(%d+):"))
	
	-- Quit if:
	if (itemType ~= SimpleStats.localized.armorName and itemType ~= SimpleStats.localized.weaponName)								-- It's not armor or a weapon
	or (invType == "INVTYPE_TABARD" or invType == "INVTYPE_BODY")																	-- It's a shirt or tabard
	or (rarity < SimpleStats.db.profile.minquality+1)																				-- It's below our current quality threshold
	or (itemType == SimpleStats.localized.armorName and invType ~= "INVTYPE_CLOAK" and not SimpleStats:CheckArmorType(itemSubType))	-- It's armor and doesn't match our armor settings (but always show cloth->cloaks)
	or (itemType == SimpleStats.localized.weaponName and not SimpleStats:CheckWeaponType(itemSubType)) then							-- It's a weapon and doesn't match our weapon settings
		return
	end
	
	-- Get data on currently equipped items
	local equippedItems = {[1]={},[2]={slotExists=false}}
	local firstItemLink = GetInventoryItemLink("player",SimpleStats.invTypes[invType])
	if (firstItemLink) then
		local _,_,_,firstItemLevel = GetItemInfo(firstItemLink)
		
		equippedItems[1] = {
			id    = tonumber(strmatch(firstItemLink,"item:(%d+):")),
			level = firstItemLevel,
			link  = firstItemLink
		}
	end
	
	-- Get data on second equipped item if in a dual slot (ring, trinket, weapon)
	
	if SimpleStats.secondSlotID[SimpleStats.invTypes[invType]] then
		equippedItems[2].slotExists = true
		
		local secondItemLink = GetInventoryItemLink("player",SimpleStats.secondSlotID[SimpleStats.invTypes[invType]])
		if (secondItemLink) then
			local _,_,_,secondItemLevel = GetItemInfo(secondItemLink)
			
			equippedItems[2] = {
				id    = tonumber(strmatch(secondItemLink,"item:(%d+):")),
				level = secondItemLevel,
				link  = secondItemLink,
				slotExists = true
			}
		end
	end
	
	-- Quit if the item is identical to the only (most things)/both (rings, trinkets, etc.) equipped item
	if SimpleStats:AreIdentical(itemLink, equippedItems[1].link)
	and (SimpleStats:AreIdentical(itemLink, equippedItems[2].link) or not equippedItems[2].slotExists) then
		return
	end
	
	-- Retrieve data about the main-hand weapon for use later
	local currentMainHand = {}
	if GetInventoryItemLink("player",16) then
		local _,mhItemLink,_,mhItemLevel,_,_,mhSubType,_,mhInvType = GetItemInfo(GetInventoryItemLink("player",16))
		
		currentMainHand = {
			link = mhItemLink,
			level = mhItemLevel,
			subType = mhSubType,
			invType = mhInvType,
		}
	end
	
	local equippedIs2HWeapon = SimpleStats:IsWeapon2H(currentMainHand.link)
	
	local newStats = GetItemStats(itemLink)
	newStats.itemlevel = itemLevel
	
	-- Collect primary stats on the item for use below
	local primaryStats = {agi=0, str=0, int=0}
	for statName,statValue in pairs(newStats) do
		if     statName == "ITEM_MOD_AGILITY_SHORT"   then primaryStats.agi = statValue
		elseif statName == "ITEM_MOD_STRENGTH_SHORT"  then primaryStats.str = statValue
		elseif statName == "ITEM_MOD_INTELLECT_SHORT" then primaryStats.int = statValue
		end
	end
	
	-- Hide comparison if it has primary stats, has primary stats we're hiding, and DOESN'T have stats we're NOT hiding
	-- So an Int item is hidden if we're hiding Int, but if it also has Agi and we're not hiding it, show it since it's still useful
	-- But if it has no primary stats at all (like trinkets, often), never hide it
	if (primaryStats.agi > 0 or primaryStats.int > 0 or primaryStats.str > 0)
	and ((primaryStats.agi > 0 and SimpleStats.db.profile.hideagility)   or primaryStats.agi == 0)
	and ((primaryStats.str > 0 and SimpleStats.db.profile.hidestrength)  or primaryStats.str == 0)
	and ((primaryStats.int > 0 and SimpleStats.db.profile.hideintellect) or primaryStats.int == 0) then
		return
	end
	
	self:AddLine(" ")
	local tooltipLines = {}
	local lines
	
	-- If the item is a trinket, show stat changes for both trinkets, but if we don't have any trinkets, just show one stat comparison ('else' below)
	if invType == "INVTYPE_TRINKET" and (equippedItems[1].link or equippedItems[2].link) then
		--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[1].level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link), true)
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines, "Trinket 1:")
		
		--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[2].level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[2].link), true)
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines, "Trinket 2:")
	
	-- If the item is a ring, show stat changes for both rings, but if we don't have any rings, just show one stat comparison ('else' below)
	elseif invType == "INVTYPE_FINGER" and (equippedItems[1].link or equippedItems[2].link) then
		--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[1].level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link), true)
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines, "Ring 1:")
		
		--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[2].level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[2].link), true)
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines, "Ring 2:")
	
	-- If the item is a 1H weapon, show stat changes for both weapon slots, but if we don't have any weapons, just show one stat comparison ('else' below)
	-- Also, if we're wielding a 2H, show a standard comparison against it ('else' below)
	elseif invType == "INVTYPE_WEAPON" and (equippedItems[1].link or equippedItems[2].link) and not equippedIs2HWeapon then
		-- If the character can't dual wield, don't show two comparisons since it can only go in the first slot
		if SimpleStats:CanDualWield() then
			--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[1].level)
			lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link), true)
			tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines, "Weapon 1:")
			
			--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[2].level)
			lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[2].link), true)
			tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines, "Weapon 2:")
		else -- Functionally the same as 'else' below
			--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[1].level)
			lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link))
			tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines)
		end
	
	-- Looking at a 2H and two 1H are equipped, so combine their stats
	elseif SimpleStats:IsWeapon2H(itemLink) and equippedItems[1].id and equippedItems[2].id then
		--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[2].level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link, equippedItems[2].link))
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines)
	
	-- Looking at a 2H and something is in the off-hand slot, so compare to that
	elseif SimpleStats:IsWeapon2H(itemLink) and GetInventoryItemLink("player",17) then
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(GetInventoryItemLink("player",17)))
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines)
	
	-- Looking at an off-hand, and a 2h weapon is in the first wep slot, so compare to that
	elseif SimpleStats.invTypes[invType] == 17 and equippedIs2HWeapon then
		--SimpleStats:GetItemLevelDiff(self, itemLevel, currentMainHand.level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(currentMainHand.link))
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines)
	
	-- Otherwise, print a single stat comparison
	else
		--SimpleStats:GetItemLevelDiff(self, itemLevel, equippedItems[1].level)
		lines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link))
		tooltipLines = SimpleStats:MergeTooltipLines(tooltipLines, lines)
	end
	
	for k,line in pairs(tooltipLines) do
		self:AddLine(line)
	end
	
	-- Finally, show the tooltip now that we're done modifying it
	if (self:GetName() == "GameTooltip") then
		self:Show()
	end
end

function SimpleStats:SetupTables()										-- Sets up all of the utility/data tables used by the addon
	-- Maps between INVTYPEs and slot IDs
	self.invTypes = {
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
	
	-- Used both to determine whether a slot has a sibling slot, and if so, what its slotID is
	self.secondSlotID = {
		[11] = 12,
		[12] = 11,
		[13] = 14,
		[14] = 13,
		[16] = 17,
		[17] = 16,
	}
	
	-- Define the order that stats should appear in in tooltips
	local orderInverse = {
		"RESISTANCE0_NAME",
		"ITEM_MOD_DAMAGE_PER_SECOND_SHORT",
		"ITEM_MOD_AGILITY_SHORT",
		"ITEM_MOD_STRENGTH_SHORT",
		"ITEM_MOD_INTELLECT_SHORT",
		"ITEM_MOD_STAMINA_SHORT",
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
		"RESISTANCE1_NAME",
		"RESISTANCE2_NAME",
		"RESISTANCE3_NAME",
		"RESISTANCE4_NAME",
		"RESISTANCE5_NAME",
		"RESISTANCE6_NAME",
		"EMPTY_SOCKET_META",
		"EMPTY_SOCKET_PRISMATIC",
		"EMPTY_SOCKET_COGWHEEL",
		"EMPTY_SOCKET_RED",
		"EMPTY_SOCKET_BLUE",
		"EMPTY_SOCKET_YELLOW",
		"ITEM_MOD_CR_STURDINESS_SHORT",
		"ITEM_MOD_CR_LIFESTEAL_SHORT",
		"ITEM_MOD_CR_AVOIDANCE_SHORT",
		"ITEM_MOD_CR_SPEED_SHORT",
		--"ITEM_MOD_CR_AMPLIFY_SHORT",
		--"ITEM_MOD_CR_CLEAVE_SHORT",
	}
	
	-- Convert order table to "STAT_NAME" => index instead of "STAT_NAME"
	self.order = {}
	
	local count = 0
	for k,statName in pairs(orderInverse) do
		count = count+1
		self.order[statName] = k
	end
	
	-- Store a count of items in self.order for later use in SortStats()
	self.order.count = count
	
	-- Create mapping between the two different resistance names used
	self.resistanceNames = {
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
	
	-- The following stats should not show a number (+Indestructible instead of +57 Indestructible, for example)
	self.noNumberStats = {
		ITEM_MOD_CR_STURDINESS_SHORT = true,
	}
	
	-- Extract localized armor and weapon type strings from Auction House functions (no global strings for them are available)
	local itemClasses = {GetAuctionItemClasses()}
	local weaponTypes = {GetAuctionItemSubClasses(1)}
	local armorTypes = {GetAuctionItemSubClasses(2)}
	
	-- Define the order weapon names appear in GetAuctionItemSubClasses()
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
	
	-- Create the final localized string array structure
	self.localized = {
		weaponName = itemClasses[1],
		armorName = itemClasses[2],
		weapons = {},
		armor = {},
		reverse = {
			armor = {}
		}
	}
	
	-- Merge localized and english weapon names
	for i,name in pairs(names.weapons) do
		self.localized.weapons[name] = weaponTypes[i]
	end
	
	-- Merge localized and english armor names
	for i,name in pairs(names.armor) do
		self.localized.armor[name] = armorTypes[i]
	end
	
	-- Create inverse table for localized -> english conversion
	for engname,locname in pairs(self.localized.armor) do
		self.localized.reverse.armor[locname] = engname
	end
	
	-- 3=Useful for spec, 2=Useful for class, 1=Usable
	self.usableWeapons = {
		WARLOCK = {
			[self.localized.weapons.onehandedswords] 		= 3,
			[self.localized.weapons.daggers]				= 3,
			[self.localized.weapons.staves]					= 3,
			[self.localized.weapons.wands]					= 3,
		},
		MAGE = {
			[self.localized.weapons.onehandedswords]		= 3,
			[self.localized.weapons.daggers]				= 3,
			[self.localized.weapons.staves]					= 3,
			[self.localized.weapons.wands]					= 3,
		},
		PRIEST = {
			[self.localized.weapons.onehandedmaces]			= 3,
			[self.localized.weapons.daggers]				= 3,
			[self.localized.weapons.staves]					= 3,
			[self.localized.weapons.wands]					= 3,
		},
		DRUID = {
			[self.localized.weapons.onehandedmaces]			= 2,
			[self.localized.weapons.twohandedmaces]			= 2,
			[self.localized.weapons.daggers]				= 2,
			[self.localized.weapons.fistweapons]			= 2,
			[self.localized.weapons.polearms]				= 2,
			[self.localized.weapons.staves]					= 2,
			
			[102] = { -- Balance
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
				[self.localized.weapons.polearms]			= 3,
				[self.localized.weapons.staves]				= 3,
			},
			[103] = { -- Feral
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.polearms]			= 3,
				[self.localized.weapons.staves]				= 3,
			},
			[104] = { -- Guardian
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.polearms]			= 3,
				[self.localized.weapons.staves]				= 3,
			},
			[105] = { -- Restoration
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
				[self.localized.weapons.polearms]			= 3,
				[self.localized.weapons.staves]				= 3,
			},
		},
		ROGUE = {
			[self.localized.weapons.bows]					= 1,
			[self.localized.weapons.crossbows]				= 1,
			[self.localized.weapons.guns]					= 1,
			
			[self.localized.weapons.onehandedaxes]			= 2,
			[self.localized.weapons.onehandedmaces]			= 2,
			[self.localized.weapons.onehandedswords]		= 2,
			[self.localized.weapons.daggers]				= 2,
			[self.localized.weapons.fistweapons]			= 2,
			
			[259] = { -- Assassination
				[self.localized.weapons.daggers]			= 3,
			},
			[260] = { -- Combat
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.onehandedswords]	= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
			},
			[261] = { -- Subtlety
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.onehandedswords]	= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
			},
		},
		MONK = {
			[self.localized.weapons.onehandedaxes]			= 3,
			[self.localized.weapons.onehandedmaces]			= 3,
			[self.localized.weapons.onehandedswords]		= 3,
			[self.localized.weapons.fistweapons]			= 3,
			[self.localized.weapons.polearms]				= 3,
			[self.localized.weapons.staves]					= 3,
		},
		SHAMAN = {
			[self.localized.weapons.onehandedaxes]			= 2,
			[self.localized.weapons.onehandedmaces]			= 2,
			[self.localized.weapons.twohandedaxes]			= 2,
			[self.localized.weapons.twohandedmaces]			= 2,
			[self.localized.weapons.daggers]				= 2,
			[self.localized.weapons.fistweapons]			= 2,
			[self.localized.weapons.staves]					= 2,
			
			[262] = { -- Elemental
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.twohandedaxes]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
				[self.localized.weapons.staves]				= 3,
			},
			[262] = { -- Enhancement
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
			},
			[262] = { -- Restoration
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.twohandedaxes]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
				[self.localized.weapons.staves]				= 3,
			},
		},
		HUNTER = {
			[self.localized.weapons.onehandedaxes]			= 1,
			[self.localized.weapons.onehandedswords]		= 1,
			[self.localized.weapons.twohandedaxes]			= 1,
			[self.localized.weapons.twohandedswords]		= 1,
			[self.localized.weapons.daggers]				= 1,
			[self.localized.weapons.fistweapons]			= 1,
			[self.localized.weapons.polearms]				= 1,
			[self.localized.weapons.staves]					= 1,
			
			[self.localized.weapons.guns]					= 3,
			[self.localized.weapons.bows]					= 3,
			[self.localized.weapons.crossbows]				= 3,
		},
		WARRIOR = {
			[self.localized.weapons.bows]					= 1,
			[self.localized.weapons.crossbows]				= 1,
			[self.localized.weapons.guns]					= 1,
			
			[self.localized.weapons.onehandedaxes]			= 2,
			[self.localized.weapons.onehandedmaces]			= 2,
			[self.localized.weapons.onehandedswords]		= 2,
			[self.localized.weapons.twohandedaxes]			= 2,
			[self.localized.weapons.twohandedmaces]			= 2,
			[self.localized.weapons.twohandedswords]		= 2,
			[self.localized.weapons.daggers]				= 2,
			[self.localized.weapons.fistweapons]			= 2,
			[self.localized.weapons.polearms]				= 2,
			[self.localized.weapons.staves]					= 2,
			
			[71] = { -- Arms
				[self.localized.weapons.twohandedaxes]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.twohandedswords]	= 3,
				[self.localized.weapons.polearms]			= 3,
				[self.localized.weapons.staves]				= 3,
			},
			[72] = { -- Fury
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.onehandedswords]	= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
			},
			[73] = { -- Protection
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.onehandedswords]	= 3,
				[self.localized.weapons.daggers]			= 3,
				[self.localized.weapons.fistweapons]		= 3,
			},
		},
		PALADIN = {
			[self.localized.weapons.onehandedaxes]			= 2,
			[self.localized.weapons.onehandedmaces]			= 2,
			[self.localized.weapons.onehandedswords]		= 2,
			[self.localized.weapons.twohandedaxes]			= 2,
			[self.localized.weapons.twohandedmaces]			= 2,
			[self.localized.weapons.twohandedswords]		= 2,
			[self.localized.weapons.polearms]				= 2,
				
			[67] = { -- Retribution
				[self.localized.weapons.twohandedaxes]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.twohandedswords]	= 3,
				[self.localized.weapons.polearms]			= 3,
			},
			[66] = { -- Protection
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.onehandedswords]	= 3,
			},
			[65] = { -- Holy
				[self.localized.weapons.onehandedaxes]		= 3,
				[self.localized.weapons.onehandedmaces]		= 3,
				[self.localized.weapons.onehandedswords]	= 3,
				[self.localized.weapons.twohandedaxes]		= 3,
				[self.localized.weapons.twohandedmaces]		= 3,
				[self.localized.weapons.twohandedswords]	= 3,
				[self.localized.weapons.polearms]			= 3,
			},
		},
		DEATHKNIGHT = {
			[self.localized.weapons.onehandedaxes]			= 3,
			[self.localized.weapons.onehandedmaces]			= 3,
			[self.localized.weapons.onehandedswords]		= 3,
			[self.localized.weapons.twohandedaxes]			= 3,
			[self.localized.weapons.twohandedmaces]			= 3,
			[self.localized.weapons.twohandedswords]		= 3,
			[self.localized.weapons.polearms]				= 3,
		}
	}
	
	-- 2=Useful for class, 1=Usable
	self.usableArmor = {
		WARLOCK = {
			[self.localized.armor.cloth]		= 2,
		},
		MAGE = {
			[self.localized.armor.cloth]		= 2,
		},
		PRIEST = {
			[self.localized.armor.cloth]		= 2,
		},
		DRUID = {
			[self.localized.armor.cloth]		= 1,
			[self.localized.armor.leather]		= 2,
		},
		ROGUE = {
			[self.localized.armor.cloth]		= 1,
			[self.localized.armor.leather]		= 2,
		},
		MONK = {
			[self.localized.armor.cloth]		= 1,
			[self.localized.armor.leather]		= 2,
		},
		SHAMAN = {
			["pre40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 2,
				[self.localized.armor.shields]	= 2,
			},
			["post40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 1,
				[self.localized.armor.mail]		= 2,
				[self.localized.armor.shields]	= 2,
			},
		},
		HUNTER = {
			["pre40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 2,
			},
			["post40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 1,
				[self.localized.armor.mail]		= 2,
			},
		},
		WARRIOR = {
			["pre40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 1,
				[self.localized.armor.mail]		= 2,
				[self.localized.armor.shields]	= 2,
			},
			["post40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 1,
				[self.localized.armor.mail]		= 1,
				[self.localized.armor.plate]	= 2,
				[self.localized.armor.shields]	= 2,
			},
		},
		PALADIN = {
			["pre40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 1,
				[self.localized.armor.mail]		= 2,
				[self.localized.armor.shields]	= 2,
			},
			["post40"] = {
				[self.localized.armor.cloth]	= 1,
				[self.localized.armor.leather]	= 1,
				[self.localized.armor.mail]		= 1,
				[self.localized.armor.plate]	= 2,
				[self.localized.armor.shields]	= 2,
			},
		},
		DEATHKNIGHT = {
			[self.localized.armor.cloth]		= 1,
			[self.localized.armor.leather]		= 1,
			[self.localized.armor.mail]			= 1,
			[self.localized.armor.plate]		= 2,
		}
	}
end

function SimpleStats:HideBlizzComparison(self)							-- Copied from OldComparison - http://www.wowinterface.com/downloads/fileinfo.php?id=14454
	local old = self.SetHyperlinkCompareItem
	self.SetHyperlinkCompareItem = function(self, link, level, shift, main, ...)
		main = nil
		return old(self, link, level, shift, main, ...)
	end
end

function SimpleStats:OnInitialize()										-- Runs when addon is initialized
	self.db = LibStub("AceDB-3.0"):New("SimpleStatsDB", self.defaults)
	local profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SimpleStats", self.options)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SimpleStats Profile", profileOptions)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SimpleStats","SimpleStats")
	self.profileFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SimpleStats Profile", "Profiles", "SimpleStats")
	
	self:RegisterChatCommand("ss", "ChatCommand")
	self:RegisterChatCommand("simplestats", "ChatCommand")
	
	self:SetupTables()
	
	self:HookScript(GameTooltip, "OnTooltipSetItem", "HandleTooltip")
	self:HookScript(ItemRefTooltip, "OnTooltipSetItem", "HandleTooltip")
	
	self:HideBlizzComparison(ShoppingTooltip1)
	self:HideBlizzComparison(ShoppingTooltip2)
	self:HideBlizzComparison(ItemRefShoppingTooltip1)
	self:HideBlizzComparison(ItemRefShoppingTooltip2)
end

--- Misc Lua Functions ---
if not print_r then				-- Debug function to print the contents of a table
function print_r ( t ) 
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end
end
function __genOrderedIndex(t)	-- Used by orderedNext()
    local orderedIndex = {}
    for key in pairs(t) do table.insert( orderedIndex, key ) end
    table.sort( orderedIndex )
    return orderedIndex
end
function orderedNext(t, state)	-- Used by orderedPairs()
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
function orderedPairs(t)		-- Same as pairs(table), but keys are returned sorted by key (alphabetically/numerically) instead of whatever order lua wants
    return orderedNext, t, nil
end
