loadstring(exports.dgs:dgsImportFunction())()

--TimeTrans=getElementData(localPlayer,"TimeTransformation")
function WolfmanT()
	localPlayer= getLocalPlayer()
	if  getElementData(localPlayer,"Raza")=="Wolfman" then
		if getElementData(localPlayer,"Transformed") then
			Destransformar()
			
			
		else
			Transformar()

			
		end
	end
end
addCommandHandler("Transformar",WolfmanT,false)

function Transformar()
	outputChatBox("Transformando")
	setElementData(localPlayer,"Transformed",true)
	------
	-- setGameSpeed(0.9)
	setWorldSpecialPropertyEnabled( "extrajump",true)
	
	toggleControl("next_weapon",false)
	toggleControl("previous_weapon",false)
	toggleControl("enter_exit",false)
	toggleControl("enter_passenger",false)
	-- setPedStat(localPlayer,24,1000)
	triggerServerEvent("setStat",resourceRoot,24,1000)
	-- setElementHealth(localPlayer, 150)
	setTimer(setElementHealth,500,1,localPlayer,200)
	-- setPedFightingStyle ( localPlayer,5)
	-- setPedGravity(localPlayer,0.002)
	 setElementData(localPlayer,"SkinLocal",getElementModel(localPlayer))
	setElementModel(localPlayer,1)
	triggerServerEvent("setAnimation",resourceRoot,localPlayer,"medic","cpr")
	addEventHandler("onClientRender", getRootElement(getThisResource()), superSalto) 	
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
	toggleControl("next_weapon",true)
	toggleControl("previous_weapon",true)
	toggleControl("enter_exit",true)
	toggleControl("enter_passenger",true)
	------
	-- setGameSpeed(1)
	setWorldSpecialPropertyEnabled( "extrajump",false)
	DestroyEffect()
	-- setPedStat(localPlayer,24,500)
	triggerServerEvent("setStat",resourceRoot,24,500)
	setElementHealth(localPlayer, 100)
	-- setPedGravity(localPlayer,0.008)
	setElementModel(localPlayer,getElementData(localPlayer,"SkinLocal"))
	-- setPedFightingStyle ( localPlayer,4)
	removeEventHandler("onClientRender", getRootElement(getThisResource()), superSalto) 
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


function onStart(TimeTransformation,_lvl,Raza)
	outputChatBox("Seteados correctamente: "..TimeTransformation)
	outputChatBox("Nivel: ".._lvl)
	setElementData(localPlayer,"Raza",Raza)
	setElementData(localPlayer,"Transformed",false)
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
			fxs=createEffect ("explosion_molotov", Vector3( getElementPosition( getLocalPlayer() ) ), 0, 0, 0)
			--fxs2=createEffect ("explosion_molotov", Vector3( getElementPosition( getLocalPlayer() ) ), 0, 0, 0)
			setEffectDensity(fxs, 1)
			attachEffect(fxs, localPlayer, Vector3(0, -0.35, 0.3))
			--attachEffect(fxs2, localPlayer, Vector3(0, 0.35, 0.3))
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

function superSalto()
	if  isPedDoingTask (localPlayer, "TASK_SIMPLE_JUMP" ) then
		outputChatBox("Saltando!!!")
		local x, y, z = getElementVelocity(localPlayer)
		outputChatBox("Velocity: "..x..";"..y..";"..z)
			setElementVelocity(localPlayer,x*2,y*2,z+2)
			-- outputChatBox("Velocity: "..x^20..";"..y^20..";"..z^20)
	end
end
