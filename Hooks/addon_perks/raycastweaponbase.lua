local old_RaycastWeaponBase__collect_hits = RaycastWeaponBase._collect_hits
function RaycastWeaponBase:_collect_hits(from, to)
	local unique_hits, hit_enemy = old_RaycastWeaponBase__collect_hits(self, from, to)

    if managers.player:has_category_upgrade("player", "striker_accuracy_to_damage") then
        managers.player:update_striker_stacks(hit_enemy and 0.01 or -0.02)
    end
	return unique_hits, hit_enemy
end



local old_RaycastWeaponBase_fire = RaycastWeaponBase.fire
function RaycastWeaponBase:fire(from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
    dmg_mul = dmg_mul + managers.player:get_striker_stacks()
    mx_log(dmg_mul)
	return old_RaycastWeaponBase_fire(self, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit)
end
