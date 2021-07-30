
local VPPP_BlackMarketManager_recoil_addend = BlackMarketManager.recoil_addend
function BlackMarketManager:recoil_addend(name, categories, recoil_index, silencer, blueprint, current_state, is_single_shot)
	local addend = VPPP_BlackMarketManager_recoil_addend(self, name, categories, recoil_index, silencer, blueprint, current_state, is_single_shot)
	addend = addend + managers.player:upgrade_value("player", "stability_increase_bonus_striker", 0)
	return addend
end

local VPPP_BlackMarketManager_damage_multiplier = BlackMarketManager.damage_multiplier
function BlackMarketManager:damage_multiplier(name, categories, silencer, detection_risk, current_state, blueprint)
	local result = VPPP_BlackMarketManager_damage_multiplier(self, name, categories, silencer, detection_risk, current_state, blueprint)
	-- code
	return result
end
