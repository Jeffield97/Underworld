addEventHandler('onClientResourceStart', resourceRoot, 
function() 

outputChatBox ( "Test")
local txd = engineLoadTXD('files/od_beachstuff.txd',true)
        engineImportTXD(txd, 1644)

	
	local dff = engineLoadDFF('files/lotion.dff', 0) 
	engineReplaceModel(dff, 1644)


	-- local col = engineLoadCOL('files/g.col') 
	-- engineReplaceCOL(col, 2052)

		
	-- engineSetModelLODDistance(2052, 500)
end 
)