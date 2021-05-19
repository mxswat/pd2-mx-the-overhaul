Hooks:PostHook(UpgradesTweakData, "init", "AddonPerk_UpgradesTweakData_init", function(self)
	self:add_temporary("dodgeopath_speed", 0, 3)
	self:add_temporary("dodgeopath_dodge", 0, 1)
    self:add_temporary_def("dodgeopath_speed")
    self:add_temporary_def("dodgeopath_dodge")
end)

function UpgradesTweakData:add_temporary(name_id, generic_val, duration)
	self.values.temporary[name_id] = {
		{
			generic_val,
			duration,
		}
	}
	-- mx_print_table(self.values.temporary[name_id])
end

function UpgradesTweakData:add_temporary_def(name_id)
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

