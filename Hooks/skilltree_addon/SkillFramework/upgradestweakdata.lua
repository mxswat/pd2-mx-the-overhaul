function UpgradesTweakData:add_definition(key, upgrade, category, value)
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