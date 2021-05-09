Hooks:PostHook(SkillTreeTweakData, "init", "VPPP_SkillTreeTweakData_init", function(self)
    local name_id_to_upgrade_map = {
        menu_deck12_1 = {
            "yakuza_injector",
            "temporary_yakuza_injector_1"
        },
        menu_deck7_1 = {
            "burglar_luck",
            "temporary_burglar_luck_1"
        }
    }

    for k, deck in pairs(self.specializations) do
        for k, card in pairs(deck) do
            if card and card.name_id and name_id_to_upgrade_map[card.name_id] then
                if card.upgrades then
                    for i, upgrade_id in ipairs(name_id_to_upgrade_map[card.name_id]) do
                        table.insert(card.upgrades, upgrade_id)
                    end
                end
            end
        end
    end

    table.insert(self.default_upgrades, "med_x")
    table.insert(self.default_upgrades, "temporary_med_x_1")
    table.insert(self.default_upgrades, "auto_inject_super_stimpak")
end)
