
Hooks:PostHook(CopDamage, "_on_damage_received", "SF2_CopDamage__on_damage_received", function(self, damage_info)
    local new_damage_info = damage_info
    new_damage_info._unit = self._unit
    -- A better listener that always includes the cop unit
    CopDamage._notify_listeners("SF2_on_damage", new_damage_info)
end)