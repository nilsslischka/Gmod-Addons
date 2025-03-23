timer.Simple(1, function()
	hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
	hook.Remove("ScoreboardHide", "FAdmin_scoreboard")
end)

--vars
local base

--colors
local main = Color(58, 0, 79)
local mainHover = Color(100, 0, 255)
local shadow = Color(20, 20, 20)
local red = Color(255, 0, 0)
local yellow = Color(255, 255, 0)
local shadow = Color(0, 0, 0, 100)
local shadowHover = Color(00, 00, 00, 150)

--cache
local scrw, scrh = ScrW(), ScrH()
local drawRoundedBox = draw.RoundedBox
local drawSimpleText = draw.SimpleText


--get kills and deaths
local function GetKills(ply)
    if ply:Frags() < 0 then
        return 0
    else 
        return ply:Frags()
    end
end

local function GetDeaths(ply)
    if ply:Deaths() < 0 then
        return 0
    else 
        return ply:Deaths()
    end
end

--fix w and h on screen size change
hook.Add("OnScreenSizeChanged", "Scoreboard_fix_width_height", function(ow, oh)
    scrw, scrh = ScrW(), ScrH()
end)

-- draw the scoreboard
local function ShowScore(toggle)
    if toggle then
        base = vgui.Create("DPanel")
        base:SetSize(scrw, scrh)
        base:Center()
        base:MakePopup()
        base.Paint = function(s, w, h)
            Derma_DrawBackgroundBlur(s, CurTime())
            drawSimpleText("Moonlight Network - Mittelalter Roleplay", "scoreboard_big", w * .5, h * .05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            drawSimpleText("Name", "scoreboard_main", w * .07, h * .1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            drawSimpleText("Job", "scoreboard_main", w / 2, h * .1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            drawSimpleText("Nutzergruppe", "scoreboard_main", w * .675, h * .1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            drawSimpleText("Kills  |  Deaths", "scoreboard_main", w * .85, h * .1, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            drawSimpleText("Ping", "scoreboard_main", w * .95, h * .1, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

            drawSimpleText("Linksklick um die SteamID zu Kopieren", "scoreboard_main", w * .05, h * .975, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            drawSimpleText("Rechtsklick um das Profil zu öffnen", "scoreboard_main", w * .95, h * .975, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

            drawSimpleText("Userzahl : "..#player.GetAll().." von "..game.MaxPlayers(), "scoreboard_main", w * .5, h * .975, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end 

        local bg = vgui.Create("DPanel", base)
        bg:SetSize(base:GetWide() * .95, base:GetTall() * .85)
        bg:SetPos(base:GetWide() * .025, base:GetTall() * .1)
        bg.Paint = nil 

        local scroll = vgui.Create("DScrollPanel", bg)
        scroll:SetPos(0, bg:GetTall() * 0.03)
        scroll:SetSize(bg:GetWide() * 1, bg:GetTall())
        function scroll:Paint(w, h) end
        local vbar = scroll:GetVBar()
	
		function vbar:Paint(w, h)
		end
		
		function vbar.btnUp:Paint(w, h)
		end
		
		function vbar.btnDown:Paint(w, h)
		end
		
		function vbar.btnGrip:Paint(w, h)
		end

        table.sort(player.GetAll(), function(a, b) return a:getJobTable().category > b:getJobTable().category end)
        for k, v in ipairs(player.GetAll()) do
            local usergroup = v:GetUserGroup()

            local user = vgui.Create("DButton", scroll)
            user:Dock(TOP)
            user:SetSize(scroll:GetWide(), scrh * .05)
            user:DockMargin(0, 0, 0, 10)
            user:SetText("")
            user.Paint = function(s, w, h)
                if s:IsHovered() then
                    drawRoundedBox(0, 0, 0, w, h, shadowHover)
                    drawRoundedBox(0, 0, 0, 5, h, mainHover)

                else 
                    drawRoundedBox(0, 0, 0, w, h, shadow)
                end

                surface.SetDrawColor(color_black)
                surface.DrawOutlinedRect(0, 0, w, h)

                drawSimpleText(v:Nick(), "scoreboard_small", w * .05, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                drawSimpleText(v:getDarkRPVar("job"), "scoreboard_small", w / 2, h * .5, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                drawSimpleText(string.upper(v:GetUserGroup()), "scoreboard_small", w * .685, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                drawSimpleText(GetKills(v).."      |      "..GetDeaths(v), "scoreboard_small", w * .865, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                drawSimpleText(v:Ping(), "scoreboard_small", w * .97, h * .5, yellow, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end 
            user.DoClick = function()
                SetClipboardText(v:SteamID())
                chat.AddText(red, "[Moonlight] ", color_white, "SteamID von ", team.GetColor(v:Team()), v:Nick(), color_white, " wurde kopiert")
            end 
            user.DoRightClick = function()
                v:ShowProfile()
            end 
            user.Think = function(s)
                if !IsValid(v) then
                    s:Remove()
                end
            end

            local avatar = vgui.Create("AvatarImage", user)
            avatar:SetSize(user:GetWide() * .027, user:GetTall() * .8) 
            avatar:SetPos(user:GetWide() * .01, user:GetTall() * .1)
            avatar:SetPlayer(v, 64)
        end

    else
        if IsValid(base) then
            base:Remove()
        end
    end
end 

hook.Add("ScoreboardShow", "scoreboard_show", function()
    ShowScore(true)
    return false
end)

hook.Add("ScoreboardHide", "scoreboard_hide", function()
    ShowScore(false)
end)

timer.Simple(2, function()
    print("Scoreboard wurde Geladen")
end)