local screenW, screenH = guiGetScreenSize()
        atmAnaEkran = guiCreateStaticImage((screenW - 866) / 2, (screenH - 610) / 2, 866, 610, "IconsFonts/atmBG.png", false)

        bankaBilgileriButton = guiCreateButton(156, 233, 75, 56, "", false, atmAnaEkran)
        guiSetProperty(bankaBilgileriButton, "NormalTextColour", "FFAAAAAA")
        gereksiz3 = guiCreateLabel(261, 243, 251, 42, "My bank", false, atmAnaEkran)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 20)
        guiSetFont(gereksiz3, font0_KeepCalmMedium)
        guiLabelSetColor(gereksiz3, 0, 0, 0)
        gereksiz1 = guiCreateLabel(62, 23, 267, 15, "Welcome to the Town Bank!", false, atmAnaEkran)
        guiSetFont(gereksiz1, "default-bold-small")
        guiLabelSetColor(gereksiz1, 0, 0, 0)
        gereksiz2 = guiCreateLabel(562, 19, 263, 19, "If your first visit please create an account.", false, atmAnaEkran)
        guiSetFont(gereksiz2, "default-bold-small")
        guiLabelSetColor(gereksiz2, 0, 0, 0)
        gereksiz4 = guiCreateLabel(261, 321, 251, 42, "Withdraw money", false, atmAnaEkran)
        guiSetFont(gereksiz4, font0_KeepCalmMedium)
        guiLabelSetColor(gereksiz4, 0, 0, 0)
        gereksiz5 = guiCreateLabel(261, 397, 251, 42, "Deposit money", false, atmAnaEkran)
        guiSetFont(gereksiz5, font0_KeepCalmMedium)
        guiLabelSetColor(gereksiz5, 0, 0, 0)
        gereksiz6 = guiCreateLabel(261, 472, 298, 35, "Create an account", false, atmAnaEkran)
        guiSetFont(gereksiz6, font0_KeepCalmMedium)
        guiLabelSetColor(gereksiz6, 0, 0, 0)
        SifreUnuttum = guiCreateButton(625, 513, 150, 17, "Forgot password?", false, atmAnaEkran)
        guiSetFont(SifreUnuttum, "default-bold-small")
        guiSetProperty(SifreUnuttum, "NormalTextColour", "FFCE9B21")
        DurumLabel = guiCreateLabel(69, 566, 780, 38, "", false, atmAnaEkran)
        guiSetFont(DurumLabel, font0_KeepCalmMedium)
        guiLabelSetColor(DurumLabel, 0, 0, 0)
        CikisButton = guiCreateButton(642, 176, 131, 30, "EXIT", false, atmAnaEkran)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 15)
        guiSetFont(CikisButton, font1_KeepCalmMedium)
        guiSetProperty(CikisButton, "NormalTextColour", "FFF00000")
        ATMparaCekButton = guiCreateButton(156, 311, 75, 56, "", false, atmAnaEkran)
        guiSetProperty(ATMparaCekButton, "NormalTextColour", "FFAAAAAA")
        ATMparaYatirButton = guiCreateButton(156, 386, 75, 56, "", false, atmAnaEkran)
        guiSetProperty(ATMparaYatirButton, "NormalTextColour", "FFAAAAAA")
        kartOlusturButton = guiCreateButton(156, 461, 75, 56, "", false, atmAnaEkran)
        guiSetProperty(kartOlusturButton, "NormalTextColour", "FFAAAAAA")    
        atmSoyButton = guiCreateButton(175, 175, 131, 30, "Hack ATM", false, atmAnaEkran)
        guiSetFont(atmSoyButton, font1_KeepCalmMedium)
        guiSetProperty(atmSoyButton, "NormalTextColour", "FFF00000")
		guiSetVisible (atmAnaEkran,false)
-----------------------------------------------------------------------------------------------------------------------------		
local screenW, screenH = guiGetScreenSize()
        atmKartBilgileriEkran = guiCreateStaticImage((screenW - 866) / 2, (screenH - 610) / 2, 866, 610, "IconsFonts/atmBG.png", false)

        bankaBilgileriGeriDonButton = guiCreateButton(642, 176, 131, 30, "Back", false, atmKartBilgileriEkran)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 12)
        guiSetFont(bankaBilgileriGeriDonButton, font0_KeepCalmMedium)
        guiSetProperty(bankaBilgileriGeriDonButton, "NormalTextColour", "FFFF0000")
        GereksizLabel22 = guiCreateLabel(230, 229, 456, 66, "Your Account", false, atmKartBilgileriEkran)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 35)
        guiSetFont(GereksizLabel22, font1_KeepCalmMedium)
        guiLabelSetColor(GereksizLabel22, 13, 0, 0)
        kartSahibiLabel = guiCreateLabel(80, 300, 663, 44, "Owner:", false, atmKartBilgileriEkran)
        local font2_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 20)
        guiSetFont(kartSahibiLabel, font2_KeepCalmMedium)
        guiLabelSetColor(kartSahibiLabel, 13, 0, 0)
        mevcutBakiyeLabel = guiCreateLabel(80, 364, 714, 44, "Money in the bank:", false, atmKartBilgileriEkran)
        guiSetFont(mevcutBakiyeLabel, font2_KeepCalmMedium)
        guiLabelSetColor(mevcutBakiyeLabel, 13, 0, 0)
        kartAlimTarihi = guiCreateLabel(80, 433, 714, 41, "Creating date:", false, atmKartBilgileriEkran)
        guiSetFont(kartAlimTarihi, font2_KeepCalmMedium)
        guiLabelSetColor(kartAlimTarihi, 13, 0, 0)    
		guiSetVisible(atmKartBilgileriEkran,false)
------------------------------------------------------------------------------------------------------------------------
local screenW, screenH = guiGetScreenSize()
        atmParaCekmeEkrani = guiCreateStaticImage((screenW - 866) / 2, (screenH - 610) / 2, 866, 610, "IconsFonts/atmBG.png", false)

        gereksiz33 = guiCreateLabel(306, 223, 394, 58, "Withdraw Money", false, atmParaCekmeEkrani)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 25)
        guiSetFont(gereksiz33, font0_KeepCalmMedium)
        guiLabelSetColor(gereksiz33, 13, 0, 0)
        paraCekmeMevcutBakiye = guiCreateLabel(93, 290, 749, 46, "Money in the bank:", false, atmParaCekmeEkrani)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 20)
        guiSetFont(paraCekmeMevcutBakiye, font1_KeepCalmMedium)
        guiLabelSetColor(paraCekmeMevcutBakiye, 13, 0, 0)
        gereksizLabel334 = guiCreateLabel(93, 359, 450, 44, "Amount you want to withdraw:", false, atmParaCekmeEkrani)
        guiSetFont(gereksizLabel334, font1_KeepCalmMedium)
        guiLabelSetColor(gereksizLabel334, 13, 0, 0)
        paraCekEdit = guiCreateEdit(550, 358, 109, 35, "", false, atmParaCekmeEkrani)
        guiSetProperty(paraCekEdit, "NormalTextColour", "FFF90A0A")
        guiEditSetMaxLength(paraCekEdit, 10)
        paraCeKButton = guiCreateButton(284, 442, 309, 58, "Withdraw money", false, atmParaCekmeEkrani)
        local font2_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 15)
        guiSetFont(paraCeKButton, font2_KeepCalmMedium)
        guiSetProperty(paraCeKButton, "NormalTextColour", "FF97D52F")
        paraCekmeGeriDonButton = guiCreateButton(642, 176, 131, 30, "Back", false, atmParaCekmeEkrani)
        local font3_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 12)
        guiSetFont(paraCekmeGeriDonButton, font3_KeepCalmMedium)
        guiSetProperty(paraCekmeGeriDonButton, "NormalTextColour", "FFF90A0A")
        ParaCekmeDurumLabel = guiCreateLabel(69, 566, 780, 38, "", false, atmParaCekmeEkrani)
        guiSetFont(ParaCekmeDurumLabel, font1_KeepCalmMedium)
        guiLabelSetColor(ParaCekmeDurumLabel, 0, 0, 0)   
guiSetVisible (atmParaCekmeEkrani,false)		
-----------------------------------------------------------------------------------------
local screenW, screenH = guiGetScreenSize()
        sifreWindow = guiCreateStaticImage((screenW - 466) / 2, (screenH - 506) / 2, 466, 506, "IconsFonts/klavye.png", false)

        sifre1button = guiCreateButton(38, 55, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre1button, 0.51)
        guiSetProperty(sifre1button, "NormalTextColour", "FFAAAAAA")
        sifreGirisButton = guiCreateButton(341, 54, 95, 89, "Enter", false, sifreWindow)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 16)
        guiSetFont(sifreGirisButton, font0_KeepCalmMedium)
        guiSetProperty(sifreGirisButton, "NormalTextColour", "FF32D321")
        sifreSilButton = guiCreateButton(341, 160, 95, 89, "Remove", false, sifreWindow)
        guiSetFont(sifreSilButton, font0_KeepCalmMedium)
        guiSetProperty(sifreSilButton, "NormalTextColour", "FFCF9D24")
        sifreCikisButton = guiCreateButton(341, 265, 95, 89, "Exit", false, sifreWindow)
        guiSetFont(sifreCikisButton, font0_KeepCalmMedium)
        guiSetProperty(sifreCikisButton, "NormalTextColour", "FFEC1106")
        sifre2 = guiCreateButton(133, 55, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre2, 0.51)
        guiSetProperty(sifre2, "NormalTextColour", "FFAAAAAA")
        sifre3 = guiCreateButton(223, 54, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre3, 0.51)
        guiSetProperty(sifre3, "NormalTextColour", "FFAAAAAA")
        sifre6 = guiCreateButton(223, 160, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre6, 0.51)
        guiSetProperty(sifre6, "NormalTextColour", "FFAAAAAA")
        sifre5 = guiCreateButton(133, 160, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre5, 0.51)
        guiSetProperty(sifre5, "NormalTextColour", "FFAAAAAA")
        sifre4 = guiCreateButton(38, 160, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre4, 0.51)
        guiSetProperty(sifre4, "NormalTextColour", "FFAAAAAA")
        sifre7 = guiCreateButton(38, 266, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre7, 0.51)
        guiSetProperty(sifre7, "NormalTextColour", "FFAAAAAA")
        sifre8 = guiCreateButton(133, 266, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre8, 0.51)
        guiSetProperty(sifre8, "NormalTextColour", "FFAAAAAA")
        sifre9 = guiCreateButton(223, 266, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre9, 0.51)
        guiSetProperty(sifre9, "NormalTextColour", "FFAAAAAA")
        sifre0 = guiCreateButton(133, 373, 80, 88, "", false, sifreWindow)
        guiSetAlpha(sifre0, 0.51)
        guiSetProperty(sifre0, "NormalTextColour", "FFAAAAAA")
        gereksizBar = guiCreateProgressBar(66, 22, 181, 27, false, sifreWindow)

        sifreLabel1 = guiCreateLabel(15, 5, 31, 18, "", false, gereksizBar)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 15)
        guiSetFont(sifreLabel1, font1_KeepCalmMedium)
        sifreLabel2 = guiCreateLabel(51, 5, 31, 18, "", false, gereksizBar)
        guiSetFont(sifreLabel2, font1_KeepCalmMedium)
        sifreLabel3 = guiCreateLabel(88, 5, 31, 18, "", false, gereksizBar)
        guiSetFont(sifreLabel3, font1_KeepCalmMedium)
        sifreLabel4 = guiCreateLabel(124, 5, 31, 18, "", false, gereksizBar)
        guiSetFont(sifreLabel4, font1_KeepCalmMedium)

        SifrePaneliDurumLabel = guiCreateLabel(65, 466, 357, 30, "", false, sifreWindow)
        local font2_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 18)
        guiSetFont(SifrePaneliDurumLabel, font2_KeepCalmMedium)
        guiLabelSetColor(SifrePaneliDurumLabel, 3, 0, 0)    
		guiSetVisible (sifreWindow,false)
		--------------------------------------------------------------------------------------
local screenW, screenH = guiGetScreenSize()
        atmParaYatirmaEkrani = guiCreateStaticImage((screenW - 866) / 2, (screenH - 610) / 2, 866, 610, "IconsFonts/atmBG.png", false)

        gereksizsmaan = guiCreateLabel(308, 225, 262, 48, "Deposit Money", false, atmParaYatirmaEkrani)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 25)
        guiSetFont(gereksizsmaan, font0_KeepCalmMedium)
        guiLabelSetColor(gereksizsmaan, 3, 0, 0)
        kendiParanizLabel = guiCreateLabel(86, 274, 703, 42, "Your money:", false, atmParaYatirmaEkrani)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 20)
        guiSetFont(kendiParanizLabel, font1_KeepCalmMedium)
        guiLabelSetColor(kendiParanizLabel, 3, 0, 0)
        paraYatirmaHesabinizdakiPara = guiCreateLabel(86, 322, 703, 42, "Money in the bank:", false, atmParaYatirmaEkrani)
        guiSetFont(paraYatirmaHesabinizdakiPara, font1_KeepCalmMedium)
        guiLabelSetColor(paraYatirmaHesabinizdakiPara, 3, 0, 0)
        gereksiz3131 = guiCreateLabel(86, 385, 420, 31, "Amount you want to deposit:", false, atmParaYatirmaEkrani)
        guiSetFont(gereksiz3131, font1_KeepCalmMedium)
        guiLabelSetColor(gereksiz3131, 3, 0, 0)
        paraYatirmaMiktarLabel = guiCreateEdit(510, 388, 166, 28, "", false, atmParaYatirmaEkrani)
        guiEditSetMaxLength(paraYatirmaMiktarLabel, 10)
        paraYatirButton = guiCreateButton(290, 464, 302, 60, "Deposit money", false, atmParaYatirmaEkrani)
        guiSetFont(paraYatirButton, font1_KeepCalmMedium)
        guiSetProperty(paraYatirButton, "NormalTextColour", "FF89FF13")
        paraYatirmaGeriDon = guiCreateButton(642, 176, 131, 30, "Back", false, atmParaYatirmaEkrani)
        local font2_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 12)
        guiSetFont(paraYatirmaGeriDon, font2_KeepCalmMedium)
        guiSetProperty(paraYatirmaGeriDon, "NormalTextColour", "FFFC1515") 
		
		ParaYatirmaDurumLabel = guiCreateLabel(69, 566, 780, 38, "", false, atmParaYatirmaEkrani)
        guiSetFont(ParaYatirmaDurumLabel, font1_KeepCalmMedium)
        guiLabelSetColor(ParaYatirmaDurumLabel, 0, 0, 0)   
guiSetVisible (atmParaYatirmaEkrani,false)		
---------------------------------------------------------------------------------------------------		
local screenW, screenH = guiGetScreenSize()
        HesapOlusturmaEkrani = guiCreateStaticImage((screenW - 866) / 2, (screenH - 610) / 2, 866, 610, "IconsFonts/atmBG.png", false)

        hesapolusgerreksiz = guiCreateLabel(265, 228, 421, 52, "Create an Account", false, HesapOlusturmaEkrani)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 25)
        guiSetFont(hesapolusgerreksiz, font0_KeepCalmMedium)
        guiLabelSetColor(hesapolusgerreksiz, 7, 0, 0)
        budagereksiz = guiCreateLabel(96, 291, 260, 31, "Write a 4-digit password:", false, HesapOlusturmaEkrani)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 15)
        guiSetFont(budagereksiz, font1_KeepCalmMedium)
        guiLabelSetColor(budagereksiz, 7, 0, 0)
        gereksizzzzzzzzz = guiCreateLabel(96, 370, 277, 35, "Select a security question:", false, HesapOlusturmaEkrani)
        guiSetFont(gereksizzzzzzzzz, font1_KeepCalmMedium)
        guiLabelSetColor(gereksizzzzzzzzz, 7, 0, 0)
        GuvenlikSorulariSecim = guiCreateComboBox(399, 371, 239, 89, "", false, HesapOlusturmaEkrani)
        guiComboBoxAddItem(GuvenlikSorulariSecim, "What is your pet’s name?")
        guiComboBoxAddItem(GuvenlikSorulariSecim, "What time of the day were you born? ")
        guiComboBoxAddItem(GuvenlikSorulariSecim, "In what year was your father born?")
        guiComboBoxAddItem(GuvenlikSorulariSecim, "Who is your favorite friend?")
        hesapOlusturButton = guiCreateButton(303, 481, 257, 41, "Create Account", false, HesapOlusturmaEkrani)
        local font2_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 10)
        guiSetFont(hesapOlusturButton, font2_KeepCalmMedium)
        guiSetProperty(hesapOlusturButton, "NormalTextColour", "FF96DA46")
        vallagereksiz = guiCreateLabel(96, 430, 140, 31, "Your answer:", false, HesapOlusturmaEkrani)
        guiSetFont(vallagereksiz, font1_KeepCalmMedium)
        guiLabelSetColor(vallagereksiz, 7, 0, 0)
        GuvenlikCevabiEdit = guiCreateEdit(242, 430, 423, 30, "", false, HesapOlusturmaEkrani)
        guiEditSetMaxLength(GuvenlikCevabiEdit, 30)
        grkszz = guiCreateLabel(669, 432, 187, 28, "Warning: case-sensitive!", false, HesapOlusturmaEkrani)
        guiSetFont(grkszz, font2_KeepCalmMedium)
        guiLabelSetColor(grkszz, 0, 0, 0)
        sifreEdit = guiCreateEdit(370, 290, 128, 32, "", false, HesapOlusturmaEkrani)
        guiEditSetMasked(sifreEdit, true)
        guiEditSetMaxLength(sifreEdit, 4)
        hesapOlusturmaGeriDon = guiCreateButton(634, 179, 136, 27, "Back", false, HesapOlusturmaEkrani)
        local font3_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 12)
        guiSetFont(hesapOlusturmaGeriDon, font3_KeepCalmMedium)
        guiSetProperty(hesapOlusturmaGeriDon, "NormalTextColour", "FFE22222")
        hesapOlusturmaBilgiLabel = guiCreateLabel(145, 562, 569, 38, "", false, HesapOlusturmaEkrani)
        local font4_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 20)
        guiSetFont(hesapOlusturmaBilgiLabel, font4_KeepCalmMedium)
        guiLabelSetColor(hesapOlusturmaBilgiLabel, 0, 0, 0)   
guiSetVisible (HesapOlusturmaEkrani,false)		
--------------------------------------------------------------------------------------------------------------	
local screenW, screenH = guiGetScreenSize()
        sifreDegistirmeWindow = guiCreateStaticImage((screenW - 866) / 2, (screenH - 610) / 2, 866, 610, "IconsFonts/atmBG.png", false)

        labelgerreksiz = guiCreateLabel(298, 223, 315, 48, "Forgot Password", false, sifreDegistirmeWindow)
        local font0_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 25)
        guiSetFont(labelgerreksiz, font0_KeepCalmMedium)
        guiLabelSetColor(labelgerreksiz, 0, 0, 0)
        guvenlikSorunuzLabel = guiCreateLabel(90, 275, 665, 54, "Your security question:", false, sifreDegistirmeWindow)
        local font1_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 18)
        guiSetFont(guvenlikSorunuzLabel, font1_KeepCalmMedium)
        guiLabelSetColor(guvenlikSorunuzLabel, 0, 0, 0)
        gerenksizLabl = guiCreateLabel(100, 329, 155, 35, "Your answer:", false, sifreDegistirmeWindow)
        guiSetFont(gerenksizLabl, font1_KeepCalmMedium)
        guiLabelSetColor(gerenksizLabl, 0, 0, 0)
        grnksztuu = guiCreateLabel(100, 384, 180, 33, "New password:", false, sifreDegistirmeWindow)
        guiSetFont(grnksztuu, font1_KeepCalmMedium)
        guiLabelSetColor(grnksztuu, 0, 0, 0)
        cevapEdit = guiCreateEdit(270, 335, 233, 29, "", false, sifreDegistirmeWindow)
        guiEditSetMaxLength(cevapEdit, 30)
        yeniSifreEdit = guiCreateEdit(280, 388, 233, 29, "", false, sifreDegistirmeWindow)
        guiEditSetMaxLength(yeniSifreEdit, 4)
        sifreyiDegistirButton = guiCreateButton(265, 467, 326, 55, "Change password", false, sifreDegistirmeWindow)
        local font2_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 15)
        guiSetFont(sifreyiDegistirButton, font2_KeepCalmMedium)
        guiSetProperty(sifreyiDegistirButton, "NormalTextColour", "FF60A735")    
				SifreDegistirmeDurumLabel = guiCreateLabel(69, 566, 780, 38, "", false, sifreDegistirmeWindow)
        guiSetFont(SifreDegistirmeDurumLabel, font1_KeepCalmMedium)
        guiLabelSetColor(SifreDegistirmeDurumLabel, 0, 0, 0)   
        SifreDegistirmeGeriDon = guiCreateButton(634, 179, 136, 27, "Back", false, sifreDegistirmeWindow)
        local font3_KeepCalmMedium = guiCreateFont("IconsFonts/KeepCalmMedium.ttf", 12)
        guiSetFont(SifreDegistirmeGeriDon, font3_KeepCalmMedium)
        guiSetProperty(SifreDegistirmeGeriDon, "NormalTextColour", "FFE22222")
guiSetVisible (sifreDegistirmeWindow,false)
---------------------------------------------------------------------------------------------------------------------		
        BarMenu = guiCreateMemo(408, 80, 496, 33, "", false)
        guiMemoSetReadOnly(BarMenu, true)

        AtmBar = guiCreateProgressBar(5, 4, 481, 24, false, BarMenu) 
guiSetVisible (BarMenu,false)		
		-------------------------------------------------------------
		setElementData (getLocalPlayer(),"atmSoyabilirmi",true)
function atmSoymA()
  if source == atmSoyButton then
  guiProgressBarSetProgress (AtmBar,0)
   guiSetVisible(BarMenu,true)
guiSetVisible(atmAnaEkran,false)
setElementData (getLocalPlayer(),"AtmSoyuyor",true)
	setTimer ( function()
	  local barpro = guiProgressBarGetProgress(AtmBar)
      guiProgressBarSetProgress (AtmBar, tonumber(barpro) + 1 )
	end, 300, 100 )
		setTimer ( triggerServerEvent, 30000, 1, "atmSoydu",getLocalPlayer() )
	setTimer ( setElementData, 30000, 1, getLocalPlayer(), "AtmSoyuyor", false )
	setTimer ( guiSetVisible, 30000, 1, BarMenu,false)
	setTimer ( guiProgressBarSetProgress, 30000, 1, AtmBar,0)
	setTimer ( showCursor, 30000, 1, false)
end
end 
addEventHandler("onClientGUIClick",getRootElement(),atmSoymA)

function soymaEkraniKapat()
guiSetVisible(BarMenu,false)
guiProgressBarSetProgress (AtmBar,0)
showCursor (false)
end
addEvent("soymaEkraniKapat", true)
addEventHandler("soymaEkraniKapat", root, soymaEkraniKapat)
		
function bankaGuiAc()
local vis = guiGetVisible (atmAnaEkran)
 if (vis == false) then
 local team = getPlayerTeam (getLocalPlayer())
 local crim = getTeamName (team)
 local atmSoymaB = getElementData (getLocalPlayer(),"atmSoyabilirmi")
 if (crim == "Criminals" and atmSoymaB)  then
  guiSetEnabled (atmSoyButton,true)
  else
  guiSetEnabled (atmSoyButton,false)
  end
    guiSetVisible (atmAnaEkran,true)
    showCursor(true)
   guiSetText (DurumLabel,"")
     setElementData (getLocalPlayer(),"label1",false)
   setElementData (getLocalPlayer(),"label2",false)
   setElementData (getLocalPlayer(),"label3",false)
   setElementData (getLocalPlayer(),"label4",false)
	end
end
addEvent("bankaGuiAc", true)
addEventHandler("bankaGuiAc", root, bankaGuiAc)

function BankaBilgileriGoster(Pname,bankaParasi,kurulumTarih)
local vis = guiGetVisible (atmAnaEkran)
 if (vis == true) then
  guiSetVisible (atmAnaEkran,false)
  guiSetVisible (atmKartBilgileriEkran,true)
  guiSetText (kartSahibiLabel,"Owner:    "..tostring(Pname).."")
  guiSetText (mevcutBakiyeLabel,"Money in the bank:    "..tostring(bankaParasi).."")
  guiSetText (kartAlimTarihi,"Creating date:    "..tostring(kurulumTarih).."")
  guiSetText (DurumLabel,"")
	end
end
addEvent("BankaBilgileriGoster", true)
addEventHandler("BankaBilgileriGoster", root, BankaBilgileriGoster)

function paraCekmeyeBasla(bankaParasi)
local vis = guiGetVisible (atmAnaEkran)
 if (vis == true) then
    setElementData (getLocalPlayer(),"label1",false)
   setElementData (getLocalPlayer(),"label2",false)
   setElementData (getLocalPlayer(),"label3",false)
   setElementData (getLocalPlayer(),"label4",false)
      guiSetText (sifreLabel1,"")
   guiSetText (sifreLabel2,"")
   guiSetText (sifreLabel3,"")
   guiSetText (sifreLabel4,"")
  guiSetVisible (atmAnaEkran,false)
  guiSetVisible (sifreWindow,true)
  guiSetText (SifrePaneliDurumLabel,"")
  --guiSetVisible (atmParaCekmeEkrani,true)
  --guiSetText (paraCekmeMevcutBakiye,"Mevcut bakiyeniz:    "..tostring(bankaParasi).."")
  guiSetText (DurumLabel,"")
  tip = "Cekme"
	end
end
addEvent("paraCekmeyeBasla", true)
addEventHandler("paraCekmeyeBasla", root, paraCekmeyeBasla)


function paraYatirmayaBasla(bankaParasi)
local vis = guiGetVisible (atmAnaEkran)
 if (vis == true) then
    setElementData (getLocalPlayer(),"label1",false)
   setElementData (getLocalPlayer(),"label2",false)
   setElementData (getLocalPlayer(),"label3",false)
   setElementData (getLocalPlayer(),"label4",false)
   guiSetText (sifreLabel1,"")
   guiSetText (sifreLabel2,"")
   guiSetText (sifreLabel3,"")
   guiSetText (sifreLabel4,"")
  guiSetVisible (atmAnaEkran,false)
  guiSetVisible (sifreWindow,true)
  guiSetText (SifrePaneliDurumLabel,"")
  --guiSetVisible (atmParaCekmeEkrani,true)
  --guiSetText (paraCekmeMevcutBakiye,"Mevcut bakiyeniz:    "..tostring(bankaParasi).."")
  guiSetText (DurumLabel,"")
  tip = "Yatirma"
	end
end
addEvent("paraYatirmayaBasla", true)
addEventHandler("paraYatirmayaBasla", root, paraYatirmayaBasla)

function ParaCekmeEkrani(bankaParasi)
local vis = guiGetVisible (sifreWindow)
 if (vis == true) then
  guiSetVisible (sifreWindow,false)
  guiSetText (SifrePaneliDurumLabel,"")
  guiSetVisible (atmParaCekmeEkrani,true)
  guiSetText (paraCekmeMevcutBakiye,"Money in the bank:    "..tostring(bankaParasi).."")
  guiSetText (DurumLabel,"")
	end
end
addEvent("ParaCekmeEkrani", true)
addEventHandler("ParaCekmeEkrani", root, ParaCekmeEkrani)

function KartOlusturC()
local vis = guiGetVisible (atmAnaEkran)
 if (vis == true) then
  guiSetText (SifrePaneliDurumLabel,"")
  guiSetVisible (atmAnaEkran,false)
  guiSetVisible (HesapOlusturmaEkrani,true)
  guiSetText (DurumLabel,"")
	end
end
addEvent("KartOlusturC", true)
addEventHandler("KartOlusturC", root, KartOlusturC)

function ParaYatirmaEkrani(kendiParasi,bankaParasi)
local vis = guiGetVisible (sifreWindow)
 if (vis == true) then
  guiSetVisible (sifreWindow,false)
  guiSetText (SifrePaneliDurumLabel,"")
  guiSetVisible (atmParaYatirmaEkrani,true)
  guiSetText (kendiParanizLabel,"Your money:    "..tostring(kendiParasi).."")
  guiSetText (paraYatirmaHesabinizdakiPara,"Money in the bank:    "..tostring(bankaParasi).."")
  guiSetText (DurumLabel,"")
	end
end
addEvent("ParaYatirmaEkrani", true)
addEventHandler("ParaYatirmaEkrani", root, ParaYatirmaEkrani)

function HataMesaji(Mesaj)
if (Mesaj) then
local vis = guiGetVisible (atmAnaEkran)
 if (vis == true) then
  guiSetText (DurumLabel,tostring(Mesaj))
	end
end
end
addEvent("HataMesaji", true)
addEventHandler("HataMesaji", root, HataMesaji)


function HataMesaji2(Mesaj)
if (Mesaj) then
local vis = guiGetVisible (sifreWindow)
 if (vis == true) then
  guiSetText (SifrePaneliDurumLabel,tostring(Mesaj))
	end
end
end
addEvent("HataMesaji2", true)
addEventHandler("HataMesaji2", root, HataMesaji2)

function paraYatirParaC(Miktar,Para,Mesaj)
if (Miktar and Para and Mesaj) then
local vis = guiGetVisible (atmParaYatirmaEkrani)
 if (vis == true) then
  guiSetText (ParaYatirmaDurumLabel,tostring(Mesaj))
  guiSetText (kendiParanizLabel,"Your money:   "..Para.."")
  guiSetText (paraYatirmaHesabinizdakiPara,"Money in the bank:   "..Miktar.."")
	end
end
end
addEvent("paraYatirParaC", true)
addEventHandler("paraYatirParaC", root, paraYatirParaC)

function paraCekParaC(Miktar,Mesaj)
if (Miktar and Mesaj) then
local vis = guiGetVisible (atmParaCekmeEkrani)
 if (vis == true) then
  guiSetText (ParaCekmeDurumLabel,tostring(Mesaj))
  guiSetText (paraCekmeMevcutBakiye,"Money in the bank:   "..Miktar.."")
	end
end
end
addEvent("paraCekParaC", true)
addEventHandler("paraCekParaC", root, paraCekParaC)

function sifreYaziGoster(Mesaj)
if (Mesaj) then
local vis = guiGetVisible (sifreDegistirmeWindow)
 if (vis == true) then
guiSetText (SifreDegistirmeDurumLabel,""..tostring(Mesaj).."")
	end
end
end
addEvent("sifreYaziGoster", true)
addEventHandler("sifreYaziGoster", root, sifreYaziGoster)


function KartSifreDegisC(soru,cevap)
local vis = guiGetVisible (atmAnaEkran)
 if (vis == true) then
guiSetVisible (atmAnaEkran,false)
guiSetText (guvenlikSorunuzLabel,"Your security question:   "..tostring(soru).."")
guiSetVisible (sifreDegistirmeWindow,true)
	end
end
addEvent("KartSifreDegisC", true)
addEventHandler("KartSifreDegisC", root, KartSifreDegisC)

function SifreDegistirArtik()
if source == sifreyiDegistirButton then
  if (guiGetText(cevapEdit)) == "" then guiSetText (SifreDegistirmeDurumLabel,"Please answer your question!") return end
    if type(tonumber(guiGetText(yeniSifreEdit))) == "nil" then guiSetText (SifreDegistirmeDurumLabel,"Please make your password 4-digit number!") return end
  if (tonumber(guiGetText(yeniSifreEdit))) < 0 then guiSetText (SifreDegistirmeDurumLabel,"Please make your password 4-digit number!") return end
triggerServerEvent("sifreDegismeDenemesi",getLocalPlayer(),(guiGetText(cevapEdit)),(guiGetText(yeniSifreEdit)))
end 
end
addEventHandler("onClientGUIClick",getRootElement(),SifreDegistirArtik)


function hesapOlusturmaSet()
local ekranacik = guiGetVisible (HesapOlusturmaEkrani)
 if ekranacik == true then
  if source == hesapOlusturButton then
  if type(tonumber(guiGetText(sifreEdit))) == "nil" then guiSetText (hesapOlusturmaBilgiLabel,"Please make your password 4-digit number!") return end
  if (tonumber(guiGetText(sifreEdit))) < 0 then guiSetText (hesapOlusturmaBilgiLabel,"Please make your password 4-digit number!") return end
  if (guiEditGetCaretIndex (sifreEdit) < 4) then guiSetText (hesapOlusturmaBilgiLabel,"Please make your password 4-digit number!") return end
  local item = guiComboBoxGetSelected(GuvenlikSorulariSecim)
   local text = guiComboBoxGetItemText(GuvenlikSorulariSecim, item)
    if  (text == "") then guiSetText (hesapOlusturmaBilgiLabel,"Please select a security question!") return end
	if  ((guiGetText(GuvenlikCevabiEdit)) == "") then guiSetText (hesapOlusturmaBilgiLabel,"Please answer your question!") return end
   triggerServerEvent("kartOlusturdu",getLocalPlayer(),(guiGetText(sifreEdit)),text,(guiGetText(GuvenlikCevabiEdit)))
      guiSetVisible(HesapOlusturmaEkrani,false)
   guiSetVisible(atmAnaEkran,true)
   guiSetText (hesapOlusturmaBilgiLabel,"")
  elseif source == hesapOlusturmaGeriDon then
   guiSetVisible(HesapOlusturmaEkrani,false)
   guiSetVisible(atmAnaEkran,true)
   guiSetText (hesapOlusturmaBilgiLabel,"")
    end
end
end
addEventHandler("onClientGUIClick",getRootElement(),hesapOlusturmaSet)

function ayarlama3()
local ekranacik = guiGetVisible (atmAnaEkran)
 if ekranacik == true then
  if source == bankaBilgileriButton then
   triggerServerEvent("bankaBilgileri",getLocalPlayer())
  elseif source == SifreUnuttum then
   triggerServerEvent("SifreUnuttum",getLocalPlayer())
  elseif source == ATMparaCekButton then
   triggerServerEvent("ParaCek",getLocalPlayer())
   guiSetText (DurumLabel,"basarili")
  elseif source == ATMparaYatirButton then
   triggerServerEvent("ParaYatir",getLocalPlayer())
  elseif source == kartOlusturButton then
   triggerServerEvent("KartOlustur",getLocalPlayer())   
  elseif source == CikisButton then
   guiSetVisible(atmAnaEkran,false)
   showCursor(false)   
    end
end
end
addEventHandler("onClientGUIClick",getRootElement(),ayarlama3)


function ayarlama5()
  if source == bankaBilgileriGeriDonButton then
   guiSetVisible(atmKartBilgileriEkran,false)
guiSetVisible(atmAnaEkran,true)  

  elseif source == paraCekmeGeriDonButton then 
   guiSetVisible(atmParaCekmeEkrani,false)
guiSetVisible(atmAnaEkran,true) 
  elseif source == SifreDegistirmeGeriDon then 
   guiSetVisible(sifreDegistirmeWindow,false)
guiSetVisible(atmAnaEkran,true) 
  elseif source == paraYatirmaGeriDon then 
   guiSetVisible(atmParaYatirmaEkrani,false)
guiSetVisible(atmAnaEkran,true) 
end 
end
addEventHandler("onClientGUIClick",getRootElement(),ayarlama5)

function paraYatirveCek()
if source == paraYatirButton then
  if type(tonumber(guiGetText(paraYatirmaMiktarLabel))) == "nil" then guiSetText (ParaYatirmaDurumLabel,"Please enter a correct number!") return end
  if (tonumber(guiGetText(paraYatirmaMiktarLabel))) <= 0 then guiSetText (ParaYatirmaDurumLabel,"Please enter a correct number!") return end
triggerServerEvent("paraYatirPara",getLocalPlayer(),(guiGetText(paraYatirmaMiktarLabel)))
  elseif source == paraCeKButton then 
  if type(tonumber(guiGetText(paraCekEdit))) == "nil" then guiSetText (ParaCekmeDurumLabel,"Please enter a correct number!") return end
  if (tonumber(guiGetText(paraCekEdit))) <= 0 then guiSetText (ParaCekmeDurumLabel,"Please enter a correct number!") return end
triggerServerEvent("paraCekPara",getLocalPlayer(),(guiGetText(paraCekEdit)))
end 
end
addEventHandler("onClientGUIClick",getRootElement(),paraYatirveCek)




function SifreYazimi()
local ekranacik = guiGetVisible (sifreWindow)
 if ekranacik == true then
    local label1 = guiGetText (sifreLabel1)
   local label2 = guiGetText (sifreLabel2)
   local label3 = guiGetText (sifreLabel3)
   local label4 = guiGetText (sifreLabel4)
  if source == sifreGirisButton then
  local data1 = getElementData (getLocalPlayer(),"label1")
  local data2 = getElementData (getLocalPlayer(),"label2")
  local data3 = getElementData (getLocalPlayer(),"label3")
  local data4 = getElementData (getLocalPlayer(),"label4")
  triggerServerEvent("sifreDeneme",getLocalPlayer(),data1,data2,data3,data4,tip)
  elseif source == sifreSilButton then
    if (label1 == "*") then
	 if (label1 == "*") and not (label2 == "*") then
	  guiSetText (sifreLabel1,"")
	  setElementData (getLocalPlayer(),"label1",false)
	 elseif (label2 == "*") and not (label3 == "*") then 
	  guiSetText (sifreLabel2,"")
	  setElementData (getLocalPlayer(),"label2",false)
	 elseif (label3 == "*") and not (label4 == "*") then 
	  guiSetText (sifreLabel3,"")
	  setElementData (getLocalPlayer(),"label3",false)
	 elseif (label4 == "*") then 
	  guiSetText (sifreLabel4,"")
	  setElementData (getLocalPlayer(),"label4",false)
	  end
	  end
  elseif source == sifre1button then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","1")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","1")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","1")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","1")
	end
  elseif source == sifre2 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","2")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","2")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","2")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","2")
	end
  elseif source == sifre3 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","3")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","3")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","3")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","3")
	end
  elseif source == sifre4 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","4")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","4")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","4")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","4")
	end
  elseif source == sifre5 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","5")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","5")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","5")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","5")
	end
   elseif source == sifre6 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","6")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","6")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","6")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","6")
	end
  elseif source == sifre7 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","7")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","7")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","7")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","7")
	end
  elseif source == sifre8 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","8")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","8")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","8")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","8")
	end
  elseif source == sifre9 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","9")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","9")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","9")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","9")
	end
  elseif source == sifre0 then
   if (label1 == "") then
    setElementData (getLocalPlayer(),"label1","0")
	guiSetText (sifreLabel1,"*")
   elseif (label1 == "*") and not (label2 == "*") then	
    guiSetText (sifreLabel2,"*")
	setElementData (getLocalPlayer(),"label2","0")
   elseif (label2 == "*") and not (label3 == "*") then	
    guiSetText (sifreLabel3,"*")
	setElementData (getLocalPlayer(),"label3","0")
   elseif (label3 == "*") and not (label4 == "*") then	
    guiSetText (sifreLabel4,"*")
	setElementData (getLocalPlayer(),"label4","0")
	end
  elseif source == sifreCikisButton then
   guiSetVisible(sifreWindow,false)
   guiSetVisible(atmAnaEkran,true)
   setElementData (getLocalPlayer(),"label1",false)
   setElementData (getLocalPlayer(),"label2",false)
   setElementData (getLocalPlayer(),"label3",false)
   setElementData (getLocalPlayer(),"label4",false)
   guiSetText (SifrePaneliDurumLabel,"")
    end
end
end
addEventHandler("onClientGUIClick",getRootElement(),SifreYazimi)


--function btn(button,press) 
 --   if button == "mouse_wheel_up" or button == "mouse_wheel_down" then
--end
--addEventHandler( "onClientKey", root,btn)
