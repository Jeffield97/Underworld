
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



