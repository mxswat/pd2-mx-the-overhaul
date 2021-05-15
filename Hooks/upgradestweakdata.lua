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

	self.values.temporary.adrenaline_shot = {
		{
			0.75,
			10
		}
	}

	self.values.temporary.spare_armor_plate = {
		{
			0.1,
			0.5
		}
	}
	
	self.values.temporary.liquid_armor = {
		{
			0.1,
			10
		}
	}

	self.values.temporary.blood_transfusion = {
		{
			0.1,
			0.5
		}
	}
	
	self.values.temporary.wick_mode = {
		{
			0.1,
			6
		}
	}

	self.values.temporary.emergency_requisition = {
		{
			0.1,
			2
		}
	}

	self.values.temporary.the_mixtape = {
		{
			0.1,
			4
		}
	}

	self.values.temporary.throwable_trip_mine = {
		{
			0.1,
			0.1
		}
	}

	-- self.values.player.body_armor.dodge[1] = 1
end)

function UpgradesTweakData:common_add_throwable(name_id)
	self.definitions[name_id] = {
		category = "grenade",
	}

	self.definitions["temporary_"..name_id.."_1"] = {
		name_id = "menu_temporary_"..name_id.."_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = name_id,
			category = "temporary"
		}
	}
end


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
	
	self.definitions.adrenaline_shot = {
		category = "grenade",
	}

	
	self.definitions.temporary_adrenaline_shot_1 = {
		name_id = "menu_temporary_adrenaline_shot_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "adrenaline_shot",
			category = "temporary"
		}
	}

	self.definitions.spare_armor_plate = {
		category = "grenade",
	}

	self.definitions.temporary_spare_armor_plate_1 = {
		name_id = "menu_temporary_spare_armor_plate_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "spare_armor_plate",
			category = "temporary"
		}
	}

	self.definitions.liquid_armor = {
		category = "grenade",
	}

	self.definitions.temporary_liquid_armor_1 = {
		name_id = "menu_temporary_liquid_armor_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "liquid_armor",
			category = "temporary"
		}
	}

	self.definitions.blood_transfusion = {
		category = "grenade",
	}

	self.definitions.temporary_blood_transfusion_1 = {
		name_id = "menu_temporary_blood_transfusion_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "blood_transfusion",
			category = "temporary"
		}
	}

	self.definitions.wick_mode = {
		category = "grenade",
	}

	self.definitions.temporary_wick_mode_1 = {
		name_id = "menu_temporary_wick_mode_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "wick_mode",
			category = "temporary"
		}
	}

	self.definitions.emergency_requisition = {
		category = "grenade",
	}

	self.definitions.temporary_emergency_requisition_1 = {
		name_id = "menu_temporary_emergency_requisition_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "emergency_requisition",
			category = "temporary"
		}
	}

	self.definitions.the_mixtape = {
		category = "grenade",
	}

	self.definitions.temporary_the_mixtape_1 = {
		name_id = "menu_temporary_the_mixtape_1",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "the_mixtape",
			category = "temporary"
		}
	}

	self:common_add_throwable("throwable_trip_mine")
end)
