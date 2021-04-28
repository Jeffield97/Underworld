loadstring(exports.dgs:dgsImportFunction())()
DGS = exports.dgs
Panel= dgsCreateWindow(0.40, 0.20, 0.19, 0.60,"Hitman",true)
dgsWindowSetCloseButtonEnabled ( Panel,false)
dgsSetProperty(Panel,"titleColor",tocolor(96,66,182,240))
DGS:dgsSetVisible ( Panel, false )
dgsWindowSetMovable ( Panel, false )
dgsWindowSetSizable ( Panel, false )
-- localPlayer = getLocalPlayer()
function HitmanPanel()
	

	outputChatBox("Iniciado")
	local tabPanel = DGS:dgsCreateTabPanel ( 0, 0.0, 1, 1, true, Panel )
	local tabListRewarded = DGS:dgsCreateTab( "Lista buscados", tabPanel )
	local tabReward = DGS:dgsCreateTab( "Agregar Recompensa", tabPanel )
	
	-------
	-------
	local playerList = DGS:dgsCreateGridList (0, 0, 1, 1, true,tabListRewarded )  --Create the grid list element
	local column = DGS:dgsGridListAddColumn( playerList, "Player", 0.5 )  --Create a players column in the list
	local column2 = DGS:dgsGridListAddColumn( playerList, "Recompensa", 0.5 )  --Create a players column in the list
	
	addEventHandler ( "onDgsMouseClick", root, function ( button, state  )
	if source == tabListRewarded then
		DGS:dgsGridListClearRow(playerList)
		LlenarPlayerList()
	end
	end)
	
	function LlenarPlayerList()
		for id, player in ipairs(getElementsByType("player")) do

			local row = DGS:dgsGridListAddRow ( playerList )
			if getElementData(player,"reward")>0 then
				DGS:dgsGridListSetItemText ( playerList, row, column, getPlayerName ( player ) )
				-- DGS:dgsGridListSetItemText ( playerList, row, column, i )
				DGS:dgsGridListSetItemText ( playerList, row, column2, getElementData( player,"reward" ) )
			end
		end
	end

	--Crea tab para dar precio por la cabeza de alguien
	
	LlenarPlayerList()
	local playerListReward = DGS:dgsCreateGridList (0,0,1,0.8, true,tabReward )  --Create the grid list element
	local columnR = DGS:dgsGridListAddColumn( playerListReward, "Player", 0.5 )  --Create a players column in the list
	for id2, playerR in ipairs(getElementsByType("player")) do
		local row2 = DGS:dgsGridListAddRow ( playerListReward )
		DGS:dgsGridListSetItemText ( playerListReward, row2, columnR, getPlayerName ( playerR ) )
	end 
	

	
	addEventHandler ( "onDgsMouseClick", root, function ( button, state  )
	if source == playerListReward then 
		local Selected = DGS:dgsGridListGetSelectedItem(playerListReward)
		if Selected ~= -1 then 
			PlayerSelected= DGS:dgsGridListGetItemText(playerListReward,Selected,columnR)
			outputChatBox(""..PlayerSelected.."",255,0,0)
			
		end
	end
end )
	

	local button = DGS:dgsCreateButton( 0.3, 0.90, 0.4, 0.06, "Poner precio!", true,tabReward )
	-- outputChatBox(DGS:dgsGetType(button))
	addEventHandler ( "onDgsMouseClickDown", button, DarPrecio)
	editBox = DGS:dgsCreateEdit( 0.3, 0.82, 0.4, 0.06, "", true,tabReward )

	
	function guiToggleVisible ( )        
        if ( DGS:dgsGetVisible ( Panel ) == true ) then -- check if the dgs element is visible               
                DGS:dgsSetVisible ( Panel, false ) -- if it is, we hide it
				showCursor(false)
				-- PanelPrincipal()
        else              
                DGS:dgsSetVisible ( Panel, true ) -- if not, we make it visible
				showCursor(true)
        end
	end
	bindKey ( "F1", "down", guiToggleVisible )
	----------------
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), HitmanPanel )


-----Button
	function DarPrecio ( button, state,localPlayer)
		if DGS:dgsGetType( source ) == "dgs-dxbutton" then
			if button == "left" and state == "down"then
				local text = DGS:dgsGetText( editBox )-- Get the text from the edit box
				if(PlayerSelected) then 
					
					--Verificar dinero del jugador
					local cantidad = tonumber(text)
					if cantidad and cantidad > 0  then
						
						if getPlayerMoney(localPlayer) >= cantidad then
							outputChatBox ("Has agregado un precio de "..text.."$ a la cabeza de "..PlayerSelected) -- Output that text
							local reward= getElementData(getPlayerFromName(PlayerSelected),"reward")
							setElementData(getPlayerFromName(PlayerSelected),"reward",reward+cantidad)
							takePlayerMoney(cantidad)
						else
							outputChatBox("No tienes suficiente dinero")
						end
					else
						outputChatBox("Ingresa una cantidad válida para la recompensa",localPlayer)
					end
				
				else
					outputChatBox("Selecciona un jugador de la lista")
				end
			end
		end
	end
