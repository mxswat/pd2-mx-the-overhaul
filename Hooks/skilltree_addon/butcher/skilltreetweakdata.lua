local skilltree_name = "mx_pack_2"

Hooks:Add("SF_InfamyTweakDataPostInit", "SF_InfamyTweakDataPostInit_Butcher", function(infamy)
    infamy:add_skill_tree(skilltree_name)
end)

local Old_SkillTreeTweakData_init = SkillTreeTweakData.init
function SkillTreeTweakData:init()
    Old_SkillTreeTweakData_init(self)

    self:add_skill_tree(skilltree_name)

    local treeTiers = {
		{"the_melee_way"}, 
		{"pumping_iron_plus"},
		{"wolverine"}
	}

    self:add_sub_skill_tree(skilltree_name, "mx_butcher", treeTiers)
    self:add_new_skill("the_melee_way", {}, {}, 1, {6, 6})
    local pumping_iron_plus_basic = {"player_non_special_melee_multiplier"}
    local pumping_iron_plus_aced = {"player_melee_damage_multiplier"}
    self:add_new_skill("pumping_iron_plus", pumping_iron_plus_basic, pumping_iron_plus_aced, 2, {1, 3})

	local wolverine_basic = {"player_butcher_melee_stacking_1"}
    local wolverine_aced = {"player_butcher_melee_stacking_2"}
    self:add_new_skill("wolverine", wolverine_basic, wolverine_aced, 3, {1, 3})
end

--[[
	-- Melee attack speed
	-- Extra range
	-- Berserker Plus
	-- Counter attack plus
	-- Pumping iron plus
	-- Hit multiple enemies at once?

]] -- 
