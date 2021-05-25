--------------------------------------------------------------------------------
function saveHealthOnQuit()
local account = getPlayerAccount(source)
local health = getElementHealth(source)
if not isGuestAccount(account) then
setAccountData(account,"health",health)
end
end
addEventHandler("onPlayerQuit",root,saveHealthOnQuit)

function saveHealthOnLogout(previousaccount,currentaccount)
local health = getElementHealth(source)
setAccountData(previousaccount,"health",health)
end
addEventHandler("onPlayerLogout",root,saveHealthOnLogout)

function loadHealthOnLogin(previousaccount,currentaccount)
local health = getAccountData(currentaccount,"health")
if (health) then
setElementHealth(source,health)
end
end
addEventHandler("onPlayerLogin",root,loadHealthOnLogin)
--------------------------------------------------------------------------------
function saveArmorOnQuit()
local account = getPlayerAccount(source)
local armor = getPedArmor(source)
if not isGuestAccount(account) then
setAccountData(account,"armor",armor)
end
end
addEventHandler("onPlayerQuit",root,saveArmorOnQuit)

function saveArmorOnLogout(previousaccount,currentaccount)
local armor = getPedArmor(source)
setAccountData(previousaccount,"armor",armor)
end
addEventHandler("onPlayerLogout",root,saveArmorOnLogout)

function loadArmorOnLogin(previousaccount,currentaccount)
local armor = getAccountData(currentaccount,"armor")
if (armor) then
setPedArmor(source,armor)
end
end
addEventHandler("onPlayerLogin",root,loadArmorOnLogin)
--------------------------------------------------------------------------------
function saveMoneyOnQuit()
local account = getPlayerAccount(source)
local money = getPlayerMoney(source)
if not isGuestAccount(account) then
setAccountData(account,"money",money)
end
end
addEventHandler("onPlayerQuit",root,saveMoneyOnQuit)

function saveMoneyOnLogout(previousaccount,currentaccount)
local money = getPlayerMoney(source)
setAccountData(previousaccount,"money",money)
setPlayerMoney(source,0)
end
addEventHandler("onPlayerLogout",root,saveMoneyOnLogout)

function loadMoneyOnLogin(previousaccount,currentaccount)
local money = getAccountData(currentaccount,"money")
if (money) then
setPlayerMoney(source,money)
end
end
addEventHandler("onPlayerLogin",root,loadMoneyOnLogin)
--------------------------------------------------------------------------------
function saveSkinOnQuit()
local account = getPlayerAccount(source)
local skin = getPedSkin(source)
if not isGuestAccount(account) then
setAccountData(account,"skin",skin)
end
end
addEventHandler("onPlayerQuit",root,saveSkinOnQuit)

function saveSkinOnLogout(previousaccount,currentaccount)
local skin = getPedSkin(source)
setAccountData(previousaccount,"skin",skin)
end
addEventHandler("onPlayerLogout",root,saveSkinOnLogout)

function loadSkinOnLogin(previousaccount,currentaccount)
local skin = getAccountData(currentaccount,"skin")
if (skin) then
setPedSkin(source,skin)
end
end
addEventHandler("onPlayerLogin",root,loadSkinOnLogin)


function onWasted()
	local skin = getElementModel (source)
	setElementData(source, "SKIN", skin)
end
addEventHandler ("onPlayerWasted", getRootElement(), onWasted)

function onSpawn(  )
	local skin = tonumber(getElementData(source, "SKIN"))
	if skin then
		setTimer(setElementModel, 50, 1, source, skin)
	end
end
addEventHandler ("onPlayerSpawn", getRootElement(), onSpawn)
--------------------------------------------------------------------------------
function saveTeamOnQuit()
local account = getPlayerAccount(source)
local team = getPlayerTeam(source)
if (team) and not isGuestAccount(account) then
setAccountData(account,"team",getTeamName(team))
end
end
addEventHandler("onPlayerQuit",root,saveTeamOnQuit)

function saveTeamOnLogout(previousaccount,currentaccount)
local team = getPlayerTeam(source)
if (team) then
setAccountData(previousaccount,"team",getTeamName(team))
setPlayerTeam(source,nil)
end
end
addEventHandler("onPlayerLogout",root,saveTeamOnLogout)

function loadTeamOnLogin(previousaccount,currentaccount)
local team = getAccountData(currentaccount,"team")
if (team) then
setPlayerTeam(source,getTeamFromName(team))
end
end
addEventHandler("onPlayerLogin",root,loadTeamOnLogin)
--------------------------------------------------------------------------------
function savePositionOnQuit()
local account = getPlayerAccount(source)
local x,y,z = getElementPosition(source)
if not isGuestAccount(account) then
setAccountData(account,"x",x)
setAccountData(account,"y",y)
setAccountData(account,"z",z)
end
end
addEventHandler("onPlayerQuit",root,savePositionOnQuit)

function savePositionOnLogout(previousaccount,currentaccount)
local x,y,z = getElementPosition(source)
setAccountData(previousaccount,"x",x)
setAccountData(previousaccount,"y",y)
setAccountData(previousaccount,"z",z)
end
addEventHandler("onPlayerLogout",root,savePositionOnLogout)

function loadPositionOnLogin(previousaccount,currentaccount)
local x = getAccountData(currentaccount,"x")
local y = getAccountData(currentaccount,"y")
local z = getAccountData(currentaccount,"z")
if (x) and (y) and (z) then
-- setElementPosition(source,x,y,z)
spawnPlayer(source,x,y,z)
end
end
addEventHandler("onPlayerLogin",root,loadPositionOnLogin)
--------------------------------------------------------------------------------
function saveInteriorOnQuit()
local account = getPlayerAccount(source)
local interior = getElementInterior(source)
if not isGuestAccount(account) then
setAccountData(account,"interior",interior)
end
end
addEventHandler("onPlayerQuit",root,saveInteriorOnQuit)

function saveInteriorOnLogout(previousaccount,currentaccount)
local interior = getElementInterior(source)
setAccountData(previousaccount,"interior",interior)
end
addEventHandler("onPlayerLogout",root,saveInteriorOnLogout)

function loadInteriorOnLogin(previousaccount,currentaccount)
local interior = getAccountData(currentaccount,"interior")
if (interior) then
setElementInterior(source,interior)
end
end
addEventHandler("onPlayerLogin",root,loadInteriorOnLogin)
--------------------------------------------------------------------------------
function saveDimensionOnQuit()
local account = getPlayerAccount(source)
local dimension = getElementDimension(source)
if not isGuestAccount(account) then
setAccountData(account,"dimension",dimension)
end
end
addEventHandler("onPlayerQuit",root,saveDimensionOnQuit)

function saveDimensionOnLogout(previousaccount,currentaccount)
local dimension = getElementDimension(source)
setAccountData(previousaccount,"dimension",dimension)
setElementDimension(source,0)
end
addEventHandler("onPlayerLogout",root,saveDimensionOnLogout)

function loadDimensionOnLogin(previousaccount,currentaccount)
local dimension = getAccountData(currentaccount,"dimension")
if (dimension) then
setElementDimension(source,dimension)
end
end
addEventHandler("onPlayerLogin",root,loadDimensionOnLogin)

function saveDimensionOnWasted()
local account = getPlayerAccount(source)
local dimension = getElementDimension(source)
if not isGuestAccount(account) then
setAccountData(account,"dimension",dimension)
end
end
addEventHandler("onPlayerWasted",root,saveDimensionOnWasted)

function loadDimensionOnSpawn()
local account = getPlayerAccount(source)
local dimension = getAccountData(account,"dimension")
if (dimension) then
setElementDimension(source,dimension)
end
end
addEventHandler("onPlayerSpawn",root,loadDimensionOnSpawn)
-------------------------------------------------------------------------------
function saveStatsOnQuit()
local account = getPlayerAccount(source)
local stat1 = getPedStat(source,21)
local stat2 = getPedStat(source,23)
local stat3 = getPedStat(source,24)
local stat4 = getPedStat(source,77)
local stat5 = getPedStat(source,71)
local stat6 = getPedStat(source,78)
local stat7 = getPedStat(source,76)
local stat8 = getPedStat(source,69)
local stat9 = getPedStat(source,73)
local stat10 = getPedStat(source,72)
local stat11 = getPedStat(source,70)
local stat12 = getPedStat(source,79)
local stat13 = getPedStat(source,74)
local stat14 = getPedStat(source,75)
if not isGuestAccount(account) then
setAccountData(account,"stat1",stat1)
setAccountData(account,"stat2",stat2)
setAccountData(account,"stat3",stat3)
setAccountData(account,"stat4",stat4)
setAccountData(account,"stat5",stat5)
setAccountData(account,"stat6",stat6)
setAccountData(account,"stat7",stat7)
setAccountData(account,"stat8",stat8)
setAccountData(account,"stat9",stat9)
setAccountData(account,"stat10",stat10)
setAccountData(account,"stat11",stat11)
setAccountData(account,"stat12",stat12)
setAccountData(account,"stat13",stat13)
setAccountData(account,"stat14",stat14)
end
end
addEventHandler("onPlayerQuit",root,saveStatsOnQuit)

function saveStatsOnLogout(previousaccount,currentaccount)
local stat1 = getPedStat(source,21)
local stat2 = getPedStat(source,23)
local stat3 = getPedStat(source,24)
local stat4 = getPedStat(source,77)
local stat5 = getPedStat(source,71)
local stat6 = getPedStat(source,78)
local stat7 = getPedStat(source,76)
local stat8 = getPedStat(source,69)
local stat9 = getPedStat(source,73)
local stat10 = getPedStat(source,72)
local stat11 = getPedStat(source,70)
local stat12 = getPedStat(source,79)
local stat13 = getPedStat(source,74)
local stat14 = getPedStat(source,75)
setAccountData(previousaccount,"stat1",stat1)
setAccountData(previousaccount,"stat2",stat2)
setAccountData(previousaccount,"stat3",stat3)
setAccountData(previousaccount,"stat4",stat4)
setAccountData(previousaccount,"stat5",stat5)
setAccountData(previousaccount,"stat6",stat6)
setAccountData(previousaccount,"stat7",stat7)
setAccountData(previousaccount,"stat8",stat8)
setAccountData(previousaccount,"stat9",stat9)
setAccountData(previousaccount,"stat10",stat10)
setAccountData(previousaccount,"stat11",stat11)
setAccountData(previousaccount,"stat12",stat12)
setAccountData(previousaccount,"stat13",stat13)
setAccountData(previousaccount,"stat14",stat14)
setPedStat(source,21,0)
setPedStat(source,23,0)
setPedStat(source,24,569)
setPedStat(source,77,999)
setPedStat(source,71,999)
setPedStat(source,78,999)
setPedStat(source,76,999)
setPedStat(source,69,500)
setPedStat(source,73,500)
setPedStat(source,72,999)
setPedStat(source,70,999)
setPedStat(source,79,999)
setPedStat(source,74,999)
setPedStat(source,75,500)
end
addEventHandler("onPlayerLogout",root,saveStatsOnLogout)

function loadStatsOnLogin(previousaccount,currentaccount)
local stat1 = getAccountData(currentaccount,"stat1")
local stat2 = getAccountData(currentaccount,"stat2")
local stat3 = getAccountData(currentaccount,"stat3")
local stat4 = getAccountData(currentaccount,"stat4")
local stat5 = getAccountData(currentaccount,"stat5")
local stat6 = getAccountData(currentaccount,"stat6")
local stat7 = getAccountData(currentaccount,"stat7")
local stat8 = getAccountData(currentaccount,"stat8")
local stat9 = getAccountData(currentaccount,"stat9")
local stat10 = getAccountData(currentaccount,"stat10")
local stat11 = getAccountData(currentaccount,"stat11")
local stat12 = getAccountData(currentaccount,"stat12")
local stat13 = getAccountData(currentaccount,"stat13")
local stat14 = getAccountData(currentaccount,"stat14")
if (stat1) and (stat2) and (stat3) and (stat4) and (stat5) and (stat6) and (stat7) and (stat8) and (stat9) and (stat10) and (stat11) and (stat12) and (stat13) and (stat14) then
setPedStat(source,21,stat1)
setPedStat(source,23,stat2)
setPedStat(source,24,stat3)
setPedStat(source,77,stat4)
setPedStat(source,71,stat5)
setPedStat(source,78,stat6)
setPedStat(source,76,stat7)
setPedStat(source,69,stat8)
setPedStat(source,73,stat9)
setPedStat(source,72,stat10)
setPedStat(source,70,stat11)
setPedStat(source,79,stat12)
setPedStat(source,74,stat13)
setPedStat(source,75,stat14)
end
end
addEventHandler("onPlayerLogin",root,loadStatsOnLogin)

function saveStatsOnWasted()
local account = getPlayerAccount(source)
local stat1 = getPedStat(source,21)
local stat2 = getPedStat(source,23)
local stat3 = getPedStat(source,24)
local stat4 = getPedStat(source,77)
local stat5 = getPedStat(source,71)
local stat6 = getPedStat(source,78)
local stat7 = getPedStat(source,76)
local stat8 = getPedStat(source,69)
local stat9 = getPedStat(source,73)
local stat10 = getPedStat(source,72)
local stat11 = getPedStat(source,70)
local stat12 = getPedStat(source,79)
local stat13 = getPedStat(source,74)
local stat14 = getPedStat(source,75)
if not isGuestAccount(account) then
setAccountData(account,"stat1",stat1)
setAccountData(account,"stat2",stat2)
setAccountData(account,"stat3",stat3)
setAccountData(account,"stat4",stat4)
setAccountData(account,"stat5",stat5)
setAccountData(account,"stat6",stat6)
setAccountData(account,"stat7",stat7)
setAccountData(account,"stat8",stat8)
setAccountData(account,"stat9",stat9)
setAccountData(account,"stat10",stat10)
setAccountData(account,"stat11",stat11)
setAccountData(account,"stat12",stat12)
setAccountData(account,"stat13",stat13)
setAccountData(account,"stat14",stat14)
end
end
addEventHandler("onPlayerWasted",root,saveStatsOnWasted)

function loadStatsOnSpawn()
local account = getPlayerAccount(source)
local stat1 = getAccountData(account,"stat1")
local stat2 = getAccountData(account,"stat2")
local stat3 = getAccountData(account,"stat3")
local stat4 = getAccountData(account,"stat4")
local stat5 = getAccountData(account,"stat5")
local stat6 = getAccountData(account,"stat6")
local stat7 = getAccountData(account,"stat7")
local stat8 = getAccountData(account,"stat8")
local stat9 = getAccountData(account,"stat9")
local stat10 = getAccountData(account,"stat10")
local stat11 = getAccountData(account,"stat11")
local stat12 = getAccountData(account,"stat12")
local stat13 = getAccountData(account,"stat13")
local stat14 = getAccountData(account,"stat14")
if (stat1) and (stat2) and (stat3) and (stat4) and (stat5) and (stat6) and (stat7) and (stat8) and (stat9) and (stat10) and (stat11) and (stat12) and (stat13) and (stat14) then
setPedStat(source,21,stat1)
setPedStat(source,23,stat2)
setPedStat(source,24,stat3)
setPedStat(source,77,stat4)
setPedStat(source,71,stat5)
setPedStat(source,78,stat6)
setPedStat(source,76,stat7)
setPedStat(source,69,stat8)
setPedStat(source,73,stat9)
setPedStat(source,72,stat10)
setPedStat(source,70,stat11)
setPedStat(source,79,stat12)
setPedStat(source,74,stat13)
setPedStat(source,75,stat14)
end
end
addEventHandler("onPlayerSpawn",root,loadStatsOnSpawn)
-------------------------------------------------------------------------------
function saveWeaponsOnQuit()
	--if isInsideColShape( theColShape, getElementPosition( theElement ) ) then
		local account = getPlayerAccount(source)
		local weapon0 = getPedWeapon(source,0)
		local weapon1 = getPedWeapon(source,1)
		local weapon2 = getPedWeapon(source,2)
		local weapon3 = getPedWeapon(source,3)
		local weapon4 = getPedWeapon(source,4)
		local weapon5 = getPedWeapon(source,5)
		local weapon6 = getPedWeapon(source,6)
		local weapon7 = getPedWeapon(source,7)
		local weapon8 = getPedWeapon(source,8)
		local weapon9 = getPedWeapon(source,9)
		local weapon10 = getPedWeapon(source,10)
		local weapon11 = getPedWeapon(source,11)
		local weapon12 = getPedWeapon(source,12)
		local ammo0 = getPedTotalAmmo(source,0)
		local ammo1 = getPedTotalAmmo(source,1)
		local ammo2 = getPedTotalAmmo(source,2)
		local ammo3 = getPedTotalAmmo(source,3)
		local ammo4 = getPedTotalAmmo(source,4)
		local ammo5 = getPedTotalAmmo(source,5)
		local ammo6 = getPedTotalAmmo(source,6)
		local ammo7 = getPedTotalAmmo(source,7)
		local ammo8 = getPedTotalAmmo(source,8)
		local ammo9 = getPedTotalAmmo(source,9)
		local ammo10 = getPedTotalAmmo(source,10)
		local ammo11 = getPedTotalAmmo(source,11)
		local ammo12 = getPedTotalAmmo(source,12)
		if not isGuestAccount(account) then
			setAccountData(account,"weapon0",weapon0)
			setAccountData(account,"weapon1",weapon1)
			setAccountData(account,"weapon2",weapon2)
			setAccountData(account,"weapon3",weapon3)
			setAccountData(account,"weapon4",weapon4)
			setAccountData(account,"weapon5",weapon5)
			setAccountData(account,"weapon6",weapon6)
			setAccountData(account,"weapon7",weapon7)
			setAccountData(account,"weapon8",weapon8)
			setAccountData(account,"weapon9",weapon9)
			setAccountData(account,"weapon10",weapon10)
			setAccountData(account,"weapon11",weapon11)
			setAccountData(account,"weapon12",weapon12)
			setAccountData(account,"ammo0",ammo0)
			setAccountData(account,"ammo1",ammo1)
			setAccountData(account,"ammo2",ammo2)
			setAccountData(account,"ammo3",ammo3)
			setAccountData(account,"ammo4",ammo4)
			setAccountData(account,"ammo5",ammo5)
			setAccountData(account,"ammo6",ammo6)
			setAccountData(account,"ammo7",ammo7)
			setAccountData(account,"ammo8",ammo8)
			setAccountData(account,"ammo9",ammo9)
			setAccountData(account,"ammo10",ammo10)
			setAccountData(account,"ammo11",ammo11)
			setAccountData(account,"ammo12",ammo12)
		end
	-- end
end
-- addEventHandler("onPlayerQuit",root,saveWeaponsOnQuit)

function saveWeaponsOnLogout(previousaccount,currentaccount)
local weapon0 = getPedWeapon(source,0)
local weapon1 = getPedWeapon(source,1)
local weapon2 = getPedWeapon(source,2)
local weapon3 = getPedWeapon(source,3)
local weapon4 = getPedWeapon(source,4)
local weapon5 = getPedWeapon(source,5)
local weapon6 = getPedWeapon(source,6)
local weapon7 = getPedWeapon(source,7)
local weapon8 = getPedWeapon(source,8)
local weapon9 = getPedWeapon(source,9)
local weapon10 = getPedWeapon(source,10)
local weapon11 = getPedWeapon(source,11)
local weapon12 = getPedWeapon(source,12)
local ammo0 = getPedTotalAmmo(source,0)
local ammo1 = getPedTotalAmmo(source,1)
local ammo2 = getPedTotalAmmo(source,2)
local ammo3 = getPedTotalAmmo(source,3)
local ammo4 = getPedTotalAmmo(source,4)
local ammo5 = getPedTotalAmmo(source,5)
local ammo6 = getPedTotalAmmo(source,6)
local ammo7 = getPedTotalAmmo(source,7)
local ammo8 = getPedTotalAmmo(source,8)
local ammo9 = getPedTotalAmmo(source,9)
local ammo10 = getPedTotalAmmo(source,10)
local ammo11 = getPedTotalAmmo(source,11)
local ammo12 = getPedTotalAmmo(source,12)
setAccountData(previousaccount,"weapon0",weapon0)
setAccountData(previousaccount,"weapon1",weapon1)
setAccountData(previousaccount,"weapon2",weapon2)
setAccountData(previousaccount,"weapon3",weapon3)
setAccountData(previousaccount,"weapon4",weapon4)
setAccountData(previousaccount,"weapon5",weapon5)
setAccountData(previousaccount,"weapon6",weapon6)
setAccountData(previousaccount,"weapon7",weapon7)
setAccountData(previousaccount,"weapon8",weapon8)
setAccountData(previousaccount,"weapon9",weapon9)
setAccountData(previousaccount,"weapon10",weapon10)
setAccountData(previousaccount,"weapon11",weapon11)
setAccountData(previousaccount,"weapon12",weapon12)
setAccountData(previousaccount,"ammo0",ammo0)
setAccountData(previousaccount,"ammo1",ammo1)
setAccountData(previousaccount,"ammo2",ammo2)
setAccountData(previousaccount,"ammo3",ammo3)
setAccountData(previousaccount,"ammo4",ammo4)
setAccountData(previousaccount,"ammo5",ammo5)
setAccountData(previousaccount,"ammo6",ammo6)
setAccountData(previousaccount,"ammo7",ammo7)
setAccountData(previousaccount,"ammo8",ammo8)
setAccountData(previousaccount,"ammo9",ammo9)
setAccountData(previousaccount,"ammo10",ammo10)
setAccountData(previousaccount,"ammo11",ammo11)
setAccountData(previousaccount,"ammo12",ammo12)
takeAllWeapons(source)
end
addEventHandler("onPlayerLogout",root,saveWeaponsOnLogout)

function loadWeaponsOnLogin(previousaccount,currentaccount)
local weapon0 = getAccountData(currentaccount,"weapon0")
local weapon1 = getAccountData(currentaccount,"weapon1")
local weapon2 = getAccountData(currentaccount,"weapon2")
local weapon3 = getAccountData(currentaccount,"weapon3")
local weapon4 = getAccountData(currentaccount,"weapon4")
local weapon5 = getAccountData(currentaccount,"weapon5")
local weapon6 = getAccountData(currentaccount,"weapon6")
local weapon7 = getAccountData(currentaccount,"weapon7")
local weapon8 = getAccountData(currentaccount,"weapon8")
local weapon9 = getAccountData(currentaccount,"weapon9")
local weapon10 = getAccountData(currentaccount,"weapon10")
local weapon11 = getAccountData(currentaccount,"weapon11")
local weapon12 = getAccountData(currentaccount,"weapon12")
local ammo0 = getAccountData(currentaccount,"ammo0")
local ammo1 = getAccountData(currentaccount,"ammo1")
local ammo2 = getAccountData(currentaccount,"ammo2")
local ammo3 = getAccountData(currentaccount,"ammo3")
local ammo4 = getAccountData(currentaccount,"ammo4")
local ammo5 = getAccountData(currentaccount,"ammo5")
local ammo6 = getAccountData(currentaccount,"ammo6")
local ammo7 = getAccountData(currentaccount,"ammo7")
local ammo8 = getAccountData(currentaccount,"ammo8")
local ammo9 = getAccountData(currentaccount,"ammo9")
local ammo10 = getAccountData(currentaccount,"ammo10")
local ammo11 = getAccountData(currentaccount,"ammo11")
local ammo12 = getAccountData(currentaccount,"ammo12")
if (weapon0) and (weapon1) and (weapon2) and (weapon3) and (weapon4) and (weapon5) and (weapon6) and (weapon7) and (weapon8) and (weapon9) and (weapon10) and (weapon11) and (weapon12) and
(ammo0) and (ammo1) and (ammo2) and (ammo3) and (ammo4) and (ammo5) and (ammo6) and (ammo7) and (ammo8) and (ammo9) and (ammo10) and (ammo11) and (ammo12) then
giveWeapon(source,weapon0,ammo0)
giveWeapon(source,weapon1,ammo1)
giveWeapon(source,weapon2,ammo2)
giveWeapon(source,weapon3,ammo3)
giveWeapon(source,weapon4,ammo4)
giveWeapon(source,weapon5,ammo5)
giveWeapon(source,weapon6,ammo6)
giveWeapon(source,weapon7,ammo7)
giveWeapon(source,weapon8,ammo8)
giveWeapon(source,weapon9,ammo9)
giveWeapon(source,weapon10,ammo10)
giveWeapon(source,weapon11,ammo11)
giveWeapon(source,weapon12,ammo12)
end
end
addEventHandler("onPlayerLogin",root,loadWeaponsOnLogin)

function saveWeaponsOnWasted()
	if not getElementData(source,"ZoneWar")=="Yes" then
		local account = getPlayerAccount(source)
		local weapon0 = getPedWeapon(source,0)
		local weapon1 = getPedWeapon(source,1)
		local weapon2 = getPedWeapon(source,2)
		local weapon3 = getPedWeapon(source,3)
		local weapon4 = getPedWeapon(source,4)
		local weapon5 = getPedWeapon(source,5)
		local weapon6 = getPedWeapon(source,6)
		local weapon7 = getPedWeapon(source,7)
		local weapon8 = getPedWeapon(source,8)
		local weapon9 = getPedWeapon(source,9)
		local weapon10 = getPedWeapon(source,10)
		local weapon11 = getPedWeapon(source,11)
		local weapon12 = getPedWeapon(source,12)
		local ammo0 = getPedTotalAmmo(source,0)
		local ammo1 = getPedTotalAmmo(source,1)
		local ammo2 = getPedTotalAmmo(source,2)
		local ammo3 = getPedTotalAmmo(source,3)
		local ammo4 = getPedTotalAmmo(source,4)
		local ammo5 = getPedTotalAmmo(source,5)
		local ammo6 = getPedTotalAmmo(source,6)
		local ammo7 = getPedTotalAmmo(source,7)
		local ammo8 = getPedTotalAmmo(source,8)
		local ammo9 = getPedTotalAmmo(source,9)
		local ammo10 = getPedTotalAmmo(source,10)
		local ammo11 = getPedTotalAmmo(source,11)
		local ammo12 = getPedTotalAmmo(source,12)
		if not isGuestAccount(account) then
			setAccountData(account,"weapon0",weapon0)
			setAccountData(account,"weapon1",weapon1)
			setAccountData(account,"weapon2",weapon2)
			setAccountData(account,"weapon3",weapon3)
			setAccountData(account,"weapon4",weapon4)
			setAccountData(account,"weapon5",weapon5)
			setAccountData(account,"weapon6",weapon6)
			setAccountData(account,"weapon7",weapon7)
			setAccountData(account,"weapon8",weapon8)
			setAccountData(account,"weapon9",weapon9)
			setAccountData(account,"weapon10",weapon10)
			setAccountData(account,"weapon11",weapon11)
			setAccountData(account,"weapon12",weapon12)
			setAccountData(account,"ammo0",ammo0)
			setAccountData(account,"ammo1",ammo1)
			setAccountData(account,"ammo2",ammo2)
			setAccountData(account,"ammo3",ammo3)
			setAccountData(account,"ammo4",ammo4)
			setAccountData(account,"ammo5",ammo5)
			setAccountData(account,"ammo6",ammo6)
			setAccountData(account,"ammo7",ammo7)
			setAccountData(account,"ammo8",ammo8)
			setAccountData(account,"ammo9",ammo9)
			setAccountData(account,"ammo10",ammo10)
			setAccountData(account,"ammo11",ammo11)
			setAccountData(account,"ammo12",ammo12)
		end
	end
end
addEventHandler("onPlayerWasted",root,saveWeaponsOnWasted)

function loadWeaponsOnSpawn()
local account = getPlayerAccount(source)
local weapon0 = getAccountData(account,"weapon0")
local weapon1 = getAccountData(account,"weapon1")
local weapon2 = getAccountData(account,"weapon2")
local weapon3 = getAccountData(account,"weapon3")
local weapon4 = getAccountData(account,"weapon4")
local weapon5 = getAccountData(account,"weapon5")
local weapon6 = getAccountData(account,"weapon6")
local weapon7 = getAccountData(account,"weapon7")
local weapon8 = getAccountData(account,"weapon8")
local weapon9 = getAccountData(account,"weapon9")
local weapon10 = getAccountData(account,"weapon10")
local weapon11 = getAccountData(account,"weapon11")
local weapon12 = getAccountData(account,"weapon12")
local ammo0 = getAccountData(account,"ammo0")
local ammo1 = getAccountData(account,"ammo1")
local ammo2 = getAccountData(account,"ammo2")
local ammo3 = getAccountData(account,"ammo3")
local ammo4 = getAccountData(account,"ammo4")
local ammo5 = getAccountData(account,"ammo5")
local ammo6 = getAccountData(account,"ammo6")
local ammo7 = getAccountData(account,"ammo7")
local ammo8 = getAccountData(account,"ammo8")
local ammo9 = getAccountData(account,"ammo9")
local ammo10 = getAccountData(account,"ammo10")
local ammo11 = getAccountData(account,"ammo11")
local ammo12 = getAccountData(account,"ammo12")
if (weapon0) and (weapon1) and (weapon2) and (weapon3) and (weapon4) and (weapon5) and (weapon6) and (weapon7) and (weapon8) and (weapon9) and (weapon10) and (weapon11) and (weapon12) and
(ammo0) and (ammo1) and (ammo2) and (ammo3) and (ammo4) and (ammo5) and (ammo6) and (ammo7) and (ammo8) and (ammo9) and (ammo10) and (ammo11) and (ammo12) then
giveWeapon(source,weapon0,ammo0)
giveWeapon(source,weapon1,ammo1)
giveWeapon(source,weapon2,ammo2)
giveWeapon(source,weapon3,ammo3)
giveWeapon(source,weapon4,ammo4)
giveWeapon(source,weapon5,ammo5)
giveWeapon(source,weapon6,ammo6)
giveWeapon(source,weapon7,ammo7)
giveWeapon(source,weapon8,ammo8)
giveWeapon(source,weapon9,ammo9)
giveWeapon(source,weapon10,ammo10)
giveWeapon(source,weapon11,ammo11)
giveWeapon(source,weapon12,ammo12)
end
end
addEventHandler("onPlayerSpawn",root,loadWeaponsOnSpawn)
-------------------------------------------------------------------------------