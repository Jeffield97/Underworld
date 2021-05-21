local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
local currentGround = nil
local elementgg = {}
local bannedTeamsEnabled = true
local bannedTeams = { -- Useful if you got an RPG server and want to prevent abuse with weapon-spawning classes, then use above variable to toggle using below table and add your server's team names that wont be able to use drop gun
    ["Official Squads"] = true,
    ["Gangs"] = true,
}

weaponmarkercolors = {
	[0] = {255,255,255},
	[1] = {100,100,255},
	[2] = {0,230,0},
	[3] = {0,150,0},
	[4] = {255,255,0},
	[5] = {255,204,0},
	[6] = {150,0,150},
	[7] = {255,0,255},
	[8] = {0,0,255},
	[9] = {204,255,255},
	[10] = {255,100,100},
	[11] = {255,255,255},
	[12] = {255,255,255}
}

weaponsIDS = {
	--0
	[1] = 331,
	--1
	[2] = 333,
	[3] = 334,
	[4] = 335,
	[5] = 336,
	[6] = 337,
	[7] = 338,
	[8] = 339,
	[9] = 341,
	--2
	[22] = 346,
	[23] = 347,
	[24] = 348,
	--3
	[25] = 349,
	[26] = 350,
	[27] = 351,
	--4
	[28] = 352,
	[29] = 353,
	[32] = 372,
	--5
	[30] = 355,
	[31] = 356,
	--6
	[33] = 357,
	[34] = 358,
	--7
	[35] = 359,
	[36] = 360,
	[37] = 361,
	[38] = 362,
	--8
	[16] = 342,
	[17] = 343,
	[18] = 344,
	[39] = 363,
	--9
	[41] = 365,
	[42] = 366,
	[43] = 367,
	--10
	[10] = 321,
	[11] = 322,
	[12] = 323,
	[13] = 324,
	[14] = 325,
	[15] = 326,
	--11
	[44] = 368,
	[45] = 369,
	[46] = 371,
	--12
	[40] = 364
}

colshapes = {}

function createGroundWeapon(groundweapon,weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	if(elementgg[groundweapon] == nil) then
		local temp = createColSphere(posX,posY,posZ+0.5, 1)
		colshapes[temp] = {}
		colshapes[temp].groundweapon = groundweapon
		colshapes[temp].weaponid = weaponid
		colshapes[temp].ammo = ammo
		colshapes[temp].clip = clip
		elementgg[groundweapon] = temp
		local slot = getSlotFromWeapon(weaponid)

		--createObject
		local object = createObject(weaponsIDS[weaponid],posX,posY,posZ,rotX,rotY,rotZ)
		setElementFrozen(object, true)
		setElementCollisionsEnabled(object, false)

		setElementInterior(object,interior)
		setElementDimension(object,dimension)
		
		colshapes[temp].object = object

		--createMarker
		local marker = createMarker(posX,posY,posZ+0.05,"corona", 0.5,weaponmarkercolors[slot][1],weaponmarkercolors[slot][2], weaponmarkercolors[slot][3], 20)
		setElementInterior(marker,interior)
		setElementDimension(marker,dimension)
			
		colshapes[temp].marker = marker

		local x,y,z = getElementPosition(localPlayer)
		if getDistanceBetweenPoints2D(x,y,posX,posY) < 0.25 then local_activate(temp, localPlayer,true) end
	end
end

function destroyGroundWeapon(groundweapon)
	local col = elementgg[groundweapon]
	local object = colshapes[col].object
	local marker = colshapes[col].marker
	colshapes[col] = nil
	if(isElement(object)) then destroyElement(object) end
	if(isElement(marker)) then destroyElement(marker) end
	if(isElement(col)) then destroyElement(col) end
	elementgg[groundweapon] = nil
end

function pickupWeapon(cmd,state)
	if (cmd == "pickup" or state=="down") and isTimer(spamTimer) then return end
	spamTimer=setTimer(function() end,500,1)
	if(isElement(currentGround)) then
		local weaponid = colshapes[currentGround].weaponid
		local ammo = colshapes[currentGround].ammo
		local clip = colshapes[currentGround].clip
		local slot = getPedWeaponSlot(localPlayer)
		if slot == getSlotFromWeapon(weaponid) and getPedWeapon(localPlayer,slot) ~= weaponid and getPedTotalAmmo(localPlayer,slot) > 0 then dropWeapon() end
		
		if ammo then
			local groundweapon = colshapes[currentGround].groundweapon
			triggerServerEvent("GroundPickups:pickupWeapon",localPlayer,groundweapon,weaponid,ammo,clip)
			for i,p in ipairs(getElementsByType("colshape")) do
				if isElementWithinColShape(localPlayer, p) then
					local_activate(p, localPlayer,true)
					break
				end
			end
		end
	end
end

function dropWeapon(cmd,ammo,state)
	if (cmd == "drop" or state=="down") and isTimer(spamTimer) then return end
	spamTimer=setTimer(function() end,500,1)
	local team = getPlayerTeam(localPlayer)
	if team and bannedTeams[getTeamName(team)] and bannedTeamsEnabled then
		outputChatBox("No puedes soltar weapons",255,0,0)
		return
	end
	local slot = getPedWeaponSlot(localPlayer)
	if slot > 0 then
		local weaponid = getPedWeapon(localPlayer, slot)
		if(ammo ~= nil) then
			if (ammo ~= nil and (tonumber(ammo) <= getPedTotalAmmo(localPlayer))) then
				if weaponid ~= 0 then
					local x,y,z = getElementPosition(localPlayer)
					local hit, hitX, hitY, hitZ, as = processLineOfSight(x, y, z, x, y, -3000, true, false, false, true, false, false, false, false)
					z = hit and hitZ or z-0.95
					triggerServerEvent("GroundPickups:dropWeapon",localPlayer,weaponid, ammo, getPedAmmoInClip(localPlayer), x,y,z, 97.3,120,math.random(0,359),getElementInterior(localPlayer),getElementDimension(localPlayer))
				end
			
			else
				--outputChatBox("No tienes esa cantidad de munición",255,0,0)
				outputChatBox("#e50914Exterminium: #5ae5b8[No tienes esa cantidad de munición]",255,255,255,true)
				--outputChatBox ( string text [, int r = 231, int g = 217, int b = 176, bool colorCoded = false ] )
			end
		else
		outputChatBox("#e50914Exterminium: #5ae5b8[Ingresa un valor a soltar]",255,255,255,true)
			--outputChatBox("",255,0,0)
		end
		
	end
end

function local_activate(shape, element,dimension)
	local playersInCol = getElementsWithinColShape(shape,"player")
	if #playersInCol == 1 and playersInCol[1] ~= localPlayer then return end
	if element == localPlayer and #playersInCol <= 1 then
		currentGround = shape
	end
end

addEventHandler("onClientResourceStart", getRootElement(),
	function(startedRes)
		if(startedRes == getThisResource()) then
			addCommandHandler("pickup",pickupWeapon)
			addCommandHandler("dropweapon",dropWeapon)
			bindKey("k","down","pickup")
		else
			for i,p in pairs(getElementsByType("groundweapon")) do
				createGroundWeapon(p)
			end
		end
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function(startedRes)
		for i,p in ipairs(getElementsByType("groundweapon")) do
			destroyGroundWeapon(p)
		end
	end
)

addEventHandler("onClientRender", getRootElement(),
	function()
		if isElement(currentGround) and colshapes[currentGround] then
			local weaponid = colshapes[currentGround].weaponid
			local ammo = colshapes[currentGround].ammo

			sx,sy = screenWidth/2, screenHeight/2

			local str = getPedWeaponSlot(localPlayer) == getSlotFromWeapon(weaponid) and "recoger arma" or "recoger arma"
			
			dxDrawRectangle(sx-80, sy-20, 160, 85, tocolor(0, 0, 0, 128))

			if getPedWeaponSlot(localPlayer) == getSlotFromWeapon(weaponid) and weaponid ~= getPedWeapon(localPlayer) then
				dxDrawImage(sx-13, sy+13, 26, 26, "img/swap.png")
				dxDrawImage(sx+20, sy-2, 50, 50, "img/" .. weaponid .. ".png")
				dxDrawImage(sx-70, sy-2, 50, 50, "img/" .. getPedWeapon(localPlayer, getSlotFromWeapon(weaponid)) .. ".png")
				dxDrawText(tostring(ammo),sx+45, sy+53, sx+45, sy+53,tocolor(255,255,255,255), 1, "default-bold", "center", "center")
				dxDrawText(tostring(getPedTotalAmmo(localPlayer, getSlotFromWeapon(weaponid))) .. " (you)",sx-45, sy+53, sx-45, sy+53,tocolor(255,255,255,255), 1, "default-bold", "center", "center")
			else
				dxDrawImage(sx-25, sy-2, 50, 50, "img/" .. tonumber(weaponid) .. ".png")
				dxDrawText(tostring(ammo),sx, sy+53, sx, sy+53,tocolor(255,255,255,255), 1, "default-bold", "center", "center")
			end

			dxDrawText("Presiona 'k' " .. str,sx, sy-18, sx, sy-18,tocolor(255,255,50,255), 1, "default-bold", "center")
		end
	end
)

addEventHandler("onClientElementDestroy", getRootElement(),
	function()
		if(getElementType(source) == "groundweapon") then
			destroyGroundWeapon(source)
		end
	end
)

addEventHandler("onClientColShapeHit", getResourceRootElement(),
	function(element,dimension)
		local_activate(source, element,dimension)
	end
)

addEventHandler("onClientColShapeLeave", getResourceRootElement(),
	function(element,dimension)
		if(element == localPlayer) then
			currentGround = nil
			for i,p in ipairs(getElementsByType("colshape")) do
				if isElementWithinColShape(localPlayer, p) then
					local_activate(p, localPlayer,true)
					break
				end
			end
		end
	end
)

addEvent("GroundPickups:createGroundWeapon", true)
addEventHandler("GroundPickups:createGroundWeapon",localPlayer,createGroundWeapon)