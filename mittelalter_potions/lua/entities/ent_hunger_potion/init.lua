AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
 
function ENT:Initialize()   
    self.Entity:SetModel("models/items/provisions/potions/full_life_potion.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end

end

local hungerRegenAmount = 2
local reps = 25

function ENT:Use(activator, caller)
	if activator:getDarkRPVar("Energy") == 100 then
		activator:ChatPrint("Du bist bereits Satt!")
		return
	end	

	timer.Create("SetHungerRegenFor"..activator:SteamID(), 1, reps, function()
		if not IsValid(activator) then return end

		if activator:getDarkRPVar("Energy") + hungerRegenAmount >= 100 then
			activator:setSelfDarkRPVar("Energy", 100)
			timer.Remove("SetHungerRegenFor"..activator:SteamID())
		else
			activator:setSelfDarkRPVar("Energy", activator:getDarkRPVar("Energy") + hungerRegenAmount)
		end

	end)

	activator:EmitSound("items/smallmedkit1.wav")

	self:Remove()
end

