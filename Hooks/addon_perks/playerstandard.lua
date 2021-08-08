Hooks:PreHook(PlayerStandard, "_start_action_unequip_weapon", "Addon_Perks_PlayerStandard__start_action_unequip_weapon", function(self, t, data)
    self._equipped_unit:base():on_reload()
    managers.hud:set_ammo_amount(self._equipped_unit:base():selection_index(), self._equipped_unit:base():ammo_info())
end)