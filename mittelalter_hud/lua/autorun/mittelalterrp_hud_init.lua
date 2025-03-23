if CLIENT then
    include("hud/cl_draw.lua")
    include("hud/cl_fonts.lua")
    include("hud/cl_hide.lua")
    include("hud/cl_overhead.lua")

    AddCSLuaFile("hud/cl_draw.lua")
    AddCSLuaFile("hud/cl_fonts.lua")
    AddCSLuaFile("hud/cl_hide.lua")
    AddCSLuaFile("hud/cl_overhead.lua")
end

if SERVER then
    AddCSLuaFile("hud/cl_draw.lua")
    AddCSLuaFile("hud/cl_fonts.lua")
    AddCSLuaFile("hud/cl_hide.lua")
    AddCSLuaFile("hud/cl_overhead.lua")
end