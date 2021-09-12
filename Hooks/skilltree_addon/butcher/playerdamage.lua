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
		local current_state = self._unit:movement()._current_state
		local has_deflect_skill = managers.player:has_category_upgrade("player", "melee_deflect_chance")
		if has_deflect_skill and (current_state and current_state.in_melee and current_state:in_melee()) then
			local deflect_roll = math.random()
			local deflect_chance = managers.player:upgrade_value("player", "melee_deflect_chance")
			local will_deflect = has_deflect_skill and deflect_roll > deflect_chance or false
	
			if will_deflect then
				local melee_entry = managers.blackmarket:equipped_melee_weapon()
				-- Add Skill check here
				local attacker_unit = attack_data.attacker_unit
				if (attacker_unit and  attacker_unit.character_damage) then
					if attacker_unit:base().sentry_gun then
						local action_data = {
							variant = "explosion",
							damage = attack_data.damage * 1.20,
							-- User current equipped primary, since equipped_melee_weapon does not have a :category which is used by copdamage 
							weapon_unit = managers.blackmarket:equipped_primary(),
							-- So, I can't use self._unit otherwise pd2 crashes, this is bullshit
							attacker_unit = nil,
							col_ray = Vector3(0, 0, 0)
						}
						attacker_unit:character_damage():damage_explosion(action_data)
					else 
						attacker_unit:character_damage():damage_simple({
							variant = "mx_damage",
							damage = attack_data.damage,
							attacker_unit = self._unit,
							pos = mvector3.copy(attacker_unit:movement():m_head_pos()),
							attack_dir = Vector3(0, 0, 0)
						})
					end

					local player_pos = Vector3() 
					mvector3.set(player_pos, managers.player:equipped_weapon_unit():position())
					sendTrail(player_pos, mvector3.copy(attacker_unit:movement():m_head_pos()))
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
				end

				return
			end
		end

		return PlayerDamage["original_pre_deflect_" .. function_name](self, attack_data)
	end
end
