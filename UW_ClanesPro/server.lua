function data() --  

	local time = getRealTime()
	return time.monthday.."/"..time.month + 1 .."/"..time.year + 1900
end

addEventHandler("onResourceStart", resourceRoot,
function()
	local data = data()
	exports.scoreboard:addScoreboardColumn("Group", root, 3, 80)
	db = dbConnect("sqlite", "database.db")               
	dbExec(db, "CREATE TABLE IF NOT EXISTS groups (group_name, group_members INT, members_limit, group_info, group_bank INT, turf_color, chat_color, tag_color, group_owner, turf_points INT, kill_points INT)")
	dbExec(db, "CREATE TABLE IF NOT EXISTS group_ranks (group_name, group_rank_name, group_rank_permission, rank_type)")
	dbExec(db, "CREATE TABLE IF NOT EXISTS group_members (group_name, member_account, member_name, member_status, member_rank, last_online, WL)")
	dbExec(db, "CREATE TABLE IF NOT EXISTS group_invite (group_name, player_account, byy)")
	dbExec(db, "CREATE TABLE IF NOT EXISTS group_history (group_name, groupaction, thetime)")
	dbExec(db, "CREATE TABLE IF NOT EXISTS group_blackaccount (group_name, byy, account_name, Reason, Time)")
	dbExec(db, "CREATE TABLE IF NOT EXISTS group_blackserial (group_name, byy, serial, Reason, Time)")
	for i, player in ipairs(getElementsByType("player")) do
		local groupName = getPlayerGroup(player)
		if groupName then
			setElementData(player, "Group", groupName)
			setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
			dbExec(db, "UPDATE group_members SET member_name = ?, member_status = ?, last_online = ? WHERE group_name = ? AND member_account = ?", getPlayerName(player),"Yes",data,groupName,getAccountName(getPlayerAccount(player)))
		else
			setElementData(player, "Group", false)
			setElementData(player, "GroupRank", false)
		end
	end
end)

addEventHandler("onResourceStop", resourceRoot,
function()
	for i, player in ipairs(getElementsByType("player")) do
		setElementData(player, "Group", false)
		setElementData(player, "GroupRank", false)
	end
end)

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

gChatSpam = {}

function onGroupChat(player,_,...)
	local group = getElementData(player, "Group")
	if getElementData(player,"GroupMute") == "True" then outputChatBox("GroupChat: You Are Muted From The GroupChat",player,255,160,0) return end
	if isPlayerMuted(player) then outputChatBox("GroupChat: You are muted",player,255,160,0) return end
	if group then
		if not gChatSpam[player] then
			gChatSpam[player] = 0
			setTimer(function(player) gChatSpam[player] = nil end, 5000, 1, player)
		end
		if gChatSpam[player] == 3 then
			outputChatBox("*** Don't Spam! ***", player, 255, 0, 0)
		else
			gChatSpam[player] = gChatSpam[player] + 1
			local msg = table.concat({...}, " ")
			local nick = getPlayerName(player)
			local re, ge, be = getPlayerNametagColor(player)
			local color = string.format("#%02X%02X%02X", re, ge, be)
			local rank = getPlayerGroupRank(player)
			local CO = getGroupChatColor(group)
			local r, g, b = CO[1], CO[2], CO[3]
			local msgc = string.format("#%02X%02X%02X", r, g, b)
			local tagc = getGroupChatTagColor(group)
			local rt, gt, bt = tagc[1], tagc[2], tagc[3]
			local tagcolor = string.format("#%02X%02X%02X", rt, gt, bt)
			outputServerLog("(Group) ("..group..") [ ".. rank .. " ] " ..nick..": "..msg)
			for _,v in ipairs(getElementsByType("player")) do
				if getElementData(v ,"Group") == group then
					outputChatBox("#FF0000(Group) "..tagcolor.. "["..rank.."] "..color..""..nick.." : "..msgc..""..msg, v, 255, 255, 255, true)		
					if getGroupFounderAccount(group) == getAccountName(getPlayerAccount(player)) then
						playSoundFrontEnd(v, 40)
					end
				end
			end
		end
	end
end
addCommandHandler("GroupChat",onGroupChat)

function onCreateGroup(name)
	if getPlayerGroup(source) then
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000Ya te encuentras en un clan.",255, 20, 0)
	elseif (getPlayerMoney(source) or 0) < 100000 then 
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000El costo para crear un clan es de $3000000.", 255, 20, 0)
	elseif isHasSpace(name) then
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000El nombre del clan debe ser sin espacios.", 255, 40, 0)
	elseif not isASCII(name) then
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000El nombre solo debe contener caracteres válidos.", 255, 40, 0)
	else
		CreateGroup(source, name)
	end
end
addEvent("Create_Group", true)
addEventHandler("Create_Group", root, onCreateGroup)

function isASCII(text)
    for i = 1, #text do
        local byte = text:byte(i)
        if(byte < 33 or byte > 126)then
            return false
        end
    end
    return true
end

function isHasSpace(text)
    for i = 1, #text do
        local byte = text:byte(i)
        if(byte == 32)then
            return true
        end
    end
    return false
end

local Ranks_Table = { 
	{"Trial", ""},
	{"Regular", ""},
	{"Trusted", "6"},
	{"Deputy", "1, 2, 3, 5, 6, 8, 16"},
	{"Leader", "1, 2, 3, 4, 5, 6, 8, 10, 11, 14, 16, 19, 22"},
	{"Founder", "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23"}
}

function CreateGroup(player, name)
	if not IsGroupExists(name) then
		local data = data()
		local playerName = getPlayerName(player)
		local accountName = getAccountName(getPlayerAccount(player))
		local color = math.random(255)..", "..math.random(255)..", "..math.random(255)
		dbExec(db, "INSERT INTO groups VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", name, 1, 20, "The Group Leader Has Not Made A Messages Yet.", 0, color, color, color, accountName, 0, 10)
		for i, R in ipairs(Ranks_Table) do
			if R[1] == "Founder" then
				dbExec(db, "INSERT INTO group_ranks VALUES(?, ?, ?, ?)", name, R[1], R[2], 1)
			elseif R[1] == "Trial" then
				dbExec(db, "INSERT INTO group_ranks VALUES(?, ?, ?, ?)", name, R[1], R[2], 2)
			else
				dbExec(db, "INSERT INTO group_ranks VALUES(?, ?, ?, ?)", name, R[1], R[2], 3)
			end
		end
		ss = getPlayerMoney(source)
		if ss > 100000 then 
		dbExec(db, "INSERT INTO group_members VALUES(?, ?, ?, ?, ?, ?, ?)", name, accountName, playerName, "Yes", "Founder", data, 0)
		setElementData(player, "Group", name)
		setElementData(player, "GroupRank", {getGroupRanks(name), getPlayerGroupRank(player)})
		exports["dxmessages"]:outputDx(player, "#04B4AE(ClanSystem) #FFFFFF"..name.." #FF0000Ha sido creado exitosamente.", 0, 255, 0)
		groupAddNewHistoryLog ( name, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Creó el clan '"..name.."'")
		takePlayerMoney ( source, 3000000 )
	else
	exports["dxmessages"]:outputDx(player, " #04B4AE(ClanSystem) #FF0000No tienes suficiente dinero ", 255, 0, 0)
	end
	else
		exports["dxmessages"]:outputDx(player, "#04B4AE(ClanSystem) #FF0000El nombre del clan #DF7401"..name.." #FF0000ya existe.", 255, 0, 0)
	end
end

addCommandHandler("tagcolor",
function (player, cmd, r, g, b)
	local Group = getElementData(player, "Group")
	local r = tonumber(r)
	local g = tonumber(g)
	local b = tonumber(b)
	if Group then
		if doesPlayerHavePermission(player, 13) then
			if r and g and b then
				if r <= 255 and r >= 0 and g <= 255 and g >= 0 and b <= 255 and b >= 0 then
					local color = r..", "..g..", "..b
					dbExec(db, "UPDATE groups SET tag_color = ? WHERE group_name = ?", color, Group)
					exports["dxmessages"]:outputDx(player,"#FF9600[ClanSystem] "..string.format("#%.2X%.2X%.2X", r, g, b).."El color del tag ha sido cambiado con éxito.", r, g, b)
					groupAddNewHistoryLog ( Group, "("..getPlayerName( player )..")["..getAccountName(getPlayerAccount(player)).."] cambió el color del tag a "..r.." , "..g.." , "..b)
				else
					-- exports["dxmessages"]:outputDx(player, "#FF9600[ClanSystem] #FFFF00The color must be a number between 0-255.", 255, 255, 0)
					exports["dxmessages"]:outputDx(player, "#FF9600[ClanSystem] #FFFF00El color del tag debe estar entre 0-255.", 255, 255, 0)
				end
				else
				exports["dxmessages"]:outputDx(source, "  #FF9600[ClanSystem] #FFFF00Sintaxis: /tagcolor [r] [g] [b]  ", 255, 255, 0)
				exports["dxmessages"]:outputDx(player, "  #FF9600[ClanSystem] #00FFFFEjemplo: /tagcolor 255 0 0  ", 0, 250, 150)
			end
		else
			exports["dxmessages"]:outputDx(player, "#FF9600[ClanSystem] #FF0000No tienes permiso para cambiar el color del tag.", 255, 0, 0)
		end
	end
end
)

addCommandHandler("chatcolor",
function(player, cmd, r, g, b)
	local Group = getElementData(player, "Group")
	local r = tonumber(r)
	local g = tonumber(g)
	local b = tonumber(b)
	if Group then
		if doesPlayerHavePermission(player, 13) then
			if r and g and b then
				if r <= 255 and r >= 0 and g <= 255 and g >= 0 and b <= 255 and b >= 0 then
					local color = r..", "..g..", "..b
					dbExec(db, "UPDATE groups SET chat_color = ? WHERE group_name = ?", color, Group)
					exports["dxmessages"]:outputDx(player,"#FF9600[ClanSystem] "..string.format("#%.2X%.2X%.2X", r, g, b).."El color del chat ha sido cambiado con éxito.", r, g, b)
					groupAddNewHistoryLog(Group, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] cambió el color del chat a "..r.." , "..g.. " , "..b.."")
				else
					exports["dxmessages"]:outputDx(player, "#FF9600[ClanSystem] #FFFF00El color del chat debe estar entre 0-255.", 255, 255, 0)
				end
				else
				exports["dxmessages"]:outputDx(player, "  #FF9600[ClanSystem] #FFFF00Sintaxis: /chatcolor [r] [g] [b]  ", 255, 255, 0)
				exports["dxmessages"]:outputDx(player, "  #FF9600[ClanSystem] #00FFFFEjemplo: /chatcolor 255 0 0  ", 0, 250, 150)
			end
		else
			exports["dxmessages"]:outputDx(player, "#FF9600[ClanSystem] #FF0000No tienes permiso para cambiar el color del chat.", 255, 0, 0)
		end
	end
end
)

turfTimer = {}

addCommandHandler("turfcolor",
function(player, cmd, r, g, b)
	if not turfTimer[player] then
		turfTimer[player] = true
		setTimer(function(player) turfTimer[player] = nil end, 2500, 1, player)
		local Group = getElementData(player, "Group")
		local r = tonumber(r)
		local g = tonumber(g)
		local b = tonumber(b)
		if Group then
			if doesPlayerHavePermission(player, 12) then
				if r and g and b then
					if r <= 255 and r >= 0 and g <= 255 and g >= 0 and b <= 255 and b >= 0 then
						local color = r..", "..g..", "..b
						dbExec(db, "UPDATE groups SET turf_color = ? WHERE group_name = ?", color, Group)
						exports["dxmessages"]:outputDx(player, "#FF9600[Turf System] "..string.format("#%.2X%.2X%.2X", r, g, b).."El color del turf ha sido cambiado con éxito.", r, g, b)
						groupAddNewHistoryLog ( Group, "("..getPlayerName( player )..")["..getAccountName(getPlayerAccount(player)).."] cambió el color del turf a "..r.." , "..g.." , "..b.." , ")
					else
						exports["dxmessages"]:outputDx(player, "#FF9600[Turf System] #FFFF00El color del turf debe estar entre 0-255.", 255, 255, 0)
					end
				else
					exports["dxmessages"]:outputDx(player, "  #FF9600[Turf System] #FFFF00Sintaxis: /turfcolor [r] [g] [b]  ", 255, 255, 0)
					exports["dxmessages"]:outputDx(player, "  #FF9600[Turf System] #00FFFFEjemplo: /turfcolor 255 0 0  ", 0, 250, 150)
				end
			else
				exports["dxmessages"]:outputDx(player, "#FF9600[Turf System] #FF0000No tienes permisos para cambiar el color del turf.", 255, 0, 0)
			end
		end
	end
end)

addEvent("guiChangeChatTagColor", true)
addEventHandler("guiChangeChatTagColor",root,
function (Red, Green, Blue)
	local Group = getElementData(source,"Group")
	if Group then
		if doesPlayerHavePermission(source, 13) then
			local color = Red..", "..Green..", "..Blue
			dbExec(db, "UPDATE groups SET tag_color = ? WHERE group_name = ?", color, Group)
			exports["dxmessages"]:outputDx(source, "#FF9600[ClanSystem] "..string.format("#%.2X%.2X%.2X", Red, Green, Blue).."El color del tag ha sido cambiado con éxito.", Red, Green, Blue)
			groupAddNewHistoryLog ( Group, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] ´cambió el color del tag a "..Red.. " , "..Green.." , "..Blue.."") 
		else
			exports["dxmessages"]:outputDx(source, "#FF9600[ClanSystem] #FF0000No tienes permiso para cambiar el color del tag.", 255, 0, 0)
		end
	end
end
)

addEvent("guiChangeTurfColor", true)
addEventHandler("guiChangeTurfColor",getRootElement(),
function (Red, Green, Blue)
	if not turfTimer[source] then
		turfTimer[source] = true
		setTimer(function(source) turfTimer[source] = nil end, 2500, 1, source)
		local Group = getElementData(source,"Group")
		if Group then
			if doesPlayerHavePermission(source, 12) then
				local color = Red..", "..Green..", "..Blue
				dbExec(db, "UPDATE groups SET turf_color = ? WHERE group_name = ?", color, Group)
				exports["dxmessages"]:outputDx(source, "#FF9600[Turf System] "..string.format("#%.2X%.2X%.2X", Red, Green, Blue).."El color del turf ha sido cambiado con éxito.", Red, Green, Blue)
				groupAddNewHistoryLog ( Group, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] cambió el color del turf a "..Red.. " , "..Green.." , "..Blue.."") 
			else
				exports["dxmessages"]:outputDx(source, "#FF9600[Turf System] #FF0000No tienes permiso para cambiar el color del turf.", 255, 0, 0)
			end
		end
	end	
end
)

addEvent("guiChangeChatColor", true)
addEventHandler("guiChangeChatColor",root,
function (Red, Green, Blue)
local Group = getElementData(source,"Group")
	if Group then
		if doesPlayerHavePermission(source, 13) then
			local color = Red..", "..Green..", "..Blue
			dbExec(db, "UPDATE groups SET chat_color = ? WHERE group_name = ?", color, Group)
			exports["dxmessages"]:outputDx(source, "#FF9600[ClanSystem] "..string.format("#%.2X%.2X%.2X", Red, Green, Blue).."El color del chat ha sido cambiado con éxito.", Red, Green, Blue)
			groupAddNewHistoryLog ( Group, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] cambió el color del chat a "..Red.. " , "..Green.." , "..Blue.."") 
		else
			exports["dxmessages"]:outputDx(source, "#FF9600[ClanSystem] #FF0000No tienes permiso para cambiar el color del chat.", 255, 0, 0)
		end
	end
end
)

addEvent("groupMutePlayer", true)
addEventHandler("groupMutePlayer",getRootElement(),
function (Player)
	local mgroup = getElementData(source,"Group")
	local data = data()
	local groupName = getPlayerGroup(source)
	if Player then
		if doesPlayerHavePermission(source, 16) then
		if getGroupFounderAccount(mgroup) == getAccountName(getPlayerAccount(Player)) then exports["dxmessages"]:outputDx(source, "#04B4AE(Group) #FF0000 No puedes mutear al dueño del clan !",255, 0, 0) return end
		if getElementData(Player,"GroupMute") == "True" then
			setElementData(Player,"GroupMute","False")
			groupAddNewHistoryLog ( groupName, "("..getPlayerName( Player )..")["..getAccountName(getPlayerAccount(Player)).."] ha sido muteado por ("..getPlayerName(source)..")["..getAccountName(getPlayerAccount(source)).."]")
			triggerClientEvent("myGroupList", source, getGroupMembers(groupName), data)
			for k, v in ipairs(getElementsByType("player")) do
				if getElementData(v, "Group") == mgroup then
					outputChatBox("#04B4AE(Group) #C80000"..getPlayerName(Player).."#00FF00 ha sido muteado por #C80000"..getPlayerName(source).." .",v , 0,255,0,true)
				end
			end
		else
			setElementData(Player,"GroupMute","True")
			groupAddNewHistoryLog ( mgroup, "("..getPlayerName( Player )..")["..getAccountName(getPlayerAccount(Player)).."] ha sido muteado por ("..getPlayerName(source)..")["..getAccountName(getPlayerAccount(source)).."]") 
			triggerClientEvent( "myGroupList", source, getGroupMembers(groupName), data)
				for k, v in ipairs (getElementsByType("player")) do
					if getElementData(v, "Group") == mgroup then
						outputChatBox("#04B4AE(Group) #C80000"..getPlayerName(Player).."#FF0000 ha sido muteado por #C80000"..getPlayerName(source).." .", v, 0, 255, 0,true)
					end
				end
			end
		end
	end
end
)

function getGroupTurfColor(group)
	if group and IsGroupExists(group) then
		local h = dbQuery(db, "SELECT turf_color FROM groups WHERE group_name = ?", group)
		local result = dbPoll(h, -1)
		return split(result[1]["turf_color"], ',')
	end
end

function getGroupHistoryLog(Group)
	if Group and IsGroupExists(Group) then
		local his = dbQuery(db, "SELECT * FROM group_history WHERE group_name = ?", Group)
		local result = dbPoll(his, -1)
		return result
	end
end

function getGroupChatColor(group)
	if group and IsGroupExists(group) then
		local h = dbQuery(db, "SELECT chat_color FROM groups WHERE group_name = ?", group)
		local result = dbPoll(h, -1)
		return split(result[1]["chat_color"], ',')
	end
end

function getGroupChatTagColor(group)
	if group and IsGroupExists(group) then
		local h = dbQuery(db, "SELECT tag_color FROM groups WHERE group_name = ?", group)
		local result = dbPoll(h, -1)
		return split(result[1]["tag_color"], ',')
	end
end

function getGroupBankBalance(group)
	if group and IsGroupExists(group) then
		local h = dbQuery(db, "SELECT group_bank FROM groups WHERE group_name = ?", group)
		local result = dbPoll(h, -1)
		return result[1]["group_bank"]
	end
end

function getGroupTurfPoints(Group)
	if Group and IsGroupExists(Group) then
		local h = dbQuery(db, "SELECT turf_points FROM groups WHERE group_name = ?", Group)
		local result = dbPoll(h, -1)
		return result[1]["turf_points"]
	end
end

function setGroupTurfPoints(Group, Points)
	if Group and IsGroupExists(Group) then
		dbExec(db, "UPDATE groups SET turf_points = ? WHERE group_name = ?", Points, Group)
	end
end

addEvent("getGroupBalance", true)
addEventHandler("getGroupBalance", root,
function()
	local groupName = getPlayerGroup(source)
	if groupName then
		local balance = getGroupBankBalance(groupName) or 0
		triggerClientEvent(source, "receiveGroupBankBalance", source, balance)
	end
end)

addEvent("DepositMoneyInGroupBank", true)
addEventHandler("DepositMoneyInGroupBank", root,
function(money)
	local groupName = getPlayerGroup(source)
	if money and groupName then
		if doesPlayerHavePermission(source, 10) then
			local balance = getGroupBankBalance(groupName) or 0
			local pMoney = getPlayerMoney(source) or 0
			if balance and pMoney >= money and balance+money > 0 then
				dbExec(db, "UPDATE groups SET group_bank = ? WHERE group_name = ?", balance+money, groupName)
				setPlayerMoney(source, pMoney-money or 0)
				
				groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Deposited $"..money.." Into Group Bank.") 
				for i, player in ipairs(getElementsByType("player")) do
					if getElementData(player, "Group") == groupName then
						outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." #C80000Deposited #00FF00$"..money.." #C80000into group bank.", player, 255, 255, 0, true)
						triggerClientEvent(player, "receiveGroupBankBalance", player, getGroupBankBalance(groupName) or 0)
					end
				end
			else
				exports["dxmessages"]:outputDx(source, "  #04B4AE(ClanSystem) #FF0000No tienes suficiente dinero.  ", 0, 255, 0)
			end
		else
			-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000You don't have permission to deposit money into the group bank.", 255, 0, 0)
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para depositar dinero en el banco del clan.", 255, 0, 0)
		end
	end
end)

addEvent("WithdrawMoneyInGroupBank", true)
addEventHandler("WithdrawMoneyInGroupBank", root,
function(money)
	local groupName = getPlayerGroup(source)
	if money and groupName then
		if doesPlayerHavePermission(source, 11) then
			local balance = getGroupBankBalance(groupName) or 0
			local pMoney = getPlayerMoney(source) or 0
			if balance and balance-money >= 0 then
				dbExec(db, "UPDATE groups SET group_bank = ? WHERE group_name = ?", balance-money, groupName)
				givePlayerMoney(source,money)
				
				groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Withdrawn $"..money.." From Group Bank.") 
				for i, player in ipairs(getElementsByType("player")) do
					if getElementData(player, "Group") == groupName then
						outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." #C80000Withdrawn #00FF00$"..money.." #C80000from group bank.", player, 255, 255, 0, true)
						triggerClientEvent(player, "receiveGroupBankBalance", player, getGroupBankBalance(groupName) or 0)
					end
				end
			else
				-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000Your group doesn't have this amount of money.", 0, 255, 0)
				exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000Tu clan no tiene esta cantidad de dinero.", 0, 255, 0)
			end
		else
			-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000You don't have permission to withdraw money from the group bank.", 255, 0, 0)
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para retirar dinero del banco del clan.", 255, 0, 0)
		end
	end
end)

function getGroupOnlineMember(group)
	local Table = {}
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player, "Group") == group then
			table.insert(Table, player)
		end
	end
	return Table
end

addEvent("GiveAllPlayerMoneyInGroupBank", true)
addEventHandler("GiveAllPlayerMoneyInGroupBank",root,
function (money)
local Group = getElementData(source, "Group")
local members = getGroupOnlineMember(Group)
local balance = getGroupBankBalance(Group) or 0
local amount = math.ceil(money / #members)
	if balance and balance-money >= 0 then
		if doesPlayerHavePermission(source, 15) then
			for k, v in ipairs(members) do
				dbExec(db, "UPDATE groups SET group_bank = ? WHERE group_name = ?", balance-money, Group)
				givePlayerMoney(v,amount)
				-- outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." #C80000Given All Group Members #00FF00$"..amount,v,255,255,0, true)
				outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." #C80000Dio a todos los miembros #00FF00$"..amount,v,255,255,0, true)
				triggerClientEvent("receiveGroupBankBalance", source, getGroupBankBalance(Group) or 0)
			end
			groupAddNewHistoryLog ( Group, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] dio a todos los miembros $"..amount.."") 
		end
	end
end
)

addEvent("guiGiveMemberMoney", true)
addEventHandler("guiGiveMemberMoney",getRootElement(),
function (name2, moneys)
	local name = getPlayerFromName(name2)
	local name4 = getPlayerName(source)
	local Group = getElementData(source, "Group")
	local ItemGroup = getElementData(name, "Group")
	local balance = getGroupBankBalance(Group) or 0
	if Group then
		if doesPlayerHavePermission(source, 17) then
			if Group == ItemGroup then
				if name4 ~= name2 then
					if moneys <= balance then
						if balance and balance-moneys >= 0 then
		
					givePlayerMoney ( name, moneys ) 
							dbExec(db, "UPDATE groups SET group_bank = ? WHERE group_name = ?", balance-moneys, Group)
							groupAddNewHistoryLog ( Group, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Gived ("..name2..")["..getAccountName(getPlayerAccount(name2)).."] $"..moneys) 
							triggerClientEvent("receiveGroupBankBalance", source, balance)
							for k, v in ipairs (getElementsByType("player")) do
								if getElementData(v, "Group") == Group then
									outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).."#C80000 Gived "..name2.." #00FF00$"..moneys,v,255,255,255, true)
								end
							end
						end
					end
				else
					-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000You Can't Give The Money To Yourself !", 255, 0, 0)
					exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes darte dinero a ti mismo !", 255, 0, 0)
				end
			else
				-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000 There's No Player With That Name In The Group.", 255, 0, 0)
				exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000 No existe el jugador con ese nombre en el clan.", 255, 0, 0)
			end
		else
			-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000You don't have permission to Give Group members Money.", 255, 0, 0)
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para dar dinero a los miembros.", 255, 0, 0)
		end
	end
end
)

addEvent("setWarningLevel", true)
addEventHandler("setWarningLevel", root,
function(Account, level, oLevel, Reason)
	local _, rankType = getPlayerGroupRank(source)
	if rankType ~= 1 and getAccountName(getPlayerAccount(source)) == Account then return end
	local groupName = getPlayerGroup(source)
	if groupName then
		if doesPlayerHavePermission(source, 14) then
			if getGroupFounderAccount(groupName) == Account then exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes advertir al dueño del clan !", 255, 0, 255) return end
			dbExec(db, "UPDATE group_members SET WL = ? WHERE group_name = ? AND member_account = ?", level, groupName, Account)
			groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] advirtió a("..getGroupMemberName(Account)..")["..Account.."] ("..oLevel..") ("..Reason..")." )
			local data = data()
			triggerClientEvent(source, "myGroupList", source, getGroupMembers(groupName), data)
			for i, player in ipairs(getElementsByType("player")) do
				if getElementData(player, "Group") == groupName then
					outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." advirtió a "..getGroupMemberName(Account).." ("..oLevel..") ("..Reason..").", player, 255, 255, 0, true)
				end
			end
		else
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para advertir a los miembros.", 255, 0, 0)
		end
	end
end)

addEvent("AddNewRank", true)
addEventHandler("AddNewRank", root,
function(rankName, addAfterRank, permission)
	local groupName = getPlayerGroup(source)
	local _, rankType = getPlayerGroupRank(source)
	if groupName and rankType == 1 then
		local result = dbPoll(dbQuery(db, "SELECT group_rank_name FROM group_ranks WHERE group_name = ? AND group_rank_name = ?", groupName, rankName), -1)
		if type(result) == "table" and #result == 0 then
			local result = dbPoll(dbQuery(db, "SELECT * FROM group_ranks WHERE group_name = ?", groupName), -1)
			if type(result) == "table" and #result ~= 0 then
				dbExec(db, "DELETE FROM group_ranks WHERE group_name = ?", groupName)
				for i, R in pairs(result) do
					dbExec(db, "INSERT INTO group_ranks VALUES(?, ?, ?, ?)", groupName, R["group_rank_name"], R["group_rank_permission"], R["rank_type"])
					if R["group_rank_name"] == addAfterRank then
						dbExec(db, "INSERT INTO group_ranks VALUES(?, ?, ?, ?)", groupName, rankName, permission, 3)
						exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00Rango #FFFF00"..rankName.." #00FF00agregado con éxito!", 0, 255, 0)
						groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] agregó el rango ("..rankName..")")
					end
				end
				for i, player in ipairs(getElementsByType("player")) do
					if getElementData(player, "Group") == groupName then
						setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
					end
				end
			end
		end
	end
end)
				
addEvent("RemoveRank", true)
addEventHandler("RemoveRank", root,
function(rankName)
	local groupName = getPlayerGroup(source)
	local _, rankType = getPlayerGroupRank(source)
	if groupName and rankType == 1 then
		local result = dbPoll(dbQuery(db, "SELECT rank_type FROM group_ranks WHERE group_name = ? AND group_rank_name = ?", groupName, rankName), -1)
		if type(result) == "table" and #result ~= 0 then
			if result[1]["rank_type"] == 3 then
				local result = dbPoll(dbQuery(db, "SELECT group_rank_name FROM group_ranks WHERE group_name = ?", groupName), -1)
				if type(result) == "table" and #result ~= 0 then
					for i, R in pairs(result) do
						if R["group_rank_name"] == rankName then
							dbExec(db, "UPDATE group_members SET member_rank = ? WHERE group_name = ? AND member_rank = ?", result[i-1]["group_rank_name"], groupName, rankName)
						end
					end
				end
				dbExec(db, "DELETE FROM group_ranks WHERE group_name = ? AND group_rank_name = ?", groupName, rankName)
				-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FFFF00"..rankName.." #00FF00Rank Removed successfully!", 0, 255, 0)
				exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00Rango #FFFF00"..rankName.." #00FF00eliminado con éxito!", 0, 255, 0)
				groupAddNewHistoryLog(groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] eliminó el rango ("..rankName..").")
				for i, player in ipairs(getElementsByType("player")) do
					if getElementData(player, "Group") == groupName then
						setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
					end
				end
			else
				exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000Este rango no puede ser eliminado.", 255, 40, 0)
			end
		end
	end
end)

addEvent("EditRank", true)
addEventHandler("EditRank", root,
function(rankName, newRankName, permission)
	local groupName = getPlayerGroup(source)
	local _, rankType = getPlayerGroupRank(source)
	if groupName and rankType == 1 then
		dbExec(db, "UPDATE group_ranks SET group_rank_permission = ? WHERE group_name = ? AND group_rank_name = ?", permission, groupName, rankName)
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FFFF00"..rankName.." #00FF00rank updated successfully!", 0, 255, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00Rango #FFFF00"..rankName.." #00FF00actualizado con éxito!", 0, 255, 0)
		groupAddNewHistoryLog(groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] actualizó el rango ("..rankName..")")
		if rankName ~= newRankName then
			-- groupAddNewHistoryLog(groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Changed The Rank Name From ("..rankName..") To ("..newRankName..")")
			groupAddNewHistoryLog(groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] cambió el rango ("..rankName..") a ("..newRankName..")")
		end
		local result = dbPoll(dbQuery(db, "SELECT group_rank_name FROM group_ranks WHERE group_name = ? AND group_rank_name = ?", groupName, newRankName), -1)
		if type(result) == "table" and #result == 0 then
			dbExec(db, "UPDATE group_ranks SET group_rank_name = ? WHERE group_name = ? AND group_rank_name = ?", newRankName, groupName, rankName)
			dbExec(db, "UPDATE group_members SET member_rank = ? WHERE group_name = ? AND member_rank = ?", newRankName, groupName, rankName)
		end
		for i, player in ipairs(getElementsByType("player")) do
			if getElementData(player, "Group") == groupName then
				setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
			end
		end
	end
end)

function IsGroupExists(name)
	local h = dbQuery(db, "SELECT * FROM group_members WHERE group_name = ?", name)
	local result = dbPoll(h, -1)
	if type(result) == "table" and #result ~= 0 and tostring(result[1]["group_name"]) == tostring(name) then
		return true
	end
end

addEventHandler("onPlayerLogin", root,
function(_, accountName)
	local groupName = getPlayerGroup(source)
	if groupName then
		local data = data()
		dbExec(db, "UPDATE group_members SET member_name = ?, member_status = ?, last_online = ? WHERE group_name = ? AND member_account = ?", getPlayerName(source), "Yes", data, groupName, getAccountName(accountName))
		setElementData(source, "Group", groupName)
		setElementData(source, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(source)})
	else
		setElementData(source, "Group", false)
		setElementData(source, "GroupRank", false)
	end
end)

function getGroupRanks(groupName)
	local Rank = dbPoll(dbQuery(db, "SELECT * FROM group_ranks WHERE group_name = ?", groupName), -1)
	if type(Rank) == "table" and #Rank ~= 0 then
		return Rank
	end
end

function getPlayerGroupRank(player)
	local groupName = getPlayerGroup(player)
	if groupName then
		local Rank = dbPoll(dbQuery(db, "SELECT member_rank FROM group_members WHERE group_name = ? AND member_account = ?", groupName, getAccountName(getPlayerAccount(player))), -1)
		if type(Rank) == "table" and #Rank ~= 0 then
			local tt = dbPoll(dbQuery(db, "SELECT rank_type FROM group_ranks WHERE group_name = ? AND group_rank_name = ?", groupName, Rank[1]["member_rank"]), -1)
			return Rank[1]["member_rank"], tt[1]["rank_type"]
		end
	end
end

function doesPlayerHavePermission(player, permission)
	permission = tonumber(permission)
	local groupName = getPlayerGroup(player)
	if groupName then
		local Rank = dbPoll(dbQuery(db, "SELECT member_rank FROM group_members WHERE group_name = ? AND member_account = ?", groupName, getAccountName(getPlayerAccount(player))), -1)
		if type(Rank) == "table" and #Rank ~= 0 then
			local Permission = dbPoll(dbQuery(db, "SELECT group_rank_permission FROM group_ranks WHERE group_name = ? AND group_rank_name = ?", groupName, Rank[1]["member_rank"]), -1)
			local pre = split(Permission[1]["group_rank_permission"], ',')
			if type(pre) == "table" then
				for i, p in ipairs(pre) do
					if tonumber(p) == permission then return true
					end
				end
			end
		end
	end
end

function getPlayerGroup(player)
	local h = dbQuery(db, "SELECT group_name FROM group_members WHERE member_account = ?", getAccountName(getPlayerAccount(player)))
	local result = dbPoll(h, -1)
	if type(result) == "table" and #result ~= 0 and result[1]["group_name"] then
		return tostring(result[1]["group_name"])
	end
end

function addMemberToGroup(player, groupName)
	local accountss = getAccountName(getPlayerAccount(player))
	local serialsv = getPlayerSerial(player)
	if IsGroupExists(groupName) and not getPlayerGroup(player) then
		if not isAccountBlocked(groupName, accountss) and not isSerialBlocked(groupName, serialsv) then
			local h = dbQuery(db, "SELECT group_members FROM groups WHERE group_name = ?", groupName)
			local result = dbPoll(h, -1)
			local cont = result[1]["group_members"] + 1
			local data = data()
			local playerName = getPlayerName(player)
			local accountName = getAccountName(getPlayerAccount(player))
			dbExec(db, "INSERT INTO group_members VALUES(?, ?, ?, ?, ?, ?, ?)", groupName, accountName, playerName, "Yes", getGroupRanks(groupName)[1]["group_rank_name"], data, 0)
			dbExec(db, "UPDATE groups SET group_members = ? WHERE group_name = ?", cont, groupName)
			dbExec(db, "DELETE FROM group_invite WHERE player_account = ?", accountName)
			setElementData(player, "Group", groupName)
			setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
			triggerClientEvent(player, "Send_Invite_List", player, getPlayerInviteGroupList(player))
			groupAddNewHistoryLog ( groupName, "("..getPlayerName( player )..")["..getAccountName(getPlayerAccount(player)).."] Joined The Group.")
			for _,v in ipairs(getElementsByType("player")) do
				if getElementData(v, "Group") == groupName then
					outputChatBox("* #04B4AE(Group) #DF7401"..getPlayerName(player).." #FF0000joined the Group.", v, 255, 255, 0, true)
				end
			end
		else
			outputChatBox("#04B4AE(Group) #FF0000 You Can't Join Because You Are Blocked", player, 255, 0, 0, true)
		end
	end
end

function removeMemberFromGroup(player)
	local groupName = getPlayerGroup(player)
	if groupName then
		local RankName, rankType = getPlayerGroupRank(source)
		if rankType ~= 1 then
			local result = dbPoll(dbQuery(db, "SELECT group_members FROM groups WHERE group_name = ?", groupName), -1)
			local cont = result[1]["group_members"] - 1
			dbExec(db, "DELETE FROM group_members WHERE member_account = ?", getAccountName(getPlayerAccount(player)))
			dbExec(db, "UPDATE groups SET group_members = ? WHERE group_name = ?", cont, groupName)
			setElementData(player, "Group", false)
			groupAddNewHistoryLog ( groupName, "("..getPlayerName( player )..")["..getAccountName(getPlayerAccount(player)).."] abandonó el grupo.")
			if getElementData(player, "GroupMute") == "True" then
				setElementData(player, "GroupMute", "False")
			end
		elseif rankType == 1 then
			local result = dbPoll(dbQuery(db, "SELECT member_rank FROM group_members WHERE group_name = ? AND member_rank = ?", groupName, RankName), -1)
			if type(result) == "table" and #result == 1 then
				-- exports["dxmessages"]:outputDx(player, "#04B4AE(ClanSystem) #FF0000You can not leave the group because you are the only one with "..RankName.." rank.", 255, 40, 0)
				exports["dxmessages"]:outputDx(player, "#04B4AE(ClanSystem) #FF0000No puedes abandonar el clan porque eres el único de rango "..RankName, 255, 40, 0)
			else
				local result = dbPoll(dbQuery(db, "SELECT group_members FROM groups WHERE group_name = ?", groupName), -1)
				local cont = result[1]["group_members"] - 1
				dbExec(db, "DELETE FROM group_members WHERE member_account = ?", getAccountName(getPlayerAccount(player)))
				dbExec(db, "UPDATE groups SET group_members = ? WHERE group_name = ?", cont, groupName)
				setElementData(player, "Group", false)
				setElementData(player, "GroupRank", false)
			if getElementData(player, "GroupMute") == "True" then
				setElementData(player, "GroupMute", "False")
			end
			end
		end
		if getElementData(player, "Group") then return end
		for _,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "Group") == groupName then
				outputChatBox("* #04B4AE(Group) #DF7401"..getPlayerName(player).." #FF0000left the Group.",v,255,255,0,true)
			end
		end
	end
end

function setGroupInfo(player, name, Texts)
	if IsGroupExists(name) and doesPlayerHavePermission(player, 5) then
		local Text = Texts.." Updated by "..getAccountName(getPlayerAccount(player)).."\n"
		dbExec(db, "UPDATE groups SET group_info = ? WHERE group_name = ?", Text, name)
		dbExec(db, "UPDATE groups SET group_members = ? WHERE group_name = ?", cont, groupName)
		groupAddNewHistoryLog ( name, "("..getPlayerName( player )..")["..getAccountName(getPlayerAccount(player)).."] Has Update The Group Information.")
		triggerClientEvent(player, "Send_Group_Info", player, getGroupInfo(name))
		for _,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "Group") == name then
				outputChatBox("* #04B4AE(Group) #DF7401"..getPlayerName(player).." #00FF00has update the Group Information.", v, 0, 255, 0, true)
			end
		end
	end
end

function getGroupInfo(name)
	if IsGroupExists(name) then
		local h = dbQuery(db, "SELECT group_info FROM groups WHERE group_name = ?", name)
		local result = dbPoll(h, -1)
		return tostring(result[1]["group_info"])
	end
end

function getGroupMembers(name)
	local M = dbQuery(db, "SELECT * FROM group_members WHERE group_name = ?", name)
	local resM = dbPoll(M, -1)
	if type(resM) == "table" and #resM ~= 0  then
		return resM
	end
end

function getGroupMemberName(account)
	local h = dbQuery(db, "SELECT member_name FROM group_members WHERE member_account = ?", account)
	local result = dbPoll(h, -1)
	if type(result) == "table" and #result ~= 0 then
		return tostring(result[1]["member_name"])
	end
end

function isGroupMemberExists(Group, Member)
	local h = dbQuery(db, "SELECT member_account FROM group_members WHERE group_name = ?", Group)
	local result = dbPoll(h, -1)
	if type(result) == "table" and #result ~= 0 then
		return result[1]["member_account"]
	end
end

function GroupBlockAccount(Group, by, account, Reason)
	if IsGroupExists(Group) then
		local time = getRealTime()
		local year = time.year + 1900
		local month = time.month + 1
		local day = time.monthday
		local hour = time.hour
		local minute = time.minute
		if isAccountBlocked(Group, account) then
			-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000The Account Is Already Blocked.",255,255,0)
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000La cuenta ya está bloqueada.",255,255,0)
		else
			dbExec(db, "INSERT INTO group_blackaccount VALUES (?, ?, ?, ?, ?)", Group, tostring(by), tostring(account),tostring(Reason),"[" .. hour ..":" .. minute .."][" .. month .."/" .. day .."/" .. year .."]")
			-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00The Account Was Blocked Successfully.",255,255,0)
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00La cuenta ha sido bloqueada con éxito.",255,255,0)
		end
	end
end

function GroupUnBlockAccount(Group, BannedAccount)
	if IsGroupExists(Group) then
		dbExec(db, "DELETE FROM group_blackaccount WHERE group_name = ? AND account_name = ?", Group, tostring(BannedAccount))
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00La cuenta ha sido desbloqueada con éxito.",255,255,0)
	end
end

function GroupBlockSerial(Group, by, serial, Reason)
	if IsGroupExists(Group) then
		local time = getRealTime()
		local year = time.year + 1900
		local month = time.month + 1
		local day = time.monthday
		local hour = time.hour
		local minute = time.minute
		if isSerialBlocked(Group, serial) then
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000El serial ya está bloqueado.",255,255,0)
		else
			dbExec(db, "INSERT INTO group_blackserial VALUES (?, ?, ?, ?, ?)", Group, tostring(by), tostring(serial),tostring(Reason),"[" .. hour ..":" .. minute .."][" .. month .."/" .. day .."/" .. year .."]")
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00El serial ha sido bloqueado con éxito.",255,255,0)
		end
	end
end

function GroupUnBlockSerial(Group, BannedSerial)
	if IsGroupExists(Group) then
		dbExec(db, "DELETE FROM group_blackserial WHERE group_name = ? AND serial = ?", Group, BannedSerial)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00El serial ha sido desbloqueado con éxito.",255,255,0)
	end
end

function isAccountBlocked(Group, Account)
	local result = dbQuery(db, "SELECT * FROM group_blackaccount WHERE group_name = ? AND account_name = ?", Group, Account)
	local result2 = dbPoll(result, -1)
	if result2 and type(result2) == "table" and #result2 ~= 0 then
		return result2
	end
end

function isSerialBlocked(Group, Serial)
	local result = dbQuery(db, "SELECT * FROM group_blackserial WHERE group_name = ? AND serial = ?", Group, Serial)
	local result2 = dbPoll(result, -1)
	if result2 and type(result2) == "table" and #result2 ~= 0 then
		return result2
	end
end

function getGroupBlockedAccounts(Group)
	if IsGroupExists(Group) then
		local h = dbQuery(db, "SELECT * FROM group_blackaccount WHERE group_name = ?", Group)
		local result = dbPoll(h, -1)
		return result
	end
end

addEvent("Request_Group_BlackList", true)
addEventHandler("Request_Group_BlackList",root,
function ()
	local mygroup = getPlayerGroup(source)
	local accountstable = getGroupBlockedAccounts(mygroup)
	local serialstable = getGroupBlockedSerials(mygroup)
	triggerClientEvent("Set_Group_BlackList", source, accountstable)
	triggerClientEvent("Set_Group_BlackListSerial", source, serialstable)
end
)

addEvent("Group_Block_Account", true)
addEventHandler("Group_Block_Account", root, 
function (Account, Reason)
	if doesPlayerHavePermission(source, 20) then
		if getAccountName(getPlayerAccount(source)) == Account then exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes bloquearte a ti mismo.!", 255, 0, 0) return end
		local Group = getPlayerGroup(source)
		if Reason == "Reason" or Reason == "" or Reason == " " then
			Reason = "No Reason"
		end
		GroupBlockAccount(Group, getPlayerName(source).."["..getAccountName(getPlayerAccount(source)).."]", Account, Reason)
		local accountstable = getGroupBlockedAccounts(Group)
		triggerClientEvent("Set_Group_BlackList", source, accountstable)
	end
end
)

addEvent("Group_Block_Serial", true)
addEventHandler("Group_Block_Serial", root, 
function (Serial, Reason)
	if doesPlayerHavePermission(source, 21) then
		if getPlayerSerial(source) == Serial then exports["dxmessages"]:outputDx(source, "* #04B4AE(ClanSystem) #FF0000No puedes bloquearte a ti mismo.!", 255, 0, 0) return end
		local Group = getPlayerGroup(source)
		if Reason == "Reason" or Reason == "" or Reason == " " then
			Reason = "No Reason"
		end
		GroupBlockSerial(Group, getPlayerName(source).."["..getAccountName(getPlayerAccount(source)).."]", Serial, Reason)
		local serialstable = getGroupBlockedSerials(Group)
		local Account = getAccountsBySerial(Serial)
		triggerClientEvent("Set_Group_BlackListSerial", source, serialstable)
	end
end
)

addEvent("Group_Unblock_Account", true)
addEventHandler("Group_Unblock_Account", root, 
function (Account)
	if doesPlayerHavePermission(source, 22) then
		local Group = getPlayerGroup(source)
		GroupUnBlockAccount(Group, Account)
		local accountstable = getGroupBlockedAccounts(Group)
		triggerClientEvent("Set_Group_BlackList", source, accountstable)
	end
end
)

addEvent("Group_UnBlock_Serial", true)
addEventHandler("Group_UnBlock_Serial", root, 
function (Account)
	if doesPlayerHavePermission(source, 23) then
		local Group = getPlayerGroup(source)
		GroupUnBlockSerial(Group, Account)	
		local serialstable = getGroupBlockedSerials(Group)
		triggerClientEvent("Set_Group_BlackListSerial", source, serialstable)
	end
end
)

function getGroupBlockedSerials(Group)
	if IsGroupExists(Group) then 
		local h = dbQuery(db, "SELECT * FROM group_blackserial WHERE group_name = ?", Group)
		local result = dbPoll(h, -1)
		return result
	end
end

function groupAddNewHistoryLog(Group, Event)
	if IsGroupExists(Group) then
		local time = getRealTime()
		local year = time.year + 1900
		local month = time.month + 1
		local day = time.monthday
		local hour = time.hour
		local minute = time.minute
		dbExec(db, "INSERT INTO group_history VALUES (?, ?, ?)", Group, tostring(Event), "[" .. hour ..":" .. minute .."][" .. month .."/" .. day .."/" .. year .."]")		
	end
end

function InvitePlayerToGroup(name,player,by)
	if isGuestAccount(getPlayerAccount(player)) then outputChatBox("* #04B4AE(ClanSystem) #FF0000You Can Invite #DF7401"..getPlayerName(player).." #FF0000 Because He Is Not Logged In Yet.", by, 0, 255, 0, true) return end
	local result = dbPoll(dbQuery(db, "SELECT * FROM group_invite WHERE group_name = ? AND player_account = ?", name, getAccountName(getPlayerAccount(player))), -1)
	local PAccount = getAccountName(getPlayerAccount(player))
	local groupnames = getPlayerGroup(by)
	local PSerial = getPlayerSerial(player)
	if type(result) == "table" and #result == 0 or not result and IsGroupExists(name) and not getPlayerGroup(player) then
		local totalMember, limit = getGroupMemberLimit(name)
		if totalMember < limit then
			if not isAccountBlocked(groupnames, PAccount) then 
				if not isSerialBlocked(groupnames, PSerial) then
					outputChatBox("* #04B4AE(ClanSystem) #FF0000You Invite #DF7401"..getPlayerName(player)..".", by, 0, 255, 0, true)
					outputChatBox("* #04B4AE(ClanSystem) #FF0000You have Invited to Join Group #DF7401("..name..") #FF0000by #DF7401"..getPlayerName(by)..".", player, 0, 255, 0, true)
					playSoundFrontEnd(player, 40)
					dbExec(db, "INSERT INTO group_invite VALUES(?, ?, ?)", name, getAccountName(getPlayerAccount(player)), getPlayerName(by).." ("..getAccountName(getPlayerAccount(by))..")")
					groupAddNewHistoryLog ( name, "("..getPlayerName( player )..")["..getAccountName(getPlayerAccount(player)).."] Was Invited To The Group By ("..getPlayerName(by)..")["..getAccountName(getPlayerAccount(by)).."]")
				else
					outputChatBox("* #04B4AE(ClanSystem) #FF0000You Can't Invite This Player Cause Of Block.", by, 255, 0, 0, true)
				end
			else
				outputChatBox("* #04B4AE(ClanSystem) #FF0000You Can't Invite This Player Cause Of Block.", by, 255, 0, 0, true)
			end
		else
			outputChatBox("* #04B4AE(ClanSystem) #FF0000You can't Invite because the group is full.", by, 255, 0, 0, true)
		end
	end
end

function getPlayerInviteGroupList(player)
	local h = dbQuery(db, "SELECT * FROM group_invite WHERE player_account = ?", getAccountName(getPlayerAccount(player)))
	local result = dbPoll(h, -1)
	if type(result) == "table" and #result ~= 0 then
		return result
	end
end

function getGroupMemberLimit(name)
	local result = dbPoll(dbQuery(db, "SELECT group_members,members_limit FROM groups WHERE group_name = ?", name), -1)
	if type(result) == "table" and #result ~= 0 then
		return tonumber(result[1]["group_members"]), tonumber(result[1]["members_limit"])
	end
end

addEvent("Send_Groups_List", true)
addEventHandler("Send_Groups_List", root,
function()
	local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, group_owner FROM groups"), -1)
	if type(result) == "table" then
		triggerClientEvent(source, "GroupList", source, result)
	end
end
)
function getGroups()
	local h = dbQuery(db, "SELECT group_name FROM groups")
	local result = dbPoll(h, -1)
	if result and type(result) == "table" then
		return result
	end
end

function getGroupKillPoints(Group)
	if Group and IsGroupExists(Group) then
		local h = dbQuery(db, "SELECT kill_points FROM groups WHERE group_name = ?", Group)
		local result = dbPoll(h, -1)
		if result and type(result) == 'table' then
			return result
		end
	end
end

function setGroupKillPoints(Group, Points)
	if Group and Points and IsGroupExists(Group) then
		local h = dbExec(db, "UPDATE groups SET kill_points = ? WHERE group_name = ?", Points, Group)
	end
end

addEvent("Request_Top_Kill", true)
addEventHandler("Request_Top_Kill", root,
function ()
	local killtable = {}
	for index, groups in pairs(getGroups()) do
		local kills = getGroupKillPoints(groups.group_name) or 0
		if kills and kills >= 100 then 
			table.insert(killtable, {groups.group_name, getGroupKillPoints(groups.group_name)})
		end
	end
	triggerClientEvent(source, "Set_Top_Kills", source, killtable)
end
)

addEvent("Request_Top_Bank", true)
addEventHandler("Request_Top_Bank", root,
function ()
	local banktable = {}
	for index, groups in pairs(getGroups()) do
		local balance = getGroupBankBalance(groups.group_name)
		if balance and balance > 10000 then
			table.insert(banktable, {groups.group_name, getGroupBankBalance(groups.group_name)})
		end
	end
	triggerClientEvent(source, "Set_Top_Bank", source, banktable)
end
)

addEvent("Request_Top_Turf", true)
addEventHandler("Request_Top_Turf", root,
function ()
	local topTable = {}
	for index, groups in pairs(getGroups()) do
		local turfpoints = getGroupTurfPoints(groups.group_name)
		if turfpoints and turfpoints >= 0.5 then
			table.insert(topTable, {groups.group_name, getGroupTurfPoints(groups.group_name)})
		end
	end
	triggerClientEvent(source, "Set_Top_Turf", source, topTable)
end
)

addEvent("Invite_Player", true)
addEventHandler("Invite_Player", root,
function(name, invited)
	InvitePlayerToGroup(name, invited, source)
end)

addEvent("Request_Invite_List", true)
addEventHandler("Request_Invite_List", root,
function()
	triggerClientEvent(source, "Send_Invite_List", source, getPlayerInviteGroupList(source))
end)

addEvent("Request_Group_Info", true)
addEventHandler("Request_Group_Info", root,
function(name)
	triggerClientEvent(source, "Send_Group_Info", source, getGroupInfo(name))
end)

addEvent("History_Remove_Event", true)
addEventHandler("History_Remove_Event", root,
function (theLogID, theLogTime)
	if doesPlayerHavePermission(source, 18) then
		dbExec(db, "DELETE FROM group_history WHERE group_name = ? AND groupaction = ? AND thetime = ? ", getPlayerGroup(source), theLogID, theLogTime)
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00The Event Was Deleted Successfully", 255, 255, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00El evento ha sido eliminado con éxito", 255, 255, 0)
		local Name = getPlayerGroup(source)
		local MyGroupHistory = getGroupHistoryLog( Name )
		triggerClientEvent("Set_Group_History", source, MyGroupHistory)
	else
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000You Don't Have The Permission To Delete A Event.", 255, 255, 0)		
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para eliminar eventos.", 255, 255, 0)		
	end
end
)

addEvent("Show_Manager_History", true)
addEventHandler("Show_Manager_History", root,
function (GroupName)
	local MyGroupHistory = getGroupHistoryLog(GroupName)
	triggerClientEvent("SetManagerGroupHistory", source, MyGroupHistory)
end
)

addEvent("Request_myGroup_MembersList", true)
addEventHandler("Request_myGroup_MembersList", root,
function(name)
	local data = data()
	local member = getGroupMembers(name)
	return triggerClientEvent(source, "myGroupList", source, member, data)
end)

addEventHandler("onPlayerChangeNick", root,
function(_,new)
	local groupName = getPlayerGroup(source)
	if groupName then
		local data = data()
		dbExec(db, "UPDATE group_members SET member_name = ?, member_status = ?, last_online = ? WHERE group_name = ? AND member_account = ?", new, "Yes", data, groupName, getAccountName(getPlayerAccount(source)))
	end
end)

addEventHandler("onPlayerLogout", root,
function(acc)
	local groupName = getElementData(source, "Group")
	if groupName then
		local data = data()
		dbExec(db, "UPDATE group_members SET member_name = ?, member_status = ?, last_online = ? WHERE group_name = ? AND member_account = ?", getPlayerName(source), "No", data, groupName, getAccountName(acc))
		setElementData(source, "Group", false)
		setElementData(source, "GroupRank", false)
	end
end)

addEventHandler("onPlayerQuit", root,
function()
	local groupName = getPlayerGroup(source)
	if groupName then
		local data = data()
		dbExec(db, "UPDATE group_members SET member_name = ?, member_status = ?, last_online = ? WHERE group_name = ? AND member_account = ?", getPlayerName(source), "No", data, groupName, getAccountName(getPlayerAccount(source)))
	end
end)

addEvent("update_Group_Info", true)
addEventHandler("update_Group_Info", root,
function(name,Text)
	setGroupInfo(source, name, Text)
end)

addEvent("Accept_Invite", true)
addEventHandler("Accept_Invite", root,
function(group)
	local totalMember, limit = getGroupMemberLimit(group)
	if totalMember < limit then
		addMemberToGroup(source,group)
	else
		outputChatBox("* #04B4AE(ClanSystem) #FF0000Unable to accept the invite, The Group is Full !!!",source,255,0,0,true)
	end
end)

addEvent("Reject_Invite", true)
addEventHandler("Reject_Invite", root,
function(groupName)
	dbExec(db, "DELETE FROM group_invite WHERE group_name = ? AND player_account = ?", groupName, getAccountName(getPlayerAccount(source)))
	triggerClientEvent(source, "Send_Invite_List", source, getPlayerInviteGroupList(source))
end)

addEvent("Leave_Group", true)
addEventHandler("Leave_Group", root,
function()
	if getPlayerGroup(source) then
		removeMemberFromGroup(source)
	end
end)

addEvent("Leader_Group_Delete", true)
addEventHandler("Leader_Group_Delete", root,
function (GroupName, AccountName, AccountPassword)
	if not doesPlayerHavePermission(source, 7) then
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000You don't have permission to delete the group.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para eliminar el clan.", 255, 0, 0)
	elseif not IsGroupExists(GroupName) then
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000The #DF7401Group Name #FF0000doesn't exist.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000El #FFFFFFnombre del clan #FF0000no existe.", 255, 0, 0)
	elseif not getAccount(AccountName) then
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000The #DF7401Account Name #FF0000doesn't exist.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000La #FFFFFFnombre de la cuenta #FF0000no existe.", 255, 0, 0)
	elseif not getAccount(AccountName, AccountPassword) then
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000The #DF7401Account Name #FF0000and #DF7401Password #FF0000doesn't match.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000La #FFFFFFCuenta #FF0000and #FFFFFFContraseña #FF0000no coinciden.", 255, 0, 0)
	elseif getElementData(source, "Group") ~= GroupName then
		-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000The #DF7401Group Name #FF0000doesn't match.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #ff0000El clan #FF0000no coincide.", 255, 0, 0)
	else
		for i, player in ipairs(getElementsByType("player")) do
			if getElementData(player, "Group") == GroupName then
				dbExec(db, "DELETE FROM groups WHERE group_name = ?", GroupName)
				dbExec(db, "DELETE FROM group_ranks WHERE group_name = ?", GroupName)
				dbExec(db, "DELETE FROM group_members WHERE group_name = ?", GroupName)
				dbExec(db, "DELETE FROM group_invite WHERE group_name = ?", GroupName)
				dbExec(db, "DELETE FROM group_history WHERE group_name = ?", GroupName)
				dbExec(db, "DELETE FROM group_blackaccount WHERE group_name = ?", GroupName)
				dbExec(db, "DELETE FROM group_blackserial WHERE group_name = ?", GroupName)
				outputChatBox("#04B4AE(Group) #DF7401"..getPlayerName(source).." #FF0000has decided to DELETE the group.", player, 255, 255, 255, true)
				setElementData(player, "Group", false)
				setElementData(player, "GroupRank", false)
				setElementData(player, "GroupMute", "False")		
			end
		end
	end
end
)

function getGroupFounderAccount(group)
	if group and IsGroupExists(group) then
		local h = dbQuery(db, "SELECT group_owner FROM groups WHERE group_name = ?", group)
		local result = dbPoll(h, -1)
		return result[1]["group_owner"]
	end
end

addEvent("Promote_Demote", true)
addEventHandler("Promote_Demote", root,
function(cmd, Account, newRankName, currentRankName, Reason)
	local groupName = getPlayerGroup(source)
	local accountName = getAccountName(getPlayerAccount(source))
	local player = getAccountPlayer(getAccount(Account))
	local data = data()
	local founderaccount = getGroupFounderAccount(groupName)
	if cmd == "Promote" and groupName then
		if doesPlayerHavePermission(source, 2) then
			if accountName == Account then
				exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes promoverte a ti mismo.", 255, 0, 0)
			else
				dbExec(db, "UPDATE group_members SET member_rank = ? WHERE group_name = ? AND member_rank = ? AND member_account = ?", newRankName, groupName, currentRankName, Account)
				groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Promoted ("..getGroupMemberName(Account)..")["..Account.."] From ("..currentRankName..") To ("..newRankName..")("..Reason..")")
				triggerClientEvent(source, "myGroupList", source, getGroupMembers(groupName), data)
				for i, player in ipairs(getElementsByType("player")) do
					if getElementData(player, "Group") == groupName then
						outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." promoted "..getGroupMemberName(Account).." to "..newRankName.." ("..Reason..").", player, 255, 255, 0, true)
					end
				end
				if player then
					setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
				end
			end
		else
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para promover miembros.", 255, 0, 0)
		end
	elseif cmd == "Demote" and groupName then
		if doesPlayerHavePermission(source, 1) then
			if accountName == Account then
				exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes degradarte a ti mismo.", 255, 0, 0)
			elseif newRankName == "Kick this player" then
				-- if founderaccount == Account then exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000 You Can't Kick The Group Owner", 255, 0, 0) return end
				if founderaccount == Account then exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes expulsar al dueño del clan ", 255, 0, 0) return end
				if doesPlayerHavePermission(source, 3) then
					for i, player in ipairs(getElementsByType("player")) do
						if getElementData(player, "Group") == groupName then
							outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." Kicked "..getGroupMemberName(Account).." from the group ("..Reason..").", player, 255, 255, 0, true)
							outputChatBox("* #04B4AE(Group) #DF7401"..getGroupMemberName(Account).." #FF0000left the Group.", player, 255, 255, 0, true)
						end
					end
					local result = dbPoll(dbQuery(db, "SELECT group_members FROM groups WHERE group_name = ?", groupName), -1)
					dbExec(db, "DELETE FROM group_members WHERE member_account = ? AND group_name = ?", Account, groupName)
					dbExec(db, "UPDATE groups SET group_members = ? WHERE group_name = ?", result[1]["group_members"] - 1, groupName)
					triggerClientEvent(source, "myGroupList", source, getGroupMembers(groupName), data)
					if player then
						setElementData(player, "Group", false)
						setElementData(player, "GroupRank", false)
					end
					groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Kicked ("..getGroupMemberName(Account)..")["..Account.."] From The Group ("..Reason..")")
				else
					exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para expulsar miembros.", 255, 0, 0)
				end
			else
				-- if founderaccount == Account then exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000 You Can't Demote The Group Owner", 255, 0, 0) return end
				if founderaccount == Account then exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No puedes degradar al dueño del clan", 255, 0, 0) return end
				dbExec(db, "UPDATE group_members SET member_rank = ? WHERE group_name = ? AND member_rank = ? AND member_account = ?", newRankName, groupName, currentRankName, Account)
				groupAddNewHistoryLog ( groupName, "("..getPlayerName( source )..")["..getAccountName(getPlayerAccount(source)).."] Demoted ("..getGroupMemberName(Account)..")["..Account.."] From ("..currentRankName..") To ("..newRankName..")("..Reason..")")
				triggerClientEvent(source, "myGroupList", source, getGroupMembers(groupName), data)
				for i, player in ipairs(getElementsByType("player")) do
					if getElementData(player, "Group") == groupName then
						outputChatBox("* #04B4AE(Group) #C80000"..getPlayerName(source).." demoted "..getGroupMemberName(Account).." to "..newRankName.." ("..Reason..").", player, 255, 255, 0, true)
					end
				end
				if player then
					setElementData(player, "GroupRank", {getGroupRanks(groupName), getPlayerGroupRank(player)})
				end
			end
		else
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000No tienes permiso para degradar miembros.", 255, 0, 0)
		end
		
	end
end)


addCommandHandler("grpm",
function(player)
	local serial = getPlayerSerial(player)
	if isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(player)),aclGetGroup("Console")) then  
		local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
		if type(result) == "table" then
			triggerClientEvent(player, "OpenGroupManager", player, result)
		end
	end
end)

addEvent("setGroupMemberLimit", true)
addEventHandler("setGroupMemberLimit", root,
function(name, NewLimit)
	if IsGroupExists(name) then
		local CurrentMember = getGroupMemberLimit(name)
		if CurrentMember <= tonumber(NewLimit) then
			dbExec(db, "UPDATE groups SET members_limit = ? WHERE group_name = ?", NewLimit, name)
			local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
			triggerClientEvent(source, "OpenGroupManager", source, result, true)
		else
			-- exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000You Can't lower The #DF7401Group Limit #FF0000less than the #DF7401Current Members.", 255, 0, 0)
			exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000No puedes reducir el limite de jugadores menor a los actuales.", 255, 0, 0)
		end
	else
		exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000El #FFFFFFnombre del clan #FF0000no existe.", 255, 0, 0)
	end
end)


addEvent("set_Group_M_Turf_Points", true)
addEventHandler("set_Group_M_Turf_Points", root,
function (GroupName, points)
	if IsGroupExists(GroupName) then
		if string.find (points, "-") then
			dbExec(db, "UPDATE groups SET turf_points = ? WHERE group_name = ?", getGroupTurfPoints(GroupName)-tonumber(points), GroupName)
			local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
			triggerClientEvent(source, "OpenGroupManager", source, result, true)
		elseif string.find (points, "+") then
			dbExec(db, "UPDATE groups SET turf_points = ? WHERE group_name = ?", getGroupTurfPoints(GroupName)+tonumber(points), GroupName)
			local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
			triggerClientEvent(source, "OpenGroupManager", source, result, true)
		else
			dbExec(db, "UPDATE groups SET turf_points = ? WHERE group_name = ?", tonumber(points), GroupName)
			local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
			triggerClientEvent(source, "OpenGroupManager", source, result, true)
		end
	end
end
)

addEvent("setGroupName", true)
addEventHandler("setGroupName", root,
function(name, NewName)
	if IsGroupExists(name) then
		if isHasSpace(NewName) then
			exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000El #FFFFFFnombre del clan #FF0000no debe contener espacios.", 255, 40, 0)
		elseif not isASCII(NewName) then
			-- exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000Only English #FFFFFFGroups name #00FF00acceptable#FF0000 chose another name in English.", 255, 40, 0)
			exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #FF0000El nombre solo debe contener caracteres válidos.", 255, 40, 0)
		elseif IsGroupExists(NewName) then
			exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000El nombre del clan #ffffff"..NewName.." #FF0000ya existe.", 255, 0, 0)
		else
			dbExec(db, "UPDATE groups SET group_name = ? WHERE group_name = ?", NewName, name)
			dbExec(db, "UPDATE group_ranks SET group_name = ? WHERE group_name = ?", NewName, name)
			dbExec(db, "UPDATE group_members SET group_name = ? WHERE group_name = ?", NewName, name)
			dbExec(db, "UPDATE group_invite SET group_name = ? WHERE group_name = ?", NewName, name)
			dbExec(db, "UPDATE group_history SET group_name = ? WHERE group_name = ?", NewName, name)
			dbExec(db, "UPDATE group_blackaccount SET group_name = ? WHERE group_name = ?", NewName, name)
			dbExec(db, "UPDATE group_blackserial SET group_name = ? WHERE group_name = ?", NewName, name)
			local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
			triggerClientEvent(source, "OpenGroupManager", source, result, true)
			for _, player in ipairs(getElementsByType("player")) do
				if getElementData(player, "Group") == name then
					setElementData(player, "Group", NewName)
				end
			end
		end
	else
		exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000El #FFFFFFnombre del clan #FF0000no existe.", 255, 0, 0)
	end
end)

addEvent("Delete_Group", true)
addEventHandler("Delete_Group", root,
function(GroupName)
	if not IsGroupExists(GroupName) then
		-- exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000The #FFFFFFGroup Name #FF0000doesn't exist.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000El #FFFFFFnombre del clan #FF0000no existe.", 255, 0, 0)
	else
		dbExec(db, "DELETE FROM groups WHERE group_name = ?", GroupName)
		dbExec(db, "DELETE FROM group_ranks WHERE group_name = ?", GroupName)
		dbExec(db, "DELETE FROM group_members WHERE group_name = ?", GroupName)
		dbExec(db, "DELETE FROM group_invite WHERE group_name = ?", GroupName)
		dbExec(db, "DELETE FROM group_history WHERE group_name = ?", GroupName)
		dbExec(db, "DELETE FROM group_blackaccount WHERE group_name = ?", GroupName)
		dbExec(db, "DELETE FROM group_blackserial WHERE group_name = ?", GroupName)
		local result = dbPoll(dbQuery(db, "SELECT group_name, group_members, members_limit, turf_points, group_owner FROM groups"), -1)
		triggerClientEvent(source, "OpenGroupManager", source, result, true)
		for i, player in pairs(getElementsByType("player")) do
			if getElementData(player, "Group") == GroupName then
				setElementData(player, "Group", false)
				setElementData(player, "GroupRank", false)
			end
		end
	end
end)

addEvent("Request_Group_History", true )
addEventHandler("Request_Group_History", root,
function ()
	local Name = getPlayerGroup(source)
	local MyGroupHistory = getGroupHistoryLog( Name )
	triggerClientEvent("Set_Group_History", source, MyGroupHistory)
end
)

addEvent("Request_Group_MembersList", true)
addEventHandler("Request_Group_MembersList", root,
function(name)
	local member = getGroupMembers(name)
	local data = data()
	triggerClientEvent(source, "ViewGroupMember", source, member, data)
end)

addEvent("Request_Group_Info", true)
addEventHandler("Request_Group_Info", root,
function(name)
	triggerClientEvent(source, "Send_Group_Info", source, getGroupInfo(name))
end)

addEvent("Change_Group_Info", true)
addEventHandler("Change_Group_Info", root,
function(name, Text)
	if IsGroupExists(name) then
		dbExec(db, "UPDATE groups SET group_info = ? WHERE group_name = ?", Text, name)
		-- exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #00FF00The Group Info has been updated #00FF00Successfully!", 0, 255, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #00FF00La información del clan ha sido actualizada con éxito!", 0, 255, 0)
	else
		-- exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000The #FFFFFFGroup Name #FF0000doesn't exist.", 255, 0, 0)
		exports["dxmessages"]:outputDx(source, "#04B4AE[Group Manager] #FF0000El #FFFFFFnombre del clan #FF0000no existe.", 255, 0, 0)
	end
end)

addEvent("get_Group_InviteList", true)
addEventHandler("get_Group_InviteList", root,
function(name)
	local h = dbQuery(db, "SELECT * FROM group_invite WHERE group_name = ?", name)
	local result = dbPoll(h, -1)
	if type(result) == "table" and #result ~= 0 then
		triggerClientEvent(source, "Send_Group_InviteList", source, result)
	end
end)

addEvent("Delete_Invite", true)
addEventHandler("Delete_Invite", root,
function(name,To,From)
	dbExec(db, "DELETE FROM group_invite WHERE group_name = ? AND player_account = ? AND byy = ?", name, To, From)
	local h = dbQuery(db, "SELECT * FROM group_invite WHERE group_name = ?", name)
	local result = dbPoll(h, -1)
	triggerClientEvent(source, "Send_Group_InviteList", source, result)
end)

addEvent("get_Group_Manager_Blacklist", true)
addEventHandler("get_Group_Manager_Blacklist", root,
function (GroupName)
	local Accounts = getGroupBlockedAccounts(GroupName)
	local Serials = getGroupBlockedSerials(GroupName)
	triggerClientEvent("set_Group_Manager_Blacklist_Serial", source, Serials)
	triggerClientEvent("set_Group_Manager_Blacklist_Account", source, Accounts)
end
)

addEvent("UnBlock_Member_By_Manager", true)
addEventHandler("UnBlock_Member_By_Manager", root,
function (GroupName, member)
	dbExec(db, "DELETE FROM group_blackaccount WHERE group_name = ? AND account_name = ?", GroupName, member)
	-- exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00The Account Was UnBlocked Successfully.",255,255,0)
	exports["dxmessages"]:outputDx(source, "#04B4AE(ClanSystem) #00FF00La cuenta ha sido desbloqueada con éxito.",255,255,0)
	local Accounts = getGroupBlockedAccounts(GroupName)
	local Serials = getGroupBlockedSerials(GroupName)
	triggerClientEvent("set_Group_Manager_Blacklist_Serial", source, Serials)
	triggerClientEvent("set_Group_Manager_Blacklist_Account", source, Accounts)
end
)


