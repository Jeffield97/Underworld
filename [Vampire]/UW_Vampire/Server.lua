
function resourceStartNotify ( resourcename )
	-- if the started resource is this one
	if ( resourcename == getThisResource() ) then
		-- send an info debug message as a notification
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " cargado." )
		setTimer(setDefaultData,2000,1)
		
-- setTimer ( delayedChat, 1000, 1, "Hello, World!" )
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )


function setWings(player)
	Wings = createObject(1644,0,0,-100)
	setElementDimension(Wings,getElementDimension(player))
	--setElementAlpha(Wings,200)
	setObjectScale(Wings,0.5)
	setElementID ( Wings, getPlayerName(player)) 
	exports.bone_attach:attachElementToBone(Wings,player,6,0.1,0,0,180,0,180)
end
addEvent("setWings",true)
addEventHandler("setWings", getResourceRootElement(getThisResource()) ,setWings)

function deleteWings(player)
	if(getElementByID(getPlayerName(player))) then
		outputDebugString(tostring(destroyElement(getElementByID(getPlayerName(player)))))
		-- setElementAlpha(getElementByID(getPlayerName(player)),0)
		outputChatBox("Alas eliminadas correctamente")
		outputDebugString("Alas eliminadas")
	end
end
addEvent("deleteWings",true)
addEventHandler("deleteWings", getResourceRootElement(getThisResource()) ,deleteWings)
-- addEventHandler ( "onPlayerQuit", getResourceRootElement(getThisResource()), deleteWings )

--ASIGNAR ANIMACIÓN
function setAnimation(source,anim,sanim)
setPedAnimation(source, anim, sanim,-1, false, true, false, false)
end
addEvent("setAnimation",true)
addEventHandler("setAnimation",resourceRoot,setAnimation)


----------------------------------
--------Asignación de datos-------
----------------------------------
function quitPlayer ( quitType )
	local playeraccount = getPlayerAccount ( source )
	local TimeTransformation = getElementData(source,"TimeTransformation")
	if TimeTransformation then
		setAccountData ( playeraccount, "TimeTransformation", TimeTransformation )
	else
		setAccountData ( playeraccount, "TimeTransformation", 1 )
	end
	 
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )


-- function onJoin()
	-- triggerClientEvent(source,"onStart",source,0,0)
	-- setElementData(source,"Transformed",false)
-- end    --End function
-- addEventHandler("onPlayerJoin", root, onJoin)

function onQuit(TimeT)
	-- if client then
		local acc = getPlayerAccount(client)
		setAccountData(acc,"TimeTransformation",TimeT)
		-- deleteWings(client)
		outputChatBox("Datos seteados a la cuenta!!")
	-- end
end
addEvent("onQuit",true)
addEventHandler("onQuit",resourceRoot,onQuit)

-- addEventHandler("onPlayerLogin", root,
  function onLogin(_,theCurrentAccount )
	local nivel= getAccountData(theCurrentAccount,"nivel")
	local TimeTransformation = getAccountData(theCurrentAccount,"TimeTransformation")
	deleteWings(source)
	outputChatBox("TimeTransformation: "..tostring(TimeTransformation))
	if TimeTransformation then
		-- setElementData(source,"TimeTransformation",TimeTransformation)
		outputChatBox("Nivel a setear: "..nivel)
		triggerClientEvent(source,"onStart",source,TimeTransformation,nivel)
		outputChatBox("TimeTransformation recuperado exitosamente!")
	else
		setAccountData(theCurrentAccount,"TimeTransformation",nivel*60)
		outputChatBox("TimeTransformation reseteado al nivel")
		triggerClientEvent(source,"onStart",source,nivel*60,nivel)
		-- setElementData(source,"TimeTransformation",60)
	end
  end
  addEventHandler("onPlayerLogin",root,onLogin)
-- )

function setDefaultData()
-- setTimer(
	for k,player in ipairs(getElementsByType("player")) do
		local theCurrentAccount= getPlayerAccount(player)
		local nivel= getAccountData(theCurrentAccount,"nivel")
		local TimeTransformation = getAccountData(theCurrentAccount,"TimeTransformation")
		deleteWings(player)
		outputChatBox("TimeTransformation: "..tostring(TimeTransformation))
		if TimeTransformation then
			outputChatBox("Nivel a setear: "..nivel)
			triggerClientEvent(player,"onStart",player,TimeTransformation,nivel)
			outputChatBox("TimeTransformation recuperado exitosamente!")
		else
			setAccountData(theCurrentAccount,"TimeTransformation",nivel*60)
			outputChatBox("TimeTransformation reseteado al nivel")
			triggerClientEvent(player,"onStart",player,nivel*60,nivel)
		end
	end
	-- ,2000,1)
end
