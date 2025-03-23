include("shared.lua")

local modelDrawDist = 1000^2 -- how many units away the model will draw

function ENT:Draw()
    ply = ply or LocalPlayer()

    if ply:GetPos():DistToSqr(self:GetPos()) > modelDrawDist then return end
    self:DrawModel()
end

local dist = 200^2 -- how many units away the 3D2D text will draw

function ENT:DrawTranslucent()
    ply = ply or LocalPlayer()
    if ply:GetPos():DistToSqr(self:GetPos()) > dist then return end
    local ang = self:GetAngles()
    local pos = self:GetPos()

    ang:RotateAroundAxis(ang:Up(), 90)
    ang:RotateAroundAxis(ang:Forward(), 90)

    local forward = ang:Forward()
    local right = ang:Right()
    local up = ang:Up()

    pos = pos + up * 0 - right * 12 + forward * 0

    cam.Start3D2D(pos, ang, 0.02)
        --Write code here that appears on top of the Entity
    cam.End3D2D()
end