--[[------------------------------------------------------------------------
Gravity Arrow - A small blue arrow that controls the force of world gravity.
Copyright (C) 2020 - 2021 viral32111 (https://viral32111.com)

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

ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName = "Gravity Arrow"
ENT.Category = "Gravity Arrow"

ENT.Purpose = "A small blue arrow that controls the force of world gravity."
ENT.Instructions = "Spawn me, then point me in a direction."

ENT.Author = "viral32111"
ENT.Contact = "https://viral32111.com"

ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()

	self:NetworkVar( "Bool", 0, "Enabled" )
	self:NetworkVar( "Bool", 1, "AffectPlayers" )
	self:NetworkVar( "Int", 0, "Force" )

	if SERVER then
		self:SetEnabled( true )
		self:SetAffectPlayers( false )
		self:SetForce( 600 )
	end

end
