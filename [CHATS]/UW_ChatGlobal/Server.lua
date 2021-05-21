function RemoveHEXColorCode( s ) 
    return s:gsub( '#%x%x%x%x%x%x', '' ) or s 
end 

function RGBToHex(red, green, blue, alpha)
	
	-- Make sure RGB values passed to this function are correct
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end

	-- Alpha check
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end

end

function colouredChat ( message, theType )
	if theType == 0 then --if its normal chat (not /me or teamchat) then
		cancelEvent() --prevent MTA from outputting chat
		local message = RemoveHEXColorCode(message)
		local r,g,b = getPlayerNametagColor ( source ) --get the player's nametag colour
		local chatterName = RemoveHEXColorCode(getPlayerName ( source )) --get his name
		local colorTeam=RGBToHex(getTeamColor(getPlayerTeam(source)))
		--output a message with the name as his nametag colour, and the rest in white.
		outputChatBox ( colorTeam..chatterName..":#FFFFFF "..message, root, r, g, b, true )
	end
end
addEventHandler("onPlayerChat", root, colouredChat)

function nickChangeHandler(oldNick, newNick)
    -- check if there's account with newNick as username
	local colorTeam=RGBToHex(getTeamColor(getPlayerTeam(source)))
	local nnick=colorTeam..RemoveHEXColorCode(newNick)
	-- setPlayerName ( source,nnick)
end
-- add an event handler
addEventHandler("onPlayerChangeNick", getRootElement(), nickChangeHandler)

function nickChangeHandler()
	setPlayerName ( source,RemoveHEXColorCode(getPlayerName(source)))
end
addEventHandler("onPlayerJoin",root,nickChangeHandler)