local VPPP_NetworkPeer_send_queued_sync = NetworkPeer.send_queued_sync
function NetworkPeer:send_queued_sync(...)
    VPPP_NetworkPeer_send_queued_sync(self, FakeNadeSync(self, ...))
end

FakeSyncFixList = FakeSyncFixList or {}
FakeSyncFixInit = FakeSyncFixInit or {}

function FakeNadeSync(peer, d1, d2, d3, d4, d5, ...)
	local _c = function(pid, frag)
		if FakeSyncFixList[pid] and FakeSyncFixList[pid][frag] then
			return true
		end
		return false
	end
	local _d1 = tostring(d1)
	if type(peer) == 'number' then
		peer = managers.network:session():peer(peer)
	end
	if peer and peer.id and peer:id() then
		if _d1 == 'sync_grenades' then
			local projectile_tweak = tweak_data.blackmarket.projectiles[d2]
			if projectile_tweak and projectile_tweak.custom and not _c(peer:id(), d2) then
				d2 = projectile_tweak.base_on or 'concussion'
                d3 = math.min(projectile_tweak.max_amount, d3) -- D3 is the amount from the host
			end
		elseif _d1 == "sync_outfit" then

		end
	end
	return d1, d2, d3, d4, d5, ...
end