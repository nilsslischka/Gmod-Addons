--colors
local main = Color(50, 50, 50)
local shadow = Color(20, 20, 20)
local hp_col = Color(255, 20, 0)
local rot = Color(150, 0, 0)
local background = Color(0, 0, 0, 200)
local hunger_col = Color(0, 200, 0)
local teamCol
local goldCol = Color(255, 215, 0)

--icons
local coin = Material("icons/coin.png", "smooth")

--vars
local h = ScrH()
local w = ScrW()
--local usergroup = LocalPlayer():GetUserGroup()

local Timestamp = os.time()
local TimeString = os.date( "Uhrzeit: %H:%M" , Timestamp )

-- screensize fixxen
hook.Add("OnScreenSizeChanged", "MittelalterRP_HUD_ScreenSizeFixForDraw", function(ow, oh)
    h = ScrH()
    w = ScrW()
end)

-- AvatarImage
local avt 
hook.Add( "InitPostEntity", "MittelalterRP_HUD_Avatar", function()
	if IsValid(avt) then return end 
    avt = vgui.Create( "AvatarImage" )
    avt:SetSize( w * .035, w * .032 )
    avt:SetPos( w * .014, h * .885 )
    avt:SetPlayer( LocalPlayer(), 128 )
end )

-- Draw HUD
hook.Add("HUDPaint", "MittelalterRP_Draw_HUD", function()
    if not LocalPlayer():Alive() then return end

    local hp, mhp = math.Clamp(LocalPlayer():Health(), 0, LocalPlayer():GetMaxHealth()), LocalPlayer():GetMaxHealth()
    local hunger, maxHunger = math.Clamp(LocalPlayer():getDarkRPVar("Energy"), 0, 100), 100

    teamCol = team.GetColor(LocalPlayer():Team())

    -- Draw Base
    surface.SetDrawColor(main)
    surface.DrawRect(w * .01, h * .875, w * .2, h * .075)

    surface.SetDrawColor(shadow)
    surface.DrawOutlinedRect(w * .01, h * .875, w * .2, h * .075)

    -- draw Name and Job
    draw.SimpleText(LocalPlayer():Nick(), "hud_medium", w * .055, h * .88, color_white, TEXT_ALIGN_LEFT)
    draw.SimpleText(LocalPlayer():getDarkRPVar("job"), "hud_main", w * .055, h * .9, teamCol, TEXT_ALIGN_LEFT)

    -- nutzergruppe
    --draw.SimpleText(string.upper(usergroup), "hud_small", w * .06, h * .925, color_white, TEXT_ALIGN_LEFT)

    -- zeit
    draw.SimpleTextOutlined(TimeString, "hud_main", w * .99, h * .005, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, shadow)

    --money
    surface.SetDrawColor(color_white)
    surface.SetMaterial(coin)
    surface.DrawTexturedRect(w * .15, h * .925, h * .02, h * .02)

    draw.SimpleText(LocalPlayer():getDarkRPVar("money"), "hud_medium", w * .165, h * .927, goldCol, TEXT_ALIGN_LEFT)

    --draw hp
    surface.SetDrawColor(hp_col)
    surface.DrawRect(w * .01, h * .96, w * .2 * (hp / mhp), h * .015)

    surface.SetDrawColor(background)
    surface.DrawRect(w * .01, h * .96, w * .2, h * .015)

    surface.SetDrawColor(shadow)
    surface.DrawOutlinedRect(w * .01, h * .96, w * .2, h * .015)

    --draw hunger
    surface.SetDrawColor(hunger_col)
    surface.DrawRect(w * .01, h * .98, w * .2 * (hunger / maxHunger), h * .015)

    surface.SetDrawColor(background)
    surface.DrawRect(w * .01, h * .98, w * .2, h * .015)

    surface.SetDrawColor(shadow)
    surface.DrawOutlinedRect(w * .01, h * .98, w * .2, h * .015)

    if LocalPlayer():getDarkRPVar("Energy") < 20 then
        draw.SimpleText("Du bist hungrig!", "hud_medium", w * .055, h * .925, hp_col, TEXT_ALIGN_LEFT)
    end
 
end)

