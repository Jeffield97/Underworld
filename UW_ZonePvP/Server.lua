local hillArea = createColCuboid (  1119.716796875, -1809.0517578125, 32.629001617432,5,5,5)
setElementDimension(hillArea,1)
local weaponsEnable={24,31}


local playerMarker = createMarker(1119.7529296875, -1482.462890625, 15.796875, "cylinder", 0.5, 10, 244, 23, 0)

function handlePlayerMarker(hitElement)
	local elementType = getElementType(hitElement)
	if elementType == "player" then
		outputChatBox("Element ("..elementType..") has entered marker.")
		teleportPlayer(hitElement,1122.2529296875, -1806.6103515625, 33.628616333008)
	end
end
addEventHandler("onMarkerHit", playerMarker, handlePlayerMarker)

function teleportPlayer(player,x,y,z)
	fadeCamera ( player, false,0.5)
	setTimer( function()

			setElementPosition(player,x,y,z)
			fadeCamera(player,true)
			setElementVelocity(player,0,0,0)
			setElementAngularVelocity (player, 0,0,2 )
			setElementVelocity(player,0,0,0.18)
			setElementDimension ( player,0)
			setElementDimension(player,1)
		 end, 700,1)
end


function hill_Enter ( thePlayer, matchingDimension )
        if getElementType ( thePlayer ) == "player" then --if the element that entered was player
			local acc=getPlayerAccount(thePlayer)
			if getAccountData(acc,"Zone")== "No" then
				setAccountData(acc,"Zone","Yes")
				outputChatBox("Entrando...")
				SaveWeapons(acc,thePlayer)
				-----DAR ARMAS-----
				takeAllWeapons(thePlayer)
				for id, weapon in ipairs(weaponsEnable) do
					outputChatBox("Arma asignada: "..getWeaponNameFromID (weapon))
					giveWeapon(thePlayer,weapon,1000)
				end
			end
        end
end
addEventHandler ( "onColShapeHit", hillArea, hill_Enter )

function hill_Exit ( thePlayer, matchingDimension )

	if getElementType ( thePlayer ) == "player" then --if the element that left was player
		local acc=getPlayerAccount(thePlayer)
		setAccountData(acc,"Zone","No")
		outputChatBox("Saliendo...")
		teleportPlayer(thePlayer, 1117.533203125, -1482.51953125, 15.796875)
		-- setElementDimension(thePlayer,1)
		LoadWeapons(acc,thePlayer)
	end
end
addEventHandler ( "onColShapeLeave", hillArea, hill_Exit )

-- we register quitPlayer as a handler for the event
function quitPlayer ( quitType )
	local acc=getPlayerAccount(source)
	local detection = isElementWithinColShape ( source, hillArea )
	
	if not detection then
		setAccountData(acc,"Zone","Fuera")
		outputChatBox("Quit fuera del colshape")
		SaveWeapons(acc,source)
	else
		setAccountData(acc,"Zone","Dentro")
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

function SaveWeapons(acc,thePlayer)
	
	local weapons = {}
	local ammo={}
	for i=0,12,1 do
		weapons[i]=getPedWeapon(thePlayer,i)
		ammo[i]=getPedTotalAmmo(thePlayer,i)
		setAccountData(acc,"weapon"..i,weapons[i])
		setAccountData(acc,"ammo"..i,ammo[i])
	end
end

function LoadWeapons(acc,thePlayer)
	takeAllWeapons(thePlayer)
	local weapons = {}
	local ammo={}
	for i=0,12,1 do
		 weapons[i]=getAccountData(acc,"weapon"..i)
		 ammo[i]=getAccountData(acc,"ammo"..i)
		 giveWeapon(thePlayer,weapons[i],ammo[i])
		
	end
end

function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " loaded." )
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )