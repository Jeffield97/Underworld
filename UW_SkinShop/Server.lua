local playerMarker = createMarker(1146.5947265625, -1514.9794921875, 15.796875, "cylinder", 0.5, 10, 244, 23, 0)
setElementDimension(playerMarker,1)


function handlePlayerMarker(hitElement)
	local elementType = getElementType(hitElement)
	if elementType == "player" then
		-- outputChatBox("Element ("..elementType..") has entered marker.")
		triggerClientEvent ( hitElement, "SkinSelector", hitElement )
		setElementFrozen(hitElement,true)
	end
	
end
addEventHandler("onMarkerHit", playerMarker, handlePlayerMarker)

function setSkin(skin)
	setElementModel(client,skin)
end
addEvent("setSkin",true)
addEventHandler("setSkin",resourceRoot,setSkin)