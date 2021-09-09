function PlayerManager:get_wolverine_stacks()
	return self._decaying_stacks.wolverine_stacks or 0
end

function PlayerManager:update_wolverine_stacks(value)
	local newValue = self._decaying_stacks.wolverine_stacks + value
	self._decaying_stacks.wolverine_stacks = math.min(math.max(newValue, 0), 1);
end

Hooks:PostHook(PlayerManager, "_setup", "Butcher_PlayerManager__setup", function(self)
	self._decaying_stacks = self._decaying_stacks or {}
	self._decaying_stacks.wolverine_stacks = 0

    if self:has_category_upgrade("player", "butcher_melee_stacking") then
		local function increase_wolverine_stacks(damage_info)
            local attacker_unit = damage_info.attacker_unit
            local variant = damage_info.variant
            mx_log_chat('variant', variant)
			if variant == "melee" and attacker_unit == self:player_unit() then
				self:update_wolverine_stacks(PlayerManager.wolverineStackIncrease)
			end
		end

        CopDamage.register_listener("wolverine_stacks", {"SF2_on_damage"}, increase_wolverine_stacks)
	else
		CopDamage.unregister_listener("wolverine_stacks")
	end
end)

PlayerManager.wolverineStackIncrease = 0.10
PlayerManager.wolverineStackDecrease = 0.10 -- not used with wolverine
PlayerManager.wolverineStackDecayDecrease = -0.05
PlayerManager.wolverineStackDecayInterval = 2.5 -- seconds between one decay and the other

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