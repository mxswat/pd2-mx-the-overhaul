function HUDManager:activate_local_ability_radial_with_fullscreen(time_left)
    local hud = managers.hud:script( PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)

    function make_bitmap()
        return hud.panel:bitmap({
			name = "chico_injector_left",
			visible = false,
			texture = "guis/textures/full_screen_effect_1",
			layer = 0,
			color = Color(1, 0.6, 0),
			blend_mode = "add",
			w = hud.panel:w(),
			h = hud.panel:h(),
			x = 0,
			y = 0 
		})
    end

    local chico_injector_left = hud.panel:child("chico_injector_left") or make_bitmap()

	local function anim(o)
		chico_injector_left:set_visible(true)
		over(time_left, function (p)
			
		end)
		chico_injector_left:set_visible(false)
	end

	chico_injector_left:stop()
	chico_injector_left:animate(anim)
    -- TODO add this? managers.hud:activate_teammate_ability_radial(HUDManager.PLAYER_PANEL, duration)
end