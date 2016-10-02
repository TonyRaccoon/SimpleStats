SimpleStats = LibStub("AceAddon-3.0"):NewAddon("SimpleStats", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

-- Retrieve localization table
local ADDON_NAME,namespace = ...
local L = namespace.L

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
		ITEM_MOD_DODGE_RATING_SHORT = true,
		ITEM_MOD_PARRY_RATING_SHORT = true,
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
		minquality = 2,
		showitemlevel = true,
		hideondisabledprimaries = false,
		hideonlowerilevel = false,
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
			name = L["Minimum item quality"],
			desc = L["Stat comparisons will only be shown on items with this quality or higher"],
			values = {ITEM_QUALITY1_DESC, ITEM_QUALITY2_DESC, ITEM_QUALITY3_DESC, ITEM_QUALITY4_DESC},
			order = 10,
			width = "double",
		},
		usableweapons = {
			type = "select",
			name = L["Show on weapon types:"],
			desc = L["Controls which types of weapons stat comparisons will be shown on"],
			values = {L["All"], L["Only usable by current class"], L["Only useful to current class"], L["Only useful to current specialization"]},
			order = 20,
			width = "double",
		},
		usablearmor = {
			type = "select",
			name = L["Show on armor types:"],
			desc = L["Controls which types of armor stat comparisons will be shown on"],
			values = {L["All"], L["Only wearable by current class"], L["Only useful to current class"]},
			order = 30,
			width = "double",
		},
		hideondisabledprimaries = {
			type = "toggle",
			name = L["Hide comparison if disabled primary stat exists"],
			desc = L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."],
			order = 40,
			width = "full"
		},
		hideonlowerilevel = {
			type = "toggle",
			name = L["Hide comparison if item level is lower"],
			order = 50,
			width = "full"
		},
		
		header2 = {type = "header", name = L["Primary Stats"], order = 90},
		
		ITEM_MOD_STRENGTH_SHORT = {
			type = "toggle",
			name = ITEM_MOD_STRENGTH_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_STRENGTH_SHORT),
			order = 100,
			width = "half"
		},
		ITEM_MOD_AGILITY_SHORT = {
			type = "toggle",
			name = ITEM_MOD_AGILITY_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_AGILITY_SHORT),
			order = 110,
			width = "half"
		},
		ITEM_MOD_INTELLECT_SHORT = {
			type = "toggle",
			name = ITEM_MOD_INTELLECT_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_INTELLECT_SHORT),
			order = 120,
			width = "half"
		},
		ITEM_MOD_STAMINA_SHORT = {
			type = "toggle",
			name = ITEM_MOD_STAMINA_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_STAMINA_SHORT),
			order = 130,
			width = "double"
		},
		RESISTANCE0_NAME = {
			type = "toggle",
			name = RESISTANCE0_NAME,
			desc = format(L["Show %s in stat comparisons"], RESISTANCE0_NAME),
			order = 140,
			width = "half"
		},
		ITEM_MOD_DAMAGE_PER_SECOND_SHORT = {
			type = "toggle",
			name = STAT_DPS_SHORT,
			desc = format(L["Show %s in stat comparisons"], STAT_DPS_SHORT),
			order = 150,
			width = "half"
		},
		showitemlevel = {
			type = "toggle",
			name = STAT_AVERAGE_ITEM_LEVEL,
			desc = format(L["Show %s in stat comparisons"], STAT_AVERAGE_ITEM_LEVEL:lower()),
			order = 155,
		},
		
		header3 = {type = "header", name = L["Secondary Stats"], order = 160},
		
		ITEM_MOD_CRIT_RATING_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CRIT_RATING_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CRIT_RATING_SHORT),
			order = 170,
		},
		ITEM_MOD_HASTE_RATING_SHORT = {
			type = "toggle",
			name = ITEM_MOD_HASTE_RATING_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_HASTE_RATING_SHORT),
			order = 180,
		},
		ITEM_MOD_MASTERY_RATING_SHORT = {
			type = "toggle",
			name = ITEM_MOD_MASTERY_RATING_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_MASTERY_RATING_SHORT),
			order = 190,
		},
		--[[ITEM_MOD_CR_MULTISTRIKE_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CR_MULTISTRIKE_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_MULTISTRIKE_SHORT),
			order = 200,
		},]]
		ITEM_MOD_VERSATILITY = {
			type = "toggle",
			name = ITEM_MOD_VERSATILITY,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_VERSATILITY),
			order = 210,
		},
		resistance = {
			type = "toggle",
			name = RESISTANCE_LABEL,
			desc = format(L["Show %s in stat comparisons"], RESISTANCE_LABEL:lower()),
			order = 220,
		},
		--[[ITEM_MOD_SPIRIT_SHORT = {
			type = "toggle",
			name = ITEM_MOD_SPIRIT_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_SPIRIT_SHORT),
			order = 230,
		},]]
		ITEM_MOD_DODGE_RATING_SHORT = {
			type = "toggle",
			name = ITEM_MOD_DODGE_RATING_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_DODGE_RATING_SHORT),
			order = 240,
		},
		ITEM_MOD_PVP_POWER_SHORT = {
			type = "toggle",
			name = ITEM_MOD_PVP_POWER_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_PVP_POWER_SHORT),
			order = 250,
		},
		ITEM_MOD_SPELL_POWER_SHORT = {
			type = "toggle",
			name = ITEM_MOD_SPELL_POWER_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_SPELL_POWER_SHORT),
			order = 260,
		},
		ITEM_MOD_PARRY_RATING_SHORT = {
			type = "toggle",
			name = ITEM_MOD_PARRY_RATING_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_PARRY_RATING_SHORT),
			order = 270,
		},
		ITEM_MOD_RESILIENCE_RATING_SHORT = {
			type = "toggle",
			name = ITEM_MOD_RESILIENCE_RATING_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_RESILIENCE_RATING_SHORT),
			order = 280,
		},
		
		
		header4 = {type = "header", name = L["Minor Stats"], order = 290},
		
		sockets = {
			type = "toggle",
			name = L["Gem Sockets"],
			desc = format(L["Show %s in stat comparisons"], L["Gem Sockets"]:lower()),
			order = 300,
		},
		ITEM_MOD_CR_STURDINESS_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CR_STURDINESS_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_STURDINESS_SHORT),
			order = 310,
		},
		ITEM_MOD_CR_LIFESTEAL_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CR_LIFESTEAL_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_LIFESTEAL_SHORT),
			order = 320,
		},
		ITEM_MOD_CR_AVOIDANCE_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CR_AVOIDANCE_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_AVOIDANCE_SHORT),
			order = 330,
		},
		ITEM_MOD_CR_SPEED_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CR_SPEED_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_SPEED_SHORT),
			order = 340,
		},
		--[[ITEM_MOD_CR_AMPLIFY_SHORT = {
			type = "toggle",a
			name = ITEM_MOD_CR_AMPLIFY_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_AMPLIFY_SHORT),
			order = 350,
		},
		ITEM_MOD_CR_CLEAVE_SHORT = {
			type = "toggle",
			name = ITEM_MOD_CR_CLEAVE_SHORT,
			desc = format(L["Show %s in stat comparisons"], ITEM_MOD_CR_CLEAVE_SHORT),
			order = 360,
		},]]
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
		self:Print(GAME_VERSION_LABEL..": "..GetAddOnMetadata("SimpleStats","Version"))
	
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
		if statName == "ITEM_MOD_DAMAGE_PER_SECOND_SHORT" then
			statChange = round(statChange, 2)
		else
			statChange = math.floor(statChange)
		end
		
		if self.order[statName] then
			local pos = self.order[statName]
			sortedStats[pos] = {statName,statChange}
		end
	end
	
	-- Finally, do the same thing for the negative stat changes, except offset them by #self.order so they always appear after the positive changes
	for statName,statChange in pairs(decreasedStats) do
		if statName == "ITEM_MOD_DAMAGE_PER_SECOND_SHORT" then
			statChange = round(statChange, 2)
		else
			statChange = math.floor(statChange)
		end
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
	elseif statName == "STAT_AVERAGE_ITEM_LEVEL" then
		return self.db.profile.showitemlevel
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
	
	-- Store item level change external to statChanges table since it's much harder to extract after sorting
	local itemLevelChange = statChanges.STAT_AVERAGE_ITEM_LEVEL
	
	-- Sort the stats in the proper order (primary first, then secondary, etc.)
	statChanges = self:SortStats(statChanges)
	
	-- If there's no stat changes, don't bother printing anything
	if #statChanges == 0 then return {} end
	
	local lines = {}
	local indent = doIndent and "  " or ""
	
	if self.db.profile.showitemlevel then
		if itemLevelChange > 0 then
			table.insert(lines, {text=indent.."|cffbbff00+"..itemLevelChange.." |cffffe100"..STAT_AVERAGE_ITEM_LEVEL})
		elseif itemLevelChange < 0 then
			table.insert(lines, {text=indent.."|cffff7423"..itemLevelChange.." |cffffe100"..STAT_AVERAGE_ITEM_LEVEL})
		end
	end
	
	-- Quit if the item level is lower than what we have, and that option is enabled	
	if SimpleStats.db.profile.hideonlowerilevel and itemLevelChange < 0 then
		return lines
	end
	
	-- Used later to determine if any stats were actually shown; if not, don't show the header line ("Trinket 1:", etc.)
	local aStatIsShown = false
	
	for k,stat in orderedPairs(statChanges) do
		statName = stat[1]
		
		-- If it's a resistance, the localized strings are wrong and need to be converted to a second style to work
		convertedName = self.resistanceNames[statName] or statName
		
		statValue = stat[2]+0
		if self:StatIsEnabled(statName) and statName ~= "STAT_AVERAGE_ITEM_LEVEL" then
			aStatIsShown = true
			if (statValue > 0) then
				if self.noNumberStats[convertedName] then
					table.insert(lines, {text=indent.."|cff00ff00+".._G[convertedName]})
				else
					table.insert(lines, {text=indent.."|cff00ff00+"..statValue.."|cffffffff ".._G[convertedName]})
				end
			elseif (statValue < 0) then
				if self.noNumberStats[convertedName] then
					table.insert(lines, {text=indent.."|cffff0000-".._G[convertedName]})
				else
					table.insert(lines, {text=indent.."|cffff0000"..statValue.."|cffffffff ".._G[convertedName]})
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
		
		-- Add item level to stat table
		local itemLevel1 = SimpleStats:GetTrueItemLevel(itemLink1)
		combinedStats["STAT_AVERAGE_ITEM_LEVEL"] = itemLevel1
		
		if itemLink2 then
			-- Set item level to the average of the two items
			local itemLevel2 = SimpleStats:GetTrueItemLevel(itemLink2)
			combinedStats["STAT_AVERAGE_ITEM_LEVEL"] = math.floor((itemLevel1+itemLevel2)/2)
		
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
	if armorType == LE_ITEM_ARMOR_GENERIC then
		return true -- If it's misc. armor (trinket, ring, etc.), always show
	end
	
	local _,class = UnitClass("player")
	local usability = self.usableArmor[class][armorType]
	
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
		local _,_,_,_,_,_,_,_,invType,_,_,classID,subclassID = GetItemInfo(itemLink)
		
		-- RANGEDRIGHT requires an additional check since wands are RANGEDRIGHT but CAN be wielded with an off-hand
		if invType == "INVTYPE_2HWEAPON"
		or invType == "INVTYPE_RANGED"
		or (invType == "INVTYPE_RANGEDRIGHT" and subclassID ~= LE_ITEM_WEAPON_WAND) then
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
	
	local _, itemID1, _, _, _, _, _, suffixID1, _, _, _, upgradeType1, instanceDifficultyID1 = strsplit(":", itemLink1)
	local _, itemID2, _, _, _, _, _, suffixID2, _, _, _, upgradeType2, instanceDifficultyID2 = strsplit(":", itemLink2)
	
	local bonuses1 = string.match(itemLink1, "item:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:(.*)")
	local bonuses2 = string.match(itemLink2, "item:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:%d*:(.*)")
	
	return (
		itemID1 == itemID2
		and suffixID1 == suffixID2
		and upgradeType1 == upgradeType2
		and instanceDifficultyID1 == instanceDifficultyID2
		and bonuses1 == bonuses2
	)
end

function SimpleStats:GetTrueItemLevel(itemString)						-- Scans an item tooltip for the TRUE itemlevel (for heirlooms and Timewalker gear, for example)
	-- Copied and slightly modified from LibItemUpgradeInfo by eridius
	local _, itemLink, rarity, itemLevel = GetItemInfo(itemString)
	local ilvl = self.heirloomCache[itemLink]
	
	if ilvl ~= nil then
		return ilvl, true
	end
	
	if not self.scanningTooltip then
		self.scanningTooltip = _G.CreateFrame("GameTooltip", "LibItemUpgradeInfoTooltip", nil, "GameTooltipTemplate")
		self.scanningTooltip:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
	end
	
	self.scanningTooltip:ClearLines()
	self.scanningTooltip:SetHyperlink(itemLink)
	
	for i = 2, 4 do
		local label, text = _G["LibItemUpgradeInfoTooltipTextLeft"..i], nil
		if label then text=label:GetText() end
		if text then
			ilvl = tonumber(text:match(self.itemLevelPattern))
			if ilvl ~= nil then
				self.heirloomCache[itemLink] = ilvl
				return ilvl, true
			end
		end
	end
	
	return itemLevel, false
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

function SimpleStats:AddLinesToTooltip(tooltip,lines)					-- Adds the given lines to the given tooltip
	local printedSeparator = false
	
	for k,line in pairs(lines) do
		-- If it has child line elements, print as a header and print all the children indented
		if line.lines and #line.lines > 0 then
			-- Print a separator if we haven't already
			if not printedSeparator then
				tooltip:AddLine(" ")
				printedSeparator = true
			end
			
			tooltip:AddLine(line.text)
			
			for k,subline in pairs(line.lines) do
				tooltip:AddLine("  "..subline.text)
			end
		elseif not line.lines then -- not is there so above if doesn't default to this if line.lines exists and #line.lines == 0
			-- Print a separator if we haven't already
			if not printedSeparator then
				tooltip:AddLine(" ")
				printedSeparator = true
			end
			
			tooltip:AddLine(line.text)
		end
	end
	
	-- :Show()ing the tooltip forces it to recalculate its sized based on contents
	tooltip:Show()
end

function SimpleStats:HandleTooltip(self, ...)							-- Tooltip handler, parses a tooltip and modifies it with the stat changes
	local _,itemLink = self:GetItem()
	if not itemLink then return end -- Quit if this isn't an item tooltip
	
	local _,_,rarity,_,_,_,_,_,invType,_,_,classID,subclassID = GetItemInfo(itemLink)
	local itemID = tonumber(strmatch(itemLink,"item:(%d+):"))
	
	-- Quit if:																											-- Quit if:
	if (classID ~= LE_ITEM_CLASS_ARMOR and classID ~= LE_ITEM_CLASS_WEAPON)												-- It's not armor or a weapon
	or (invType == "INVTYPE_TABARD" or invType == "INVTYPE_BODY")														-- It's a shirt or tabard
	or (rarity < SimpleStats.db.profile.minquality)																		-- It's below our current quality threshold
	or (classID == LE_ITEM_CLASS_ARMOR and invType ~= "INVTYPE_CLOAK" and not SimpleStats:CheckArmorType(subclassID))	-- It's armor and doesn't match our armor settings (but always show cloth->cloaks)
	or (classID == LE_ITEM_CLASS_WEAPON and not SimpleStats:CheckWeaponType(subclassID))								-- It's a weapon and doesn't match our weapon settings
	or (SimpleStats.blacklistedItems[itemID])																			-- It's a blacklisted item
	or (strmatch(GetMouseFocus() and GetMouseFocus():GetName() or "", "^Character.*Slot$")) then						-- We're looking at an equipped item
		return
	end
	
	-- Get data on currently equipped items
	local equippedItems = {[1]={level=0},[2]={slotExists=false, level=0}}
	local firstItemLink = GetInventoryItemLink("player",SimpleStats.invTypes[invType])
	if (firstItemLink) then
		local firstItemLevel = SimpleStats:GetTrueItemLevel(firstItemLink)
		
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
			local secondItemLevel = SimpleStats:GetTrueItemLevel(secondItemLink)
			
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
		local _,mhItemLink,_,_,_,_,mhSubType,_,mhInvType = GetItemInfo(GetInventoryItemLink("player",16))
		local mhItemLevel = SimpleStats:GetTrueItemLevel(GetInventoryItemLink("player",16))
		
		currentMainHand = {
			link = mhItemLink,
			level = mhItemLevel,
			subType = mhSubType,
			invType = mhInvType,
		}
	end
	
	local equippedIs2HWeapon = SimpleStats:IsWeapon2H(currentMainHand.link)
	local newStats = GetItemStats(itemLink)
	
	local itemLevel = SimpleStats:GetTrueItemLevel(itemLink)
	newStats["STAT_AVERAGE_ITEM_LEVEL"] = itemLevel
	
	-- Collect primary stats on the item for use below
	local primaryStats = {agi=0, str=0, int=0}
	for statName,statValue in pairs(newStats) do
		if     statName == "ITEM_MOD_AGILITY_SHORT"   then primaryStats.agi = statValue
		elseif statName == "ITEM_MOD_STRENGTH_SHORT"  then primaryStats.str = statValue
		elseif statName == "ITEM_MOD_INTELLECT_SHORT" then primaryStats.int = statValue
		end
	end
	
	-- Hide comparison if it has primary stats, has primary stats we're not showing, and DOESN'T have stats we're showing
	-- So an Int item is hidden if we're not showing Int, but if it also has Agi and we're showing that, show it since it's still useful
	-- But if it has no primary stats at all (like trinkets, often), never hide it
	if (primaryStats.agi > 0 or primaryStats.int > 0 or primaryStats.str > 0)
	and SimpleStats.db.profile.hideondisabledprimaries
	and ((primaryStats.agi > 0 and not SimpleStats.db.profile.ITEM_MOD_AGILITY_SHORT)   or primaryStats.agi == 0)
	and ((primaryStats.str > 0 and not SimpleStats.db.profile.ITEM_MOD_STRENGTH_SHORT)  or primaryStats.str == 0)
	and ((primaryStats.int > 0 and not SimpleStats.db.profile.ITEM_MOD_INTELLECT_SHORT) or primaryStats.int == 0) then
		return
	end
	
	local tooltipLines = {}
	
	-- If the item is a trinket, show stat changes for both trinkets, but if we don't have any trinkets, just show one stat comparison ('else' below)
	if invType == "INVTYPE_TRINKET" and (equippedItems[1].link or equippedItems[2].link) then
		tinsert(tooltipLines, {text="Trinket 1:", lines=  SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link), true)  })
		tinsert(tooltipLines, {text="Trinket 2:", lines=  SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[2].link), true)  })
	
	-- If the item is a ring, show stat changes for both rings, but if we don't have any rings, just show one stat comparison ('else' below)
	elseif invType == "INVTYPE_FINGER" and (equippedItems[1].link or equippedItems[2].link) then
		tinsert(tooltipLines, {text="Ring 1:", lines=  SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link), true)  })
		tinsert(tooltipLines, {text="Ring 2:", lines=  SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[2].link), true)  })
	
	-- If the item is a 1H weapon, show stat changes for both weapon slots, but if we don't have any weapons, just show one stat comparison ('else' below)
	-- Also, if we're wielding a 2H, show a standard comparison against it ('else' below)
	elseif invType == "INVTYPE_WEAPON" and (equippedItems[1].link or equippedItems[2].link) and not equippedIs2HWeapon then
		-- If the character can't dual wield, don't show two comparisons since it can only go in the first slot
		if SimpleStats:CanDualWield() then
			tinsert(tooltipLines, {text="Weapon 1:", lines=  SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link), true)  })
			tinsert(tooltipLines, {text="Weapon 2:", lines=  SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[2].link), true)  })
		else -- Functionally the same as 'else' below
			tooltipLines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link))
		end
	
	-- Looking at a 2H and two 1H are equipped, so combine their stats
	elseif SimpleStats:IsWeapon2H(itemLink) and equippedItems[1].id and equippedItems[2].id then
		tooltipLines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link, equippedItems[2].link))
	
	-- Looking at a 2H and something is in the off-hand slot, so compare to that
	elseif SimpleStats:IsWeapon2H(itemLink) and GetInventoryItemLink("player",17) then
		tooltipLines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(GetInventoryItemLink("player",17)))
	
	-- Looking at an off-hand, and a 2h weapon is in the first wep slot, so compare to that
	elseif SimpleStats.invTypes[invType] == 17 and equippedIs2HWeapon then
		tooltipLines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(currentMainHand.link))
	
	-- Otherwise, print a single stat comparison
	else
		tooltipLines = SimpleStats:GetStatChangeLines(newStats, SimpleStats:CombineItemStats(equippedItems[1].link))
	end
	
	-- Finally, augment the tooltip
	SimpleStats:AddLinesToTooltip(self,tooltipLines)
end

function SimpleStats:SetupTables()										-- Sets up all of the utility/data tables used by the addon
	
	-- These items should never show a stat comparison (most of them are Use: items with a classID of LE_ITEM_CLASS_ARMOR/WEAPON)
	local blacklist = {
		114052,114053,114094,114096,114097,114098,114099,114100,114101,114105,114108,	-- 512-610 mission gear
		114057,114058,114059,114063,114066,114068,114109,								-- 615 mission gear
		114069,114070,114071,114075,114078,114080,114110,								-- 630 mission gear
		114082,114083,114084,114085,114086,114087,114112,								-- 645 mission gear
		114745,114808,114822,114807,114806,114746,										-- Follower armor upgrades
		114128,114129,114131,114616,114081,114622,										-- Follower weapon upgrades
		120313,																			-- Sanketsu
		
		124550,124551,124552,124553,124554,124555,124556,124557,124558,124559,124560,
		124561,124562,127779,127780,127783,127784,127792,127793,127796,127797,127799,	-- Baleful tokens
		127800,127805,127806,127809,127810,127818,127819,127822,127823,128348,
		
		128225,																			-- Empowered Apexis Fragment
	}
	
	-- Inverse the blacklist so we can do self.blacklistedItems[itemID]
	self.blacklistedItems = {}
	for k,itemID in pairs(blacklist) do
		self.blacklistedItems[itemID] = true
	end
	
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
		"STAT_AVERAGE_ITEM_LEVEL",
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
	
	-- 3=Useful for spec, 2=Useful for class, 1=Usable
	self.usableWeapons = {
		WARLOCK = {
			[LE_ITEM_WEAPON_SWORD1H] 		= 3,
			[LE_ITEM_WEAPON_DAGGER]			= 3,
			[LE_ITEM_WEAPON_STAFF]			= 3,
			[LE_ITEM_WEAPON_WAND]			= 3,
		},
		MAGE = {
			[LE_ITEM_WEAPON_SWORD1H]		= 3,
			[LE_ITEM_WEAPON_DAGGER]			= 3,
			[LE_ITEM_WEAPON_STAFF]			= 3,
			[LE_ITEM_WEAPON_WAND]			= 3,
		},
		PRIEST = {
			[LE_ITEM_WEAPON_MACE1H]			= 3,
			[LE_ITEM_WEAPON_DAGGER]			= 3,
			[LE_ITEM_WEAPON_STAFF]			= 3,
			[LE_ITEM_WEAPON_WAND]			= 3,
		},
		DRUID = {
			[LE_ITEM_WEAPON_MACE1H]			= 2,
			[LE_ITEM_WEAPON_MACE2H]			= 2,
			[LE_ITEM_WEAPON_DAGGER]			= 2,
			[LE_ITEM_WEAPON_UNARMED]		= 2,
			[LE_ITEM_WEAPON_POLEARM]		= 2,
			[LE_ITEM_WEAPON_STAFF]			= 2,
			
			[102] = { -- Balance
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
			[103] = { -- Feral
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
			[104] = { -- Guardian
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
			[105] = { -- Restoration
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
		},
		ROGUE = {
			[LE_ITEM_WEAPON_BOWS]			= 1,
			[LE_ITEM_WEAPON_CROSSBOW]		= 1,
			[LE_ITEM_WEAPON_GUNS]			= 1,
			
			[LE_ITEM_WEAPON_AXE1H]			= 2,
			[LE_ITEM_WEAPON_MACE1H]			= 2,
			[LE_ITEM_WEAPON_SWORD1H]		= 2,
			[LE_ITEM_WEAPON_DAGGER]			= 2,
			[LE_ITEM_WEAPON_UNARMED]		= 2,
			
			[259] = { -- Assassination
				[LE_ITEM_WEAPON_DAGGER]		= 3,
			},
			[260] = { -- Combat
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_SWORD1H]	= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
			},
			[261] = { -- Subtlety
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_SWORD1H]	= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
			},
		},
		MONK = {
			[LE_ITEM_WEAPON_AXE1H]			= 3,
			[LE_ITEM_WEAPON_MACE1H]			= 3,
			[LE_ITEM_WEAPON_SWORD1H]		= 3,
			[LE_ITEM_WEAPON_UNARMED]		= 3,
			[LE_ITEM_WEAPON_POLEARM]		= 3,
			[LE_ITEM_WEAPON_STAFF]			= 3,
		},
		SHAMAN = {
			[LE_ITEM_WEAPON_AXE1H]			= 2,
			[LE_ITEM_WEAPON_MACE1H]			= 2,
			[LE_ITEM_WEAPON_AXE2H]			= 2,
			[LE_ITEM_WEAPON_MACE2H]			= 2,
			[LE_ITEM_WEAPON_DAGGER]			= 2,
			[LE_ITEM_WEAPON_UNARMED]		= 2,
			[LE_ITEM_WEAPON_STAFF]			= 2,
			
			[262] = { -- Elemental
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_AXE2H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
			[263] = { -- Enhancement
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
			},
			[264] = { -- Restoration
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_AXE2H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
		},
		HUNTER = {
			[LE_ITEM_WEAPON_AXE1H]			= 1,
			[LE_ITEM_WEAPON_SWORD1H]		= 1,
			[LE_ITEM_WEAPON_AXE2H]			= 1,
			[LE_ITEM_WEAPON_SWORD2H]		= 1,
			[LE_ITEM_WEAPON_DAGGER]			= 1,
			[LE_ITEM_WEAPON_UNARMED]		= 1,
			[LE_ITEM_WEAPON_POLEARM]		= 1,
			[LE_ITEM_WEAPON_STAFF]			= 1,
			
			[LE_ITEM_WEAPON_GUNS]			= 2,
			[LE_ITEM_WEAPON_BOWS]			= 2,
			[LE_ITEM_WEAPON_CROSSBOW]		= 2,
			
			[253] = { -- Beast Mastery
				[LE_ITEM_WEAPON_GUNS]		= 3,
				[LE_ITEM_WEAPON_BOWS]		= 3,
				[LE_ITEM_WEAPON_CROSSBOW]	= 3,
			},
			
			[254] = { -- Marksmanship
				[LE_ITEM_WEAPON_GUNS]		= 3,
				[LE_ITEM_WEAPON_BOWS]		= 3,
				[LE_ITEM_WEAPON_CROSSBOW]	= 3,
			},
			
			[255] = { -- Survival
				[LE_ITEM_WEAPON_AXE2H]		= 3,
				[LE_ITEM_WEAPON_SWORD2H]	= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
			
			
		},
		WARRIOR = {
			[LE_ITEM_WEAPON_BOWS]			= 1,
			[LE_ITEM_WEAPON_CROSSBOW]		= 1,
			[LE_ITEM_WEAPON_GUNS]			= 1,
			
			[LE_ITEM_WEAPON_AXE1H]			= 2,
			[LE_ITEM_WEAPON_MACE1H]			= 2,
			[LE_ITEM_WEAPON_SWORD1H]		= 2,
			[LE_ITEM_WEAPON_AXE2H]			= 2,
			[LE_ITEM_WEAPON_MACE2H]			= 2,
			[LE_ITEM_WEAPON_SWORD2H]		= 2,
			[LE_ITEM_WEAPON_DAGGER]			= 2,
			[LE_ITEM_WEAPON_UNARMED]		= 2,
			[LE_ITEM_WEAPON_POLEARM]		= 2,
			[LE_ITEM_WEAPON_STAFF]			= 2,
			
			[71] = { -- Arms
				[LE_ITEM_WEAPON_AXE2H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_SWORD2H]	= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
				[LE_ITEM_WEAPON_STAFF]		= 3,
			},
			[72] = { -- Fury
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_SWORD1H]	= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
			},
			[73] = { -- Protection
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_SWORD1H]	= 3,
				[LE_ITEM_WEAPON_DAGGER]		= 3,
				[LE_ITEM_WEAPON_UNARMED]	= 3,
			},
		},
		PALADIN = {
			[LE_ITEM_WEAPON_AXE1H]			= 2,
			[LE_ITEM_WEAPON_MACE1H]			= 2,
			[LE_ITEM_WEAPON_SWORD1H]		= 2,
			[LE_ITEM_WEAPON_AXE2H]			= 2,
			[LE_ITEM_WEAPON_MACE2H]			= 2,
			[LE_ITEM_WEAPON_SWORD2H]		= 2,
			[LE_ITEM_WEAPON_POLEARM]		= 2,
				
			[67] = { -- Retribution
				[LE_ITEM_WEAPON_AXE2H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_SWORD2H]	= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
			},
			[66] = { -- Protection
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_SWORD1H]	= 3,
			},
			[65] = { -- Holy
				[LE_ITEM_WEAPON_AXE1H]		= 3,
				[LE_ITEM_WEAPON_MACE1H]		= 3,
				[LE_ITEM_WEAPON_SWORD1H]	= 3,
				[LE_ITEM_WEAPON_AXE2H]		= 3,
				[LE_ITEM_WEAPON_MACE2H]		= 3,
				[LE_ITEM_WEAPON_SWORD2H]	= 3,
				[LE_ITEM_WEAPON_POLEARM]	= 3,
			},
		},
		DEATHKNIGHT = {
			[LE_ITEM_WEAPON_AXE1H]			= 3,
			[LE_ITEM_WEAPON_MACE1H]			= 3,
			[LE_ITEM_WEAPON_SWORD1H]		= 3,
			[LE_ITEM_WEAPON_AXE2H]			= 3,
			[LE_ITEM_WEAPON_MACE2H]			= 3,
			[LE_ITEM_WEAPON_SWORD2H]		= 3,
			[LE_ITEM_WEAPON_POLEARM]		= 3,
		},
		DEMONHUNTER = {
			[LE_ITEM_WEAPON_DAGGER]			= 1,
			[LE_ITEM_WEAPON_UNARMED]		= 1,
			[LE_ITEM_WEAPON_AXE1H]			= 1,
			[LE_ITEM_WEAPON_MACE1H]			= 1,
			[LE_ITEM_WEAPON_SWORD1H]		= 1,
			[LE_ITEM_WEAPON_WARGLAIVE]		= 3,
		}
	}
	
	-- 2=Useful for class, 1=Usable
	self.usableArmor = {
		WARLOCK = {
			[LE_ITEM_ARMOR_CLOTH]	= 2,
		},
		MAGE = {
			[LE_ITEM_ARMOR_CLOTH]	= 2,
		},
		PRIEST = {
			[LE_ITEM_ARMOR_CLOTH]	= 2,
		},
		DRUID = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 2,
		},
		ROGUE = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 2,
		},
		MONK = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 2,
		},
		SHAMAN = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 1,
			[LE_ITEM_ARMOR_MAIL]	= 2,
			[LE_ITEM_ARMOR_SHIELD]	= 2,
		},
		HUNTER = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 1,
			[LE_ITEM_ARMOR_MAIL]	= 2,
		},
		WARRIOR = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 1,
			[LE_ITEM_ARMOR_MAIL]	= 1,
			[LE_ITEM_ARMOR_PLATE]	= 2,
			[LE_ITEM_ARMOR_SHIELD]	= 2,
		},
		PALADIN = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 1,
			[LE_ITEM_ARMOR_MAIL]	= 1,
			[LE_ITEM_ARMOR_PLATE]	= 2,
			[LE_ITEM_ARMOR_SHIELD]	= 2,
		},
		DEATHKNIGHT = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER]	= 1,
			[LE_ITEM_ARMOR_MAIL]	= 1,
			[LE_ITEM_ARMOR_PLATE]	= 2,
		},
		DEMONHUNTER = {
			[LE_ITEM_ARMOR_CLOTH]	= 1,
			[LE_ITEM_ARMOR_LEATHER] = 2,
		}
	}
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
	
	-- for GetTrueItemLevel()
	self.itemLevelPattern = _G["ITEM_LEVEL"]:gsub("%%d", "(%%d+)")
	self.scanningTooltip = false
	self.heirloomCache = {}
end

--- Public Functions ---
function SimpleStats:ShowStatChanges(tooltip,stats1,stats2)				-- Shows stat changes from stats1 -> stats2 in the given tooltip. Pass it either itemstrings or the result of GetItemStats()
	-- If given an item link instead of a stats table, extract the stats from the link
	if type(stats1) == "string" and strmatch(stats1, "item:") then
		stats1 = GetItemStats(stats1)
	end
	if type(stats2) == "string" and strmatch(stats2, "item:") then
		stats2 = GetItemStats(stats2)
	end
	
	local lines = SimpleStats:GetStatChangeLines(stats2,stats1)
	SimpleStats:AddLinesToTooltip(tooltip, lines)
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
function round(num, idp)		-- Rounds a number to x places
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end