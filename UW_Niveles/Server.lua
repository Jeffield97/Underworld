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
--Creación de teams
SOX8 = createTeam("Legendario",205,38,38)
SOX7 = createTeam("Titan",114,74,253)
SOX6 = createTeam("Depredador",231,135,8)
SOX5 = createTeam("Mercenario",141,141,141)
SOX4 = createTeam("Cazador",216,203,59)
SOX3 = createTeam("Superviviente",50,161,85)
SOX2 = createTeam("Explorador",45,120,222)
SOX1 = createTeam("Iniciado",255,255,255)
--Función para manejar niveles y experiencia
function Level (ammo,killer, weapon, bodypart)

	--Si el jugador es humano
	if((killer) and (killer ~= source)) and (getElementType(killer) ~= "ped") then
	    local EXP = tonumber(getElementData(killer,"exp"))
		local Transf=getElementData(source,"Transformacion")
		local LVL = tonumber(getElementData(killer,"nivel"))
		local EXPS = tonumber(getElementData(source,"exp"))
		local LVLS = tonumber(getElementData(source,"nivel"))
		
		
		subirLvl(killer,EXP,LVL)
		bajarLvl(source,EXPS,LVLS)
		if(LVL == LVLS) then  --Verificacion de niveles del jugador
			if(Transf) then --Verificacion si está transformado da bonus extra
				DarExp(killer,20)
				QuitarExp(source,20)
				outputChatBox("Bonus extra! +10")
			else
				DarExp(killer,10)
			end
		elseif (LVL > LVLS) then
			if(Transf) then --Verificacion si está transformado da bonus extra
				DarExp(killer,10)
				QuitarExp(source,10)
				outputChatBox("Bonus extra! +5")
			else
				DarExp(killer,5)
			end
		else
			if(Transf) then --Verificacion si está transformado da bonus extra
				DarExp(killer,40)
				QuitarExp(source,40)
				outputChatBox("Bonus extra! +40")
			else
				DarExp(killer,20)
			end
		end
		
	--Si el jugador es un bot
	--else
		
	end
end
addEventHandler ("onPlayerWasted", getRootElement(), Level)


--Función para dar Experiencia
function DarExp(killer,_exp)
	outputChatBox("+ Exp".._exp)
	local EXP = tonumber(getElementData(killer,"exp"))
	setElementData(killer,"exp",EXP+_exp)
	
end

--Función para quitar Experiencia
function QuitarExp(source,_exp)
	outputChatBox("- Exp".._exp)
	local EXP = tonumber(getElementData(source,"exp"))
	setElementData(source,"exp",EXP-_exp)
end

--Función para asignar teams
function AsignarTeam(source)
	local nivel = tonumber(getElementData(source,"nivel"))
		if(nivel >=0 and nivel <9) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX1 )
				elseif (nivel >=10 and nivel <= 19) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX2 )
				elseif (nivel >=20 and nivel <= 29) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX3 )
				elseif (nivel >=30 and nivel <= 39) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX4 )
				elseif (nivel >=40 and nivel <= 49) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX5 )
				elseif (nivel >=50 and nivel <= 59) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX6 )
				elseif (nivel >=60 and nivel <= 69) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX7 )
				elseif (nivel >=70) then
			-- setElementData(source,"Level",":Ex_Niveles/Level"..nivel..".png")
			setPlayerTeam ( source, SOX8 )
		end
end
outputChatBox("Nivel: "..Nivel[1])
outputChatBox("Nivel: "..Nivel[2])

--Función para subir Nivel
function subirLvl(_player,_exp,_nivel)
	if(_exp>=Nivel[_nivel+1])then
		setElementData(_player,"nivel",_nivel+1)
		AsignarTeam(_player)
		--AsignarTeam(source)
		outputChatBox("Tu nivel ha cambiado")	
	end
end

--Función para bajar Nivel
function bajarLvl(_player,_exp,_nivel)
	if(_nivel>1 and _exp<=Nivel[_nivel])then
		setElementData(_player,"nivel",_nivel-1)
		AsignarTeam(_player)
		--AsignarTeam(source)
		outputChatBox("Tu nivel ha bajado")	
	end
end

--Función para establecer las cantidades iniciales
function onStart()
	local players = getElementsByType("player")
	for _,player in ipairs(players) do 
			setElementData(player,"nivel",2)
			setElementData(player,"exp",1000)
			AsignarTeam(player)
	end
end
addEventHandler("onResourceStart",resourceRoot,onStart)

--Función para establecer nivel y experiencia al momento de conectarse
function onJoin()
	setElementData(source,"nivel",1)
	setElementData(source,"exp",0)
	setPlayerTeam(source,SOX1)
end
addEventHandler("onPlayerJoin",root,onJoin)

function agregarColumnaScoreboard(source)
	exports.scoreboard:scoreboardAddColumn("nivel",source,20,"Nivel")
	exports.scoreboard:scoreboardAddColumn("exp",source,50,"Exp")
end
addEventHandler("onResourceStart",root,agregarColumnaScoreboard)

--Panel de Niveles
function abrirPanel(sourcePlayer)
	local accName = getAccountName ( getPlayerAccount ( sourcePlayer ) )
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
		triggerClientEvent (sourcePlayer, "PanelNiveles", sourcePlayer)
	end
end
addCommandHandler("Nivel",abrirPanel)


 ---LOAD
addEventHandler ( 'onPlayerLogin', getRootElement ( ),
    function ( _, theCurrentAccount )
	local experiencia = getAccountData(theCurrentAccount,"exp")
	local nivel = getAccountData(theCurrentAccount,"nivel")
	setElementData(source,"exp",experiencia)
	setElementData(source,"nivel",nivel)
	end
)


 
-- addEventHandler ( 'onPlayerLogin', getRootElement ( ),
    -- function ( _, theCurrentAccount )
    -- local Serial = Firewall[getAccountName(theCurrentAccount)]
        -- if Serial and Serial ~= getPlayerSerial ( source ) then
            -- outputChatBox( "Sorry, you're not allowed to access this account.", source)
            -- cancelEvent( true )
        -- end
    -- end
-- )

---SAVE
-- function loggedOut(thePreviousAccount,theCurrentAccount)
	-- local experiencia = getElementData(source,"exp")
	-- local acc = getPlayerAccount(source)
	-- setAccountData(thePreviousAccount,"exp",experiencia)
-- end
-- addEventHandler("onPlayerLogout",getRootElement(),loggedOut)

function quitPlayer ( )
	local experiencia = getElementData(source,"exp")
	local nivel = getElementData(source,"nivel")
	local acc = getPlayerAccount(source)
	setAccountData(acc,"exp",experiencia)
	setAccountData(acc,"nivel",nivel)
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )