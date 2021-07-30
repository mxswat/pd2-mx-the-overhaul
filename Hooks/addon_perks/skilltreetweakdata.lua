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
            desc_id = "dodgeopath_1_desc",
            name_id = "dodgeopath_1",
            upgrades = {
                "player_damage_dampener_outnumbered_strong",
                "melee_stacking_hit_damage_multiplier_1",
                "player_passive_dodge_chance_2",
                "temporary_dodgeopath_speed_1",
                "temporary_dodgeopath_invulnerability_on_kill_1",
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
            desc_id = "dodgeopath_3_desc",
            name_id = "dodgeopath_3",
            upgrades = {

            },
            icon_xy = {
                0,
                5
            }
        },
        deck4,
        {
            cost = 0,
            desc_id = "dodgeopath_5_desc",
            name_id = "dodgeopath_5",
            upgrades = {
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
            desc_id = "dodgeopath_7_desc",
            name_id = "dodgeopath_7",
            upgrades = {

            },
            icon_xy = {
                2,
                5
            }
        },
        deck8,
        {
            cost = 0,
            desc_id = "dodgeopath_9_desc",
            name_id = "dodgeopath_9",
            upgrades = {
                "player_passive_loot_drop_multiplier",
                "player_killshot_close_panic_chance"
            },
            icon_xy = {
                3,
                5
            }
        },
        name_id = "dodgeopath",
        desc_id = "dodgeopath_desc"
    }

    -- Striker's Battlegear
    -- +28 Stability
    -- Every consecutive hit deals 1% more damage. Stacks up to 100%. Missing shots drops bonus by 2%. Bonus is reduced by 1% every second.
    -- Every hit adds 1 stacks of a self-healing bonus; each stack is worth 0.01% of max health per second. Stacks up to 100 hits. [This bonus is increased by 0.05% per stack for every 3000 Stamina | Maybe scale with armor]

    local striker = {
        {
            cost = 0,
            desc_id = "striker_1_desc",
            name_id = "striker_1",
            upgrades = {
                "player_striker_accuracy_to_damage_1",
                "player_stability_increase_bonus_striker_1"
            },
            icon_xy = {
                5,
                2
            }
        },
        deck2,
        {
            cost = 0,
            desc_id = "striker_3_desc",
            name_id = "striker_3",
            upgrades = {

            },
            icon_xy = {
                5,
                2
            }
        },
        deck4,
        {
            cost = 0,
            desc_id = "striker_5_desc",
            name_id = "striker_5",
            upgrades = {

            },
            icon_xy = {
                5,
                2
            }
        },
        deck6,
        {
            cost = 0,
            desc_id = "striker_7_desc",
            name_id = "striker_7",
            upgrades = {

            },
            icon_xy = {
                5,
                2
            }
        },
        deck8,
        {
            cost = 0,
            desc_id = "striker_9_desc",
            name_id = "striker_9",
            upgrades = {
                "player_passive_loot_drop_multiplier",
            },
            icon_xy = {
                5,
                2
            }
        },
        name_id = "striker",
        desc_id = "striker_desc"
    }

    table.insert(self.specializations, dodgeOpath)
    table.insert(self.specializations, striker)
end

Hooks:PostHook(SkillTreeTweakData, "init", "addon_perks_SkillTreeTweakData_init", AddAddonPerks)
