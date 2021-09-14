-- Deflect Code from https://modworkshop.net/mod/25441
-- Credits to :
-- Rickerus -- Author
-- Cpone Supporter -- Collaborator
-- fuglore -- Collaborator


local damage_functions = {
	"damage_tase",
	"damage_melee",
	"damage_bullet"
}

local function sendTrail(source_position, target_position)
    local TRAIL_EFFECT = Idstring("effects/particles/weapons/sniper_trail")
    local idstr_trail = Idstring("trail")
    local idstr_simulator_length = Idstring("simulator_length")
    local idstr_size = Idstring("size")
    local trail_length
    
    local hit_position = target_position
    local distance_from_target = mvector3.distance_sq(source_position, hit_position)
    if not trail_length then
        trail_length = World:effect_manager():get_initial_simulator_var_vector2(TRAIL_EFFECT, idstr_trail, idstr_simulator_length, idstr_size)
    end
    
    -- local rot = Rotation()
    -- mrotation.set_look_at(rot, source_position - hit_position, math.UP)
    local trail = World:effect_manager():spawn({
        effect = TRAIL_EFFECT,
        position = source_position,
        normal =  hit_position - source_position,
        -- rotation = rot -- Solved using custom effect
    })

    mvector3.set_y(trail_length, math.sqrt(distance_from_target))
    World:effect_manager():set_simulator_var_vector2(trail, idstr_trail, idstr_simulator_length, idstr_size, trail_length)
end

for _, function_name in ipairs(damage_functions) do
	PlayerDamage["original_pre_deflect_" .. function_name] = PlayerDamage["original_pre_deflect_" .. function_name] or PlayerDamage[function_name]

	PlayerDamage[function_name] = function(self, attack_data)
		local player_pos = Vector3() 
		mvector3.set(player_pos, managers.player:equipped_weapon_unit():position())

		local current_state = self._unit:movement()._current_state
		local has_deflect_skill = managers.player:has_category_upgrade("player", "melee_deflect_chance")
		local is_in_melee = (current_state and current_state.in_melee and current_state:in_melee()) or true
		if has_deflect_skill and is_in_melee then
			local melee_entry = managers.blackmarket:equipped_melee_weapon()
			-- Add Skill check here
			local attacker_unit = attack_data.attacker_unit
			if (attacker_unit and attacker_unit.character_damage) then
				local deflect_damage = attack_data.damage

				local col_ray, from, to = raycast_from_player_eyes()
				mx_print(col_ray)
				if col_ray then 
					if col_ray.unit:character_damage() then
						mx_log_chat('ray hit', col_ray)	
					else
						mx_log_chat('ray', col_ray)
					end	
					InstantBulletBase:on_collision(col_ray, managers.player:equipped_weapon_unit(), managers.player:player_unit(), deflect_damage)
					
					sendTrail(player_pos, mvector3.copy(col_ray.hit_position))
				else
					sendTrail(player_pos, mvector3.copy(to))
				end
			end

			if (current_state._play_melee_sound) then
				local anim_attack_vars = tweak_data.blackmarket.melee_weapons[melee_entry].anim_attack_vars
				local anim_attack_var = anim_attack_vars and math.random(#anim_attack_vars)

				current_state:_play_melee_sound(melee_entry, "hit_gen", anim_attack_var or 0)

				if (function_name == "damage_tase") then
					self._unit:sound():play("tase_counter_attack")
				end
			end

			if (current_state.discharge_melee) then
				current_state:discharge_melee()
				self._unit:camera():play_shaker("player_exit_zipline", 0)
			end

			return
		end

		return PlayerDamage["original_pre_deflect_" .. function_name](self, attack_data)
	end
end