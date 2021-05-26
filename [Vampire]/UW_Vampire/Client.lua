loadstring(exports.dgs:dgsImportFunction())()

--TimeTrans=getElementData(localPlayer,"TimeTransformation")
function VampireT()
	localPlayer= getLocalPlayer()
	if  getElementData(localPlayer,"Raza")=="Vampire" then
		if getElementData(localPlayer,"Transformed") then
			Destransformar()
			
		else
			Transformar()

		end
	end
end
addCommandHandler("Transformar",VampireT,false)

function Transformar()
	outputChatBox("Transformando")
	setElementData(localPlayer,"Transformed",true)
	------
	triggerServerEvent("setWings",resourceRoot,localPlayer)
	setWorldSpecialPropertyEnabled( "extrajump",true)
	setWorldSpecialPropertyEnabled( "snipermoon ",true)
	setGameSpeed(1.30)
	Effect()
	setElementData( localPlayer, "WALLRUN:autorized",true)
	triggerServerEvent("setAnimation",resourceRoot,localPlayer,"freeweights","gym_free_a")
	-- addEventHandler("onClientRender", getRootElement(), Falling) 	
	------
	if isTimer(TimerRest) then
		killTimer(TimerRest)
	end
	TimerTrans= setTimer(
	function()
		if TimeTrans >0 then
			outputChatBox("Tiempo restante: "..TimeTrans)
			TimeTrans=TimeTrans-1
			dgsProgressBarSetProgress(progressbar,(TimeTrans*100/TimeCalulated))
			setElementData(localPlayer,"TimeTransformation",TimeTrans)

		else
			
			Destransformar()
		end
	end,1000,0)
end

function Destransformar()
	outputChatBox("Destransformando")
	setElementData(localPlayer,"Transformed",false)
	
	------
	triggerServerEvent("deleteWings",resourceRoot,localPlayer)
	setWorldSpecialPropertyEnabled( "extrajump",false)
	setWorldSpecialPropertyEnabled( "snipermoon ",false)
	setGameSpeed(1)
	DestroyEffect()
	setElementData( localPlayer, "WALLRUN:autorized",false)
	-- removeEventHandler("onClientRender", getRootElement(), Falling) 
	------
	-- if isTimer(TimeTrans) then
	killTimer(TimerTrans)
	TimerRest= setTimer(
	function()
		if TimeTrans <TimeCalulated then
			outputChatBox("Tiempo restaurado: "..TimeTrans)
			TimeTrans=TimeTrans+1
			dgsProgressBarSetProgress(progressbar,(TimeTrans*100/TimeCalulated))
			setElementData(localPlayer,"TimeTransformation",TimeTrans)
		else
			killTimer(TimerRest)
		end
	end,1000,0)
end


function onStart(TimeTransformation,_lvl)
	outputChatBox("Seteados correctamente: "..TimeTransformation)
	outputChatBox("Nivel: ".._lvl)
	setElementData(localPlayer,"Transformed",false)
	setElementData(localPlayer,"Raza","Vampire")
	setElementData(localPlayer,"TimeTransformation",TimeTransformation)
	TimeTrans=getElementData(localPlayer,"TimeTransformation")
	TimeCalulated= _lvl*60
	Status()
end
addEvent("onStart",true)
addEventHandler("onStart",localPlayer,onStart)
-- addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),onStart)

function onClientQuit( )
    outputChatBox("Guardando datos en cuenta: "..TimeTrans)
	-- Destransformar()
	triggerServerEvent("onQuit",resourceRoot,TimeTrans)
end
-- addCommandHandler("sda",onClientQuit)
addEventHandler( "onClientPlayerQuit", getRootElement(), onClientQuit )


------
-- function onQuitGame( reason )
    -- outputChatBox ( getPlayerName( source ).." ha dejado el servidor ("..reason..")" )
-- end
-- addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )
------


function Status()
	
	
	progressbar = dgsCreateProgressBar(0.45,0.97, 0.1, 0.025, true,_,_,_,_,tocolor(200,40,40,255)) 
	dgsProgressBarSetProgress(progressbar,100)
	LblStatus= dgsCreateLabel(0.38,0.15,0.1,0.1,"Power",true,progressbar)
	dgsSetFont (LblStatus, "default-bold" )
	
	-- dgsProgressBarSetStyle(progressbar,"ring-round",{
	-- isReverse = false,
	-- rotation = 90,
	-- antiAliased = 0.005,
	-- radius = 0.2,
	-- thickness = 0.05})
end


function Effect()
		--Creación de efecto al transformarse
			fxs=createEffect ("blood_heli", Vector3( getElementPosition( getLocalPlayer() ) ), 0, 0, 0)
			fxs2=createEffect ("blood_heli", Vector3( getElementPosition( getLocalPlayer() ) ), 0, 0, 0)
			setEffectDensity(fxs, 1)
			attachEffect(fxs, localPlayer, Vector3(0, -0.35, 0.3))
			attachEffect(fxs2, localPlayer, Vector3(0, 0.35, 0.3))
			setTimer(function()	
					DestroyEffect()
			end,1000,1)
end

function DestroyEffect()
	--if(fxs) then
	local effects={}
	effects=getElementsByType("effect")
	for fx, info in pairs(effects) do
		destroyElement(info)
	end	
		
		-- destroyElement(fxs2)
	-- end 
end
--********************************
--********************************
--**CANCELAR DAÑO AL SUPER SALTO
function GodJump ()        
	if ( isPedDoingTask ( localPlayer, "TASK_COMPLEX_IN_AIR_AND_LAND" ) and getElementData(localPlayer,"Transformed")== true ) then
		--outputChatBox ( getPlayerName ( getLocalPlayer() ) .. " está saltando!" )
		triggerServerEvent("setAnimation",resourceRoot,localPlayer,"bsktball","BBALL_Dnk_Lnd")
		cancelEvent()
		
	end
end
addEventHandler ( "onClientPlayerDamage", root, GodJump )

--FUNCIÓN PARA ATACHAR EFECTOS
local attachedEffects = {}

-- Taken from https://wiki.multitheftauto.com/wiki/GetElementMatrix example
function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z  -- Return the transformed point
end

function attachEffect(effect, element, pos)
	attachedEffects[effect] = { effect = effect, element = element, pos = pos }
	addEventHandler("onClientElementDestroy", effect, function() attachedEffects[effect] = nil end)
	addEventHandler("onClientElementDestroy", element, function() attachedEffects[effect] = nil end)
	return true
end

addEventHandler("onClientPreRender", root, 	
	function()
		for fx, info in pairs(attachedEffects) do
			local x, y, z = getPositionFromElementOffset(info.element, info.pos.x, info.pos.y, info.pos.z)
			setElementPosition(fx, x, y, z)
		end		
	end
)

-- function 