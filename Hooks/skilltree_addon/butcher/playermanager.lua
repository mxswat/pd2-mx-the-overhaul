function PlayerManager:get_wolverine_stacks()
	return self._decaying_stacks.wolverine_stacks or 0
end

function PlayerManager:update_wolverine_stacks(value)
	local newValue = self._decaying_stacks.wolverine_stacks + value
	self._decaying_stacks.wolverine_stacks = math.min(math.max(newValue, 0), 1);
end

PlayerManager.wolverineStackIncrease = 0.10
PlayerManager.wolverineStackDecrease = 0.10 -- not used with wolverine
PlayerManager.wolverineStackDecayDecrease = -0.05
PlayerManager.wolverineStackDecayInterval = 2.5 -- seconds between one decay and the other

Hooks:PostHook(PlayerManager, "_setup", "Butcher_PlayerManager__setup", function(self)
	self._decaying_stacks = self._decaying_stacks or {}
	self._decaying_stacks.wolverine_stacks = 0
    PlayerManager.wolverineStackDecayInterval = self:upgrade_value("player", "butcher_melee_stacking") or 2.5

    if self:has_category_upgrade("player", "butcher_melee_stacking") then
		local function increase_wolverine_stacks(damage_info)
            local attacker_unit = damage_info.attacker_unit
            local variant = damage_info.variant
            local was_killed = damage_info.result.type == "death"
            local is_saw = damage_info and damage_info.weapon_unit and damage_info.weapon_unit:base():is_category("saw")
            if variant == "melee" or is_saw and attacker_unit == self:player_unit() then
				self:update_wolverine_stacks(PlayerManager.wolverineStackIncrease)
                if not was_killed then
                    -- Since I already know that I hit someone in melee I might as well calculate and apply the extra damage now
                    -- Using the mx_damage variant so I dont re-trigger this function
                    -- local damage_mult = self:get_wolverine_stacks()
                    local damage = damage_info.damage * self:get_wolverine_stacks()
                    damage_info._unit:character_damage():damage_simple({
                        variant = "mx_damage",
                        damage = damage,
                        attacker_unit = self:player_unit(),
                        pos = damage_info.pos,
                        attack_dir = Vector3(0, 0, 0)
                    })
                end
			end

		end

        CopDamage.register_listener("wolverine_stacks", {"SF2_on_damage"}, increase_wolverine_stacks)
	else
		CopDamage.unregister_listener("wolverine_stacks")
	end
end)

Hooks:PostHook(PlayerManager, "update", "Butcher_PlayerManager_update", function(self, t, dt)
	local player = self:player_unit()

	if not self:has_category_upgrade("player", "butcher_melee_stacking") or not player then
		return
	end
	
	self._wolverine_stack_decay_t = self._wolverine_stack_decay_t or t + self.wolverineStackDecayInterval
	if self._wolverine_stack_decay_t <= t and managers and managers.hud then
		self._wolverine_stack_decay_t = self._wolverine_stack_decay_t + self.wolverineStackDecayInterval
		self:update_wolverine_stacks(self.wolverineStackDecayDecrease)
        mx_log_chat('get_wolverine_stacks()', self:get_wolverine_stacks())
	end
end)