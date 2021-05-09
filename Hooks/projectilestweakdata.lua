Hooks:PostHook(BlackMarketTweakData, "_init_projectiles", "VPPP_init_projectiles", function (self)
    local injectors = {
        {
            name_id = "yakuza_injector",
            base_cooldown = 30,
            max_amount = 1,
        },
        {
            name_id = "burglar_luck",
            base_cooldown = 30,
            max_amount = 1,
        },
        {
            name_id = "med_x",
            base_cooldown = 30,
            max_amount = 1,
        },
        {
            name_id = "auto_inject_super_stimpak",
            base_cooldown = 250,
            max_amount = 1,
        }
    }

    for i, injector in ipairs(injectors) do
        self.projectiles[injector.name_id] = {
            name_id = "bm_ability_"..injector.name_id.."",
            desc_id = "bm_ability_"..injector.name_id.."_desc",
            ignore_statistics = true,
            icon = injector.name_id,
            ability = injector.name_id,
            texture_bundle_folder = "mods",
            base_cooldown = injector.base_cooldown,
            max_amount = injector.max_amount,
            custom = true,
            sounds = {
                activate = "perkdeck_activate",
                cooldown = "perkdeck_cooldown_over"
            }
        }
    end
end)