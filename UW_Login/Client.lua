loadstring(exports.dgs:dgsImportFunction())()

local sound = playSound("soundtrack.mp3")
setSoundVolume(sound,1)
function Uw_Login()
	local screenW, screenH = guiGetScreenSize() 
	outputChatBox("Login Iniciado!!")
	local player = getLocalPlayer()
	blurArea = CreateBlur(screenW,screenH)
	Login(player,screenW, screenH)
	Vista()
	showCursor(true)
	showChat(false)
	setPlayerHudComponentVisible ( "all",false)
	guiSetInputEnabled(true)
	-- CloseBlur(blurArea)
end
-- addEventHandler("Uw_Login",true)
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), Uw_Login )


function Login(player,_x,_y)
	Login_Windows = dgsCreateWindow ( 0.5-(0.43/2), 0.5-(0.41/2), 0.43, 0.41, "Login", true,_,_,_,_,_,tocolor(50,50,50,250))
	dgsWindowSetCloseButtonEnabled ( Login_Windows, false)
	dgsWindowSetSizable(Login_Windows,false)
	dgsWindowSetMovable(Login_Windows,false)
	
	local lblUserL= dgsCreateLabel(0.032, 0.09, 0.3, 0.08,"Usuario",true,Login_Windows)
	local txt_user= dgsCreateEdit( 0.032, 0.17, 0.3, 0.08, "", true,Login_Windows )
	dgsEditSetMaxLength (txt_user,20)
	
	local lblUserL2= dgsCreateLabel(0.032, 0.39, 0.3, 0.08,"Contraseña",true,Login_Windows)
	local txt_pass= dgsCreateEdit( 0.032, 0.47, 0.3, 0.08, "", true,Login_Windows )
	dgsEditSetMaxLength (txt_user,20)
	
	local imgFondo = dgsCreateImage(0.57,-0.05,0.45,0.8,"Fondo.png",true,Login_Windows)
	ap = false
	byrk = 0

	function Logo()
		if ap == true then
			byrk = byrk + 0.02
			if byrk >= 1 then
			ap = false
			end
		elseif ap == false then
			byrk = byrk - 0.02
			if byrk <= 0 then
				ap = true
			end		
		end	
		dgsSetAlpha ( imgFondo, byrk)
	end
	addEventHandler ( "onClientRender", getRootElement(getThisResource()), Logo )

	--BOTONES--
	
	--Ingresar
	BtnIngresar=dgsCreateButton(0.05,0.79,0.2,0.09,"Ingresar",true,Login_Windows,_,_,_,_,_,_,tocolor(255,0,0,130))
	function Ingresar()	
		if dgsGetType(source)=="dgs-dxbutton" then
			outputChatBox("BtnIngresar")
			local UserL=dgsGetText(txt_user)
			local PassL=dgsGetText(txt_pass)
			triggerServerEvent ( "Login", resourceRoot,player,UserL,PassL)
		end
	end
	addEventHandler ( "onDgsMouseClickDown", BtnIngresar, Ingresar )
	
	--Invitado
	BtnInvitado=dgsCreateButton(0.4,0.79,0.2,0.09,"Invitado",true,Login_Windows,_,_,_,_,_,_,tocolor(255,0,0,130))
	function Invitado()
		if dgsGetType(source)=="dgs-dxbutton" then
			outputChatBox("BtnInvitado")
			CerrarLogin()
			triggerServerEvent ( "invitado", resourceRoot,player)
		end
	end
	addEventHandler ( "onDgsMouseClickDown", BtnInvitado, Invitado )
	
	--Registrar
	BtnRegistro=dgsCreateButton(0.75,0.79,0.2,0.09,"Registrar",true,Login_Windows,_,_,_,_,_,_,tocolor(255,0,0,130))
	function Registro()
		if dgsGetType(source)=="dgs-dxbutton" then
			outputChatBox("BtnRegistro")
			dgsCloseWindow(Login_Windows)
			Register(player,_x,_y)
			removeEventHandler("onClientRender", getRootElement(getThisResource()), Logo) 
		end
	end
	addEventHandler ( "onDgsMouseClickDown", BtnRegistro, Registro )
end	
	
function Register(player,_x,_y)
Register_Windows = dgsCreateWindow ( (_x - 656) / 2, (_y - 493) / 2, 656, 493, "Panel de Registro Underworld", false,_,_,_,_,_,tocolor(50,50,50,250))
	dgsWindowSetCloseButtonEnabled ( Register_Windows, false)
	dgsWindowSetSizable(Register_Windows,false)
	dgsWindowSetMovable(Register_Windows,false)
	LblInfo= dgsCreateLabel(0.02,0.01,1,0.1,"Ingresa los datos correctos dentro los espacios en blanco que se muestran en el panel, estos datos pueden ",true,Register_Windows)
	LblInfo2= dgsCreateLabel(0.02,0.04,1,0.1,"afectar la experiencia dentro del servidor. (Por favor ingresa correctamente)",true,Register_Windows)
	dgsLabelSetColor(LblInfo,200,200,200,255)
	dgsLabelSetColor(LblInfo2,200,200,200,255)
	local rndRect = dgsCreateRoundRect(0,true,tocolor(80,0,200,255))  --Create Rounded Rectangle with 50 pixels radius
	local image1 = dgsCreateImage(0,0.08,1,0.01,rndRect,true,Register_Windows)  --Apply it to the dgs image
	dgsSetFont (LblInfo, "default-bold" )
	dgsSetFont (LblInfo2, "default-bold" )

	--Input de datos
	LblAccount=dgsCreateLabel(0.02,0.13,0.1,0.05,"Usuario:",true,Register_Windows)
	dgsSetFont (LblAccount, "default-bold" )
	txtUser = dgsCreateEdit( 0.02, 0.17, 0.23, 0.05, "", true,Register_Windows )

	dgsEditSetMaxLength (txtUser,20)
	
	LblEmail=dgsCreateLabel(0.32,0.13,0.1,0.05,"E-mail:",true,Register_Windows)
	dgsSetFont (LblEmail, "default-bold" )
	txtEmail = dgsCreateEdit( 0.32, 0.17, 0.3, 0.05, "", true,Register_Windows )
	dgsEditSetMaxLength (txtEmail,28)
	
	LblPassword=dgsCreateLabel(0.02,0.28,0.1,0.05,"Contraseña:",true,Register_Windows)
	dgsSetFont (LblPassword, "default-bold" )
	txtPassword = dgsCreateEdit( 0.02, 0.32, 0.23, 0.05, "", true,Register_Windows )
	dgsEditSetMaxLength (txtPassword,20)
	
	LblRaza= dgsCreateLabel(0.32,0.28,0.1,0.05,"Selecciona la raza:",true,Register_Windows)
	dgsSetFont (LblRaza, "default-bold" )
	CbxRaza=dgsCreateComboBox(0.32, 0.32, 0.2, 0.05, "Raza", true,Register_Windows)
	dgsComboBoxAddItem(CbxRaza,"Humano")
    dgsComboBoxAddItem(CbxRaza,"Vampire")
    dgsComboBoxAddItem(CbxRaza,"Wolfman")

	LblPasswordV=dgsCreateLabel(0.02,0.43,0.1,0.05,"Repetir contraseña:",true,Register_Windows)
	dgsSetFont (LblPasswordV, "default-bold" )
	txtPasswordV = dgsCreateEdit( 0.02, 0.47, 0.23, 0.05, "", true,Register_Windows )
	dgsEditSetMaxLength (txtPasswordV,20)
	
	LblEdad=dgsCreateLabel(0.02,0.58,0.1,0.05,"Selecciona tu edad:",true,Register_Windows)
	dgsSetFont (LblEdad, "default-bold" )
	CbxEdad=dgsCreateComboBox(0.02, 0.62, 0.2, 0.05, "Edad", true,Register_Windows)
	for i=10,40,1 do
    dgsComboBoxAddItem(CbxEdad, i)
	end
	
    LblSexo=dgsCreateLabel(0.02,0.73,0.1,0.05,"Selecciona tu sexo:",true,Register_Windows)
	dgsSetFont (LblSexo, "default-bold" )
	CbxSexo=dgsCreateComboBox(0.02, 0.77, 0.2, 0.05, "Sexo", true,Register_Windows)
	dgsComboBoxAddItem(CbxSexo,"Femenino")
    dgsComboBoxAddItem(CbxSexo,"Masculino")
    dgsComboBoxAddItem(CbxSexo,"Otro")

	--Términos y condiciones
	local rndRect2 = dgsCreateRoundRect(0,true,tocolor(0,0,0,50))  --Create Rounded Rectangle with 50 pixels radius
	local image2 = dgsCreateImage(0.65,0.09,0.351,0.861,rndRect2,true,Register_Windows)  --Apply it to the dgs image
	
	local LblTerminos =dgsCreateLabel(0.65,0.1,0.351,0.05,"Términos y condiciones",true,Register_Windows)
	dgsLabelSetHorizontalAlign( LblTerminos, "center" )
	dgsSetFont (LblTerminos, "default-bold" )
	dgsLabelSetColor(LblTerminos,216,29,29,255)
	
	local LblTerminos1 =dgsCreateLabel(0.66,0.15,0.351,0.05,"Al registrarse en este servidor el ",true,Register_Windows)
	local LblTerminos2 =dgsCreateLabel(0.66,0.18,0.351,0.05,"usuario acepta los términos/condiciones. ",true,Register_Windows)
	local LblTerminos3 =dgsCreateLabel(0.66,0.22,0.351,0.05,"1. Los datos de registro serán utilizados ",true,Register_Windows)
	local LblTerminos4 =dgsCreateLabel(0.66,0.25,0.351,0.05,"de manera que el servidor requiera. ",true,Register_Windows)
	local LblTerminos5 =dgsCreateLabel(0.66,0.30,0.351,0.05,"2. Los derechos de aportes que se  ",true,Register_Windows)
	local LblTerminos6 =dgsCreateLabel(0.66,0.33,0.351,0.05,"realicen al servidor pasan a ser ",true,Register_Windows)
	local LblTerminos7 =dgsCreateLabel(0.66,0.36,0.351,0.05,"totalmente del mismo. ",true,Register_Windows)
	local LblTerminos8 =dgsCreateLabel(0.66,0.41,0.351,0.05,"3. Se realizarán registro de la actividad",true,Register_Windows)
	local LblTerminos9 =dgsCreateLabel(0.66,0.44,0.351,0.05,"del usuario.",true,Register_Windows)
	local LblTerminos10 =dgsCreateLabel(0.66,0.49,0.351,0.05,"4. En caso de incumplimiento de reglas ",true,Register_Windows)
	local LblTerminos11 =dgsCreateLabel(0.66,0.52,0.351,0.05,"el usuario tiene derecho a apelar, sin  ",true,Register_Windows)
	local LblTerminos12 =dgsCreateLabel(0.66,0.55,0.351,0.05,"embargo luego de la apelación el usuario",true,Register_Windows)
	local LblTerminos13 =dgsCreateLabel(0.66,0.58,0.351,0.05,"acepta sin reclamo alguno.",true,Register_Windows)
	local LblTerminos14 =dgsCreateLabel(0.66,0.63,0.351,0.05,"5. Los servicios adquiridos por el usuario",true,Register_Windows)
	local LblTerminos15 =dgsCreateLabel(0.66,0.66,0.351,0.05,"no son reembolsables luego del 10% de",true,Register_Windows)
	local LblTerminos16 =dgsCreateLabel(0.66,0.69,0.351,0.05,"tiempo del servicio, por única vez.",true,Register_Windows)
	-- local LblTerminos =dgsCreateLabel(0.66,0.63,0.351,0.05,"4. Los servicios adquiridos por el usuario",true,Register_Windows)
	local LblTerminos17 =dgsCreateLabel(0.66,0.74,0.351,0.05,"El servidor se reserva el derecho para ",true,Register_Windows)
	local LblTerminos18 =dgsCreateLabel(0.66,0.77,0.351,0.05,"cambiar los términos y condiciones ",true,Register_Windows)
	
	dgsLabelSetColor(LblTerminos1,200,200,200,255)
	dgsLabelSetColor(LblTerminos2,200,200,200,255)
	dgsLabelSetColor(LblTerminos3,200,200,200,255)
	dgsLabelSetColor(LblTerminos4,200,200,200,255)
	dgsLabelSetColor(LblTerminos5,200,200,200,255)
	dgsLabelSetColor(LblTerminos6,200,200,200,255)
	dgsLabelSetColor(LblTerminos7,200,200,200,255)
	dgsLabelSetColor(LblTerminos8,200,200,200,255)
	dgsLabelSetColor(LblTerminos9,200,200,200,255)
	dgsLabelSetColor(LblTerminos10,200,200,200,255)
	dgsLabelSetColor(LblTerminos11,200,200,200,255)
	dgsLabelSetColor(LblTerminos12,200,200,200,255)
	dgsLabelSetColor(LblTerminos13,200,200,200,255)
	dgsLabelSetColor(LblTerminos14,200,200,200,255)
	dgsLabelSetColor(LblTerminos15,200,200,200,255)
	dgsLabelSetColor(LblTerminos16,200,200,200,255)
	dgsLabelSetColor(LblTerminos17,200,200,200,255)
	dgsLabelSetColor(LblTerminos18,200,200,200,255)

--BOTONES--

--Regresar
	BtnRegresar=dgsCreateButton(0.02,0.89,0.2,0.05,"Regresar",true,Register_Windows,_,_,_,_,_,_,tocolor(255,0,0,130))
	function Regresar ()
		if dgsGetType(source) == "dgs-dxbutton" then
			outputChatBox(dgsGetText(source))
			dgsCloseWindow(Register_Windows)
			Login(player,_x,_y)
			-- triggerServerEvent ( "Registrar", resourceRoot,player,User,Pass,Email,Item_Edad,Item_Sexo,Item_Raza )

		end
	end
	addEventHandler ( "onDgsMouseClickDown", BtnRegresar, Regresar )

--Registrar
	BtnRegistrar=dgsCreateButton(0.43,0.89,0.2,0.05,"Registrar",true,Register_Windows,_,_,_,_,_,_,tocolor(255,0,0,130))
	function Registrar ()
		if dgsGetType(source) == "dgs-dxbutton" then
			local User= dgsGetText(txtUser)
			local Pass= dgsGetText(txtPassword)
			local PassV= dgsGetText(txtPasswordV)
			local Email= dgsGetText(txtEmail)
			local Edad= dgsComboBoxGetSelectedItem(CbxEdad)
			local Sexo= dgsComboBoxGetSelectedItem(CbxSexo)
			local Raza= dgsComboBoxGetSelectedItem(CbxRaza)

		
			if string.len(User)<4 then			
				exports["_infobox"]:addNotification("Ingresa un usuario de al menos 4 caracteres","error")
			elseif string.len(Pass)<5 then
				exports["_infobox"]:addNotification("Ingresa una contraseña de al menos 5 caracteres","error")
			elseif PassV~=Pass then
				exports["_infobox"]:addNotification("Las contraseñas no coinciden","error")
			elseif Edad < 0 then
				exports["_infobox"]:addNotification("Selecciona una edad","error")

			elseif Sexo <0 then
				exports["_infobox"]:addNotification("Selecciona un sexo","error")
			elseif not (isValidMail(Email) and string.len(Raza)<5) then
				exports["_infobox"]:addNotification("Ingresa un E-mail correcto","error")
			elseif Raza <0 then
				exports["_infobox"]:addNotification("Selecciona una raza para tu jugador","error")
			else
				-- exports["_infobox"]:addNotification("Correcto!","success")
				local Item_Edad = dgsComboBoxGetItemText(CbxEdad,Edad)
				local Item_Sexo = dgsComboBoxGetItemText(CbxSexo,Sexo)
				local Item_Raza = dgsComboBoxGetItemText(CbxRaza,Raza)
				triggerServerEvent ( "Registrar", resourceRoot,player,User,Pass,Email,Item_Edad,Item_Sexo,Item_Raza )
			end
		end
	end
	addEventHandler ( "onDgsMouseClickDown", BtnRegistrar, Registrar )
end


function Vista()
	local timerpos=0
	setPlayerHudComponentVisible ( "all",false)
	setCameraMatrix(2089.6452636719,-2388.6723632812,42.590339660645,1996.0173339844,-2419.484375,25.724863052368)
	TVista= setTimer(function()
		if timerpos==0 then
		elseif timerpos ==1 then
			fadeCamera(true, 5)
			setCameraMatrix(523.68988037109,-2189.1105957031,70.177085876465,472.41934204102,-2105.7668457031,49.558032989502)
		elseif timerpos ==2 then
			fadeCamera(true, 5)
			setCameraMatrix(1800.2630615234,-1014.2406616211,328.20233154297,1765.6394042969,-1103.3786621094,298.95141601562)
		elseif timerpos ==3 then
			fadeCamera(true, 5)
			setCameraMatrix(1824.9288330078,814.48602294922,90.907913208008,1899.4256591797,877.06695556641,67.802864074707)
		elseif timerpos ==4 then
			fadeCamera(true, 5)
			setCameraMatrix(-1130.8585205078,1213.8549804688,140.14546203613,-1201.2275390625,1145.1536865234,122.02578735352)
			timerpos=0
		end
		timerpos=timerpos+1
	end,10000,0)
end

function CerrarLogin()
	destroyElement(sound)
	killTimer(TVista)
	CloseBlur()
	setCameraTarget(getLocalPlayer())
	showCursor(false)
	showChat(true)
	setPlayerHudComponentVisible ( "radar",true)
	setPlayerHudComponentVisible ( "crosshair",true)
	guiSetInputEnabled(false)
	dgsCloseWindow(Login_Windows)
	removeEventHandler("onClientRender", getRootElement(getThisResource()), Logo) 
	-- outputChatBox(tostring(check))
end
addEvent("CerrarLogin",true)
addEventHandler("CerrarLogin",getRootElement(getThisResource()),CerrarLogin)

function CreateBlur(_x,_y)
--Fondo Blur--
	local blurbox = dgsCreateBlurBox(_x,_y) --Blur Box
	local blurArea = dgsCreateImage(0,0,1,1,blurbox,true)
	dgsSetLayer(blurArea,"bottom")
	return blurArea
	
end

function CloseBlur()
	destroyElement(blurArea)
end

function isValidMail( mail )
    assert( type( mail ) == "string", "Bad argument @ isValidMail [string expected, got " .. tostring( mail ) .. "]" )
    return mail:match( "[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?" ) ~= nil
end

function CerrarRegistro()
	killTimer(TVista)
	dgsCloseWindow(Register_Windows)
	outputChatBox("Cerrando panel registro")
	CloseBlur()
	setCameraTarget(getLocalPlayer())
	showCursor(false)
	showChat(true)
	setPlayerHudComponentVisible ( "all",true)
	guiSetInputEnabled(false)
end
addEvent("CerrarRegistro",true)
addEventHandler("CerrarRegistro",getRootElement(getThisResource()),CerrarRegistro)
