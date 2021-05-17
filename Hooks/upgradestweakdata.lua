Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "VPPP_UpgradesTweakData_init_pd2_values", function(self)
	self:throwable_values("yakuza_injector", 1, 8)
	self:throwable_values("burglar_luck", 1, 8)
	self:throwable_values("med_x", 1, 8)
	self:throwable_values("adrenaline_shot", 2, 10)
	self:throwable_values("spare_armor_plate", 1, 0.5)
	self:throwable_values("liquid_armor", 2, 10)
	self:throwable_values("blood_transfusion", 1, 0.5)
	self:throwable_values("wick_mode", 1, 6)
	self:throwable_values("emergency_requisition", 1, 2)
	self:throwable_values("the_mixtape", 1, 4)
	self:throwable_values("throwable_trip_mine", 1, 0.1)
	self:throwable_values("jet", 1, 8)
	self:throwable_values("whiff", 2, 8)
	-- self.values.player.body_armor.dodge[1] = 1 -- Debug always dodgde
end)

Hooks:PostHook(UpgradesTweakData, "_player_definitions", "VPPP_UpgradesTweakData_player_definitions", function(self)
	self:common_add_throwable("yakuza_injector")
	self:common_add_throwable("burglar_luck")
	self:common_add_throwable("med_x")
	self:common_add_throwable("auto_inject_super_stimpak")
	self:common_add_throwable("adrenaline_shot")
	self:common_add_throwable("spare_armor_plate")
	self:common_add_throwable("liquid_armor")
	self:common_add_throwable("blood_transfusion")
	self:common_add_throwable("wick_mode")
	self:common_add_throwable("emergency_requisition")
	self:common_add_throwable("the_mixtape")
	self:common_add_throwable("throwable_trip_mine")
	self:common_add_throwable("jet")
	self:common_add_throwable("whiff")
end)

--[[
	cooldown_reduction on kill, does not includes the custom cooldown reductions, like on melee or explosive kill
]]
function UpgradesTweakData:throwable_values(name_id, cooldown_reduction, duration)
	self.values.temporary[name_id] = {
		{
			cooldown_reduction,
			duration,
		}
	}
	-- mx_print_table(self.values.temporary[name_id])
end

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

