Hooks:PostHook(UpgradesTweakData, "init", "Pyromancer_UpgradesTweakData_init", function(self)
    self.values.flamethrower = self.values.flamethrower or {}
    self.values.flamethrower.reload_speed_multiplier = {
        1.45,
        1.75
	}

    self.values.flamethrower.flame_max_range = {
        1600,
        2100
    }

    self.values.flamethrower.magazine_capacity_inc = {
        1.5,
        2
    }

    self.values.flamethrower.damage_addend = {
		5,
		7
	}

    self.values.flamethrower.fire_rate_multiplier = {
		0.3,
		0.40
	}

    self:add_definition(nil, "flame_max_range", "flamethrower", 1)
    self:add_definition(nil, "flame_max_range", "flamethrower", 2)
    self:add_definition(nil, "reload_speed_multiplier", "flamethrower", 1)
    self:add_definition(nil, "reload_speed_multiplier", "flamethrower", 2)
    self:add_definition(nil, "damage_addend", "flamethrower", 1)
    self:add_definition(nil, "damage_addend", "flamethrower", 2)
    self:add_definition(nil, "fire_rate_multiplier", "flamethrower", 1)
    self:add_definition(nil, "fire_rate_multiplier", "flamethrower", 2)
    self:add_definition(nil, "magazine_capacity_inc", "flamethrower", 1)
    self:add_definition(nil, "magazine_capacity_inc", "flamethrower", 2)
end)