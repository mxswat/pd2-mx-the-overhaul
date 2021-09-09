Hooks:PostHook(UpgradesTweakData, "init", "Butcher_UpgradesTweakData_init", function(self)
	self.values.player.butcher_melee_stacking = {
		1,
		1
	}
	self:add_definition(nil, "butcher_melee_stacking", "player", 1)
	self:add_definition(nil, "butcher_melee_stacking", "player", 2)
	
end)