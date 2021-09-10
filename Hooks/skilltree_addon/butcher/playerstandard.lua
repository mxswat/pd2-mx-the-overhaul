local Butcher_PlayerStandard__calc_melee_hit_ray = PlayerStandard._calc_melee_hit_ray
function PlayerStandard:_calc_melee_hit_ray(t, sphere_cast_radius)
	local result = Butcher_PlayerStandard__calc_melee_hit_ray(self, t, sphere_cast_radius)

    if managers.player:has_category_upgrade("player", "melee_range_boost") then
        -- It's the same code as the original, but with the dded melee range skill upgrade 
        local melee_entry = managers.blackmarket:equipped_melee_weapon()
        local range = tweak_data.blackmarket.melee_weapons[melee_entry].stats.range or 175
        range = range  * managers.player:upgrade_value("player", "melee_range_boost")
        local from = self._unit:movement():m_head_pos()
        local to = from + self._unit:movement():m_head_rot():y() * range
        return self._unit:raycast("ray", from, to, "slot_mask", self._slotmask_bullet_impact_targets, "sphere_cast_radius", sphere_cast_radius, "ray_type", "body melee")
    end

	return result
end

Hooks:PostHook(PlayerStandard, "_do_action_melee", "Butcher_PlayerStandard__do_action_melee", function(self, t, input, skip_damage)
    if managers.player:has_category_upgrade("player", "melee_speed_boost") then
        local melee_entry = managers.blackmarket:equipped_melee_weapon()
        local boost = managers.player:upgrade_value("player", "melee_speed_boost")
        self._state_data.melee_expire_t = t + tweak_data.blackmarket.melee_weapons[melee_entry].expire_t
        self._state_data.melee_repeat_expire_t = t + math.min(tweak_data.blackmarket.melee_weapons[melee_entry].repeat_expire_t, tweak_data.blackmarket.melee_weapons[melee_entry].expire_t) * boost        
    end
end)

local Butcher_PlayerStandard__get_melee_charge_lerp_value = PlayerStandard._get_melee_charge_lerp_value
function PlayerStandard:_get_melee_charge_lerp_value(t, offset)
	local result = Butcher_PlayerStandard__get_melee_charge_lerp_value(self, t, offset)
    self._state_data.melee_charge_lerp_value = result
	return result
end

function PlayerStandard:get_current_melee_charge_lerp_value()
    return self._state_data.melee_charge_lerp_value
end