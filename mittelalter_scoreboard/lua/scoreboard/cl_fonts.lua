resource.AddFile("resource/fonts/skyrim.ttf")

local h = ScrH()

hook.Add("OnScreenSizeChanged", "Scoreboard_fix_height_fonts", function(ow, oh)
    h = ScrH()
end)


surface.CreateFont( "scoreboard_big", {
    font = "Typo3",
    size = (h / 1080) * 30,
    weight = 500,
} )

surface.CreateFont( "scoreboard_main", {
    font = "Typo3",
    size = (h / 1080) * 20,
    weight = 600,
} )

surface.CreateFont( "scoreboard_small", {
    font = "Typo3",
    size = (h / 1080) * 18,
    weight = 600,
} )
