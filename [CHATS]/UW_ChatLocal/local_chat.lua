--LOGS--
addEventHandler("onResourceStart", resourceRoot,
function()
	LocalDB = dbConnect( "sqlite", "LogLocal.db" )
		if LocalDB then
			outputDebugString( "Connection with database was successfully established." )
			dbExec(LocalDB, "CREATE TABLE IF NOT EXISTS ChatLocal (Nick TEXT, Cuenta TEXT,DateTime TEXT,Msg TEXT)")
		else
			outputDebugString( "Connection with database couldn't be established." )
		end
end)
------

chat_range=100
 
addEventHandler("onPlayerJoin",getRootElement(),
function ()
bindKey(source,"u","down","chatbox","Local")
end)
 
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
function ()


for index, player in pairs(getElementsByType("player")) do
bindKey(player,"u","down","chatbox","Local")
  end
end)
 
function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
 
function onChat(player,_,...)
  local px,py,pz=getElementPosition(player)
  local msg = table.concat({...}, " ")
  local nick=getPlayerName(player)
  if not isPlayerMuted (player) then 
	  for _,v in ipairs(getElementsByType("player")) do
		if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then
		  outputChatBox( "#f98ee6(Local) #ffffff"..nick..": "..msg,v,r,g,b,true)
		end
	  end
	  
		local time = getRealTime()
		local datenow=tostring("["..(time.year+1900).."-"..(time.month+1).."-"..time.monthday.."]")
		local datetime = tostring("["..time.hour..":"..time.minute.."]")
		dbExec( LocalDB, "INSERT INTO ChatLocal VALUES (?,?,?,?)",nick,getAccountName(getPlayerAccount(player)),datenow..datetime,tostring(msg))
	  -- exports["LogCreator"]:saveLog("(Local)"..nick..": "..msg,"Local")
  else
	outputChatBox("[Servidor]: "..nick.." estás muted")
	
  end
  
	--local sender = getAccountName(getPlayerAccount(source))
	--local reciver = getAccountName(getPlayerAccount(plr))
	-- exports["LogCreator"]:saveLog("["..(hours-5)..":"..minutes.."]"..message.."("..sender.."->"..reciver..")",sender.."/"..reciver)
  -- exports.LogCreator:saveLog("#f98ee6(Local) #ffffff"..nick..": "..msg,"Local")
end
addCommandHandler("Local",onChat)
