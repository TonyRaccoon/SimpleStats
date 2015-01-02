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
	L["All"] = "Alle"
	L["Controls which types of armor stat comparisons will be shown on"] = "Steuert auf welchen Arten von Rüstung die Wertevergleiche angezeigt werden"
	L["Controls which types of weapons stat comparisons will be shown on"] = "Steuert auf welchen Arten von Waffen die Wertevergleiche angezeigt werden"
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect." = "Zum Beispiel: Zeige den Vergleich nicht auf Gegenständen mit Beweglichkeit an, wenn du keine Beweglichkeit benutzt.\n\nVergleiche werden weiterhin gezeigt, wenn der Gestand einen Wert besitzt, den du benutzt.\n\nBetrifft nur Stärke, Beweglichkeit und Intelligenz"
	L["Gem Sockets"] = "Edelsteinsockel"
	L["Hide comparison if disabled primary stat exists"] = "Zeige Vergleiche nicht an wenn ein deaktivierter Primärwert vorhanden ist"
	L["Minimum item quality"] = "Minimale Qualitätsstufe"
	L["Minor Stats"] = "Optionale Werte"
	L["Only usable by current class"] = "Nur von der aktuellen Klasse benutzbar"
	L["Only useful to current class"] = "Nur für die aktuelle Klasse sinnvoll"
	L["Only useful to current specialization"] = "Nur für die aktuelle Spezialisierung sinnvoll"
	L["Only wearable by current class"] = "Nur von der aktuellen Klasse ausrüstbar"
	L["Primary Stats"] = "Primärwerte"
	L["Secondary Stats"] = "Sekundärwerte"
	L["Show on armor types:"] = "Zeige auf diesen Rüstungsarten:"
	L["Show on weapon types:"] = "Zeige auf diesen Waffenarten:"
	L["Show %s in stat comparisons"] = "Zeige %s in Wertevergleichen"
	L["Stat comparisons will only be shown on items with this quality or higher"] = "Wertevergleiche werden nur für Gegenstände dieser Qualitätsstufe oder höher angezeigt"

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
	L["All"] = "所有"
	L["Controls which types of armor stat comparisons will be shown on"] = "控制何種類型的護甲會顯示屬性比對"
	L["Controls which types of weapons stat comparisons will be shown on"] = "控制何種類型的武器會顯示屬性比對"
	L["For example, hide comparisons on items with Agility if you're not showing Agility.\n\nComparisons will still be shown if the item also has a primary stat you're showing.\n\nOnly affects Strength, Agility, and Intellect."] = "舉例來說，裝備沒顯示敏捷就會隱藏敏捷屬性的比對。\n\n比對仍會顯示如果裝備還有顯示其他主屬性。\n\n只對力量、敏捷與智力生效。"
	L["Gem Sockets"] = "珠寶插槽"
	L["Hide comparison if disabled primary stat exists"] = "隱藏非啟用之主屬性的比對"
	L["Minimum item quality"] = "最低裝備品質"
	L["Minor Stats"] = "其他屬性"
	L["Only usable by current class"] = "只有當前職業能使用的"
	L["Only useful to current class"] = "只有當前職業適用的"
	L["Only useful to current specialization"] = "只有當前專精適用的"
	L["Only wearable by current class"] = "只有當前職業可穿的"
	L["Primary Stats"] = "主屬性"
	L["Secondary Stats"] = "副屬性"
	L["Show on armor types:"] = "顯示的護甲類型："
	L["Show on weapon types:"] = "顯示的武器類型："
	L["Shows customizable stat comparisons in item tooltips"] = "在物品提示顯示自訂化的屬性比對"
	L["Show %s in stat comparisons"] = "顯示 %s 在屬性比對中"
	L["Stat comparisons will only be shown on items with this quality or higher"] = "屬性比對將只會顯示在高於此品質的裝備上"
end
