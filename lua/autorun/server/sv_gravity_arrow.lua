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

-- Add the custom spawnmenu icon to the client download queue
resource.AddSingleFile( "materials/vgui/entities/gravity_arrow.vtf" )
resource.AddSingleFile( "materials/vgui/entities/gravity_arrow.vmt" )

-- Add the network string for enabling or disabling the arrow
util.AddNetworkString( "gravityArrowToggle" )

-- Runs when the client requests that the arrow be enabled or disabled
net.Receive( "gravityArrowToggle", function( length, player )
	-- Read the network variables
	local entity = net.ReadEntity()
	local state = net.ReadBool()

	-- Update the arrow's network var
	entity:SetEnabled( state )
end )
