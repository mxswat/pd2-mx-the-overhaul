-- I'm using this to enforce the custom correct nade max amounts if you are the client or host without having to worry about the spoofed outfit_string
local VPPP_PlayerManager_get_max_grenades_by_peer_id = PlayerManager.get_max_grenades_by_peer_id
function PlayerManager:get_max_grenades_by_peer_id(peer_id)
	local peer = managers.network:session() and managers.network:session():peer(peer_id)
	local is_local_player = managers.network:session():local_peer() == peer
	if is_local_player then
		return self:get_max_grenades()
	end
	return VPPP_PlayerManager_get_max_grenades_by_peer_id(self, peer_id)
end

local VPPP_PlayerManager_attempt_ability = PlayerManager.attempt_ability
function PlayerManager:attempt_ability(ability)
	if managers.blackmarket:equipped_grenade() == "auto_inject_super_stimpak" then
		-- Sadly I had to duplicated the code to allow the usage of abilities when downed
		-- If you read this and know how to avoid it, PLEASE tell me how
		-- I was thinking about the function override used in Beardlib fixes, to override game_state_machine:verify_game_state but I'm unsure
		if not self:player_unit() then
			return
		end
	
		local local_peer_id = managers.network:session():local_peer():id()
		local has_no_grenades = self:get_grenade_amount(local_peer_id) == 0
		local is_downed = false
		local swan_song_active = managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier")
	
		if has_no_grenades or is_downed or swan_song_active then
			return
		end
	
		local attempt_func = self["_attempt_" .. ability]
	
		if attempt_func and not attempt_func(self) then
			return
		end
	
		local tweak = tweak_data.blackmarket.projectiles[ability]
	
		if tweak and tweak.sounds and tweak.sounds.activate then
			self:player_unit():sound():play(tweak.sounds.activate)
		end
	
		self:add_grenade_amount(-1)
		self._message_system:notify("ability_activated", nil, ability)
	else 
		return VPPP_PlayerManager_attempt_ability(self, ability)
	end
end

--[[ Common functions ]] --

function PlayerManager:give_temporary_value_boost(starting_value, temporay_nameid, boost)
	return managers.player:has_activate_temporary_upgrade("temporary", temporay_nameid) and (starting_value + boost) or starting_value
end

function PlayerManager:multiply_by_temporary_value_boost(starting_value, temporay_nameid, boost)
	return managers.player:has_activate_temporary_upgrade("temporary", temporay_nameid) and (starting_value * boost) or starting_value
end

function PlayerManager:generic_attempt(name_id, reduction)
	if self:has_activate_temporary_upgrade("temporary", name_id) then
		return false
	end

	local duration = self:upgrade_value("temporary", name_id)[2]
	local now = managers.game_play_central:get_heist_timer()
	managers.network:session():send_to_peers("sync_ability_hud", now + duration, duration)

	self:activate_temporary_upgrade("temporary", name_id)

	local function speed_up_on_kill()
		managers.player:speed_up_grenade_cooldown(reduction or 1)
	end

	self:register_message(Message.OnEnemyKilled, "speed_up_"..name_id, speed_up_on_kill)
	managers.hud:activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, duration)
	return true
end

--[[ Common functions END ]] --

function PlayerManager:_attempt_yakuza_injector()
	return self:generic_attempt("yakuza_injector", 2)
end


local VPPP_PlayerManager_movement_speed_multiplier = PlayerManager.movement_speed_multiplier
function PlayerManager:movement_speed_multiplier(speed_state, bonus_multiplier, upgrade_level, health_ratio)
	local multiplier = VPPP_PlayerManager_movement_speed_multiplier(self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
	-- Changed to be a multiplicative buff
	multiplier = self:multiply_by_temporary_value_boost(multiplier, "yakuza_injector", 1.35)
	multiplier = self:multiply_by_temporary_value_boost(multiplier, "adrenaline_shot", 1.15)

	return multiplier
end

local VPPP_PlayerManager_body_armor_regen_multiplier = PlayerManager.body_armor_regen_multiplier
function PlayerManager:body_armor_regen_multiplier(moving, health_ratio)
	local multiplier = VPPP_PlayerManager_body_armor_regen_multiplier(self, moving, health_ratio)
	multiplier = self:give_temporary_value_boost(multiplier, "yakuza_injector", 0.40)
	
	return multiplier
end

function PlayerManager:_attempt_burglar_luck()
	return self:generic_attempt("burglar_luck")
end

local VPPP_PlayerManager_skill_dodge_chance = PlayerManager.skill_dodge_chance
function PlayerManager:skill_dodge_chance(running, crouching, on_zipline, override_armor, detection_risk)
	local chance = VPPP_PlayerManager_skill_dodge_chance(self, running, crouching, on_zipline, override_armor, detection_risk)
	chance = self:give_temporary_value_boost(chance, "burglar_luck", 0.30)

	return chance
end

function PlayerManager:_attempt_auto_inject_super_stimpak()
	if game_state_machine:verify_game_state(GameStateFilters.downed) then
		self:send_message(Message.RevivePlayer, nil, nil)
		return true
	end
	return false -- false Does not allow the attempt_ability() to remove 1 nade
end

function PlayerManager:_attempt_adrenaline_shot()
	return self:generic_attempt("adrenaline_shot", 2)
end

function PlayerManager:_attempt_med_x()
	return self:generic_attempt("med_x")
end

local VPPP_PlayerManager_damage_reduction_skill_multiplier = PlayerManager.damage_reduction_skill_multiplier
function PlayerManager:damage_reduction_skill_multiplier(damage_type)
	local multiplier = VPPP_PlayerManager_damage_reduction_skill_multiplier(self, damage_type)
	multiplier = self:multiply_by_temporary_value_boost(multiplier, "med_x", 0.70)

	return multiplier
end

function PlayerManager:_attempt_spare_armor_plate()
	local activated = self:generic_attempt("spare_armor_plate")
	if activated then
		char_damage:_regenerate_armor(false)
	end
	return activated
end

function PlayerManager:_attempt_liquid_armor()
	return self:generic_attempt("liquid_armor", 2)
end


local VPPP_PlayerManager_body_armor_skill_multiplier = PlayerManager.body_armor_skill_multiplier
function PlayerManager:body_armor_skill_multiplier(override_armor)
	local multiplier = VPPP_PlayerManager_body_armor_skill_multiplier(self, override_armor)
	multiplier = self:multiply_by_temporary_value_boost(multiplier, "liquid_armor", 2)
	return multiplier
end

function PlayerManager:_attempt_blood_transfusion()
	local activated = self:generic_attempt("blood_transfusion", 2)
	if activated then
		local char_damage = managers.player: player_unit():character_damage()
		char_damage._armor_stored_health = char_damage._armor_stored_health * 2
		char_damage:consume_armor_stored_health()
		char_damage:set_armor(math.max(char_damage:_max_armor() / 2, char_damage:get_real_armor()))
	end
	return activated
end
