
local vdp_Textura1 = dxCreateTexture("files/img/mark1.png")
local vdp_Textura2 = dxCreateTexture("files/img/mark2.png")
local vdp_Textura3 = dxCreateTexture("files/img/mark3.png")
local vdp_Textura4 = dxCreateTexture("files/img/mark4.png")
local renderTarget1 = dxCreateRenderTarget(500, 500, true)
-- local renderTarget2 = dxCreateRenderTarget(400, 20, true)
local font = dxCreateFont('font.ttf', 30, false, 'antialiased') or 'default'    
addEventHandler( "onClientResourceStart", getRootElement( ),
   function ( startedRes )
    
		

		-----Creación de markers-----
		markersPos={{  1119.7529296875, -1478.580078125, 15.796875}
		,{1119.7529296875, -1482.462890625, 15.796875}
		}
		 -- MarkerTable = {}
		for i,v in ipairs(markersPos)do
			local groundZ=getGroundPosition(markersPos[i][1],markersPos[i][2],markersPos[i][3]+1)
			markersPos[i][3]=groundZ
			-- MarkerTable[i]=createMarker(markersPos[i][1],markersPos[i][2],markersPos[i][3],"cylinder",0.9,0,200,255,15)
		end

    end
);

function vdpVidaCriar()
	dxSetRenderTarget(renderTarget1, true)
	dxDrawImage(250, 250, 254, 254, vdp_Textura1, getTickCount() / 10, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 254, 254, vdp_Textura2, getTickCount() / -15, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 254, 254, vdp_Textura3, getTickCount() / 50, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 254, 254, vdp_Textura4, getTickCount() / -100, 0, 0, tocolor(r, g, b, 200), false)
	dxSetRenderTarget()
	--ZONA PVP dim1
	if getElementDimension(getLocalPlayer()) ==1 then
		-- dxDrawTextOnElement(MarkerTable[1], "Teleport Dimensión Zombie", 2.01,15, 0,0,0, 255, 1.21	,font)
		dxDrawTextOnElement("Teleport Dimensión Zombie", 2, 15, 193,207,43, 255, 1.2,font,markersPos[1][1],markersPos[1][2],markersPos[1][3])
	else	
		dxDrawTextOnElement("Teleport Dimensión Underworld", 2, 15, 193,207,43, 255, 1.2,font,markersPos[1][1],markersPos[1][2],markersPos[1][3])
	end
		dxDrawMaterialLine3D( markersPos[1][1]-1.5, markersPos[1][2]-1+0.45, markersPos[1][3]+0.05, markersPos[1][1]+0.5, markersPos[1][2]-0.5, markersPos[1][3]+0.05, renderTarget1, 2, tocolor(255, 255, 255, 255), 2039.99878, -1419.96094, 17.168 + 500000000)
		

	--DIMENSION ZOMBIE
	if getElementDimension(getLocalPlayer()) ==1 then
		-- dxDrawTextOnElement(MarkerTable[2], "Teleport Zona PVP", 2.01,15, 0,0,0, 255, 1.21	,font)
		-- dxDrawTextOnElement(MarkerTable[2], "Teleport Zona PVP", 2, 15, 193,207,43, 255, 1.2,font)
		dxDrawTextOnElement("Teleport Zona PVP", 2, 15, 193,207,43, 255, 1.2,font,markersPos[2][1],markersPos[2][2],markersPos[2][3])
		dxDrawMaterialLine3D( markersPos[2][1]-1.5, markersPos[2][2]-1+0.45, markersPos[2][3]+0.05, markersPos[2][1]+0.5, markersPos[2][2]-0.5, markersPos[2][3]+0.05, renderTarget1, 2, tocolor(255, 255, 255, 255), 2039.99878, -1419.96094, 17.168 + 500000000)
		-- dxDrawMaterialLine3D( markersPos[3][1]-1.5, markersPos[3][2]-1+0.45, markersPos[3][3]+0.05, markersPos[3][1]+0.5, markersPos[3][2]-0.5, markersPos[3][3]+0.05, renderTarget1, 2, tocolor(255, 255, 255, 255), 2039.99878, -1419.96094, 17.168 + 500000000)
	end
end
addEventHandler("onClientRender", getRootElement(), vdpVidaCriar)


function dxDrawTextOnElement(text,height,distance,R,G,B,alpha,size,font,x,y,z,...)
	-- local x, y, z = getElementPosition(TheElement)
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