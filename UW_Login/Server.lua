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
		
		local account=addAccount(User,Pass)
		if account then
		setAccountData(account,"Sexo",Sexo)
		setAccountData(account,"Email",Email)
		setAccountData(account,"Edad",Edad)
		setAccountData(account,"Raza",Raza)
		end
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
	If a player triggered it (rather than the admin) then
	-- if ( playerSource ) then
		-- local ctry= exports.admin:getPlayerCountry( playerSource )
		-- outputChatBox(tostring(ctry))
	-- end
-- end
-- Attach the 'consoleCreateMarker' function to the "createmarker" command
-- addCommandHandler ( "gc", consoleCreateMarker )