Hooks:PostHook(CopDamage, "damage_bullet", "Demo_CopDamage_damage_bullet",    function(self, attack_data)
    if managers.player:has_category_upgrade("player", "primer_round") and attack_data.attacker_unit == managers.player:player_unit() and not self:is_friendly_fire(attack_data.attacker_unit) then
        local primer_damage_mult = managers.player:upgrade_value("player", "primer_round")
        local SLOT_MASK = managers.slot:get_mask("enemies")
        local col_ray = attack_data.col_ray
        local user_unit = managers.player:player_unit()
        local exp_damage = attack_data.damage * primer_damage_mult -- Base Wepon damage * primer_mult
        local exp_range = 300 -- 500 was too much Test value
        -- Look for the enemies in the explosion range
        local bodies = World:find_units_quick("sphere", col_ray.position, exp_range, SLOT_MASK)
        local action_data = {
            variant = "explosion",
            damage = exp_damage,
            weapon_unit = attack_data.weapon_unit,
            attacker_unit = user_unit,
            col_ray = col_ray
        }
        for _, hit_unit in ipairs(bodies) do
            if hit_unit:character_damage() then
                hit_unit:character_damage():damage_explosion(action_data)
            end
        end

        -- Spawn effects
        local EXP_DMG = 0.01
        -- managers.explosion:give_local_player_dmg(col_ray.position, range, damage) -- Handle player self damage?
        InstantExplosiveBulletBase:on_collision(col_ray, attack_data.weapon_unit, user_unit, EXP_DMG, false) -- Just for the boom effect
        -- managers.network:session():send_to_peers_synched("sync_explode_bullet", position, normal, math.min(16384, network_damage), managers.network:session():local_peer():id())
    end
end)

Hooks:PostHook(CopDamage, "damage_explosion", "Demo_damage_explosion" ,function(self, attack_data)
    if self._dead or self._invulnerable or not managers.player:has_category_upgrade("grenade_launcher", "afterburn") then
		return
	end
    local fire_dot_data = {
        dot_damage = 2.5,
        dot_trigger_max_distance = 9000,
        dot_trigger_chance = 100,
        dot_length = 2,
        dot_tick_period = 0.5
    }
    local action_data = {}
    action_data.variant = "fire"
    action_data.damage = 1
    action_data.attacker_unit = managers.player:player_unit()
    action_data.col_ray = attack_data.col_ray
    action_data.fire_dot_data = fire_dot_data
    self:damage_fire(action_data)
end)