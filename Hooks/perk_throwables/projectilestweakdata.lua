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
            base_cooldown = 50,
            max_amount = 1,
        },
        {
            name_id = "auto_inject_super_stimpak",
            base_cooldown = 210,
            max_amount = 1,
        },
        {
            name_id = "adrenaline_shot",
            base_cooldown = 60,
            max_amount = 2,
        },
        {
            name_id = "spare_armor_plate",
            base_cooldown = 90,
            max_amount = 2,
            activate = "" -- I know, it's a bad fix, but I had no better idea to disable the sound and keep the default value defined
        },
        {
            name_id = "liquid_armor",
            base_cooldown = 90,
            max_amount = 1,
            activate = "" -- I know, it's a bad fix, but I had no better idea to disable the sound and keep the default value defined
        },
        {
            name_id = "blood_transfusion",
            base_cooldown = 40,
            max_amount = 1,
        },
        {
            name_id = "wick_mode",
            base_cooldown = 50,
            max_amount = 1,
        },
        {
            name_id = "emergency_requisition",
            base_cooldown = 25,
            max_amount = 1,
            activate = "" -- I know, it's a bad fix, but I had no better idea to disable the sound and keep the default value defined
        },
        {
            name_id = "the_mixtape",
            base_cooldown = 40,
            max_amount = 1,
            icon = "chico_injector"
        },
        {
            name_id = "throwable_trip_mine",
            base_cooldown = 100,
            max_amount = 2,
            icon = "equipment_trip_mine"
        },
        {
            name_id = "jet",
            base_cooldown = 40,
            max_amount = 1,
            icon = "chico_injector"
        },
        {
            name_id = "whiff",
            base_cooldown = 40,
            max_amount = 1,
            icon = "chico_injector"
        },
        {
            name_id = "lonestar_rage",
            base_cooldown = 40,
            max_amount = 1,
            icon = "lonestar_rage"
        },
        {
            name_id = "crooks_con",
            base_cooldown = 35,
            max_amount = 2,
            icon = "crooks_con"
        },
        {
            name_id = "crew_synchrony",
            base_cooldown = 50,
            max_amount = 1,
            icon = "blood_transfusion"
        },
        {
            name_id = "buff_banner",
            base_cooldown = 90,
            max_amount = 1,
            icon = "blood_transfusion"
        },
    }

    for i, injector in ipairs(injectors) do
        self.projectiles[injector.name_id] = {
            name_id = "bm_ability_"..injector.name_id.."",
            desc_id = "bm_ability_"..injector.name_id.."_desc",
            ignore_statistics = true,
            icon = injector.icon or injector.name_id,
            ability = injector.name_id,
            texture_bundle_folder = "mods",
            base_cooldown = injector.base_cooldown,
            max_amount = injector.max_amount,
            custom = true,
            sounds = {
                activate = injector.activate or "perkdeck_activate",
                cooldown = "perkdeck_cooldown_over"
            }
        }
    end

    self.projectiles.dynamite_mx = {
		name_id = "bm_dynamite",
		unit = "units/pd2_dlc_west/weapons/wpn_gre_dynamite/wpn_gre_dynamite",
		unit_dummy = "units/payday2/equipment/gen_equipment_tripmine/gen_equipment_tripmine_dummy",
		icon = "dynamite_grenade",
		dlc = "west",
		texture_bundle_folder = "west",
		max_amount = 3,
		throwable = true,
		animation = "throw_dynamite",
		anim_global_param = "projectile_dynamite",
		throw_allowed_expire_t = 0.1,
		expire_t = 1.3,
		repeat_expire_t = 1.5,
		is_a_grenade = true,
		is_explosive = true
	}

    self.projectiles.wpn_prj_four_mx = {
		name_id = "bm_wpn_prj_four",
		unit = "units/pd2_dlc_turtles/weapons/wpn_prj_four/wpn_prj_four",
		unit_dummy = "units/pd2_dlc_turtles/weapons/wpn_prj_four/wpn_prj_four_husk",
		local_unit = "units/pd2_dlc_turtles/weapons/wpn_prj_four/wpn_prj_four_local",
		icon = "four_projectile",
		throw_shout = true,
		no_cheat_count = true,
		impact_detonation = true,
		client_authoritative = true,
		add_trail_effect = true,
		throwable = true,
		texture_bundle_folder = "turtles",
		dlc = "turtles",
		max_amount = 10,
		anim_global_param = "projectile_four",
		throw_allowed_expire_t = 0.15,
		expire_t = 1.1,
		repeat_expire_t = 0.5
	}

    self.projectiles.wpn_prj_hur_mx = {
		name_id = "bm_wpn_prj_hur",
		unit = "units/pd2_dlc_born/weapons/wpn_fps_mel_hur/wpn_prj_hur",
		unit_dummy = "units/pd2_dlc_born/weapons/wpn_fps_mel_hur/wpn_prj_hur_husk",
		local_unit = "units/pd2_dlc_born/weapons/wpn_fps_mel_hur/wpn_prj_hur_local",
		icon = "throwing_axe",
		throw_shout = true,
		no_cheat_count = true,
		impact_detonation = true,
		client_authoritative = true,
		add_trail_effect = true,
		throwable = true,
		texture_bundle_folder = "born",
		dlc = "born",
		max_amount = 3,
		anim_global_param = "projectile_four",
		throw_allowed_expire_t = 0.15,
		expire_t = 1.1,
		repeat_expire_t = 0.5
	}

end)