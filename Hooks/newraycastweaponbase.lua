local VPPP_NewRaycastWeaponBase_reload_speed_multiplier = NewRaycastWeaponBase.reload_speed_multiplier
function NewRaycastWeaponBase:reload_speed_multiplier()
    local multiplier = VPPP_NewRaycastWeaponBase_reload_speed_multiplier(self)
    multiplier = managers.player:give_temporary_value_boost(multiplier, "adrenaline_shot", 0.80)

    return multiplier
end     