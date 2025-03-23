local vectorpos = Vector( 0, 0, 85 )
local dist = 100^2

local function DrawName( ply )
	if ( !IsValid( ply ) ) then return end 
	if ( ply == LocalPlayer() ) then return end
	if ( !ply:Alive() ) then return end
 
	local Distance = LocalPlayer():GetPos():DistToSqr( ply:GetPos() ) 
	local hp, mhp = math.Clamp(ply:Health(), 0, ply:GetMaxHealth()), ply:GetMaxHealth()
	
	if ( Distance < dist ) then 
 
		local offset = vectorpos
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()
	 
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )
	 
		
		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.05 )
            draw.SimpleText(ply:getDarkRPVar("job"), "hud_overhead", 0, 0, color_white, TEXT_ALIGN_CENTER)
			surface.SetDrawColor(color_white)
			surface.DrawOutlinedRect(-200, 100, 400, 30)
			surface.DrawRect(-190, 110, 380 * (hp / mhp), 10)
		cam.End3D2D()
	end
end
hook.Add( "PostPlayerDraw", "MilitaryRP_hud_overhead", DrawName )