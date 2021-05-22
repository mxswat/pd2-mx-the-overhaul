
local old_WeaponDescription__get_skill_stats = WeaponDescription._get_skill_stats
function WeaponDescription._get_skill_stats(name, category, slot, base_stats, mods_stats, silencer, single_mod, auto_mod, blueprint)
	local skill_stats = old_WeaponDescription__get_skill_stats(name, category, slot, base_stats, mods_stats, silencer, single_mod, auto_mod, blueprint)
    local primary_category = tweak_data.weapon[name].categories[1]
    local flamer_clip_buff = managers.player:upgrade_value(primary_category, "magazine_capacity_inc", 0)
    if primary_category == "flamethrower" and flamer_clip_buff > 0 then
        local CLIP_AMMO_MAX = tweak_data.weapon[name].CLIP_AMMO_MAX
        skill_stats.magazine.skill_in_effect = true
        skill_stats.magazine.value = math.abs(CLIP_AMMO_MAX * (1 - flamer_clip_buff)) 
        -- it's the clips size multipliyed by the buff minus 1 becaue the values are 1.5 and 2, so half extra mag and double mag size
        -- so, by thanking the absolute value of this calculation you get the increase value
    end
	return skill_stats
end