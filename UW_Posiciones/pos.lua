
function posicion (player)
	x, y, z = getElementPosition(player)
	getElementInterior(player)
	getElementDimension(player)
	xrotacion,yrotacion,zrotacion = getElementRotation (player)
	outputChatBox("#00ff00TU POSICION ES: #ffffff".. x ..", ".. y ..", " .. z, player, 0,255,0, true) -- Posicion --
        outputChatBox("#00FF00TU ROTACION ES: #ffffff".. xrotacion ..", ".. yrotacion ..", " .. zrotacion, player, 0,255,0, true) -- Rotacion --
	

end
addCommandHandler("posr", posicion)