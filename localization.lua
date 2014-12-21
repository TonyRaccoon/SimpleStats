local _,namespace = ...

local L = setmetatable({}, {
	__index = function(t,k)
		rawset(t,k,k)
		return k
	end,
	__newindex = function(t,k,v)
		if v then
			rawset(t,k,v)
		else
			rawset(t,k,k)
		end
	end
})

namespace.L = L
local LOCALE = GetLocale()

if     LOCALE == "esES" or LOCALE == "esMX" then --======================================  Spanish               ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "deDE" then --==========================================================  German                ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "frFR" then --==========================================================  French                ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "itIT" then --==========================================================  Italian               ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "ptBR" or LOCALE == "ptPT" then --======================================  Brazilian Portuguese  ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "ruRU" then --==========================================================  Russian               ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "koKR" then --==========================================================  Korean                ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "zhCN" then --==========================================================  Simplified Chinese    ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
elseif LOCALE == "zhTW" then --==========================================================  Traditional Chinese   ==========================
	L["Minimum item quality"]														= nil
	L["Stat comparisons will only be shown on items with this quality or higher"]	= nil
	L["Show on weapon types:"]														= nil
	L["Show on armor types:"]														= nil
	L["Controls which types of weapons stat comparisons will be shown on"]			= nil
	L["Controls which types of armor stat comparisons will be shown on"]			= nil
	L["All"]																		= nil
	L["Only usable by current class"]												= nil
	L["Only wearable by current class"]												= nil
	L["Only useful to current class"]												= nil
	L["Only useful to current specialization"]										= nil
	L["Hide comparison if disabled primary stat exists"]							= nil
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = nil
	L["Primary Stats"]																= nil
	L["Secondary Stats"]															= nil
	L["Minor Stats"]																= nil
	L["Show %s in stat comparisons"]												= nil
	L["Gem Sockets"]																= nil
end
