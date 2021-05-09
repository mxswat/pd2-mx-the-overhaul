Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "VPPP_UpgradesTweakData_init_pd2_values", function(self)
    self.values.temporary.yakuza_injector = {
		{
			0.75,
			8
		}
	}

	self.values.temporary.burglar_luck = {
		{
			0.75,
			8
		}
	}

	self.values.temporary.med_x = {
		{
			0.75,
			8
		}
	}
end)

Hooks:PostHook(UpgradesTweakData, "_player_definitions", "VPPP_UpgradesTweakData_player_definitions", function(self)
    self.definitions.yakuza_injector = {
		category = "grenade",
	}

    self.definitions.temporary_yakuza_injector_1 = {
		name_id = "menu_temporary_yakuza_injector_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "yakuza_injector",
			category = "temporary"
		}
	}

    self.definitions.burglar_luck = {
		category = "grenade",
	}

	self.definitions.temporary_burglar_luck_1 = {
		name_id = "menu_temporary_burglar_luck_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "burglar_luck",
			category = "temporary"
		}
	}

	self.definitions.med_x = {
		category = "grenade",
	}
	
	self.definitions.temporary_med_x_1 = {
		name_id = "menu_temporary_med_x_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "med_x",
			category = "temporary"
		}
	}

	self.definitions.auto_inject_super_stimpak = {
		category = "grenade",
	}
end)
