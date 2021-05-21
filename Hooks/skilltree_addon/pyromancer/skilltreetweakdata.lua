local skilltree_name = "mx_pack"

Hooks:Add("SF_InfamyTweakDataPostInit", "Pyromancer_InfamyTweakDataPostInit_Hawkeye", function(infamy)
    infamy:add_skill_tree(skilltree_name)
end)

Hooks:PostHook(SkillTreeTweakData, "init", "Pyromancer_SkillTreeTweakData_init", function(self)
    self:add_skill_tree(skilltree_name)

	local demolitionistTreeTiers = {
		{
			"extender"
		},
		{
			"strong_back",
			"flaming_hands"
		},
		{
			"hard_skin",
			"good_demoman"
		},
		{
			"primer_round"
		}
	}

	self:add_sub_skill_tree(skilltree_name, "mx_demolitionist", demolitionistTreeTiers)
	self:add_new_skill("extender", "flamethrower_flame_max_range_1", "flamethrower_flame_max_range_2", 1, { 6,6 })

	self:add_new_skill("strong_back", "XXX", "XXX", 2, { 6,0 })
	self:add_new_skill("flaming_hands", "flamethrower_reload_speed_multiplier_1", "flamethrower_reload_speed_multiplier_2", 2, { 1,9 })

	self:add_new_skill("good_demoman", "XXX", "XXX", 3, { 9,10 })
	self:add_new_skill("hard_skin", "XXX", "XXX", 3, { 1,7 })
	
	self:add_new_skill("primer_round", "XXX", "XXX", 4, { 0,0 })
end)