function FlameBulletBase:give_fire_damage(col_ray, weapon_unit, user_unit, damage, armor_piercing)
	local fire_dot_data = nil

	if weapon_unit.base and weapon_unit:base()._ammo_data and weapon_unit:base()._ammo_data.bullet_class == "FlameBulletBase" then
		fire_dot_data = weapon_unit:base()._ammo_data.fire_dot_data
	elseif weapon_unit.base and weapon_unit:base()._name_id then
		local weapon_name_id = weapon_unit:base()._name_id

		if tweak_data.weapon[weapon_name_id] and tweak_data.weapon[weapon_name_id].fire_dot_data then
			fire_dot_data = deep_clone(tweak_data.weapon[weapon_name_id].fire_dot_data)
            
			local dot_damage_addend = managers.player:upgrade_value("flamethrower", "dot_damage_addend", 0)
			local dot_length_addend = managers.player:upgrade_value("flamethrower", "dot_length_addend", 0)
            fire_dot_data.dot_damage = fire_dot_data.dot_damage + dot_damage_addend
			fire_dot_data.dot_length = fire_dot_data.dot_length + dot_length_addend
		end
	end
    -- self.flamethrower_mk2.fire_dot_data = {
	-- 	dot_trigger_chance = 75,
	-- 	dot_damage = 30,
	-- 	dot_length = 1.6,
	-- 	dot_trigger_max_distance = 3000,
	-- 	dot_tick_period = 0.5
	-- }

	local action_data = {
		variant = "fire",
		damage = damage,
		weapon_unit = weapon_unit,
		attacker_unit = user_unit,
		col_ray = col_ray,
		armor_piercing = armor_piercing,
		fire_dot_data = fire_dot_data
	}
	local defense_data = col_ray.unit:character_damage():damage_fire(action_data)

	return defense_data
end
