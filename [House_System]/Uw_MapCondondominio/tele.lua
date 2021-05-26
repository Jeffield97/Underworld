local posicoes =
    {
        { 2874.119140625, -1992.0824462891, 12.0334444976807 },		
    }
	
function PosicaoPlayer ( thePlayer, command )
    local azar = math.random ( #posicoes )
	local veh = getPedOccupiedVehicle(thePlayer)
		if (veh) then
			setElementPosition(veh, unpack ( posicoes [ azar ] ) )
		else
			setElementPosition(thePlayer, unpack ( posicoes [ azar ] ) )
		end	
			outputChatBox ( "#FFFFFF[#33ff00Tele#FFFFFF] ".. getPlayerName(thePlayer) .." #ffffffFoi dar um Rolê no #000000[#33ff00/Condominio#000000]", root, 0, 255, 0, true )
end
addCommandHandler ( "condominio", PosicaoPlayer  )