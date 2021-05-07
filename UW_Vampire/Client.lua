loadstring(exports.dgs:dgsImportFunction())()

TimeTrans=getElementData(localPlayer,"TimeTransformation")
function VampireT()
	localPlayer= getLocalPlayer()
	if getElementData(localPlayer,"Transformed") then
		Destransformar()
		
		
	else
		Transformar()

		
	end
end
addCommandHandler("v",VampireT)

function Transformar()
	outputChatBox("Transformando")
	setElementData(localPlayer,"Transformed",true)
	------
	triggerServerEvent("setWings",resourceRoot,localPlayer)
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
	------
	-- if isTimer(TimeTrans) then
	killTimer(TimerTrans)
	TimerRest= setTimer(
	function()
		if TimeTrans <TimeCalulated then
			outputChatBox("Tiempo restaurado: "..TimeTrans)
			TimeTrans=TimeTrans+1
			dgsProgressBarSetProgress(progressbar,(TimeTrans*100/TimeCalulated))
		else
			killTimer(TimerRest)
		end
	end,1000,0)
end


function onStart()
	TimeCalulated = getElementData(localPlayer,"nivel") * 60
	setElementData(localPlayer,"Transformed",false)
	outputChatBox("Client Resource Started")
	setElementData(localPlayer,"TimeTransformation",TimeCalulated)
	TimeTrans=getElementData(localPlayer,"TimeTransformation")
	Status()
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),onStart)

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
