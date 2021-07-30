Hooks:PostHook(StatisticsManager, "shot_fired", "VPPP_StatisticsManager_shot_fired", function(self, data)
    managers.player:update_striker_stacks(data.hit and 1 or -1)
end)