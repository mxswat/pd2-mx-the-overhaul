Hooks:PostHook(PlayerManager, "check_skills", "Addon_Perks_PlayerManager_check_skills", function(self)
	if self:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
		local function speed_up_on_melee_kill(weapon_unit, variant)
			if variant == "melee" then
				self:activate_temporary_upgrade("temporary", "dodgeopath_speed")
				self:activate_temporary_upgrade("temporary", "dodgeopath_dodge")
				managers.hud:activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, 1)
				local player_unit = self:player_unit()
				local stamina_regen = player_unit:movement():_max_stamina()
				player_unit:movement():add_stamina(stamina_regen)
				log("speed_up_on_melee_kill triggered")
			end
		end
	
		self:register_message(Message.OnEnemyKilled, "speed_up_on_melee_kill_dodgeopath", speed_up_on_melee_kill)
	else
		self:unregister_message(Message.OnEnemyKilled, "speed_up_on_melee_kill_dodgeopath")
	end
end)


local VPPP_PlayerManager_movement_speed_multiplier = PlayerManager.movement_speed_multiplier
function PlayerManager:movement_speed_multiplier(speed_state, bonus_multiplier, upgrade_level, health_ratio)
	local multiplier = VPPP_PlayerManager_movement_speed_multiplier(self, speed_state, bonus_multiplier, upgrade_level, health_ratio)
	multiplier = self:multiply_by_temporary_value_boost(multiplier, "dodgeopath_speed", 1.5)
	return multiplier
end

local VPPP_PlayerManager_skill_dodge_chance = PlayerManager.skill_dodge_chance
function PlayerManager:skill_dodge_chance(running, crouching, on_zipline, override_armor, detection_risk)
	local chance = VPPP_PlayerManager_skill_dodge_chance(self, running, crouching, on_zipline, override_armor, detection_risk)
	chance = self:give_temporary_value_boost(chance, "dodgeopath_dodge", 1)

	return chance
end