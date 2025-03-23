AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
 
function ENT:Initialize()   
    self.Entity:SetModel("models/items/provisions/potions/cure_poison_potion.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end

end

local speedBuffAmount = 75

function ENT:Use(activator, caller)
	if timer.Exists("SpeedBuffCheckFor"..activator:SteamID()) then
		activator:ChatPrint("Du bist noch erschöpft von letzten mal...")
		return
	end

	activator:SetRunSpeed(activator:GetRunSpeed() + speedBuffAmount)

	timer.Create("SpeedBuffCheckFor"..activator:SteamID(), 300, 1, function() end)

	activator:EmitSound("items/smallmedkit1.wav")

	self:Remove()

	timer.Simple(30, function()
		if IsValid(activator) then
			activator:SetRunSpeed(activator:GetRunSpeed() - speedBuffAmount)
		end
	end)
	
end

hook.Add("PlayerDeath", "Mittelalter_potions_removeSpeedCheck", function(ply)
	timer.Remove("SpeedBuffCheckFor"..ply:SteamID())
end)

