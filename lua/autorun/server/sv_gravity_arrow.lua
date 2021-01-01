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

-- Add the custom spawnmenu icon to the client download queue
resource.AddSingleFile( "materials/vgui/entities/gravity_arrow.vtf" )
resource.AddSingleFile( "materials/vgui/entities/gravity_arrow.vmt" )

-- Add the network strings
util.AddNetworkString( "gravityArrowToggle" ) -- Enabling or disabling the arrow
util.AddNetworkString( "gravityArrowNotify" ) -- Sending notifiations to the client

-- Runs when the client requests that the arrow be enabled or disabled
net.Receive( "gravityArrowToggle", function( length, player )

	-- Read the network variables
	local entity = net.ReadEntity()
	local state = net.ReadBool()

	-- Update the arrow's network var
	entity:SetEnabled( state )

end )

-- Runs when an entity is attempting to be spawned by a player
hook.Add( "PlayerSpawnSENT", "gravityArrowSpawn", function( ply, entityClass )

	-- Prevent further execution if this isn't for the gravity arrow
	if entityClass ~= "gravity_arrow" then return end

	-- Is there at least one arrow already on the map?
	if #ents.FindByClass( "gravity_arrow" ) > 0 then

		-- Send them a notification
		net.Start( "gravityArrowNotify" )
		net.WriteString( "Only one arrow can be spawned on the map, please remove the existing one first." )
		net.Send( ply )

		-- Prevent them from spawning it
		return false

	end

	-- Is there more than one player & are they not an admin?
	if #player.GetHumans() > 1 and not ply:IsAdmin() then

		-- Send them a notification
		net.Start( "gravityArrowNotify" )
		net.WriteString( "You cannot spawn this when there are multiple players online." )
		net.Send( ply )

		-- Prevent them from spawning it
		return false

	end

end )

-- Runs when a player initally spawns in the server
hook.Add( "PlayerInitialSpawn", "gravityArrowRemove", function( ply )

	-- Is there now more than one player?
	if #player.GetHumans() > 1 then

		-- Find all the spawned gravity arrows
		local arrows = ents.FindByClass( "gravity_arrow" )

		-- Loop through them
		for _, arrow in ipairs( arrows ) do

			-- Remove the arrow
			arrow:Remove()

		end

	end

end )
