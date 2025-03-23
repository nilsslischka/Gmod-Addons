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

local healAmount = 25

function ENT:Use(activator, caller)
	if activator:Health() == activator:GetMaxHealth() then
		activator:ChatPrint("Du hast bereits volle Lebenspunkte!")
		return
	end

	if activator:Health() + 25 >= activator:GetMaxHealth() then
		activator:SetHealth(activator:GetMaxHealth())
	else
		activator:SetHealth(activator:Health() + healAmount)
	end
	activator:EmitSound("items/smallmedkit1.wav")

	activator:ChatPrint("Du wurdest für "..healAmount.."hp geheilt!")

	self:Remove()
end

