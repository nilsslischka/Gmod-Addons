if CLIENT then
    include("scoreboard/cl_core.lua")
    include("scoreboard/cl_fonts.lua")
    
    AddCSLuaFile("scoreboard/cl_core.lua")
    AddCSLuaFile("scoreboard/cl_fonts.lua")
end

if SERVER then 
    AddCSLuaFile("scoreboard/cl_core.lua")
    AddCSLuaFile("scoreboard/cl_fonts.lua")
    include("scoreboard/sv_core.lua")
end 