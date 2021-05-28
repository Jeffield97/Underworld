local hillArea = createColCuboid (  -1137.560546875, 1018.7021484375, 1339.1188964844,170,82,20)
setElementDimension(hillArea,1)
local weaponsEnable={24,31}



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
				setElementData(thePlayer,"ZoneWar","Yes")
			end
        end
end
addEventHandler ( "onColShapeHit", hillArea, hill_Enter )

function hill_Exit ( thePlayer, matchingDimension )

	if getElementType ( thePlayer ) == "player" then --if the element that left was player
		local acc=getPlayerAccount(thePlayer)
		setAccountData(acc,"Zone","No")
		outputChatBox("Saliendo...")
		-- teleportPlayer(thePlayer, 1117.533203125, -1482.51953125, 15.796875,1,0)
		-- setElementDimension(thePlayer,1)
		setElementData(thePlayer,"ZoneWar","No")
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