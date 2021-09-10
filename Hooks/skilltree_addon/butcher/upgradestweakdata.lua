Hooks:PostHook(UpgradesTweakData, "init", "Butcher_UpgradesTweakData_init", function(self)
	self.values.player.butcher_melee_stacking = {
		2.5,
		3
	}
	self:add_definition(nil, "butcher_melee_stacking", "player", 1)
	self:add_definition(nil, "butcher_melee_stacking", "player", 2)
	
	self.values.player.melee_range_boost = {
		1.70,
		2
	}

	self:add_definition(nil, "melee_range_boost", "player", 1)
	self:add_definition(nil, "melee_range_boost", "player", 2)
end)