function PlayerManager:_attempt_yakuza_injector()
	if self:has_activate_temporary_upgrade("temporary", "yakuza_injector") then
		return false
	end

	local duration = self:upgrade_value("temporary", "yakuza_injector")[2]
	local now = managers.game_play_central:get_heist_timer()
	managers.network:session():send_to_peers("sync_ability_hud", now + duration, duration)

	self:activate_temporary_upgrade("temporary", "yakuza_injector")

	local function speed_up_on_kill()
		managers.player:speed_up_grenade_cooldown(1)
	end

	self:register_message(Message.OnEnemyKilled, "speed_up_yakuza_injector", speed_up_on_kill)
	return true
end

function PlayerManager:give_temporary_value_boost(starting_value, temporay_nameid, boost)
	return managers.player:has_activate_temporary_upgrade("temporary", temporay_nameid) and (starting_value + boost) or starting_value
end

local VPPP_PlayerManager_get_max_grenades_by_peer_id = PlayerManager.get_max_grenades_by_peer_id
-- I'm using this to enforce the custom correct nade max amounts if you are the client or host without having to worry about the spoofed outfit_string
function PlayerManager:get_max_grenades_by_peer_id(peer_id)
	local peer = managers.network:session() and managers.network:session():peer(peer_id)
	local is_local_player = managers.network:session():local_peer() == peer
	if is_local_player then
		return self:get_max_grenades()
	end
	return VPPP_PlayerManager_get_max_grenades_by_peer_id(self, peer_id)
end

local VPPP_PlayerManager_movement_speed_multiplier = PlayerManager.movement_speed_multiplier
function PlayerManager:movement_speed_multiplier(speed_state, bonus_multiplier, upgrade_level, health_ratio)
	local multiplier = VPPP_PlayerManager_movement_speed_multiplier(self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
	multiplier = managers.player:has_activate_temporary_upgrade("temporary", "yakuza_injector") and (multiplier + 0.35) or multiplier

	return multiplier
end

local VPPP_PlayerManager_body_armor_regen_multiplier = PlayerManager.body_armor_regen_multiplier
function PlayerManager:body_armor_regen_multiplier(moving, health_ratio)
	local multiplier = VPPP_PlayerManager_body_armor_regen_multiplier(self, moving, health_ratio)
	multiplier = managers.player:has_activate_temporary_upgrade("temporary", "yakuza_injector") and (multiplier + 0.40) or multiplier
	
	return multiplier
end

function PlayerManager:_attempt_burglar_luck()
	if self:has_activate_temporary_upgrade("temporary", "burglar_luck") then
		return false
	end

	local duration = self:upgrade_value("temporary", "burglar_luck")[2]
	local now = managers.game_play_central:get_heist_timer()
	managers.network:session():send_to_peers("sync_ability_hud", now + duration, duration)

	self:activate_temporary_upgrade("temporary", "burglar_luck")

	local function speed_up_on_kill()
		managers.player:speed_up_grenade_cooldown(1)
	end

	self:register_message(Message.OnEnemyKilled, "speed_up_burglar_luck", speed_up_on_kill)
	return true
end

local VPPP_PlayerManager_skill_dodge_chance = PlayerManager.skill_dodge_chance
function PlayerManager:skill_dodge_chance(running, crouching, on_zipline, override_armor, detection_risk)
	local chance = VPPP_PlayerManager_skill_dodge_chance(self, running, crouching, on_zipline, override_armor, detection_risk)
	chance = self:give_temporary_value_boost(chance, "burglar_luck", 0.30)
	log("chance"..chance)
	return chance
end
