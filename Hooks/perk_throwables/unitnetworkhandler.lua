-- local VPPP_UnitNetworkHandler_sync_grenades_cooldown = UnitNetworkHandler.sync_grenades_cooldown
-- function UnitNetworkHandler:sync_grenades_cooldown(end_time, duration, sender)
--     log("UnitNetworkHandler:sync_grenades_cooldown")
--     local peer = self._verify_sender(sender)
--     local is_local_player = managers.network:session():local_peer() == peer
--     local grenade, amount = managers.blackmarket:equipped_grenade()
--     local nade_tweak = tweak_data.blackmarket.projectiles[grenade]
--     local is_using_custom_injector = nade_tweak.custom and nade_tweak.base_cooldown
--     local is_on_real_cooldown = amount < nade_tweak.max_amount
--     mx_print_table({
--         is_local_player = is_local_player,
--         is_using_custom_injector = is_using_custom_injector,
--         is_on_real_cooldown = is_on_real_cooldown,  
--     })
--     if is_local_player and is_using_custom_injector and is_on_real_cooldown then
--         log('CUSTOM sync_grenades_cooldown')
--         -- get_timer_remaining
--         return -- Do not use host sync
--     end
--     return VPPP_UnitNetworkHandler_sync_grenades_cooldown(self, end_time, duration, sender)
-- end