local VPPP_OutfitString_Block = BlackMarketManager.outfit_string

function BlackMarketManager:outfit_string()
	local outfit_string = VPPP_OutfitString_Block(self)
	local _grenade = self:equipped_grenade()
	if tweak_data.blackmarket.projectiles[_grenade].custom then
		outfit_string = outfit_string:gsub(_grenade, 'concussion') -- I dont care of using based_on like beardlib, I just dont want people to crash
	end
	return outfit_string
end