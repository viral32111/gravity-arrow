--[[------------------------------------------------------------------------
Gravity Arrow - A small blue arrow that controls the force of world gravity.
Copyright (C) 2020 viral32111 (https://viral32111.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see https://www.gnu.org/licenses.
------------------------------------------------------------------------]]--

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:Initialize()

	self:SetModel( "models/sprops/misc/alphanum/alphanum_arrow_b.mdl" )
	self:SetMaterial( "models/debug/debugwhite" )
	self:SetColor( Color( 64, 112, 255 ) )

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )

	local physicsObject = self:GetPhysicsObject()

	if physicsObject:IsValid() then

		physicsObject:Wake()

	end

end

function ENT:SpawnFunction( spawner, traceResult, entityClass )

	if not traceResult.Hit then return end

	local position = traceResult.HitPos + traceResult.HitNormal * 9
	local angle = physenv.GetGravity():AngleEx( Vector( 0, 0, 0 ) ) + Angle( 90, 0, 0 )

	local arrow = ents.Create( entityClass )
	arrow:SetPos( position )
	arrow:SetAngles( angle )
	arrow:Spawn()
	arrow:Activate()
	arrow:GetPhysicsObject():EnableMotion( false )

	return arrow

end

function ENT:Think()

	physenv.SetGravity( self:GetUp() * 600 )

	self:NextThink( CurTime() + 0.1 )

	return true

end

function ENT:OnRemove()

	physenv.SetGravity( Vector( 0, 0, -600 ) )

end
