util.AddNetworkString("KatakurisDeathscreen:SendDeathScreenToClient")

local function sendDeathScreen(ply)
    net.Start("KatakurisDeathscreen:SendDeathScreenToClient")
    net.Send(ply)
end


hook.Add("PlayerDeath", "KatakurisDeathscreen:OnPlayerDeath", function(victim, inflictor, attacker)
    sendDeathScreen(victim)
    victim:EmitSound(KatakurisDeathscreen.DeathSound, 100, 100, 1, CHAN_AUTO)

    timer.Create(victim:SteamID64(), KatakurisDeathscreen.RespawnTime, 1, function() 
        victim:Spawn()
    end)

end)

