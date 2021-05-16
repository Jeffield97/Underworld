--LOGS--
addEventHandler("onResourceStart", resourceRoot,
function()
	TeamDB = dbConnect( "sqlite", "LogTeam.db" )
		if TeamDB then
			outputDebugString( "Connection with database was successfully established." )
			dbExec(TeamDB, "CREATE TABLE IF NOT EXISTS ChatTeam (Team TEXT,Nick TEXT, Cuenta TEXT,DateTime TEXT,Msg TEXT)")
		else
			outputDebugString( "Connection with database couldn't be established." )
		end
end)
------

function RGBToHex(red, green, blue) 
    if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255)) then 
        return nil 
    end 
    return string.format("#%.2X%.2X%.2X", red, green, blue) 
end 
  
local function onplayerChat ( message, messageType ) 
    if ( messageType == 2 ) then --Team (Clan) chat 
        cancelEvent ( ) 
		
		local team = getPlayerTeam( source ) 
		local teamColor= RGBToHex(getTeamColor(team))
		
        if not team then 
            return outputChatBox( "You are not part of a team yet !", source, 200, 100, 0) 
        end 
		
        local name = getPlayerName ( source ) 
        local red, green, blue = getPlayerNametagColor ( source ) 
        -- local hex = RGBToHex ( red, green, blue ) 
  	
        local members = getPlayersInTeam( team ) or {} 
        for _, player in ipairs(members) do 
            outputChatBox(teamColor.."[TEAM] "..name .. ": #FFFFFF" .. message, player, 255, 255, 255, true ) 
        end 
        outputServerLog( "(TEAM): " .. name .. ": " .. message )
		local teamName=getTeamName(team)
		local time = getRealTime()
		local datenow=tostring("["..(time.year+1900).."-"..(time.month+1).."-"..time.monthday.."]")
		local datetime = tostring("["..time.hour..":"..time.minute.."]")
		dbExec( TeamDB, "INSERT INTO ChatTeam VALUES (?,?,?,?,?)",teamName,name,getAccountName(getPlayerAccount(source)),datenow..datetime,message)
    end 
end 
addEventHandler ( "onPlayerChat", root, onplayerChat ) 

