addEvent("enableGodMode", true)
addEvent("disableGodMode", true)
addEventHandler ("enableGodMode", getRootElement(), 
function()
  addEventHandler ("onClientPlayerDamage", getRootElement(), cancelEventEvent)
end)

addEventHandler ("disableGodMode", getRootElement(), 
function()
  removeEventHandler ("onClientPlayerDamage", getRootElement(), cancelEventEvent)
end)

function cancelEventEvent () cancelEvent() end 

--liedje in piratenschip
pirShipMusicCol = createColCuboid (1997.58,1523.16,8,6,17.66,4)
addEventHandler ("onClientColShapeHit", getRootElement(), 
function(hitElement, matchingDimension)
  if (source == pirShipMusicCol) and (hitElement == getLocalPlayer()) then
    setRadioChannel (7)
	-- dxDrawTextOnElement(getLocalPlayer(), "ZONA SEGURA", 1, 20, 0, 0, 255, 255, 1, "pricedown")
	-- outputChatBox("Zona segura")
  end
end)


addEventHandler ("onClientColShapeLeave", getRootElement(), 
function(leaveElement, matchingDimension)
  if (source == pirShipMusicCol) and (leaveElement == getLocalPlayer()) then
    setRadioChannel (0)
  end
end)



function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end


function onHit()
	
	function drawtext()
		dxDrawTextOnElement(localPlayer, "Greenzone", 0.91, 20, 0, 0,0, 255, 1.55, "default-bold")
		dxDrawTextOnElement(localPlayer, "Greenzone", 0.9, 20, 0, 255,0, 255, 1.5, "default-bold")	
	end
	addEventHandler ( "onClientRender", root, drawtext )
	outputChatBox("Name: "..getPlayerName(localPlayer))
end
addEvent( "onHit", true )
addEventHandler( "onHit", localPlayer, onHit )

function onLeave()
	removeEventHandler ( "onClientRender", root, drawtext )
end
addEvent( "onLeave", true )
addEventHandler( "onLeave", localPlayer, onLeave )


