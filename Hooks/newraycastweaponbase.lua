local VPPP_NewRaycastWeaponBase_reload_speed_multiplier = NewRaycastWeaponBase.reload_speed_multiplier
function NewRaycastWeaponBase:reload_speed_multiplier()
    local multiplier = VPPP_NewRaycastWeaponBase_reload_speed_multiplier(self)
    multiplier = managers.player:give_temporary_value_boost(multiplier, "adrenaline_shot", 0.80)

    return multiplier
end     



local old_NewRaycastWeaponBase_fire_rate_multiplier = NewRaycastWeaponBase.fire_rate_multiplier
function NewRaycastWeaponBase:fire_rate_multiplier()
	local multiplier = old_NewRaycastWeaponBase_fire_rate_multiplier(self)
	multiplier = managers.player:multiply_by_temporary_value_boost(multiplier, "wick_mode", 1.5)
	return multiplier
end
