        GUI = guiCreateWindow(436, 271, 253, 246, "Change password - By lLinux", false)
        guiWindowSetSizable(GUI, false)
		guiSetVisible(GUI, false)
		

        Label_Account = guiCreateLabel(10, 31, 52, 15, "Account:", false, GUI)
        Cuenta = guiCreateLabel(72, 31, 171, 15, "none", false, GUI)
        guiLabelSetColor(Cuenta, 255, 0, 0)
        Label_Newpass1 = guiCreateLabel(10, 56, 233, 19, "NEW PASSWORD:", false, GUI)
        guiLabelSetHorizontalAlign(Label_Newpass1, "center", false)
        Edit_pass1 = guiCreateEdit(10, 81, 233, 24, "PASSWORD", false, GUI)

        Label_Newpass2 = guiCreateLabel(10, 115, 233, 19, "REPEAT NEW PASSWORD:", false, GUI)
        guiLabelSetHorizontalAlign(Label_Newpass2, "center", false)
        Edit_pass2 = guiCreateEdit(10, 144, 233, 24, "PASSWORD", false, GUI)
		
        Boton_change = guiCreateButton(45, 178, 81, 26, "CHANGE", false, GUI)
        guiSetProperty(Boton_change, "NormalTextColour", "FFAAAAAA")
        Boton_cancel = guiCreateButton(126, 178, 81, 26, "CANCEL", false, GUI)
        guiSetProperty(Boton_cancel, "NormalTextColour", "FFAAAAAA")
        Boton_help = guiCreateButton(86, 204, 81, 26, "HELP", false, GUI)
        guiSetProperty(Boton_help, "NormalTextColour", "FFAAAAAA")


        GUI2 = guiCreateWindow(690, 271, 256, 315, "HELP", false)
        guiWindowSetSizable(GUI2, false)
		guiSetVisible(GUI2, false)

        scrollpanel = guiCreateScrollPane(10, 27, 236, 241, false, GUI2)

        text_help = guiCreateLabel(0, 0, 243, 245, "/changep = open panel\n\n*remember to log in.\n*CHANGE = change the password.\n*CANCEL = close panel.\n*HELP = open help panel.\n*CLOSE = close help panel\n\n==[[INFORMATION]]==\n\nScript by lLinux(HackerlLinux)\nSkype: HackerlLinux\nFB: www.fb.com/lLinux\nWeb: http://scriptingmtasa.wordpress.com", false, scrollpanel)

        Boton_close = guiCreateButton(86, 278, 85, 25, "CLOSE", false, GUI2)
        guiSetProperty(Boton_close, "NormalTextColour", "FFAAAAAA")   
		--
		showCursor(false)
		
		
		function Abrir()
			triggerServerEvent("obAccount", getLocalPlayer(), getLocalPlayer())
		end
		addCommandHandler("changep", Abrir)
		
		function abrir2(PCuenta)
			guiSetText(Cuenta, PCuenta)
			guiSetVisible(GUI, true)
			showCursor(true)
		end
		addEvent("OnDatas",true)
		addEventHandler("OnDatas",getLocalPlayer(),abrir2)
		
		function cerrar()
			guiSetVisible(GUI, false)
			guiSetVisible(GUI2, false)
			showCursor(false)
		end
		addEventHandler("onClientGUIClick", Boton_cancel, cerrar, false)
		
		function abrirhelp()
			if (guiGetVisible(GUI2)) == false then
				guiSetVisible(GUI2, true)
			else
				guiSetVisible(GUI2, false)
			end
		end
		addEventHandler("onClientGUIClick", Boton_help, abrirhelp, false)
		
		function cerrarhelp()
			guiSetVisible(GUI2, false)
		end
		addEventHandler("onClientGUIClick", Boton_close, cerrarhelp, false)
		
		function clearedit()
			if (source == Edit_pass1) then
				guiSetText(Edit_pass1, "")
				guiEditSetMasked(Edit_pass1, true)
			elseif (source == Edit_pass2) then
				guiSetText(Edit_pass2, "")
				guiEditSetMasked(Edit_pass2, true)
			end
		end
		addEventHandler("onClientGUIClick", root, clearedit)
		
		function cambiarpass()
			newpass1 = guiGetText(Edit_pass1)
			newpass2 = guiGetText(Edit_pass2)
			if (newpass1 == newpass2) then
				triggerServerEvent ("Cambiar", getLocalPlayer(), newpass1)
			else
				triggerServerEvent("ErrorPass", getLocalPlayer(), getLocalPlayer())
			end
		end
		addEventHandler("onClientGUIClick", Boton_change, cambiarpass, false)

