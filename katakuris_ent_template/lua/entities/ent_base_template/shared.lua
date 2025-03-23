ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "ENT Name" -- The name of the entity that appears in the spawn menu
ENT.Author = "Your Name" -- The name of the author of the script
ENT.Spawnable = true -- Whether the entity is spawnable or not
ENT.AdminOnly = false -- Whether only admins can spawn the entity or not
ENT.Category = "ENT Category"  -- The category that the entity will appear in the spawn menu

if CLIENT then 
    ENT.RenderGroup = RENDERGROUP_BOTH
end

