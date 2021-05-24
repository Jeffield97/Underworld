-- NOTIFICACIÓN AL INICIAR EL RECURSO
function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " loaded." )
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )
-----

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--------------------------------------------------Spawn system--------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

local Bases={
				{ 1877.126953125, 1778.4140625, 18.933877944946},--LV
				{ -2501.6904296875, -686.845703125, 139.3203125},--SF
				{1127.7919921875, -1528.4306640625, 22.75513458252},--LS
				{ -2240.515625, -2303.677734375, 30.352777481079},
				{ -2091.9853515625, 2314.6220703125, 25.9140625}
			}

function spawnBase(player)
	local px,py,pz = getElementPosition( player )
	--Calculo de distancia menor hacia el refugio
	local closestDistance 
	local closestPoint
	for i=1,#Bases do --For all the locations in table
		local hx, hy, hz = Bases[i][1], Bases[i][2], Bases[i][3] --Base locations
		local distance = getDistanceBetweenPoints3D (hx, hy, hz, px, py, pz) --Get the distance between player and hospitals
		if not closestDistance or distance < closestDistance then -- If the closestDistance is nil/(false) OR the distance is smaller than the closestDistance. 
			closestDistance = distance -- save the distance in closestDistance, which is located outside of the loop.
			closestPoint = Bases[i] -- save the point in closestPoint, which is located outside of the loop.
		end
	end
	
	local x = (tostring(closestPoint[1])) --x
	local y = (tostring(closestPoint[2])) --y
	local z = (tostring(closestPoint[3])) --z
	-- local r = (tostring(closestPoint[4])) --rotation
	spawn(player,x,y,z)
end

---Al momento de morir
addEventHandler( "onPlayerWasted", root,
	function()
		local x,y,z = getElementPosition(source)
		-- setTimer( spawn, 2000, 1, source, x, y, z+300 )
		
		if getElementInterior(source) ~= 0 then
			--spawn base
			local interior = getElementInterior(source)
			spawn(source,x,y,z+1,_,_,interior)
		else
			--Verificar forma spawn
			if getElementData(source,"spawnBase") then
				--spawn base
				-- spawn(source,0,0,5)
				spawnBase(source)
			else
				spawn(source,x,y,z+300)
			end
		end
		
	end
)

---Toggle para el tipo de spawn del player
function spawnType(playersource,cmd)
	local typespawn = getElementData(playersource,"spawnBase")
	setElementData(playersource,"spawnBase",not(typespawn))
	outputChatBox("Tipo spawn:"..tostring(not(typespawn)))
end
addCommandHandler("spawnBase",spawnType,_,false)


---Spawn al momento del join
-- function onJoinPlayer ()
	-- spawn(source, 0.0, 0.0, 600.0, 90.0)
	-- setElementData(source,"spawnBase",true)
	-- setTimer(giveWeapon,1000,1,source,46)
-- end
-- addEventHandler ( "onPlayerJoin", root, onJoinPlayer )


function spawn(player,x,y,z,rotation,skin,interior,dimension)
	outputChatBox("Spawneado!!")
	fadeCamera ( player, false,2)

   setTimer( function()
		spawnPlayer (player,x,y,z,rotation or 0,skin or 0,interior or 0,dimension or 1)
		fadeCamera(player,true,1)
		giveWeapon(player,46)
   end,2000,1)

	setCameraTarget ( player)
end
-- addCommandHandler ( "spawn", onJoinPlayer,false,false)