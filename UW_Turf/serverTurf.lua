------------------------------------------------------
--            Scripting By Sasu
--		Copyright © 2013-2015 - All rights reserved.
------------------------------------------------------


local turfPos = {
{ 2133.1950683594, 633.66455078125, 0, 197.5, 92, 90 },
{ 2486.5935058594, 678.20172119141, 0,  245, 133, 30 },
{ 1856.2864990234, 627.07629394531, 0,  138.25, 152.75, 90 },
{ 1576.8956298828, 662.84362792969, 0, 181, 120.5, 90 },
{ 1577.6783447266, 943.66607666016, 0,  190, 190, 90 },
{ 1383.4364013672, 909.61499023438, 0,  142, 230, 90 },
{ 956.94744873047, 1011.635925293, 0,  220, 140, 90 },
{ 1017.7476196289, 1203.4068603516, 0,  180, 165, 90 },
{ 1017.623046875, 1383.4741210938, 0,  190, 290, 90 },
{ 917.99707031253, 1623.6003417969, 0,  80, 220, 90 },
{ 1017.7178955078, 1862.6740722656, 0,  140, 180, 90 },
{ 912.50573730469, 1958.6761474609, 0,  90, 230, 90 },
{ 1017.3455200195, 2063.38671875, 0,  150, 300, 90 },
{ 1300.7644042969, 2095.5100097656, 0,  200, 140, 90 },
{ 1398.1997070313, 2323.5505371094, 0,  160, 65, 90 },
{ 1578.1955566406, 2284.0825195313, 0,  180, 110, 90 },
{ 1237.6285400391, 2581.4663085938, 0,  450, 130, 90 },
{ 1780.478515625, 2567.2121582031, 0,  130, 130, 90 },
{ 1698.2750244141, 2724.494140625, 0,  200, 150, 90 },
{ 2237.9494628906, 2723.7814941406, 0,  180, 110, 90 },
{ 2498.6853027344, 2704.6188964844, 0,  300, 140, 90 },
{ 2798.1267089844, 2303.9643554688, 0,  120, 300, 90 },
{ 2557.5688476563, 2243.4963378906, 0,  100, 230, 90 },
{ 2532.5830078125, 2063.4118652344, 0,  100, 150, 90 },
{ 2558.1779785156, 1624.0816650391, 0,  100, 300, 90 },
{ 2437.685546875, 1483.7209472656, 0,  160, 120, 90 },
{ 2077.7106933594, 1203.5559082031, 0,  340, 170, 90 },
{ 2082.3193359375, 979.23583984375, 0,  270, 210, 90 }
}

local turfElement = {}
local turfTimer = {}
local checkComplete = false

local messages = {
	-- [1] = "Turf System by Sasuke* was started correctly!",
	[1] = "Sistema Turf empezó correctamente!",
	-- [2] = "This territory already belongs to %s",
	[2] = "Este territorio ya pertenece a %s",
	-- [3] = "You enter into de %s's turf zone. Wait 2 minutes to capture the turf and win 4k",
	[3] = "Entraste al territorio dominado por %s. Espera 3 minutos para conquistar la zona",
	-- [4] = "This turf doesn't belong to anyone. Wait 2 minutes to capture the turf and win 4k",
	[4] = "Este territorio se encuentra libre. Espera 3 minutos para conquistar la zona",
	-- [5] = "Congratulations. You capture the turf. +4K!",
	[5] = "Felicitaciones!. Has conquistado este territorio",
	-- [6] = "If you don't come back within 20s, you won't capture the turf",
	[6] = "Regresa a la zona!, caso contrario se cancelará la conquista",
	-- [7] = "You couldn't capture the turf because of absence"
	[7] = "No pudiste capturar el territorio porque lo abandonaste"
 }
 
-- 	Nadie = None | Just a translation

addEventHandler("onResourceStart", resourceRoot,
function()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS Turf_System ( Turfs TEXT, GangOwner TEXT, r INT, g INT, b INT)")
	--
	local check = executeSQLQuery("SELECT * FROM Turf_System" )
	if #check == 0 then
		for i=1,#turfPos do
			executeSQLQuery("INSERT INTO Turf_System(Turfs,GangOwner,r,g,b) VALUES(?,?,?,?,?)", "Turf["..tostring(i).."]", "Nadie", 0, 255, 0)
		end
	elseif #check > 1 then
		for i = #check, #turfPos do
			executeSQLQuery("INSERT INTO Turf_System(Turfs,GangOwner,r,g,b) VALUES(?,?,?,?,?)", "Turf["..tostring(i).."]", "Nadie", 0, 255, 0)
		end
	end
	
	for i,v in ipairs(turfPos) do
		local sqlData = executeSQLQuery("SELECT * FROM Turf_System WHERE Turfs=?", "Turf["..tostring(i).."]")
		local turfCol = createColCuboid(unpack(v))
		setElementData(turfCol, "getTurfGang", sqlData[1].GangOwner)
		local turfArea = createRadarArea(v[1], v[2], v[4], v[5], sqlData[1].r, sqlData[1].g, sqlData[1].b, 175)
		turfElement[turfCol] = {turfCol, turfArea, i}
		turfTimer[turfCol] = {}
	end
	
	outputDebugString( messages[1] )
end )

addEventHandler ( "onColShapeHit", root,
	function ( player )
		if turfElement[source] and source == turfElement[source][1] then
			local turf,area,id = unpack( turfElement[source] )
			local playerGang = getElementData ( player, "Group" )
			local turfGang = executeSQLQuery("SELECT GangOwner FROM Turf_System WHERE Turfs=?", "Turf["..tostring(id).."]" )
			if ( turfGang[1].GangOwner == playerGang ) then
				-- outputChatBox( messages[2]:format( turfGang[1].GangOwner or "None" ), player, 0, 255, 0, false )
				exports ["_infobox"]:addNotification(player,messages[2]:format( turfGang[1].GangOwner or "None" ),"info")
			else
				local playerGang = getElementData ( player, "Group" )
				setElementData( source, "warTurf", playerGang )
				if ( isTimer ( turfTimer[source][1] ) ) then
					if isTimer( turfTimer[source][2] ) then killTimer( turfTimer[source][2] ) end 
					return 
				end
				if ( playerGang ) then
					local r, g, b = unpack ( getGangColor ( playerGang ) )
					-- local r, g, b = 255, 255, 255
					setRadarAreaFlashing ( area, true )
					setElementData(player,"turf",true)
					if turfGang[1].GangOwner ~= "Nadie" then
						-- outputChatBox( messages[3]:format( turfGang[1].GangOwner ), player, 0, 255, 0, false )
						exports ["_infobox"]:addNotification(player,messages[3]:format( turfGang[1].GangOwner ),"info")
						triggerClientEvent ( player, "ProgressTurf", player)
					else
						-- outputChatBox( messages[4], player, 0, 255, 0, false )
						exports ["_infobox"]:addNotification(player,messages[4],"info")
						triggerClientEvent ( player, "ProgressTurf", player)
					end
					
					turfTimer[source][1] = setTimer (
						function ( )
							local players = getGangPlayersInTurf ( turf, playerGang )
							setRadarAreaColor ( area, tonumber(r), tonumber(g), tonumber(b), 175 )
							for _, player in ipairs ( players ) do
								-- outputChatBox( messages[5], player, 0, 255, 0, false )
								exports ["_infobox"]:addNotification(player,messages[5],"success")
								triggerClientEvent(player, "onTakeTurf", player)
								triggerClientEvent(player,"OcultarProgressTurf",player)
								-- triggerClientEvent(thePlayer,"OcultarProgressTurf",thePlayer)
								givePlayerMoney ( player, 4000 )
								executeSQLQuery("UPDATE Turf_System SET GangOwner=?,r=?,g=?,b=? WHERE Turfs=?", playerGang, tonumber(r), tonumber(g), tonumber(b), "Turf["..tostring(id).."]" )
								-- setElementData ( turf, "getTurfGang", playerGang )
							end
							setRadarAreaFlashing ( area, false )
						end
					,30000, 1)
				end
			end
		end
	end
)

addEventHandler ( "onColShapeLeave", root, 
	function( player )
		if turfElement[source] and source == turfElement[source][1] then
			if isTimer( turfTimer[source][1] ) then
				local aGang = getElementData( source, "warTurf" )
				local ps = getGangPlayersInTurf( source, aGang )
				if #ps <1  then
					-- outputChatBox( messages[6], player, 255, 0, 0 )
					exports ["_infobox"]:addNotification(player,messages[6],"warning")
					turfTimer[source][2] = setTimer(
						function(source, aGang)
							if isTimer(turfTimer[source][1]) then killTimer(turfTimer[source][1]) end
							setRadarAreaFlashing(turfElement[source][2], false)
							for _, v in ipairs( getElementsByType("player") ) do
								if getElementData(v, "Group") == aGang then
									-- outputChatBox(messages[7], v, 255, 0, 0)
									exports ["_infobox"]:addNotification(player,messages[7],"error")
									triggerClientEvent(player,"OcultarProgressTurf",player)
									setElementData(player,"turf",false)
								end
							end
						end
					, 3000, 1, source, aGang)
				end
			end
		end
	end
)

function getGangPlayersInTurf( turf, gang ) -- element, string
	if turf and gang then
		local players = getElementsWithinColShape ( turf, "player" )
		local gPla = {}
		for _, v in ipairs(	players ) do		
			if getElementData(v, "Group") == gang then
				table.insert(gPla, v)
			end
		end
		return gPla
	end
end

function getGangColor(gangName)
	return exports[ "ClanesPro" ]:getGroupTurfColor ( gangName)
	-- return exports[ "gang_system" ]:getGangData ( gangName, "color" )
end
