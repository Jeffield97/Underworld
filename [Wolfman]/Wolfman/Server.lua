
function resourceStartNotify ( resourcename )
	-- if the started resource is this one
	if ( resourcename == getThisResource() ) then
		-- send an info debug message as a notification
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " cargado." )
		-- onLogin(source)
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )


function setWings(player)
	Wings = createObject(1644,0,0,-100)
	--setElementAlpha(Wings,200)
	setObjectScale(Wings,0.5)
	setElementID ( Wings, getPlayerName(player)) 
	exports.bone_attach:attachElementToBone(Wings,player,6,0.1,0,0,180,0,180)
end
addEvent("setWings",true)
addEventHandler("setWings", getResourceRootElement(getThisResource()) ,setWings)

function deleteWings(player)
	if(getElementByID(getPlayerName(player))) then
		destroyElement(getElementByID(getPlayerName(player)))
		outputChatBox("Alas eliminadas correctamente")
	end
end
addEvent("deleteWings",true)
addEventHandler("deleteWings", getResourceRootElement(getThisResource()) ,deleteWings)

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


function onJoin()
	-- triggerClientEvent(source,"onStart",source,0,0)
	-- setElementData(source,"Transformed",false)
end    --End function
-- addEventHandler("onPlayerJoin", root, onJoin)

function onQuit(TimeT)
	-- if client then
		local acc = getPlayerAccount(client)
		setAccountData(acc,"TimeTransformation",TimeT)
		outputChatBox("Datos seteados a la cuenta!!")
	-- end
end
addEvent("onQuit",true)
addEventHandler("onQuit",resourceRoot,onQuit)

addEventHandler("onPlayerLogin", root,
  function()
    -- outputChatBox(getPlayerName(source).." has logged in!", root)
	local theCurrentAccount = getPlayerAccount(source)
	local nivel= getAccountData(theCurrentAccount,"nivel")
	local TimeTransformation = getAccountData(theCurrentAccount,"TimeTransformation")
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
)

function setStat(stat,value)
	setPedStat(client,stat,value)
end
addEvent("setStat",true)
addEventHandler("setStat",resourceRoot,setStat)
