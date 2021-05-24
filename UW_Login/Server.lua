-- local function logEvent(file, text)
	-- local file_exists = fileExists("logs/"..file)
	-- local real_time = getRealTime()
	-- local year = real_time.year + 1900
	-- local month = real_time.month < 10 and "0"..real_time.month + 1 or real_time.month + 1
	-- local month_day = real_time.monthday < 10 and "0"..real_time.monthday or real_time.monthday
	-- local hour = real_time.hour < 10 and "0"..real_time.hour or real_time.hour
	-- local minute = real_time.minute < 10 and "0"..real_time.minute or real_time.minute
	-- local second = real_time.second < 10 and "0"..real_time.second or real_time.second
	-- if file_exists then
		-- local log_file = fileOpen("logs/"..file)
		-- if log_file then
			-- fileSetPos(log_file, fileGetSize(log_file))
			-- fileWrite(log_file, "\r\n["..year.."-"..month.."-"..month_day.." "..hour..":"..minute..":"..second.."] "..text)
			-- fileFlush(log_file)
			-- fileClose(log_file)
		-- else
			-- outputDebugString("Couldn't open log file.", 0, 255, 127, 0)
			-- return false
		-- end
	-- else
		-- local new_log = fileCreate("logs/"..file)
		-- if new_log then
			-- outputDebugString(file.." log file created successfully.", 0, 255, 127, 0)
			-- fileWrite(new_log, "["..year.."-"..month.."-"..month_day.." "..hour..":"..minute..":"..second.."] Log file created successfully.")
			-- if text then
				-- fileSetPos(new_log, fileGetSize(new_log))
				-- fileWrite(new_log, "\r\n["..year.."-"..month.."-"..month_day.." "..hour..":"..minute..":"..second.."] "..text)
			-- end
			-- fileFlush(new_log)
			-- fileClose(new_log)
		-- else
			-- outputDebugString("Couldn't create new log file.", 0, 255, 127, 0)
			-- return false
		-- end	
	-- end
-- end


-- function getCam(playerSource, commandName )
	-- outputChatBox("Getting Camera de: "..getPlayerName(playerSource))
	-- local x, y, z, lx, ly, lz = getCameraMatrix (playerSource)
	-- outputChatBox("Posición: "..x..","..y..","..z..","..lx..","..ly..","..lz)
	-- local x, y, z, lx, ly, lz = getCameraMatrix (playerSource)
	-- x, lx = x + 1, lx + 1

	-- setCameraMatrix (playerSource,x, y, z, lx, ly, lz)
-- end
-- addCommandHandler("g",getCam)

-- LOGGEAR JUGADOR
function login(player,user,pass)
	
	local account = getAccount ( user, pass )
	if ( account ~= false ) then
		logIn( player, account, pass )
		triggerClientEvent ( player, "CerrarLogin",player)
		outputChatBox("Logueo exitoso")
		outputDebugString("Se acaba de logguear: "..user.." con contraseña: "..pass)
	else
		outputDebugString("Intento de logguear: "..user.." con contraseña: "..pass,1)
		exports["_infobox"]:addNotification(player,"Usuario o contraseña incorrectos","error")
	end
end
addEvent("Login",true)
addEventHandler("Login",resourceRoot,login)

--NOTIFICACIÓN AL INICIAR EL RECURSO
function resourceStartNotify ( resourcename )
	if ( resourcename == getThisResource() ) then
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " loaded." )
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )

--REGISTRAR JUGADOR
function Registrar(player,User,Pass,Email,Edad,Sexo,Raza)
	-- triggerClientEvent ( player, "CerrarLogin", player)
	outputChatBox("Datos recibidos: "..User..","..Pass..","..Email)
	local Serial = getPlayerSerial(player)
	outputChatBox("Serial: "..Serial)
	local accounts = getAccountsBySerial( Serial )
	if	#accounts <2 then
		outputChatBox("Cuentas:"..#accounts)
		if not getAccount(User) then
			local account=addAccount(User,Pass)
			if account then
				setAccountData(account,"Sexo",Sexo)
				setAccountData(account,"Email",Email)
				setAccountData(account,"Edad",Edad)
				setAccountData(account,"Raza",Raza)
				setAccountData(account,"serial",Serial)
				setAccountData(account,"ip",getPlayerIP(player))
				exports["_infobox"]:addNotification(player,"Registro de usuario correcto","success")
				outputChatBox("#d1ebf7[UNDERWORLD]#f71919 Se ha registrado el nuevo usuario #19f730"..getPlayerName(player),getRootElement(),0,0,0,true)
				outputChatBox("#f71919 Bienvenido al servidor UnderWorld",player,0,0,0,true)
				outputChatBox("#d1ebf7Tus datos de registro son",player,0,0,0,true)
				outputChatBox("#d1ebf7Usuario: #19f730"..User,player,0,0,0,true)
				outputChatBox("#d1ebf7Contraseña: #19f730"..Pass,player,0,0,0,true)
				logIn (player,account,Pass)
				triggerClientEvent ( player, "CerrarRegistro",player)
				spawnPlayer(player,1134.537109375, -1557.2515869141, 24.55,63.22)
			end
		else
			exports["_infobox"]:addNotification(player,"La cuenta ya existe","error")
		end
	else
		exports["_infobox"]:addNotification(player,"Solo está permitido la creación de una cuenta","error")
	end
end
addEvent("Registrar",true)
addEventHandler("Registrar",resourceRoot,Registrar)


function ammountAccount(thePlayer,commandName)
	local Serial = getPlayerSerial(thePlayer)
	outputChatBox("Serial: "..Serial)
	local accs= getAccountsBySerial(Serial)
	outputChatBox("Número de cuentas:"..#accs)
end
addCommandHandler("b",ammountAccount)

addEventHandler( "onResourceStart", resourceRoot,
	function( )
		local players = getElementsByType( 'player' )
		setTimer( function( )
			for i=1, #players do 
				logOut( players[i] )
				-- triggerClientEvent( players[i], "login:abrirLogin", players[i] )
			end
		end, 1000, 1 )
	end
)

function invitado(player)
	spawnPlayer(player,1134.537109375, -1557.2515869141, 24.55,63.22)
end
addEvent("invitado",true)
addEventHandler("invitado",resourceRoot,invitado)