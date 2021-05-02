addEventHandler("onClientResourceStart", resourceRoot,
	function()
		setDevelopmentMode(true)
	end
)

function music()
	local sound = playSound("missionDone.mp3")
	-- OcultarProgressTurf()
end
addEvent("onTakeTurf", true)
addEventHandler("onTakeTurf", resourceRoot, music)

-------
sx,sy= guiGetScreenSize()
DGS = exports.dgs
progressbar = DGS:dgsCreateProgressBar(0.41, 0.89, 0.18, 0.03, true)
porcentaje = DGS:dgsCreateLabel(0.4,0.2,0.18,0.18,"0%",true,progressbar)    
number = 0
function ProgressTurf()

DGS:dgsSetAlpha(progressbar,255)
outputChatBox("Turf Iniciado")
capturing= setTimer(function ()
	if getElementData(localPlayer,"turf",true) then
		outputChatBox("Iniciando conteo")
		number = number + 10
		DGS:dgsSetText(porcentaje,number.."%")
		DGS:dgsProgressBarSetProgress(progressbar,number)
		if number == 100 then
			outputChatBox("TurfCompletado")
		end 
	else
		-- if capturing then
			killTimer(capturing)
			outputChatBox("Matando el timer")
		-- end
	end
end,3000,10)
end
addEvent("ProgressTurf",true)
addEventHandler("ProgressTurf",localPlayer,ProgressTurf)

function OcultarProgressTurf()
DGS:dgsSetAlpha(progressbar,0)
DGS:dgsSetText(porcentaje,tostring(0).."%")
DGS:dgsProgressBarSetProgress(progressbar,0)
number=0
end
addEvent("OcultarProgressTurf",true)
addEventHandler("OcultarProgressTurf",localPlayer,OcultarProgressTurf)
addEventHandler("onClientResourceStart",getRootElement(),OcultarProgressTurf)
