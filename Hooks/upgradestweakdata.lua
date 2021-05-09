Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "VPPP_UpgradesTweakData_init_pd2_values", function(self)
    self.values.temporary.yakuza_injector = {
		{
			0.75,
			10
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
end)
