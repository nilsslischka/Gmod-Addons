AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()   
    self.Entity:SetModel("models/items/provisions/potions/life_potion.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end

end

function ENT:Use(activator, caller)

	timer.Create("SetPoisonDamageTo".. activator:SteamID(), 3, 10, function()
		local damage = 5
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(damage)
		dmginfo:SetDamageType(DMG_BURN) 
		dmginfo:SetAttacker(game.GetWorld())
		dmginfo:SetInflictor(game.GetWorld())
		activator:TakeDamageInfo(dmginfo)
	end)

	self:Remove()
end

