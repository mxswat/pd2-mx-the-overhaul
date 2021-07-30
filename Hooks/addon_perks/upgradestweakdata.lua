Hooks:PostHook(UpgradesTweakData, "init", "AddonPerk_UpgradesTweakData_init", function(self)
	self:add_temporary_upgrades("dodgeopath_speed", 0, 3)
	self:add_temporary_upgrades("dodgeopath_invulnerability_on_kill", 0, 3)

	self.values.player.stability_increase_bonus_striker = { -0.35 }
	self:add_definition(nil, "stability_increase_bonus_striker", "player", 1)

	self.values.player.striker_accuracy_to_damage = {true}
	self:add_definition(nil, "striker_accuracy_to_damage", "player", 1)
end)

function UpgradesTweakData:add_temporary_upgrades(name_id, generic_val, duration)
    self.values.temporary[name_id] = {
		{
			generic_val,
			duration,
		}
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
