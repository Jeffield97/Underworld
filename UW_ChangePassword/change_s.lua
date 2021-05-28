function obteneraccount(playerSource)
	sourceAccount = getPlayerAccount ( playerSource )
	if isGuestAccount ( sourceAccount ) then
		outputChatBox("#AFAFAF[SERVER]#FFFFFF Please log in to use this feature.", playerSource, 255, 255, 255, true)
	else
		PCuenta = getAccountName(getPlayerAccount(source))
		triggerClientEvent("OnDatas",source,PCuenta)
	end
end
addEvent("obAccount", true)
addEventHandler("obAccount",getRootElement(),obteneraccount)

function errorp()
	outputChatBox("#AFAFAF[SERVER]#FFFFFF Passwords do not match.", source, 255, 255, 255, true)
end
addEvent("ErrorPass", true)
addEventHandler("ErrorPass",getRootElement(),errorp)

function cambiar(newpass1)
	local account = getPlayerAccount(source)
	local nCuenta = getAccountName(account)
	if (account) then
		if (isGuestAccount(account)) then
			outputChatBox("#AFAFAF[SERVER]#FFFFFF Please log in to change the password.", source, 255, 255, 255, true)
		else
			setAccountPassword(account, newpass1)
			outputChatBox("#AFAFAF[SERVER]#FFFFFF The account password has been changed.", source, 255, 255, 255, true)
			outputChatBox("#AFAFAF[ACCOUNT]#FFFFFF [USER:#AFAFAF "..nCuenta.." #FFFFFF] - [NEW PASSWORD:#AFAFAF "..newpass1.." #FFFFFF].", source, 255, 255, 255, true)
		end
	end
end
addEvent("Cambiar", true)
addEventHandler("Cambiar",getRootElement(),cambiar)