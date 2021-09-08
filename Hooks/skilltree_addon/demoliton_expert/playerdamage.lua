local old_PlayerDamage_damage_explosion = PlayerDamage.damage_explosion
function PlayerDamage:damage_explosion(attack_data)
    if managers.player:has_category_upgrade("player", "explosion_resistance") then
        attack_data.damage = attack_data.damage * managers.player:upgrade_value("player", "explosion_resistance")
    end
    old_PlayerDamage_damage_explosion(self, attack_data)
end