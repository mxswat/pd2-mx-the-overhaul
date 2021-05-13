local VPPP_PlayerStandard_do_melee_damage = PlayerStandard._do_melee_damage
function PlayerStandard:_do_melee_damage(t, bayonet_melee, melee_hit_ray, melee_entry, hand_id)
    local col_ray = VPPP_PlayerStandard_do_melee_damage(self, t, bayonet_melee, melee_hit_ray, melee_entry, hand_id)
    if not col_ray and managers.player:has_activate_temporary_upgrade("temporary", "yakuza_injector") then
        local player = managers.player:player_unit()

        if player then
            -- Do self damage to health
            local max_10_perc = player:character_damage():_max_health() * 0.10
            player:character_damage():set_health(math.max(1, player:character_damage():get_real_health() - max_10_perc))
        end
    end
    return col_ray
end


local VPPP_PlayerStandard_get_swap_speed_multiplier = PlayerStandard._get_swap_speed_multiplier
function PlayerStandard:_get_swap_speed_multiplier()
	local multiplier = VPPP_PlayerStandard_get_swap_speed_multiplier(self)
	multiplier = managers.player:give_temporary_value_boost(multiplier, "adrenaline_shot", 0.80)

	return multiplier
end



local old_PlayerStandard__find_pickups = PlayerStandard._find_pickups
function PlayerStandard:_find_pickups(t)
	local result = old_PlayerStandard__find_pickups(self, t)
	if managers.player:has_activate_temporary_upgrade("temporary", "emergency_requisition") then
        local pickups = World:find_units_quick("sphere", self._unit:movement():m_pos(), 30000, self._slotmask_pickups)
        local grenade_tweak = tweak_data.blackmarket.projectiles[managers.blackmarket:equipped_grenade()]
        local may_find_grenade = not grenade_tweak.base_cooldown and managers.player:has_category_upgrade("player", "regain_throwable_from_ammo")

        for _, pickup in ipairs(pickups) do
            if pickup:pickup() and pickup:pickup():pickup(self._unit) then
                if may_find_grenade then
                    local data = managers.player:upgrade_value("player", "regain_throwable_from_ammo", nil)

                    if data then
                        managers.player:add_coroutine("regain_throwable_from_ammo", PlayerAction.FullyLoaded, managers.player, data.chance, data.chance_inc)
                    end
                end

                for id, weapon in pairs(self._unit:inventory():available_selections()) do
                    managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
                end
            end
        end
    end
    
	return result
end
