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

properties.Add( "gravityarrow", {

	-- Set the display text and icon
	MenuLabel = "Gravity Arrow",
	MenuIcon = "icon16/arrow_down.png",

	-- Set to display at the top
	Order = 0,

	-- Only show for entities that pass this check
	Filter = function( self, entity, player )

		-- Don't continue if the entity is somehow invalid
		if not IsValid( entity ) then return false end

		-- Don't continue if the CanProperty hook returns false
		if not hook.Run( "CanProperty", player, "gravityarrow", entity ) then return false end

		-- Return true/false if the entity is a Gravity Arrow
		return entity:GetClass() == "gravity_arrow"

	end,

	-- Runs when the property is added
	MenuOpen = function( self, option, entity, trace )

		-- Create the submenu
		local subMenu = option:AddSubMenu()

		-- Enable/disable completely option
		if entity:GetEnabled() then
			-- Add the disable option
			subMenu:AddOption( "Disable", function()
				if not hook.Run( "CanProperty", LocalPlayer(), "gravityarrow_disable", entity ) then return end

				net.Start( "gravityArrowToggle" )
					net.WriteEntity( entity )
					net.WriteBool( false )
				net.SendToServer()
			end ):SetIcon( "icon16/cross.png" )
		else
			-- Add the enable option
			subMenu:AddOption( "Enable", function()
				if not hook.Run( "CanProperty", LocalPlayer(), "gravityarrow_enable", entity ) then return end

				net.Start( "gravityArrowToggle" )
					net.WriteEntity( entity )
					net.WriteBool( true )
				net.SendToServer()
			end ):SetIcon( "icon16/tick.png" )
		end

		-- Affect players option
		--[[ https://github.com/conspiracy-servers/gravity-arrow/projects/1#card-41700985
		if entity:GetAffectPlayers() then
			local subOption = subMenu:AddOption( "Ignore Players", function()
				if not hook.Run( "CanProperty", LocalPlayer(), "gravityarrow_ignoreplayers", entity ) then return end
				entity:SetAffectPlayers( false )
			end )
			subOption:SetIcon( "icon16/cross.png" )
			subOption:SetEnabled( entity:GetEnabled() )
		else
			local subOption = subMenu:AddOption( "Affect Players", function()
				if not hook.Run( "CanProperty", LocalPlayer(), "gravityarrow_affectplayers", entity ) then return end
				entity:SetAffectPlayers( true )
			end )
			subOption:SetIcon( "icon16/tick.png" )
			subOption:SetEnabled( entity:GetEnabled() )
		end

		-- Force option
		local subOption = subMenu:AddOption( "Set Force", function()
			if not hook.Run( "CanProperty", LocalPlayer(), "gravityarrow_setforce", entity ) then return end
			print( "yolo" )
		end )
		subOption:SetIcon( "icon16/brick_go.png" )
		subOption:SetEnabled( entity:GetEnabled() )
		]]

	end,

	-- Runs when the property is clicked
	Action = function( self, entity, trace )

	end

} )

net.Receive( "gravityArrowNotify", function( length )

	-- Read the notification text
	local message = net.ReadString()

	-- Add the notification for 3 seconds
	notification.AddLegacy( message, NOTIFY_ERROR, 3 )

	-- Play a sound
	surface.PlaySound("buttons/button10.wav")

end )
