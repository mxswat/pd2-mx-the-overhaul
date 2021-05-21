Hooks:PostHook(NewFlamethrowerBase, "setup_default", "Pyromancer_NewFlamethrowerBase_setup_default", function(self)
	self._flame_max_range = managers.player:upgrade_value("flamethrower", "flame_max_range", 1000)
    log("self._flame_max_range"..self._flame_max_range)
end)