Hooks:PostHook(PlayerManager, "init", "SF_PlayerManager_init", function(self)
    self._cooldowns = {}
end)

function PlayerManager:get_ability_on_cooldown(ability_id)
    return self._cooldowns[ability_id] or 0
end

function PlayerManager:set_ability_on_cooldown(ability_id, cooldown_duration)
    self._cooldowns[ability_id] = Application:time() + cooldown_duration
end

function PlayerManager:is_ability_cooldown_ended(ability_id)
    return self:get_ability_on_cooldown(ability_id) < Application:time()
end

function PlayerManager:get_ability_remaining_cooldown(ability_id)
    return self:get_ability_on_cooldown(ability_id) - Application:time()
end

Hooks:RegisterHook("SF_Cooldowns_update")

Hooks:PostHook(PlayerManager, "update", "SF_PlayerManager_update", function(self, t, dt)
    Hooks:Call("SF_Cooldowns_update", self, t, dt)
end)
