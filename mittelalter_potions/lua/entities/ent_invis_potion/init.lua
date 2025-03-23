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

local invisibilityTime = 120
local transparent = Color(255, 255, 255, 40)
local white = Color(255, 255, 255, 255)

function ENT:Use(activator, caller)

	activator:SetRenderMode(RENDERMODE_TRANSALPHA) 
    activator:SetColor(transparent)

	timer.Simple(invisibilityTime, function()
		activator:SetRenderMode(RENDERMODE_NORMAL) 
    	activator:SetColor(white)
	end) 

	self:Remove()
end

