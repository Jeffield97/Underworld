---------------------------------------------------------------------------------------------------------------------
--									This script was made by kieranb and IIYAMA							  		   --
-- 		  						 			Created on the 11/11/2017				   					 		   --
--		    You may use as you wish, just remember IIYAMA basically made this script :P I just edited it		   --
--Link to original topic: https://forum.mtasa.com/topic/100973-question-using-mathmin-to-get-smallest-xyz-distance/--
--																												   --
--									 Weapon save is copied from dieselhp script						 	  	       --
--																												   --
--					   Skin save is made in under 5 minutes, might be buggy, comment if it is					   --
---------------------------------------------------------------------------------------------------------------------

--Want more hospital locations?  Add them below! (x, y, z, rotation)
hosp_loc = {
	-- x, y, z, rot
	{ 1173, -1323, 15, 270}, -- All Saints
	{ 2038, -1411, 17, 130}, --Jefferson
	{ 1242, 327, 19, 340}, -- Red County
	{ 1609, 1816, 12, 360}, -- Las Venturas
	{ -2655, 635, 14, 180}, -- San Fierro
	{ -2200, -2311, 30, 320}, -- Angel Pine
	{ -320, 1049, 20, 0 }, --Fort Carson - Bone County
	{ -1514.5, 2524, 56, 0 } --Tierra Robada
}

		
fade = false --true enables fade, false disables fade
wepsave = false--true gives weapons on respawn, false will not give weapons on respawn
saveweps = {} 

FadeTimer = 15 --Time for camera to be black and show the wasted message (in seconds)
--Let it be noted, your camera fades out half the time set above to black, text shows instantly.

function getDistance(thePlayer) --IIYAMA basically made this, I came up with the idea and tweaked it
	-- get the player position
	local px,py,pz = getElementPosition( thePlayer ) --Player location
	-- prepare 2 variables, but do not give them a value yet.
	local closestDistance 
	local closestPoint
	-- loop through the tables
	for i=1,#hosp_loc do --For all the locations in table
		local hx, hy, hz = hosp_loc[i][1], hosp_loc[i][2], hosp_loc[i][3] --Hospital locations
		local distance = getDistanceBetweenPoints3D (hx, hy, hz, px, py, pz) --Get the distance between player and hospitals
		if not closestDistance or distance < closestDistance then -- If the closestDistance is nil/(false) OR the distance is smaller than the closestDistance. 
			closestDistance = distance -- save the distance in closestDistance, which is located outside of the loop.
			closestPoint = hosp_loc[i] -- save the point in closestPoint, which is located outside of the loop.
		end
	end
	--x, y, z, rotation from hospital location table
	local x = (tostring(closestPoint[1])) --x
	local y = (tostring(closestPoint[2])) --y
	local z = (tostring(closestPoint[3])) --z
	local r = (tostring(closestPoint[4])) --rotation
	
	skin = getElementData(thePlayer, "respawn-skin" )--get skin
	--outputChatBox(""..skin, thePlayer)
	spawnPlayer ( thePlayer, -2233.0595703125, -1737.4462890625, 480.830078125, r, skin ) --Spawn the player
	
	giveWeapon( thePlayer, 46, 1, true )
	
	if (fade == true) then --If fade is enabled
		fadeCamera(thePlayer,true,1.5) --Since we set camera to black screen below, we reset it here
	end
	
	--Load weapons
	if (wepsave == true) then
		local name = getPlayerName(thePlayer) -- Get his name
		if saveweps[name] and saveweps[name].weapons then -- Check if there is a saveweps
			if saveweps[name].weapons ~= false then -- Double check
			local weps = saveweps[name].weapons
				for i, node in ipairs(weps) do -- Loop the table
					local wepinfo = split(node, ".") -- Split the string
					local wepid = wepinfo[1]
					local wepammo = wepinfo[2]
					--setTimer(giveWeapon, i*1000, 1, thePlayer, wepid, wepammo ) -- Used for testing
					giveWeapon ( thePlayer, wepid, wepammo ) -- gives the weapon
				end
			end
		end
	end
end

function Respawn()
	if (fade == true) then --If fade is true
		fadeCamera(source,false,tonumber(FadeTimer)/2,0,0,0) --Fade camera to black
		triggerClientEvent(source, "WastedText", getRootElement(), FadeTimer)
	end
	
	--Get players skin
	local skinid = getElementModel(source)
	setElementData(source, "respawn-skin", skinid)
	
	setTimer(getDistance, tonumber(FadeTimer)*100, 1, source) --Set a timer to spawn player
end

addEventHandler("onPlayerWasted", getRootElement(), Respawn ) --When player dies function is triggered

-----------------
-----------------
local function initScript()

	resetMapInfo()
	local players = getElementsByType("player")

	
	for _,player in ipairs(players) do 
		spawnPlayer( player,  -2233.0595703125, -1737.4462890625, 480.830078125, 224.96771240234, 0 )
		fadeCamera(player, true)
		setCameraTarget(player, player)
	end
	--for _,vehicledata in ipairs(vehiclesToSpawn) do createNewVehicle(vehicledata) end

	
	--addEventHandler("onPlayerWasted",root,onWasted)

end
addEventHandler("onResourceStart",resourceRoot,initScript)
addEventHandler("onPlayerJoin",root,initScript)