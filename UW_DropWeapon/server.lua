local function createGroundWeapon(weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	local temp = createElement("groundweapon")
	for i,p in ipairs(getElementsByType("player")) do
		triggerClientEvent(p,"GroundPickups:createGroundWeapon",p,temp,weaponid,ammo,clip,posX,posY,posZ,rotX,rotY,rotZ,interior,dimension)
	end
	return temp
end

local function destroyWeapons()

	for i,p in ipairs(getElementsByType("groundweapon")) do
		destroyElement(p)
	end

end

local function pickupWeapon(groundweapon,weaponid,ammo,clip)

	if client~=source then return end
	destroyElement(groundweapon)
	giveWeapon(client,weaponid,ammo,true)

end

local function dropWeapon(weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	local sourceAccount = getPlayerAccount ( client )
    if isGuestAccount ( sourceAccount ) then 
	outputChatBox("#e50914Exterminium: #5ae5b8[Debes iniciar sección para poder soltar armas]",client,255,255,255,true)
	else
		if client~=source then return end
		createGroundWeapon(weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
		takeWeapon(client,weaponid,ammo)
	end
	

end

local function initScript()

	addEvent("GroundPickups:pickupWeapon", true)
	addEvent("GroundPickups:dropWeapon", true)
	addEventHandler("GroundPickups:pickupWeapon",root,pickupWeapon)
	addEventHandler("GroundPickups:dropWeapon",root,dropWeapon)
	addEventHandler("onResourceStop",resourceRoot,destroyWeapons)

end

addEventHandler("onResourceStart",resourceRoot,initScript)