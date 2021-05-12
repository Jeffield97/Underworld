-- local dineros=[]
function createDropAt(x, y, z, money,pSource)
	local drop = createMarker ( x, y, z-0.5, "cylinder", 1, 0, 0, 0, 0 )
	if tonumber(money) < 100000 then
		 canta = createObject ( 1212, x, y, z-0.7 )
	else
		 canta = createObject ( 1550, x, y, z-0.7 )
	end
    local marker= createMarker ( x, y,z-1.2, "cylinder", 0.5, 80, 0, 200, 255 )    
        --[[ write some data with key "money_amount" to our marker, so
             when we pick it up, we can read that value --]]
        setElementData( drop, "money_amount", money )
		setElementData(drop,"owner",getPlayerName(pSource))
		setElementData(pSource,"droped",true)
		outputChatBox("Owner seteado: "..getPlayerName(pSource))
        -- setObjectScale (canta, 2)
	addEventHandler( "onMarkerHit", drop, MarkerHit ) -- attach onMarkerHit event to MarkerHit function	
	
        -- Kind of "attach" bag object to marker, so when marker gets destroyed,
        -- object also will get destroyed
        setElementParent( canta, drop )
		setElementParent(marker,drop)
end

function createDropCommand(pSource, cmd, money)

	if tonumber(money) > getPlayerMoney(pSource) then
		outputChatBox("No tienes suficiente dinero!")
	else
		if getElementData(pSource,"droped") then
			outputChatBox("Ya tienes dinero lanzado!!")
			
		else

		 local matrix = getElementMatrix(pSource)
			nx = 0 * matrix[1][1] + 2 * matrix[2][1] + 0 * matrix[3][1] + 1 * matrix[4][1]
			ny = 0 * matrix[1][2] + 2 * matrix[2][2] + 0 * matrix[3][2] + 1 * matrix[4][2]
			nz = 0 * matrix[1][3] + 2 * matrix[2][3] + 0 * matrix[3][3] + 1 * matrix[4][3]
			setPedAnimation(pSource, "strip", "ply_cash",-1,false,true,true,false)
			takePlayerMoney(pSource,money)
			createDropAt(nx,ny,nz,money,pSource)
		end
	end
end
addCommandHandler("createdrop", createDropCommand)



function MarkerHit( hitElement, matchingDimension )

	if getElementType(hitElement)=="player" then
		local playerName = getPlayerName( hitElement ) 

		local money = getElementData( source, "money_amount" )    
		local owner = getElementData(source,"owner")
		outputChatBox("Dinero de "..tostring(owner))
		givePlayerMoney ( hitElement, money )
		if owner then
			setElementData(getPlayerFromName(owner),"droped",false)
		end
		
		destroyElement (source)
		
		
	end
end
