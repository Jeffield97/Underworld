atmls1 = 2116, -1118.3000488281,24.89999961853,0,0,162
atmls2 = 1186.1999511719,-1374.3000488281, 13.199999809265 ,0,0,90
atmls3 = 1975.4000244141,-2176.1000976563, 13.199999809265 ,0,0,178

atmsf1 = -1571.0999755859,666.59997558594, 6.8000001907349 ,0,0,88
atmsf2 = -2655.8999023438,257.89999389648, 4 ,0,0,90

atmredcounty = -74.800003051758,1116.3000488281, 19.39999961853 ,0,0,90

atmlv1 = 1715.5999755859,1533.5, 10.39 ,0,0,92
atmlv2 = 2176.6000976563,2443.6999511719, 10.5 ,0,0,178
atmlv3 = 2159.5,950.79998779297, 10.699999809265 ,0,0,270

atmler = { { 2116, -1118.3000488281,24.89999961853,0,0,162 }, { 1186.1999511719,-1374.3000488281, 13.199999809265 ,0,0,90 }, { 1975.4000244141,-2176.1000976563, 13.199999809265 ,0,0,178 }, { -1571.0999755859,666.59997558594, 6.8000001907349 ,0,0,88 }, { -2655.8999023438,257.89999389648, 4 ,0,0,90 }, {-74.800003051758,1116.3000488281, 19.39999961853 ,0,0,90 }, { 1715.5999755859,1533.5, 10.39 ,0,0,92 }, { 2176.6000976563,2443.6999511719, 10.5 ,0,0,178 }, { 2159.5,950.79998779297, 10.699999809265 ,0,0,270 } }


atm = {}
function displayLoadedRes ( res )
 for theKey,theAtm in ipairs(atmler) do 
atm[theAtm] = createObject ( 2942,  theAtm [ 1 ],  theAtm  [ 2 ],  theAtm [ 3 ], theAtm [ 4 ], theAtm [ 5 ], theAtm [ 6 ] )
atmx, atmy, atmz = getElementPosition (atm[theAtm])
atmMarker = createMarker ( atmx, atmy, atmz -1, "cylinder", 1.5, 100, 100, 200, 170 )
setElementData (atmMarker,"atm",true)
atmBlip = createBlipAttachedTo ( atm[theAtm], 52 )
setBlipVisibleDistance (atmBlip,200)
setElementCollisionsEnabled(atm[theAtm], false)
end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )


function MarkerHit( hitElement, matchingDimension )
if ((getElementType(hitElement) == "player")) then
local acc = getPlayerAccount (hitElement)
 if (acc and not isGuestAccount (acc)) then
  local atmmi = getElementData (source,"atm")
   if (atmmi == true) then
      triggerClientEvent(hitElement, "bankaGuiAc", hitElement)
end
end
end
end
addEventHandler( "onMarkerHit", getRootElement(), MarkerHit )


function getCurrentDateAndTime()
	local realTime = getRealTime()
    local cDate = string.format("%04d/%02d/%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
	return cDate
end


addEvent("bankaBilgileri",true) 
addEventHandler("bankaBilgileri",root, 
function ()
local acc = getPlayerAccount (source)
 local kartSifre = getAccountData (acc,"KartSifresi")
  if (kartSifre) then
   local bankaParasi = getAccountData (acc,"BankaPara")
    local kurulumTarih = getAccountData (acc,"BankaKurmaTarih")
	 local Pname = getPlayerName (source)
	  triggerClientEvent(source, "BankaBilgileriGoster", source,Pname,bankaParasi,kurulumTarih)
	else
	  triggerClientEvent(source, "HataMesaji", source,"You don't have a bank account!")
end
end
)

addEvent("atmSoydu",true) 
addEventHandler("atmSoydu",root, 
function ()
local data = getElementData (source,"AtmSoyuyor")
 if (data == true) then
 local para = math.random (4000,8000)
  givePlayerMoney (source,para)
  setElementData (source,"atmSoyabilirmi",false)
  setTimer ( setElementData, 180000, 1, source,"atmSoyabilirmi",true)
  setTimer ( outputChatBox, 180000, 1,"You can hack the atm now!",source,0,255,0)
  outputChatBox("You hacked the ATM and received  "..para.."! You can hack the atm again in 180 seconds." ,source,0,255,0,true)
   local wanted = getPlayerWantedLevel (source)
    if (wanted < 3) then
	 setPlayerWantedLevel (source,wanted + 1)
end
end
end
)

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		setElementData (source,"AtmSoyuyor",false)
		triggerClientEvent(source, "soymaEkraniKapat",source)
	end
)


function outputChange1(dataName,oldValue)
	if getElementType(source) == "player" then 
		 if (dataName == "Yakalanma") then
		  local dataa = getElementData (source,"Yakalanma")
		   if (dataa == true) then
		   		setElementData (source,"AtmSoyuyor",false)
		triggerClientEvent(source, "soymaEkraniKapat",source)
end
end
end
end
addEventHandler("onElementDataChange",getRootElement(),outputChange1)

function outputChange2(dataName,oldValue)
	if getElementType(source) == "player" then 
		 if (dataName == "Tutuklanma") then
		  local dataa = getElementData (source,"Tutuklanma")
		   if (dataa == true) then
		   		setElementData (source,"AtmSoyuyor",false)
		triggerClientEvent(source, "soymaEkraniKapat",source)
end
end
end
end
addEventHandler("onElementDataChange",getRootElement(),outputChange2)

addEvent("SifreUnuttum",true) 
addEventHandler("SifreUnuttum",root, 
function ()
local acc = getPlayerAccount (source)
 local kartSifre = getAccountData (acc,"KartSifresi")
 local soru = getAccountData (acc,"SifreSorusu")
 local cevap = getAccountData (acc,"SifreSorusuCevabi")
  if (kartSifre) then
	  triggerClientEvent(source, "KartSifreDegisC",source,soru,cevap)
	else
	  triggerClientEvent(source, "HataMesaji", source,"You don't have a bank account!")
end
end
)

addEvent("ParaCek",true) 
addEventHandler("ParaCek",root, 
function ()
local acc = getPlayerAccount (source)
 local kartSifre = getAccountData (acc,"KartSifresi")
  if (kartSifre) then
   local bankaParasi = getAccountData (acc,"BankaPara")
	  triggerClientEvent(source, "paraCekmeyeBasla", source,bankaParasi)
	else
	  triggerClientEvent(source, "HataMesaji", source,"You don't have a bank account!")
end
end
)




addEvent("KartOlustur",true) 
addEventHandler("KartOlustur",root, 
function ()
local acc = getPlayerAccount (source)
 local kartSifre = getAccountData (acc,"KartSifresi")
  if not (kartSifre) then
	  triggerClientEvent(source, "KartOlusturC", source)
	else
	  triggerClientEvent(source, "HataMesaji", source,"You already have a bank account!")
end
end
)

addEvent("kartOlusturdu",true) 
addEventHandler("kartOlusturdu",root, 
function (sifre,soru,cevap)
local acc = getPlayerAccount (source)
setAccountData (acc,"SifreSorusu",soru)
setAccountData (acc,"SifreSorusuCevabi",cevap)
 setAccountData (acc,"KartSifresi",sifre)
 setAccountData (acc,"BankaPara",0)
 local cDate = getCurrentDateAndTime()
 setAccountData (acc,"BankaKurmaTarih",""..cDate.."")
end
)

addEvent("ParaYatir",true) 
addEventHandler("ParaYatir",root, 
function ()
local acc = getPlayerAccount (source)
 local kartSifre = getAccountData (acc,"KartSifresi")
  if (kartSifre) then
   local bankaParasi = getAccountData (acc,"BankaPara")
	  triggerClientEvent(source, "paraYatirmayaBasla", source,bankaParasi)
	else
	  triggerClientEvent(source, "HataMesaji", source,"You don't have a bank account!")
end
end
)



addEvent("sifreDeneme",true) 
addEventHandler("sifreDeneme",root, 
function (sifre1,sifre2,sifre3,sifre4,tip)
local acc = getPlayerAccount (source)
if (sifre1) and (sifre2) and (sifre3) and (sifre4) then
 local kartSifre = getAccountData (acc,"KartSifresi")
  if (kartSifre) then
  local gelenSifre = ""..sifre1..""..sifre2..""..sifre3..""..sifre4..""
   if (tostring(gelenSifre) == kartSifre) then
   local bankaParasi = getAccountData (acc,"BankaPara")
   local kendiParasi = getPlayerMoney (source)
    if (tip == "Cekme") then
	  triggerClientEvent(source, "ParaCekmeEkrani", source,bankaParasi)
    elseif (tip == "Yatirma") then
	  triggerClientEvent(source, "ParaYatirmaEkrani", source,kendiParasi,bankaParasi)
	  end
	else
	  triggerClientEvent(source, "HataMesaji2", source,"Wrong or missing password!")
end
end
end
end
)


addEvent("paraYatirPara",true) 
addEventHandler("paraYatirPara",root, 
function (miktar)
local acc = getPlayerAccount (source)
 if (miktar) then
  local para = getPlayerMoney (source)
   if (para >= tonumber(miktar)) then
    local bankaParasi = getAccountData (acc,"BankaPara")
	 takePlayerMoney (source,miktar)
	 setAccountData (acc,"BankaPara",tonumber(bankaParasi) + tonumber (miktar))
	  local bankaParasi2 = getAccountData (acc,"BankaPara")
	  local para = getPlayerMoney (source)
	 triggerClientEvent(source, "paraYatirParaC", source,bankaParasi2,para,""..tostring(miktar).." $ has been deposited!")
	 	 local pName = getPlayerName (source)
	 local BankMiktar = getAccountData (acc,"BankaPara")
	else 
		  local bankaParasi2 = getAccountData (acc,"BankaPara")
	  local para = getPlayerMoney (source)
	triggerClientEvent(source, "paraYatirParaC", source,bankaParasi2,para,"Not enough money!")
end
end
end
)

addEvent("sifreDegismeDenemesi",true) 
addEventHandler("sifreDegismeDenemesi",root, 
function (cevap,sifre)
local acc = getPlayerAccount (source)
 if (cevap and sifre) then
    local sifre2 = getAccountData (acc,"KartSifresi")
	local cevap2 = getAccountData (acc,"SifreSorusuCevabi")
   if (tostring(cevap) == tostring(cevap2)) then
	 triggerClientEvent(source, "sifreYaziGoster", source,"Your password has been changed!")
	 setAccountData (acc,"KartSifresi",sifre)
	else 
	local sifre = getAccountData (acc,"KartSifresi")
	triggerClientEvent(source, "sifreYaziGoster", source,"The answer is wrong!")
end
end
end
)



addEvent("paraCekPara",true) 
addEventHandler("paraCekPara",root, 
function (miktar)
local acc = getPlayerAccount (source)
 if (miktar) then
  local bankaParasi = getAccountData (acc,"BankaPara")
   if (tonumber(bankaParasi) >= tonumber(miktar)) then
	 givePlayerMoney (source,tonumber(miktar))
	 setAccountData (acc,"BankaPara",tonumber(bankaParasi) - tonumber (miktar))
	  local bankaParasi2 = getAccountData (acc,"BankaPara")
	 triggerClientEvent(source, "paraCekParaC", source,bankaParasi2,""..tostring(miktar).." $ Has been withdrawn!")
	 local pName = getPlayerName (source)
	 local BankMiktar = getAccountData (acc,"BankaPara")
	else 
		  local bankaParasi2 = getAccountData (acc,"BankaPara")
	triggerClientEvent(source, "paraCekParaC", source,bankaParasi2,"You don't have enough money in the bank!")
end
end
end
)




















