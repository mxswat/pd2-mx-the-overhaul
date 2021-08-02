function HUDManager:set_info_meter_fast(i, data)
	self._teammate_panels[i or HUDManager.PLAYER_PANEL]:set_info_meter_fast(data)
end
