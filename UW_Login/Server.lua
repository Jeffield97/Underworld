-- function printAllData ( thePlayer )
    -- local playerAccount = getPlayerAccount( thePlayer ) -- get his account
    -- if ( playerAccount ) then -- if we got the account then
        -- local data = getAllAccountData( playerAccount ) -- get data
        -- count = 0
        -- for _ in pairs(data) do count = count + 1 end -- get the count
        -- outputChatBox ( "table holds " .. count .. " entries" ) -- output number of rows
        -- if ( data ) then
            -- for k,v in pairs ( data ) do
                -- outputChatBox(k..": "..v) -- print the key and value of each entry of data
            -- end
        -- end
    -- end
-- end
-- addCommandHandler( "getall", printAllData ) -- add a command handler for command 'getall'


function Registrar(player,User,Pass,Email,Edad,Sexo,Raza)
	outputChatBox("Datos recibidos: "..User..","..Pass..","..Email)
	local Serial = getPlayerSerial(player)
	-- local IP = getPlayerIP(player)
	-- outputChatBox (exports.admin:getPlayerCountry( player ))
	outputChatBox("Serial: "..Serial)
	local accounts = getAccountsBySerial( Serial )
	
	if	#accounts <2 then
		outputChatBox("Cuentas:"..#accounts)
		-- outputChatBox("Cuentas:"..#accounts)
		
		-- local account=addAccount(User,Pass)
		-- if account then
		-- setAccountData(account,"Sexo",Sexo)
		-- setAccountData(account,"Email",Email)
		-- setAccountData(account,"Edad",Edad)
		-- setAccountData(account,"Raza",Raza)
		
		-- outputChatBox("#d1ebf7[UNDERWORLD]#f71919 Se ha registrado el nuevo usuario #19f730"..getPlayerName(player),0,0,0,true)
		-- outputChatBox("#f71919 Bienvenido al servidor UnderWorld",player,0,0,0,true)
		-- outputChatBox("#d1ebf7Tus datos de registro son",player,0,0,0,true)
		-- outputChatBox("#d1ebf7Usuario: #19f730"..User,player,0,0,0,true)
		-- outputChatBox("#d1ebf7Contraseña: #19f730"..Pass,player,0,0,0,true)
	
		-- triggerClientEvent ( source, "Close", source)
		
		-- end
	else
		exports["_infobox"]:addNotification(player,"Solo está permitido la creación de una cuenta","error")
	end
end
addEvent("Registrar",true)
addEventHandler("Registrar",resourceRoot,Registrar)


-- addEventHandler("onPlayerJoin", root,
-- function()
    -- local ip = getPlayerIP(source)
    -- local function displayPlayerCity(resp, errno, source)
        -- if errno == 0 then
            -- local data = fromJSON("[".. resp .. "]")
            -- local status = data["status"] or "fail"
            -- if status == "success" then
                -- if isElement(source) then
                    -- outputChatBox(getPlayerName(source).." has joined the game ("..data["city"]..", "..data["country"]..")", root, 255, 100, 100)
                -- end
            -- else
                -- if isElement(source) then
                    -- outputChatBox(getPlayerName(source).." has joined the game.", root, 255, 100, 100)
                -- end
                -- outputDebugString("JOINQUIT: Cannot retrieve network details")
            -- end
        -- else
            -- outputDebugString("JOINQUIT: Error @fetchRemote, ERRNO: "..errno)
        -- end
    -- end 

    -- fetchRemote("http://ip-api.com/json/" .. ip, displayPlayerCity, "", false, source)
-- end, true, "low")

-- function consoleCreateMarker ( playerSource, commandName )
	-- If a player triggered it (rather than the admin) then
	-- if ( playerSource ) then
		-- local ctry= exports.admin:getPlayerCountry( playerSource )
		-- outputChatBox(tostring(ctry))
	-- end
-- end
-- Attach the 'consoleCreateMarker' function to the "createmarker" command
-- addCommandHandler ( "gc", consoleCreateMarker )
function resourceStartNotify ( resourcename )
	-- if the started resource is this one
	if ( resourcename == getThisResource() ) then
		-- send an info debug message as a notification
		outputDebugString ( "Resource " .. getResourceName(resourcename) .. " loaded." )
	end
end
addEventHandler( "onResourceStart", root, resourceStartNotify )

function login(player,user,pass)
	outputDebugString(user..pass)
	local account = getAccount ( user, pass )
	if ( account ~= false ) then
		logIn( player, account, pass )
		triggerClientEvent ( player, "Close", player)
		outputChatBox("Logueo exitoso")
	else
		exports["_infobox"]:addNotification(player,"Usuario o contraseña incorrectos","error")
	end
end
addEvent("Login",true)
addEventHandler("Login",resourceRoot,login)


function onJoin ( )
	-- we store the player's name
	-- local joinedPlayerName = getPlayerName ( source )
	-- local serverName = getServerName( )
	-- and send him a greeting
	-- outputChatBox ( "Welcome " .. joinedPlayerName .. " to ".. serverName .."!" , source, 255, 255, 255 )
	triggerClientEvent ( source, "AbrirLogin", source)
end
addEventHandler ( "onPlayerJoin", root, onJoin )