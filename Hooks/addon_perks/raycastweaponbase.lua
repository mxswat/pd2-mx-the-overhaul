local old_RaycastWeaponBase_fire = RaycastWeaponBase.fire
function RaycastWeaponBase:fire(from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
    dmg_mul = dmg_mul + managers.player:get_striker_stacks()
	return old_RaycastWeaponBase_fire(self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
end


local old_RaycastWeaponBase__fire_raycast = RaycastWeaponBase._fire_raycast
function RaycastWeaponBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul)
	local result = old_RaycastWeaponBase__fire_raycast(self, user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul)
	if user_unit == managers.player:player_unit()  then
		managers.player:update_striker_stacks(result.hit_enemy and 0.015 or -0.02)
	end
	return result
end
