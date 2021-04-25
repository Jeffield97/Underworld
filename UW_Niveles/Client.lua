local Nivel ={
750,
1000,
1500,
2000,
2500,
3000,
3500,
4000,
4500,
5000,
5500,
6000,
7000,
8000,
9000,
10000,
11000,
12000,
13000,
14000,
15000,
16000,
18000,
20000,
22000,
24000,
26000,
28000,
30000,
32000,
34000,
36000,
40000,
45000,
50000,
55000,
60000,
65000,
70000,
75000,
80000,
85000,
90000,
100000,
110000,
120000,
130000,
140000,
150000,
160000,
170000,
180000,
190000,
200000,
215000,
230000,
245000,
260000,
275000,
290000,
305000,
320000,
335000,
350000,
370000,
390000,
410000,
430000,
450000,
}

local screenW, screenH = guiGetScreenSize()
local texto = "Nivel"


addEventHandler("onClientRender", root,
    function()
	dxSetAspectRatioAdjustmentEnabled( true )
	--if not isGuestAccount ( localPlayer ) then
	--local zk = getElementData(localPlayer, "Zombie kills")
	local nivel = tonumber(getElementData(localPlayer, "nivel"))
	local experiencia=tonumber(getElementData(localPlayer, "exp"))
		if nivel >= 0 then
			dxDrawText("#000000"..texto..": ".. nivel.."", (screenW * 0.0307), (screenH * 1.192), (screenW * 0.140) - 1, (screenH * 0.746) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, true, false)
			dxDrawText("#FF0000"..texto..": #FFFFFF".. nivel.."", (screenW * 0.0295), (screenH * 1.19), (screenW * 0.1419) - 1, (screenH * 0.7474) - 1, tocolor(200, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, true, false)
			dxDrawText("#000000 Exp: ".. experiencia.."", (screenW * 0.0807), (screenH * 1.192), (screenW * 0.140) - 1, (screenH * 0.746) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, true, false)
			dxDrawText("#FF0000 Exp: #FFFFFF".. experiencia.."", (screenW * 0.0795), (screenH * 1.19), (screenW * 0.1419) - 1, (screenH * 0.7474) - 1, tocolor(200, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, true, false)
			--dxDrawText("#000000Zombie Kills"..": ".. zk.."", (screenW * 0.0695), (screenH * 1.192), (screenW * 0.140) - 1, (screenH * 0.746) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, true, true, false)
			--dxDrawText("#FF0000Zombie Kills"..": #FFFFFF".. zk.."", (screenW * 0.069), (screenH * 1.19), (screenW * 0.1419) - 1, (screenH * 0.7474) - 1, tocolor(200, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, true, true, false)
			--dxDrawText(texto..": ".. nivel.."", (screenW * 0.0574) + 1, (screenH * 0.6927) - 1, (screenW * 0.1419) + 1, (screenH * 0.7474) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			--dxDrawText(texto..": ".. nivel.."", (screenW * 0.0574) - 1, (screenH * 0.6927) + 1, (screenW * 0.1419) - 1, (screenH * 0.7474) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			--dxDrawText(texto..": ".. nivel.."", (screenW * 0.0574) + 1, (screenH * 0.6927) + 1, (screenW * 0.1419) + 1, (screenH * 0.7474) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			--dxDrawText(texto..": ".. nivel.."", screenW * 0.0574, screenH * 0.6927, screenW * 0.1419, screenH * 0.7474, tocolor(255, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)	
		end
	end
)


-- GUIEditor = {
    -- edit = {},
    -- button = {},
    -- window = {},
    -- label = {},
    -- gridlist = {}
-- }
-- addEventHandler("onClientResourceStart", resourceRoot,
local ventanaActiva= false
function Panel()
outputChatBox("Holaaa")
	if ventanaActiva == false then
		ventanaActiva= true
		local screenW, screenH = guiGetScreenSize()
		Ventana = guiCreateWindow((screenW - 347) / 2, (screenH - 396) / 2, 347, 396, "Sistema De Niveles", false)
		guiWindowSetSizable(Ventana, false)

		LblCreador = guiCreateLabel(278, 371, 59, 15, "by: pc_hunter", false, Ventana)
		guiSetFont(LblCreador, "default-small")
		BotonDarExperiencia = guiCreateButton(255, 46, 72, 19, "Dar exp", false, Ventana)
		BotonQuitarExperiencia = guiCreateButton(255, 75, 72, 19, "Quitar exp", false, Ventana)
		GridList = guiCreateGridList(18, 36, 206, 327, false, Ventana)
		guiGridListAddColumn(GridList, "Player", 0.3)
		guiGridListAddColumn(GridList, "Exp", 0.3)
		guiGridListAddColumn(GridList, "Lvl", 0.3)
		EditObtenerText = guiCreateEdit(245, 317, 93, 20, "", false, Ventana)
		LblCantidad = guiCreateLabel(244, 292, 55, 15, "Cantidad:", false, Ventana)
		BotonCambiarExperiencia = guiCreateButton(255, 104, 72, 19, "Cambiar lvl", false, Ventana)
		-- BtnDarLvl = guiCreateButton(255, 191, 72, 19, "Dar lvl", false, Ventana)
		-- GUIEditor.button[5] = guiCreateButton(255, 220, 72, 19, "Quitar lvl", false, Ventana)
		-- GUIEditor.button[6] = guiCreateButton(255, 249, 72, 19, "Cambiar lvl", false, Ventana)
		BotonSalirExperiencia = guiCreateButton(18, 368, 48, 18, "Cerrar", false, Ventana)    
	
		cargarUsuariosPanel()
		
		showCursor(true)
	addEventHandler("onClientGUIClick", BotonDarExperiencia, darExperienciaFuncAdmin, false)
	addEventHandler("onClientGUIClick", BotonQuitarExperiencia, quitarExperienciaFuncAdmin, false)
	addEventHandler("onClientGUIClick", BotonCambiarExperiencia, cambiarExperienciaFuncAdmin, false)
	addEventHandler("onClientGUIClick", BotonSalirExperiencia, cerrarVentanaExperiencia, false)
	-- addEventHandler("onClientGUIClick", BotonActualizarLista, cargarUsuariosPanel, false)
	end
end
addEvent( "PanelNiveles", true )
addEventHandler( "PanelNiveles", root, Panel )
-- )

function darExperienciaFuncAdmin()
	local row = guiGridListGetSelectedItem(GridList)
	if (not row or row == -1) then outputChatBox("[Server]#ffffffSelecciona un jugador",255,0,0,true) return end
	local nombre = guiGridListGetItemText(GridList, row, 1)
	local experiencia = guiGridListGetItemText(GridList, row, 2)
	nombre = tostring(nombre)
	experiencia = tonumber(experiencia)
	jugador = getPlayerFromName(nombre)
	cantidad = guiGetText (EditObtenerText)
	cantidad = tonumber(cantidad)
	if (not cantidad or cantidad ==0)then outputChatBox("[Server]#ffffffColoca una cantidad",255,0,0,true)return end
	--triggerServerEvent( "darExperienciaJugador", getLocalPlayer(),jugador,cantidad)
	setElementData(jugador,"exp",getElementData(jugador,"exp")+cantidad)
	outputChatBox("[Server]#ffffffLe diste "..cantidad.." Experiencia al jugador "..nombre, 255,0,0,true)
	cargarUsuariosPanel()
	guiSetText(EditObtenerText,"")
end

function quitarExperienciaFuncAdmin()
	local row = guiGridListGetSelectedItem(GridList)
	if (not row or row == -1) then outputChatBox("[Server]#ffffffSelecciona un jugador",255,0,0,true) return end
	local nombre = guiGridListGetItemText(GridList, row, 1)
	local experiencia = guiGridListGetItemText(GridList, row, 2)
	nombre = tostring(nombre)
	experiencia = tonumber(experiencia)
	jugador = getPlayerFromName(nombre)
	cantidad = guiGetText (EditObtenerText)
	cantidad = tonumber(cantidad)
	if (not cantidad or cantidad ==0)then outputChatBox("[Server]#ffffffColoca una cantidad",255,0,0,true)return end
	--triggerServerEvent( "quitarExperienciaJugador", getLocalPlayer(),jugador,cantidad)
    setElementData(jugador,"exp",getElementData(jugador,"exp")-cantidad)
	outputChatBox("[Server]#ffffffLe quitaste "..cantidad.." Experiencia al jugador "..nombre, 255,0,0,true)
	cargarUsuariosPanel()
	guiSetText(EditObtenerText,"")
end

function cambiarExperienciaFuncAdmin()
	local row = guiGridListGetSelectedItem(GridList)
	if (not row or row == -1) then outputChatBox("[Server]#ffffffSelecciona un jugador",255,0,0,true) return end
	local nombre = guiGridListGetItemText(GridList, row, 1)
	local experiencia = guiGridListGetItemText(GridList, row, 2)
	nombre = tostring(nombre)
	experiencia = tonumber(experiencia)
	jugador = getPlayerFromName(nombre)
	cantidad = guiGetText (EditObtenerText)
	cantidad = tonumber(cantidad)
	if (not cantidad or cantidad ==0)then outputChatBox("[Server]#ffffffColoca una cantidad",255,0,0,true)return end
	-- triggerServerEvent( "cambiarExperienciaJugador", getLocalPlayer(),jugador,cantidad)
    setElementData(jugador,"exp",Nivel[cantidad])
	setElementData(jugador,"nivel",cantidad)
	outputChatBox("[Server]#ffffffffffffCambiaste a "..cantidad.." el nivel del jugador "..nombre, 255,0,0,true)
	cargarUsuariosPanel()
	guiSetText(EditObtenerText,"")
end

function cerrarVentanaExperiencia()
	showCursor(false)
	destroyElement(Ventana)
    ventanaActiva = false
end

function cargarUsuariosPanel()
guiGridListClear( GridList )
    for i, player in ipairs(getElementsByType("player")) do
        local item = guiGridListAddRow( GridList )
        local _player = guiGridListSetItemText( GridList, item, 1, getPlayerName(player), false, false )
        local _exp= guiGridListSetItemText( GridList, item, 2, getElementData(player,"exp"), false, false )
        local _lvl = guiGridListSetItemText( GridList, item, 3, getElementData(player,"nivel"), false, false ) 
	end
end