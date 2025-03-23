

local h = ScrH()

hook.Add("OnScreenSizeChanged", "MittelalterRP_HUD_FixHeight", function(ow, oh)
    h = ScrH()

    chat.AddText(Color(0,195,255),"[SERVER]", color_white," Du hast deine Auflösung geändert, rejoine um die UI zu fixxen")
    chat.AddText(Color(0,195,255),"[SERVER]", color_white," falls UI fehler auftreten")
    chat.AddText(Color(255,0,0),"[Alte Auflösung] ", color_white, ow.." * "..oh)
    chat.AddText(Color(255,0,0),"[Neue Auflösung] ", color_white, ScrW().." * "..ScrH())

end)

resource.AddFile("resource/fonts/skyrim.ttf")

surface.CreateFont( "hud_main", {
    font = "Typo3",
    size = (h / 1080) * 20,
    weight = 800,
} )

surface.CreateFont( "hud_small", {
    font = "Typo3",
    size = (h / 1080) * 16,
    weight = 800,
} )

surface.CreateFont( "hud_medium", {
    font = "Typo3",
    size = (h / 1080) * 17,
    weight = 800,
} )


surface.CreateFont( "hud_overhead", {
    font = "Typo3",
    size = (h / 1080) * 80,
    weight = 800,
} )

surface.CreateFont( "hud_overhead_small", {
    font = "Typo3",
    size = (h / 1080) * 40,
    weight = 800,
} )