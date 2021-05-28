local vdp_Textura1 = dxCreateTexture("files/img/mark1.png")
local vdp_Textura2 = dxCreateTexture("files/img/mark2.png")
local vdp_Textura3 = dxCreateTexture("files/img/mark3.png")
local vdp_Textura4 = dxCreateTexture("files/img/mark4.png")

local renderTarget1 = dxCreateRenderTarget(500, 500, true)
local renderTarget2 = dxCreateRenderTarget(400, 20, true)

local font = dxCreateFont('font.ttf', 30, false, 'antialiased') or 'default' 

-----Creación de markers-----
local markersPos={{  1119.7529296875, -1478.580078125, 15.796875}
,{1119.7529296875, -1482.462890625, 15.796875}
}
local MarkerTable = {}
-- for v,marker in markersPos do
for i,v in ipairs(markersPos)do
	local groundZ=getGroundPosition(markersPos[i][1],markersPos[i][2],markersPos[i][3]+1)
	markersPos[i][3]=groundZ
	MarkerTable[i]=createMarker(markersPos[i][1],markersPos[i][2],markersPos[i][3],"cylinder",0.9,0,200,255,15)
end
-----------------------------


-- local vdp_Marker1 = createMarker(2041.71411, -1426.72, 16, "cylinder", 1.2, 0, 200, 255, 15)

-- local vdp_Marker2 = createMarker(2041.71411, -1426.72, 16, "cylinder", 1, 0, 0, 0, 0)

local r, g, b = 0, 200, 255
-- local groundZ= getGroundPosition (  2010.892578125, -1414.0517578125, 17.9921875)
-- outputChatBox(groundZ)
-- local vdp_Marker3 = createMarker(2014.18103515625, -1412.548828125, groundZ, "cylinder", 1.2, 0, 200, 255, 15)
local CurrentDimensionPlayer=getElementDimension(getLocalPlayer())
function vdpVidaCriar()
	dxSetRenderTarget(renderTarget1, true)
	dxDrawImage(250, 250, 254, 254, vdp_Textura1, getTickCount() / 10, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 254, 254, vdp_Textura2, getTickCount() / -15, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 254, 254, vdp_Textura3, getTickCount() / 50, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 254, 254, vdp_Textura4, getTickCount() / -100, 0, 0, tocolor(r, g, b, 200), false)
	dxSetRenderTarget()
	--ZONA PVP dim1
	if CurrentDimensionPlayer ==1 then
		dxDrawTextOnElement(MarkerTable[1], "Teleport Dimensión Zombie", 2.01,15, 0,0,0, 255, 1.21	,font)
		dxDrawTextOnElement(MarkerTable[1], "Teleport Dimensión Zombie", 2, 15, 193,207,43, 255, 1.2,font)
	elseif CurrentDimensionPlayer == 0 then	
		dxDrawTextOnElement(MarkerTable[1], "Teleport Dimensión Underworld", 2.01,15, 0,0,0, 255, 1.21	,font)
		dxDrawTextOnElement(MarkerTable[1], "Teleport Dimensión Underworld", 2, 15, 193,207,43, 255, 1.2,font)
	end
		dxDrawMaterialLine3D( markersPos[1][1]-1.5, markersPos[1][2]-1+0.45, markersPos[1][3]+0.05, markersPos[1][1]+0.5, markersPos[1][2]-0.5, markersPos[1][3]+0.05, renderTarget1, 2, tocolor(255, 255, 255, 255), 2039.99878, -1419.96094, 17.168 + 500000000)
		setElementDimension(MarkerTable[2],1)

	--DIMENSION ZOMBIE
	if CurrentDimensionPlayer ==1 then
		dxDrawTextOnElement(MarkerTable[2], "Teleport Zona PVP", 2.01,15, 0,0,0, 255, 1.21	,font)
		dxDrawTextOnElement(MarkerTable[2], "Teleport Zona PVP", 2, 15, 193,207,43, 255, 1.2,font)
		
		dxDrawMaterialLine3D( markersPos[2][1]-1.5, markersPos[2][2]-1+0.45, markersPos[2][3]+0.05, markersPos[2][1]+0.5, markersPos[2][2]-0.5, markersPos[2][3]+0.05, renderTarget1, 2, tocolor(255, 255, 255, 255), 2039.99878, -1419.96094, 17.168 + 500000000)
	end
end
addEventHandler("onClientRender", getRootElement(), vdpVidaCriar)

function vdpVidaMarkerEntrar(player,matchingDimension)
	if CurrentDimensionPlayer==1 then
		if (player == getLocalPlayer()) and (source == MarkerTable[1]) then
			teleportPlayer(player,1117.93359375, -1478.5009765625, 15.796875,0)
			CurrentDimensionPlayer=0
			setElementDimension(MarkerTable[1],0)
		end
	elseif CurrentDimensionPlayer==0 then
			teleportPlayer(player,1117.93359375, -1478.5009765625, 15.796875,1)
			CurrentDimensionPlayer=1
			setElementDimension(MarkerTable[1],1)
	end
end
addEventHandler("onClientMarkerHit", getRootElement(), vdpVidaMarkerEntrar)

function teleportPlayer(player,x,y,z,dimension)
	fadeCamera (false,0.5)
	setTimer( function()
			setElementPosition(player,x,y,z)
			fadeCamera(true)
			setElementVelocity(player,0,0,0)
			setElementAngularVelocity (player, 0,0,2 )
			setElementVelocity(player,0,0,0.18)
			triggerServerEvent ( "setDimension", resourceRoot,dimension)
			-- setElementDimension ( player,dimension)
			-- setelementRotation(player,0,0,90)
		 end, 700,1)
end

-- function vdpVidaMarkerSair(player)
	-- if (player == getLocalPlayer()) and (source == vdp_Marker2) then
		-- r, g, b = 0, 200, 255
		-- setMarkerColor(vdp_Marker1, 0, 200, 255, 15)
		-- setElementData(getLocalPlayer(), "Recarregar Vida", false)
	-- end
-- end
-- addEventHandler("onClientMarkerLeave", getRootElement(), vdpVidaMarkerSair)

-- setTimer(function(player)
	-- if (getElementData(getLocalPlayer(), "Recarregar Vida") == true) then
		-- if (isElementWithinMarker(getLocalPlayer(), vdp_Marker2)) then
			-- setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer()) + 0.5)
		-- end
	-- end
-- end, 300, 0)

-- function getPedMaxHealth(ped)
	-- assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got "..tostring(ped).."]")
	-- local stat = getPedStat(ped, 24)
	-- local maxhealth = 100 + (stat - 569) / 4.31
	-- return math.max(1, maxhealth)
-- end

-- **************************************************
-- **
-- ** Nome: Recarregar Vida
-- ** Author: ~#Brown^
-- ** Versão: 1.0
-- ** Data: 16/03/2016
-- ** Arquivo: client.lua
-- **
-- **************************************************

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