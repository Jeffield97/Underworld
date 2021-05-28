function setDimension(dimension)
    setElementDimension(client,dimension)
end
addEvent("setDimension",true)
addEventHandler("setDimension", getResourceRootElement(getThisResource()),setDimension)

markersPos={{  1119.7529296875, -1478.580078125, 15.796875} --Dimension Underworld 1
		,{1119.7529296875, -1478.580078125, 15.796875}--Dimension Zombie 0
		,{1119.7529296875, -1482.462890625, 15.796875}--Zona PVP
		,{-978.05078125, 1053.0654296875, 1344.9899902344}--Zona PVP Quit
		}
MarkerTable = {}
MarkerTableAlpha = {}
for i,v in ipairs(markersPos)do
	MarkerTable[i]=createMarker(markersPos[i][1],markersPos[i][2],markersPos[i][3],"cylinder",0.9,0,200,255,0)
	-- outputChatBox("Marker creado!!")
end

--Markers Alpha
for i,v in ipairs(markersPos)do
	MarkerTableAlpha[i]=createMarker(markersPos[i][1],markersPos[i][2],markersPos[i][3]-1.8,"cylinder",0.9,0,200,255,255)
end


-- local marker= createMarker(-975.9580078125, 1071.265625, 1344.9842529297,"cylinder",1,0,200,255,255)
-- setElementDimension(marker,1)
-- setElementInterior(marker,10)

--Dimensiones cambios----
-------------------------
setElementDimension(MarkerTableAlpha[2],1)
-- setElementDimension(MarkerTableAlpha[1],1)

function MarkerUnderZombie(hitElement,matchingDimension)
	local elementType = getElementType(hitElement)
	if elementType=="player" then
		if getElementDimension(hitElement) ==1 then
			teleportPlayer(hitElement,1113.8408203125, -1478.5498046875, 15.796875,0,0)
		elseif getElementDimension(hitElement)==0 then
			teleportPlayer(hitElement,1113.8408203125, -1478.5498046875, 15.796875,1,0)
		end
		
	end
end
addEventHandler("onMarkerHit", MarkerTable[1], MarkerUnderZombie)

--Zona PVP--------------------
------------------------------
setElementDimension(MarkerTable[3],1)
setElementDimension(MarkerTableAlpha[3],1)


function MarkerPVPZone(hitElement,matchingDimension)
	local elementType = getElementType(hitElement)
	if elementType=="player" then
		if matchingDimension then
			teleportPlayer(hitElement,-973.6103515625, 1061.0419921875, 1345.6732177734,1,10)
		end
	end
end
addEventHandler("onMarkerHit", MarkerTable[3], MarkerPVPZone)

setElementInterior(MarkerTable[4],10)
setElementDimension(MarkerTable[4],1)

setElementInterior(MarkerTableAlpha[4],10)
setElementDimension(MarkerTableAlpha[4],1)




function MarkerPVPZoneQuit(hitElement,matchingDimension)
	local elementType = getElementType(hitElement)
	if elementType=="player" then
		if matchingDimension then
			teleportPlayer(hitElement,1115.3291015625, -1482.8017578125, 15.796875,1,0)
		end
	end
end
addEventHandler("onMarkerHit", MarkerTable[4], MarkerPVPZoneQuit)

function teleportPlayer(player,x,y,z,dimension,interior)
	fadeCamera ( player, false,0.5)
	setTimer( function()
			setElementDimension(player,dimension or 1)
			setElementPosition(player,x,y,z)
			fadeCamera(player,true)
			setElementVelocity(player,0,0,0)
			setElementAngularVelocity (player, 0,0,2 )
			setElementVelocity(player,0,0,0.18)
			setElementInterior ( player,interior or 0)
		 end, 900,1)
end