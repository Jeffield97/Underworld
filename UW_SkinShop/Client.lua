loadstring(exports.dgs:dgsImportFunction())()
maleSkins = {0, 1, 2, 7, 14, 15,17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 57, 58, 59, 60, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 82,
 94, 95, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 
 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 
 147, 153, 154, 156, 158, 159, 160, 161, 162, 168, 170, 171, 173, 174, 175, 
 176, 177, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 
 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 
 252, 253, 254, 258, 259, 260, 261, 262, 264, 268, 269, 270, 271, 
 290, 291, 292, 293, 294, 295, 296, 297, 299,
 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311}
-- maleSkinsBlocked={16, 50,51,52,61,80,81,83, 84, 96,155, 163, 164, 165, 166, 167,179, 255, 265, 266,
 -- 267,272, 274, 275, 276,277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 312}

femaleSkins = {11, 12, 13, 40, 41, 55, 56, 63, 64, 69, 75, 76, 85, 87, 88,
  90, 91,  93,  131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190,
 191, 192, 193, 194, 195, 198, 201, 207, 211, 214, 215, 216, 219, 224, 225, 226,
 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304}
-- femaleSkinsBloked={9, 10, 31, 38, 39, 53, 54,  77,89,92,129, 130,196, 197, 199, 205, 218, 231, 232}

especialSkins = {"N/A","N/A","N/A","N/A","N/A","N/A","N/A","N/A","N/A","N/A"}
especialSkinsCost={1000,2000,3000,4000,5000,9000,10000,15000,1600000,110000,}

function WindowSkin()
	-- local x,y = guiGetScreenSize()
	outputChatBox("Interfaz Creada")
	-- local material = dgsCreate3DInterface(0,0,4,2,2,400,400,tocolor(255,255,255,255),0,1,0)
	local panelSkin=dgsCreateWindow ( 0.7, 0.21, 0.17, 0.59, "Selecciona tu skin", true )
	dgsWindowSetSizable ( panelSkin, false )
	dgsWindowSetMovable ( panelSkin, false )
	local TabSkins= dgsCreateTabPanel (0,0,1,0.935,true,panelSkin)
	local TabMale= dgsCreateTab("Masculinos",TabSkins)
	local TabFemale= dgsCreateTab("Femeninos",TabSkins)
	local TabEspecial= dgsCreateTab("Especial",TabSkins)
	
	
	--GridList Male
	local skinListM =dgsCreateGridList (0,0,1,1, true,TabMale )  --Create the grid list element
	local columnM =dgsGridListAddColumn( skinListM, "Skin ID", 0.5 )  --Create a players column in the list
	local columnM2 =dgsGridListAddColumn( skinListM, "Costo", 0.3 )  --Create a players column in the list
	for id, skin in ipairs(maleSkins) do
		local row = dgsGridListAddRow ( skinListM )
		dgsGridListSetItemText ( skinListM, row, columnM, maleSkins[id] )
		dgsGridListSetItemText ( skinListM, row, columnM2, "Gratis" )
	end 
	
	
	--GridList Female
	local skinListF =dgsCreateGridList (0,0,1,1, true,TabFemale )  --Create the grid list element
	local columnF =dgsGridListAddColumn( skinListF, "Skin ID", 0.5 )  --Create a players column in the list
	local columnF2 =dgsGridListAddColumn( skinListF, "Costo", 0.3 )  --Create a players column in the list
	for id, skin in ipairs(femaleSkins) do
		local row = dgsGridListAddRow ( skinListF )
		dgsGridListSetItemText ( skinListF, row, columnF, femaleSkins[id] )
		dgsGridListSetItemText ( skinListF, row, columnF2, "Gratis" )
	end 
	
	--GridList Especial
	local skinListE =dgsCreateGridList (0,0,1,1, true,TabEspecial )  --Create the grid list element
	local columnE =dgsGridListAddColumn( skinListE, "Skin ID", 0.5 )  --Create a players column in the list
	local columnE2 =dgsGridListAddColumn( skinListE, "Costo", 0.3 )  --Create a players column in the list
	for id, skin in ipairs(especialSkins) do
		local row = dgsGridListAddRow ( skinListE )
		dgsGridListSetItemText ( skinListE, row, columnE, especialSkins[id] )
		dgsGridListSetItemText ( skinListE, row, columnE2, especialSkinsCost[id] )
	end 
	
	--Botones--
	-- local button= dgsCreateButton( 0.35, 0.83, 0.3, 0.07, "Seleccionar", true,panelSkin)
	-- addEventHandler ( "onDgsMouseClickDown", button, SetSkin)
	
	addEventHandler ( "onDgsMouseClickDown", root, function ( button, state  )
		if source == skinListM then 
			local Selected = dgsGridListGetSelectedItem(skinListM)
			if Selected ~= -1 then 
				SkinSelected= dgsGridListGetItemText(skinListM,Selected,columnM)
				-- outputChatBox(""..SkinSelected.."",255,0,0)
				setElementModel(localPlayer,SkinSelected)
				
			end
		end
		
		if source == skinListF then 
			local Selected = dgsGridListGetSelectedItem(skinListF)
			if Selected ~= -1 then 
				SkinSelected= dgsGridListGetItemText(skinListF,Selected,columnF)
				-- outputChatBox(""..SkinSelected.."",255,0,0)
				setElementModel(localPlayer,SkinSelected)
				
			end
		end
		
		
	end )
	
	
	-- function SetSkin ( button, state,localPlayer)
		-- if dgsGetType( source ) == "dgs-dxbutton" then
			-- if button == "left" and state == "down"then
				-- local text = dgsGetText( editBox )-- Get the text from the edit box
				-- if(SkinSelected) then 
					
					--Verificar dinero del jugador
					-- local cantidad = tonumber(text)
					-- if cantidad and cantidad > 0  then
						
						-- if getPlayerMoney(localPlayer) >= cantidad then
							-- outputChatBox ("Has agregado un precio de "..text.."$ a la cabeza de "..SkinSelected) -- Output that text
							-- local reward= getElementData(getPlayerFromName(SkinSelected),"reward")
							-- setElementData(getPlayerFromName(SkinSelected),"reward",reward+cantidad)
							-- takePlayerMoney(cantidad)
						-- else
							-- outputChatBox("No tienes suficiente dinero")
						-- end
					-- else
						-- outputChatBox("Ingresa una cantidad válida para la recompensa",localPlayer)
					-- end
					-- setElementModel(localPlayer,SkinSelected)
				-- else
					-- outputChatBox("Selecciona un jugador de la lista")
				-- end
			-- end
		-- end
	-- end
	showCursor(true)
	
	function windowClosed()
	cancelEvent()
	dgsAlphaTo(panelSkin,0,false,"OutQuad",700)
	showCursor(false)
	setElementFrozen(localPlayer,false)
	setTimer(function()
		destroyElement(panelSkin)
	end,1100,1)
end
addEventHandler("onDgsWindowClose",panelSkin,windowClosed)
end
-- addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),WindowSkin)
addEvent("SkinSelector",true)
addEventHandler("SkinSelector",localPlayer,WindowSkin)

function onStop()
	outputChatBox("Interfaz cerrada")
	showCursor(false)
end


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


local playerMarker = createMarker(1146.5947265625, -1514.9794921875, 14.696875, "cylinder", 0.5, 255,0,37, 200)
local ClothPed = createPed ( 256,  1148.40625, -1516.8125, 15.796875)
--setElementInterior (ClothPed, 1, 294.94079589844, -40.216415405273, 1001.515625)
setElementRotation(ClothPed,  0, 0, 47.233703613281)
setPedVoice(ClothPed, "PED_TYPE_ENABLED")
setElementFrozen (ClothPed, true)
setElementDimension (ClothPed, 0)

function cancelPedDamage()
	cancelEvent() 
end
addEventHandler("onClientPedDamage", ClothPed, cancelPedDamage)

local font = dxCreateFont('Blacklist.ttf', 80, false, 'antialiased')

addEventHandler("onClientRender", root,
function()
	dxDrawTextOnElement(ClothPed,"Skins",2.5,15,0,0,0,255,1.02,font)
	dxDrawTextOnElement(ClothPed,"Skins",2.5,15,10,188,255,255,1,font)
end)
