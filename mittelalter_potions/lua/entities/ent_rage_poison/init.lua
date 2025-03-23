AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()   
    self.Entity:SetModel("models/items/provisions/potions/mana_potion.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end

end

local damageboost = 1.3
local damageboostTime = 60

function ENT:Use(activator, caller)

	activator:ChatPrint("Deine venen füllen sich mit Wut! Deine Angriffe verursachen nun 30% mehr Schaden!")
	hook.Add( "EntityTakeDamage", "Mittelalter_potions_setDamageBoost", function( target, dmginfo )
        if ( target:IsPlayer() or target:IsNPC() ) then
            dmginfo:ScaleDamage(1.5)
        end
    end )

	timer.Simple(damageboostTime, function()

		hook.Remove("EntityTakeDamage", "Mittelalter_potions_setDamageBoost")

        hook.Add( "EntityTakeDamage", "Mittelalter_potions_setDamageBoostToDefault", function( target, dmginfo )
            if ( target:IsPlayer() or target:IsNPC() ) then
                activator:ScaleDamage(1)
            end
        end )

		hook.Remove("EntityTakeDamage", "Mittelalter_potions_setDamageBoostToDefault")
    end)

	self:Remove()
end

