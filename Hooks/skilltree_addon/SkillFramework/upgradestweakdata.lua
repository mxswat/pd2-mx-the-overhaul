function UpgradesTweakData:add_definition(key, upgrade, category, value)
	key = key or category.."_"..upgrade.."_"..tostring(value)
    self.definitions[key] = {
		name_id = "menu_"..key,
		category = "feature",
		upgrade = {
			value = value,
			upgrade = upgrade,
			category = category
		}
	}
end

function UpgradesTweakData:add_definition_v2(category, upgrade, values)
	for _, value in ipairs(values) do
		local key = category.."_"..upgrade.."_"..tostring(value)
    self.definitions[key] = {
		name_id = "menu_"..key,
		category = "feature",
		upgrade = {
			value = value,
			upgrade = upgrade,
			category = category
		}
	}
	end
end