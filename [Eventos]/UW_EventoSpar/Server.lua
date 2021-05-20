-- NOTIFICACIÓN AL INICIAR EL RECURSO
local ZoneEvent = createColCuboid (  1119.716796875, -1809.0517578125, 32.629001617432,5,5,5)
function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " loaded." )
		StartEvent()
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )

function StartEvent()
	openEvent =setTimer(function() 
					outputChatBox("Se ha creado un evento DM, escribe /evento para ir al evento, el comando se desactivará en 5 segundos")
					addEventHandler("onPlayerWasted",root,CheckingPlayersAlive)
					addCommandHandler ( "evento", teleportPlayer )
					WaitingPlayers()
				end,10000,1)
				
	function WaitingPlayers()
		setTimer(function()
			removeCommandHandler("evento",teleportPlayer)

			outputChatBox("Se ha desactivado el comando /evento")
			
			local players = getElementsWithinColShape( ZoneEvent, "player" )
			outputChatBox("Cantidad de participantes en el evento: "..#players)
			if #players <2 then
				outputChatBox("El evento fue cancelado por falta de participantes")
				StopEvent()
			end
		end,5000,1)
	end
end



function CheckingPlayersAlive()
	        -- get all the players inside the sphere
	-- for _, thePlayer in ipairs( players ) do                                   -- use a generic for loop to step through each player
		-- outputChatBox( getPlayerName( thePlayer ) .. " is in our new sphere ID:".._ ) -- print their name to the chat
	-- end
	--if players == nil then
		--outputChatBox("El evento ha sido cancelado")
	--	StopEvent()
	-- else
	setTimer(function()
	local players = getElementsWithinColShape( ZoneEvent, "player" ) 
		outputChatBox("Jugadores en evento: "..#players)
		if #players<2 then
			-- setTimer(killPed,3000,1,players[1])
			if players[1] then
				killPed(players[1])
				StopEvent(players[1])
			end
		end
	end,5000,1)
	
	-- end
	
end
addCommandHandler("Check",CheckingPlayersAlive)

function StopEvent(player)
		removeEventHandler("onPlayerWasted",root,CheckingPlayersAlive)
		
		-- killPed(player)
		if player== nil then
			StartEvent()
		else
			outputChatBox("El evento ha finalizado, el ganador es "..getPlayerName(player))
			
			StartEvent()
		end
		outputChatBox("Próximo evento en 10 segundos")
end
----TELEPORT---
---------------
function teleportPlayer(playerSource,commandName )
	fadeCamera ( playerSource, false,0.5)
	setTimer( function()

			setElementPosition(playerSource, 1122.1943359375, -1806.4501953125, 34.628616333008)
			fadeCamera(playerSource,true)
			setElementVelocity(playerSource,0,0,0)
			setElementAngularVelocity (playerSource, 0,0,2 )
			setElementVelocity(playerSource,0,0,0.18)
			setElementDimension ( playerSource,0)
			-- setElementFrozen(playerSource,true)
		 end, 700,1)
end

addEventHandler( "onResourceStop", root,
    function( resource )
       removeCommandHandler("evento",teleportPlayer)
	   removeEventHandler("onPlayerWasted",root,CheckingPlayersAlive)
    end
)