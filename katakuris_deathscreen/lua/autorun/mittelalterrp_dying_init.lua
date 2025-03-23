if CLIENT then
    include("dying_core/cl_deathscreen.lua")
    AddCSLuaFile("dying_core/cl_deathscreen.lua")
end

if SERVER then
    AddCSLuaFile("dying_core/cl_deathscreen.lua")
    include("dying_core/sv_deathscreen.lua")
end