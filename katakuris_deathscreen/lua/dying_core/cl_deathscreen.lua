-- vars
local deathscreen
local hh = ScrH()
local ww = ScrW()

-- colors
local red = Color(255, 20, 0)

--fonts
resource.AddFile("resource/fonts/skyrim.ttf")

surface.CreateFont( "DeathScreenFontBig", {
    font = "Typo3",
    size = (hh / 1080) * 40,
    weight = 700,
} )

surface.CreateFont( "DeathScreenFontNormal", {
    font = "Typo3",
    size = (hh / 1080) * 30,
    weight = 700,
} )

-- Deathscreen
net.Receive("KatakurisDeathscreen:SendDeathScreenToClient", function()
    if IsValid(deathscreen) then return end 

    surface.PlaySound(KatakurisDeathscreen.HeartbeatSound)

    deathscreen = vgui.Create("DPanel")
    deathscreen:SetSize(ww, hh)
    deathscreen:SetPos(0, 0)
    deathscreen:MakePopup()
    local bar, speed = 0, 1
    deathscreen.Paint = function(s, w, h)
        bar = math.Clamp(bar + speed * FrameTime(), 0, 1)

        surface.SetDrawColor(0, 0, 0, 255*bar)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255, 255*bar)
        surface.SetMaterial(KatakurisDeathscreen.Icon)
        surface.DrawTexturedRect(w/2 - 64, h/2 - 64, 128, 128)

        draw.SimpleText(KatakurisDeathscreen.BiggerText, "DeathScreenFontBig", w / 2, h * .6, Color(red.r, red.g, red.b, red.a*bar), 1, 1)
        draw.SimpleText(KatakurisDeathscreen.SmallerText, "DeathScreenFontNormal", w / 2, h * .65, Color(red.r, red.g, red.b, red.a*bar), 1, 1)

    end 

    timer.Create("RemoveDeathScreenFrom"..LocalPlayer():SteamID64(), KatakurisDeathscreen.RespawnTime, 1, function() 
        deathscreen:Remove()
    end)
end)