function AddAddonPerks(self)
    local deck2 = {
		cost = 0,
		desc_id = "menu_deckall_2_desc",
		name_id = "menu_deckall_2",
		upgrades = {
			"weapon_passive_headshot_damage_multiplier"
		},
		icon_xy = {
			1,
			0
		}
	}
	local deck4 = {
		cost = 0,
		desc_id = "menu_deckall_4_desc",
		name_id = "menu_deckall_4",
		upgrades = {
			"passive_player_xp_multiplier",
			"player_passive_suspicion_bonus",
			"player_passive_armor_movement_penalty_multiplier"
		},
		icon_xy = {
			3,
			0
		}
	}
	local deck6 = {
		cost = 0,
		desc_id = "menu_deckall_6_desc",
		name_id = "menu_deckall_6",
		upgrades = {
			"armor_kit",
			"player_pick_up_ammo_multiplier"
		},
		icon_xy = {
			5,
			0
		}
	}
	local deck8 = {
		cost = 0,
		desc_id = "menu_deckall_8_desc",
		name_id = "menu_deckall_8",
		upgrades = {
			"weapon_passive_damage_multiplier",
			"passive_doctor_bag_interaction_speed_multiplier"
		},
		icon_xy = {
			7,
			0
		}
	}

    local dodgeOpath = {
        {
            cost = 0,
            desc_id = "menu_deck9_1_desc",
            name_id = "menu_deck9_1",
            upgrades = {
                "player_damage_dampener_outnumbered_strong",
                "melee_stacking_hit_damage_multiplier_1",
                "player_passive_dodge_chance_2",
                "temporary_dodgeopath_speed_1",
                "temporary_dodgeopath_dodge_1",
                "the_mixtape",
                "temporary_the_mixtape_1"
            },
            icon_xy = {
                6,
                4
            }
        },
        deck2,
        {
            cost = 0,
            desc_id = "menu_deck9_3_desc",
            name_id = "menu_deck9_3",
            upgrades = {
                -- "player_killshot_regen_armor_bonus",
                -- "player_tier_armor_multiplier_1",
                -- "player_tier_armor_multiplier_2"
            },
            icon_xy = {
                0,
                5
            }
        },
        deck4,
        {
            cost = 0,
            desc_id = "menu_deck9_5_desc",
            name_id = "menu_deck9_5",
            upgrades = {
                -- "player_melee_kill_life_leech",
                "player_damage_dampener_close_contact_1"
            },
            icon_xy = {
                1,
                5
            }
        },
        deck6,
        {
            cost = 0,
            desc_id = "menu_deck9_7_desc",
            name_id = "menu_deck9_7",
            upgrades = {
                -- "player_killshot_close_regen_armor_bonus",
                -- "player_tier_armor_multiplier_3"
            },
            icon_xy = {
                2,
                5
            }
        },
        deck8,
        {
            cost = 0,
            desc_id = "menu_deck9_9_desc",
            name_id = "menu_deck9_9",
            upgrades = {
                "player_passive_loot_drop_multiplier",
                "player_killshot_close_panic_chance"
            },
            icon_xy = {
                3,
                5
            }
        },
        name_id = "menu_st_spec_9_dodge",
        desc_id = "menu_st_spec_9_dodge_desc"
    }

    table.insert(self.specializations, dodgeOpath)
end

Hooks:PostHook(SkillTreeTweakData, "init", "addon_perks_SkillTreeTweakData_init", AddAddonPerks)
