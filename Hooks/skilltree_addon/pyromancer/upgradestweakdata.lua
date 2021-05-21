Hooks:PostHook(UpgradesTweakData, "init", "Pyromancer_UpgradesTweakData_init", function(self)
    self.values.flamethrower = self.values.flamethrower or {}
    self.values.flamethrower.reload_speed_multiplier = {
        1.35,
        1.70
	}

    self.values.flamethrower.flame_max_range = {
        1500,
        2000
    }

    self:add_definition(nil, "flame_max_range", "flamethrower", 1)
    self:add_definition(nil, "flame_max_range", "flamethrower", 2)
    self:add_definition(nil, "reload_speed_multiplier", "flamethrower", 1)
    self:add_definition(nil, "reload_speed_multiplier", "flamethrower", 2)
end)