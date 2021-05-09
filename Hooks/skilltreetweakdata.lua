Hooks:PostHook(SkillTreeTweakData, "init", "VPPP_SkillTreeTweakData_init", function(self)
    local name_id_to_upgrade_map = {
        menu_deck12_1 = {
            "yakuza_injector",
            "temporary_yakuza_injector_1"
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
end)
