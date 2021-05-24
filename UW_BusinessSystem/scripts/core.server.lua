local _settings = get("");
local settings = {};
for k, v in pairs(_settings) do
	k = split(k, ".")[2];
	settings[k] = v;
end

if (settings.key:len() < 1 or settings.key:len() > 1) then
	settings.key = "N";
end
if (not settings.blip or tonumber(settings.blip) == nil) then
	settings.blip = false;
end

addEventHandler("onResourceStart", resourceRoot, function()
	if (settings.database == "mysql") then
		local host, db, username, password, port, socket = unpack(settings.database_data);
		if not (host and db and username and password) then outputDebugString("Business: Failed to connect to the MySQL server - The data is invalid"); return; end
		if (tonumber(port)) then port = "port="..port..";"; else port = ""; end
		if (socket and socket ~= "") then socket = "socket="..socket..";"; else socket = ""; end
		database = Connection("mysql", "host="..host..";dbname="..db..";"..port..socket, username, password);
		if (not database) then outputDebugString("Business: Failed to connect to the MySQL server"); return; end
	else
		database = Connection("sqlite", "files/business.db");
		if (not database) then outputDebugString("Business: Failed to connect to the SQLite file"); return; end
	end
	database:exec("CREATE TABLE IF NOT EXISTS business(id INT, name TEXT, owner TEXT, cost INT, pos TEXT, payout INT, payout_time INT, payout_otime INT, payout_unit TEXT, payout_cur_time INT, bank INT)");
	database:query(dbCreateBusinessesCallback,  "SELECT * FROM business");
end);

function dbCreateBusinessesCallback(query_handle)
	local sql = query_handle:poll(0);
	if (sql and #sql > 0) then
		for index, row in ipairs(sql) do
			local pos = split(row["pos"], ",");
			local b_marker = Marker(pos[1], pos[2], pos[3], "cylinder", 1.2, settings.marker_color[1], settings.marker_color[2], settings.marker_color[3], settings.marker_color[4]);
			b_marker.interior = pos[4];
			b_marker.dimension = pos[5];
			if (settings.blip ~= false) then
				if (row["owner"] == "En Venta") then
					local b_blip = Blip.createAttachedTo(b_marker, settings.blip, 2, 255, 0, 0, 255, 0, 100.0);
					b_blip.interior = pos[4];
					b_blip.dimension = pos[5];
				else
					local b_blip = Blip.createAttachedTo(b_marker, settings.blip, 2, 255, 0, 0, 255, 0, 100.0);
					b_blip.interior = pos[4];
					b_blip.dimension = pos[5];
				end
			end
			addEventHandler("onMarkerHit", b_marker, onBusinessMarkerHit);
			addEventHandler("onMarkerLeave", b_marker, onBusinessMarkerLeave);
			local timer = Timer(businessPayout, row["payout_cur_time"] , 1, b_marker);
			b_marker:setData("b_data", {row["id"], row["name"], row["owner"], row["cost"], row["payout"], row["payout_time"], row["payout_otime"], row["payout_unit"], row["bank"], timer});
		end
	end
end

addCommandHandler("business", function(player)
	if (ACL.hasObjectPermissionTo(player, "function.banPlayer")) then
		triggerClientEvent(player, "business.showCreateBusinessWindow", player);
	else
		player:outputMessage("Business: You don't have access to this command.", 255, 0, 0);
	end
end);

function Player:outputMessage(message, r, g, b)
	if (settings.info_messages_type == "dx") then
		dxOutputMessage(message, self, r, g, b);
	else
		self:outputChat(message, r, g, b, true);
	end
end

function outputMessage(message, player, r, g, b)
	if (settings.info_messages_type == "dx") then
		dxOutputMessage(message, player, r, g, b);
	else
		player:outputChat(message, r, g, b, true);
	end
end

function dxOutputMessage(message, player, r, g, b)
	triggerClientEvent(player, "business.dxOutputMessage", player, message, r, g, b);
end

addEvent("business.outputMessage", true);
addEventHandler("business.outputMessage", root, function(message, r, g, b)
	source:outputMessage(message, r, g, b);
end);

addEvent("business.createBusiness", true);
addEventHandler("business.createBusiness", root, function(x, y, z, interior, dimension, name, cost, payout, payout_time, payout_unit)
	database:query(dbCreateBusinessCallback,  {client, x, y, z, interior, dimension, name, cost, payout, payout_time, payout_unit}, "SELECT * FROM business");
end);

function dbCreateBusinessCallback(query_handle, client, x, y, z, interior, dimension, name, cost, payout, payout_time, payout_unit)
	local sql = query_handle:poll(0);
	if (sql) then
		local id;
		if (#sql > 0) then
			id = sql[#sql]["id"] + 1;
		else
			id = 1;
		end
		local unit;
		if (payout_unit == "Seconds") then
			unit = 1000;
		elseif (payout_unit == "Minutes") then
			unit = 60000;
		elseif (payout_unit == "Hours") then
			unit = 3600000;
		elseif (payout_unit == "Days") then
			unit = 86400000;
		end

		x = tonumber(x);
		y = tonumber(y);
		z = tonumber(z);
		interior = tonumber(interior);
		dimension = tonumber(dimension);
		cost = tonumber(cost);
		payout = tonumber(payout);
		payout_time = tonumber(payout_time);

		z = z - 1;

		database:exec("INSERT INTO business(id,name,owner,cost,pos,payout,payout_time,payout_otime,payout_unit,payout_cur_time,bank) VALUES(?,?,?,?,?,?,?,?,?,?,?)", id, name, "En Venta", cost, x..","..y..","..z..","..interior..","..dimension, payout, payout_time * unit, payout_time, payout_unit, payout_time * unit, 0);

		local b_marker = Marker(x, y, z, "cylinder", 1, settings.marker_color[1], settings.marker_color[2], settings.marker_color[3], settings.marker_color[4]);
		b_marker.interior = interior;
		b_marker.dimension = dimension;
		if (settings.blip ~= false) then
			local b_blip = Blip.createAttachedTo(b_marker, settings.blip, 2, 255, 0, 0, 255, 0, 100.0);
			b_blip.interior = interior;
			b_blip.dimension = dimension;
		end
		local timer = Timer(businessPayout, payout_time * unit , 1, b_marker);
		b_marker:setData("b_data", {id, name, "En Venta", cost, payout, payout_time * unit, payout_time, payout_unit, 0, timer});
		addEventHandler("onMarkerHit", b_marker, onBusinessMarkerHit);
		addEventHandler("onMarkerLeave", b_marker, onBusinessMarkerLeave);
		if (#tostring(id) == 1) then id = "0".. tostring(id) end
		client:outputMessage("Business: Business(ID #"..id..") has been created successfully", 0, 255, 0);
	end
end

function onBusinessMarkerHit(hElement, mDim)
	if (hElement:getType() ~= "player") then return; end
	if (hElement:isInVehicle()) then return; end
	if (not mDim) then return; end
	triggerClientEvent(hElement, "business.showInstructions", hElement);
end

function onBusinessMarkerLeave(hElement, mDim)
	if (hElement:getType() ~= "player") then return; end
	if (hElement:isInVehicle()) then return; end
	if (not mDim) then return; end
	triggerClientEvent(hElement, "business.hideInstructions", hElement);
end

function businessPayout(b_marker)
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	if (owner ~= "En Venta") then
		bank = bank + payout;
		database:exec("UPDATE business SET bank = ? WHERE id = ?", bank, id);
		if (settings.inform_player_of_payout) then
			local account = Account(owner);
			if (account) then
				local player = account:getPlayer();
				if (player and player.isElement) then
					player:outputMessage("Business: Business \" "..name.." \" has paid out($"..payout..")", 0, 255, 0);
				end
			end
		end
	end
	timer = Timer(businessPayout, payout_time, 1, b_marker);
	b_marker:setData("b_data", {id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer});
end

addEventHandler("onResourceStop", resourceRoot, function()
	for index, b_marker in ipairs(Element.getAllByType("marker", resourceRoot)) do
		local b_data = b_marker:getData("b_data");
		local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
		if (timer and timer:isValid()) then
			local left = timer:getDetails();
			if (left >= 50) then
				database:exec("UPDATE business SET payout_cur_time = ? WHERE id = ?", left, id);
			else
				database:exec("UPDATE business SET payout_cur_time = ? WHERE id = ?", payout_time, id);
			end
		end
	end
end);

function Ped:isInMarker(marker)
	local colshape = marker.colShape;
	return self:isWithinColShape(colshape);
end

addEventHandler("onResourceStart", resourceRoot, function()
	for index, player in ipairs(Element.getAllByType("player")) do
		bindKey(player, settings.key, "up", onPlayerAttemptToOpenBusiness);
	end
end);

addEventHandler("onPlayerJoin", root,function()
	bindKey(source, settings.key, "up", onPlayerAttemptToOpenBusiness);
end);

function onPlayerAttemptToOpenBusiness(player)
	for index, b_marker in ipairs(Element.getAllByType("marker", resourceRoot)) do
		if (player:isInMarker(b_marker)) then
			local b_data = b_marker:getData("b_data");
			local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
			triggerClientEvent(player, "business.showBusinessWindow", player, b_marker, getAccountName(getPlayerAccount(player)) == owner, ACL.hasObjectPermissionTo(player, "function.banPlayer"));
			break;
		end
	end
end

function Ped:getMarker()
	for index, b_marker in ipairs(Element.getAllByType("marker", resourceRoot)) do
		if (self:isInMarker(b_marker)) then
			return b_marker;
		end
	end
end

addEvent("business.buy", true);
addEventHandler("business.buy", root, function()
	local account = client.account;
	if (not account or account:isGuest()) then client:outputMessage("Business: You are not logged in", 255, 0, 0) return; end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	if (owner ~= "En Venta") then client:outputMessage("Business: This business is owned", 255, 0, 0); return; end
	database:query(dbBuyBusinessCallback, {client, b_marker, id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer}, "SELECT * FROM business WHERE owner = ?", account.name);
end);

addEvent("business.sell", true);
addEventHandler("business.sell", root, function()
	local account = client.account;
	if (not account or account:isGuest()) then return; end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	if (owner ~= account.name) then
		if (ACL.hasObjectPermissionTo(client, "function.banPlayer")) then
			database:exec("UPDATE business SET owner = ? WHERE id = ?", "En Venta", id);
			b_marker:setData("b_data", {id, name, "En Venta", cost, payout, payout_time, payout_otime, payout_unit, bank, timer});
			client:outputMessage("Business: You have successfully sold this business", 0, 255, 0);
			return;
		else
			client:outputMessage("Business: You are not the owner of this business", 255, 0, 0);
			return;
		end
	end
	database:exec("UPDATE business SET owner = ?, bank = ? WHERE id = ?", "En Venta", 0, id);
	client:giveMoney(tonumber(("%.f"):format(cost / 2)));
	client:giveMoney(bank);
	b_marker:setData("b_data", {id, name, "En Venta", cost, payout, payout_time, payout_otime, payout_unit, 0});
	client:outputMessage("Business: You have successfully sold this business, all the money in the bank have been paid to you.", 0, 255, 0);
end);

addEvent("business.deposit", true);
addEventHandler("business.deposit", root, function(amount)
	local account = client.account;
	if (not account or account:isGuest()) then return; end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	if (not tonumber(amount)) then client:outputMessage("Business: Invalid amount", 255, 0, 0); return; end
	if (owner ~= account.name) then
		client:outputMessage("Business: You are not the owner of this business", 255, 0, 0);
		return;
	end
	if (client.money < amount) then
		client:outputMessage("Business: You don't have enough money", 255, 0, 0);
		return;
	end
	database:exec("UPDATE business SET bank = ? WHERE id = ?", bank + amount, id);
	client:takeMoney(amount);
	b_marker:setData("b_data", {id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank + amount, timer});
	client:outputMessage("Business: You have successfully deposited $"..amount.." to the business", 0, 255, 0);
end);

addEvent("business.withdraw", true);
addEventHandler("business.withdraw", root, function(amount)
	local account = client.account;
	if (not account or account:isGuest()) then return; end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	if (not tonumber(amount)) then client:outputMessage("Business: Invalid amount", 255, 0, 0); return; end
	if (owner ~= account.name) then
		client:outputMessage("Business: You are not the owner of the business", 255, 0, 0);
		return;
	end
	if (bank < amount) then
		client:outputMessage("Business: You don't have that much in the business bank", 255, 0, 0);
		return;
	end
	database:exec("UPDATE business SET bank = ? WHERE id = ?", bank - amount, id);
	client:giveMoney(amount);
	b_marker:setData("b_data", {id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank - amount, timer});
	client:outputMessage("Business: You have successfully withdrew $"..amount.." from the business", 0, 255, 0);
end);

addEvent("business.setName", true);
addEventHandler("business.setName", root, function(new_name)
	if (new_name == "" or #new_name > 30) then
		client:outputMessage("Business: Invalid value", 255, 0, 0);
		return;
	end
	if (not ACL.hasObjectPermissionTo(client, "function.banPlayer")) then
		client:outputMessage("Business: You don't have access to do that", 255, 0, 0);
		return;
	end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	database:exec("UPDATE business SET name = ? WHERE id = ?", new_name, id);
	b_marker:setData("b_data", {id, new_name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer});
	client:outputMessage("Business: You have successfully renamed the business", 0, 255, 0);
end);

addEvent("business.setOwner", true);
addEventHandler("business.setOwner", root, function(new_owner)
	if (not ACL.hasObjectPermissionTo(client, "function.banPlayer")) then
		client:outputMessage("Business: You don't have access to do that", 255, 0, 0);
		return;
	end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	database:exec("UPDATE business SET owner = ? WHERE id = ?", new_owner, id);
	b_marker:setData("b_data", {id, name, new_owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer});
	client:outputMessage("Business: You have successfully changed the business owner", 0, 255, 0);
end);

addEvent("business.setCost", true);
addEventHandler("business.setCost", root, function(amount)
	if (tonumber(amount) == nil) then
		client:outputMessage("Business: Invalid value", 255, 0, 0);
		return;
	end
	amount = tonumber(amount);
	if (not ACL.hasObjectPermissionTo(client, "function.banPlayer")) then
		client:outputMessage("Business: You don't have access to do that", 255, 0, 0);
		return;
	end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	database:exec("UPDATE business SET cost = ? WHERE id = ?", amount, id);
	b_marker:setData("b_data", {id, name, owner, amount, payout, payout_time, payout_otime, payout_unit, bank, timer});
	client:outputMessage("Business: You have successfully changed the business cost", 0, 255, 0);
end);

addEvent("business.setBank", true);
addEventHandler("business.setBank", root, function(amount)
	if (tonumber(amount) == nil) then
		client:outputMessage("Business: Invalid value", 255, 0, 0);
		return;
	end
	amount = tonumber(amount);
	if (not ACL.hasObjectPermissionTo(client, "function.banPlayer")) then
		client:outputMessage("Business: You don't have access to do that", 255, 0, 0);
		return;
	end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	database:exec("UPDATE business SET bank = ? WHERE id = ?", amount, id);
	b_marker:setData("b_data", {id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, amount, timer});
	client:outputMessage("Business: You have successfully changed the business bank amount", 0, 255, 0);
end);

addEvent("business.destroy", true);
addEventHandler("business.destroy", root, function()
	if (not ACL.hasObjectPermissionTo(client, "function.banPlayer")) then
		client:outputMessage("Business: You don't have access to do that", 255, 0, 0);
		return;
	end
	local b_marker = client:getMarker();
	if (not isElement(b_marker)) then return; end
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	if (timer and timer:isValid()) then timer:destroy() end
	database:exec("DELETE FROM business WHERE id = ?", id);
	b_marker:destroyAttachedBlips();
	b_marker:destroy();
	client:outputMessage("Business: You have successfully destroyed the business", 0, 255, 0);
	triggerClientEvent(client, "business.hideInstructions", client);
	database:query(dbReOrderBusinessesCallback,  "SELECT * FROM business");
end);

function dbBuyBusinessCallback(query_handle, source, b_marker, id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer)
	local sql = query_handle:poll(0);
	if (#sql == settings.owned_businesses) then
		source:outputMessage("Business: You already own "..#sql.." businesses which is the maximum amount", 255, 0, 0);
		return;
	end
	local money = source.money;
	if (money < cost) then source:outputMessage("Business: You don't have enough money", 255, 0, 0) return end
	database:exec("UPDATE business SET owner = ? WHERE id = ?", source.account.name, id);
	source:takeMoney(cost);
	source:outputMessage("Business: You have successfully bought this business", 0, 255, 0);
	b_marker:setData("b_data", {id, name, source.account.name, cost, payout, payout_time, payout_otime, payout_unit, bank, timer});
end

function dbReOrderBusinessesCallback(query_handle)
	local sql = query_handle:poll(0);
	if (sql and #sql > 0) then
		for index, row in ipairs(sql) do
			database:exec("UPDATE business SET id = ? WHERE id = ?", index, row["id"]);
		end
		for index, b_marker in ipairs(Element.getAllByType("marker", resourceRoot)) do
			database:query(dbUpdateBusinessesIDsCallback, {b_marker, index}, "SELECT id FROM business WHERE id = ?", index);
		end
	end
end

function dbUpdateBusinessesIDsCallback(query_handle, b_marker, index)
	local sql = query_handle:poll(0);
	local b_data = b_marker:getData("b_data");
	local id, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer = unpack(b_data);
	b_marker:setData("b_data", {index, name, owner, cost, payout, payout_time, payout_otime, payout_unit, bank, timer});
end

function Element:destroyAttachedBlips()
	if (not self) then return; end
	for index, element in pairs(self:getAttachedElements()) do
		if (element and element.isElement) then
			element:destroy();
		end
	end
end

addEvent("business.getSettings", true);
addEventHandler("business.getSettings", root, function()
	triggerClientEvent(source, "business.getSettings", source, settings);
end);