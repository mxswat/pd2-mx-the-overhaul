Hooks:PostHook(PlayerManager, "check_skills", "Addon_Perks_PlayerManager_check_skills", function(self)
	if self:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then -- Fix here to avoid skill being triggered by other perkdecks
		local function speed_up_on_melee_kill(weapon_unit, variant)
			if variant == "melee" or weapon_unit:base():is_category("saw") then
				self:activate_temporary_upgrade("temporary", "dodgeopath_speed")
				self:activate_temporary_upgrade("temporary", "dodgeopath_invulnerability_on_kill")
				managers.hud:activate_local_ability_radial_with_fullscreen(3)
				local player_unit = self:player_unit()
				local stamina_regen = player_unit:movement():_max_stamina()
				player_unit:movement():add_stamina(stamina_regen)
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
	-- local player = managers.player:player_unit()
	chance = self:give_temporary_value_boost(chance, "dodgeopath_invulnerability_on_kill", 1)

	return chance
end

function PlayerManager:get_striker_stacks()
	return self._decaying_stacks.striker_stacks or 0
end

function PlayerManager:update_striker_stacks(value)
	local newValue = self._decaying_stacks.striker_stacks + value
	self._decaying_stacks.striker_stacks = math.min(math.max(newValue, 0), 1);
end

Hooks:PostHook(PlayerManager, "_setup", "VPPP_PlayerManager__setup", function(self)
	self._decaying_stacks = {
		striker_stacks = 0
	}
end)

local strikerDecayInterval = 1 -- 1s between one decay and the other

PlayerManager.stikerStackIncrease = 0.015
PlayerManager.stikerStackDecrease = -0.02

Hooks:PostHook(PlayerManager, "update", "VPPP_PlayerManager_update", function(self, t, dt)
	local player = self:player_unit()

	if not self:has_category_upgrade("player", "striker_accuracy_to_damage") or not player then
		return
	end
	
	self._striker_stack_decay_t = self._striker_stack_decay_t or t + strikerDecayInterval
	if self._striker_stack_decay_t <= t and managers and managers.hud then
		self._striker_stack_decay_t = self._striker_stack_decay_t + strikerDecayInterval
		self:update_striker_stacks(-managers.player.stikerStackIncrease)
		local char_damage = managers.player and managers.player:player_unit() and managers.player:player_unit():character_damage()

		if char_damage and self:get_striker_stacks() > 0 then
			local healing = char_damage:_max_health() * managers.player.stikerStackIncrease * self:get_striker_stacks()
			-- mx_log("healing:"..tostring(healing).."_max_health"..tostring(char_damage:_max_health()))
			char_damage:restore_health(healing, true)
		end

		local attempt_hud_update = managers.hud[managers.hud.set_info_meter_fast and "set_info_meter_fast" or "set_info_meter"]

		attempt_hud_update(nil, {
			icon = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_icon_01",
			max = 1,
			current = self:get_striker_stacks(),
			total = 1
		})
	end
end)

Hooks:PostHook(PlayerManager, "_internal_load", "CHANGEME_PlayerManager__internal_load", function(self)
	if self:has_category_upgrade("player", "striker_accuracy_to_damage") and managers and managers.hud then
		managers.hud:set_info_meter(nil, {
			icon = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_icon_01",
			max = 1,
			current = self:get_striker_stacks(),
			total = self:get_striker_stacks()
		})
		self:update_cocaine_hud()
	end	
end)
