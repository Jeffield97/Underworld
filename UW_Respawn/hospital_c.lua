local sx, sy = guiGetScreenSize ( )
local pX, pY = ( sx / 2 - 485 / 2 ), ( sy / 2 - 150 / 2 )

function Wasted_Dx( )
	dxDrawText("Wasted", pX, pY, 670-10, 314-20, tocolor(0, 0, 0, 255), 3, "bankgothic", "center", "top", false, false, false, false, false)
	dxDrawText("Wasted", pX, pY, 670, 314, tocolor(255, 0, 0, 255), 3, "bankgothic", "center", "top", false, false, false, false, false)
end

function WastedTimer(FadeTimer)
	--addEventHandler("onClientRender", root, Wasted_Dx)
	setTimer(StopText, FadeTimer*500, 1, localPlayer) 
end

addEvent("WastedText", true)
addEventHandler("WastedText", getRootElement(), WastedTimer)

function StopText()
	removeEventHandler("onClientRender", root, Wasted_Dx)
end