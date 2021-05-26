local Niveles ={
0,
1000,
2000,
3000,
4000,
5000,
6000,
7000,
8000,
9000,
11000,
13000,
15000,
17000,
19000,
21000,
23000,
25000,
27000,
29000,
35000,
41000,
47000,
53000,
59000,
65000,
71000,
77000,
83000,
89000,
95000,
101000,
107000,
113000,
119000,
125000,
131000,
137000,
143000,
150000,
160000,
170000,
180000,
190000,
200000,
210000,
220000,
230000,
240000,
250000,
270000,
290000,
310000,
330000,
350000,
370000,
390000,
410000,
430000,
450000,
500000,
600000,
700000,
800000,
900000,
1000000,
1100000,
1200000,
1300000,
1400000,
1500000,
1600000,
1700000,
1800000,
1900000,
2000000,
2100000,
2200000,
2300000,
2400000,
2500000,
2600000,
2700000,
2800000,
2900000,
3000000,
3100000,
3200000,
3300000,
3400000,
3500000,
3600000,
3700000,
3800000,
3900000,
4000000,
4100000,
4200000,
4300000,
4400000

}

lbl={}
tab={}

command={{"/Kill","Mata al jugador"},
{"/SpawnPlayer","Habilita/deshabilita el spawn hacia el refugio"},
{"/Hitman","Abre el panel para poner precio a la cabeza de un jugador"},
-- {"",""},
-- {"",""},
{"/Dararma","Suelta el arma que se tiene en mano y la cantidad de munición"},
{"/Dardinero","Suelta la cantidad de dinero que se establecida"},
{"/Transformar","Transforma a la raza del jugador Vampire/Wolfman"}
}
rules={{"Prohibido realizar spawn kill","[Kick]"},
{"Prohibido abusar de bugs","[Ban]"},
{"Prohibido realizar spam","[Ban]"},
{"Prohibido realizar estafas","[Kick/Ban]"},
{"Prohibido pedir cosas al staff","[Mute/Kick]"},
{"Prohibido faltar el respeto a staff","[Mute/Kick]"},
{"Prohibido realizar publicidad de otros servidores ajenos a la comunidad","[Ban]"}
-- {},
-- {},
}

rulesStaff={"Prohibido ocultar reportes","Prohibido abusar del panel según el rango","Prohibido dar cosas mediante el panel","Prohibido sancionar sin razón"
}
-- local font = dxCreateFont('font.ttf', 11, false, 'antialiased') or 'default'
local font = dxCreateFont('font2.otf', 9, true, 'antialiased') or 'default'
loadstring(exports.dgs:dgsImportFunction())()
x,y= guiGetScreenSize()
DGS = exports.dgs
Panel= dgsCreateWindow(0.05,0.05,0.9,0.8,"Panel de ayuda Underworld",true)
dgsSetFont(Panel,font)
-- dgsCloseWindow(Panel
dgsSetVisible ( Panel, false )
dgsWindowSetCloseButtonEnabled(Panel,false)
function PanelPrincipal()


 dgsWindowSetMovable ( Panel, false )
 dgsWindowSetSizable ( Panel, false )
 local tabPanel = dgsCreateTabPanel ( 0, 0.0, 1, 1, true, Panel )
 local tabInfo = dgsCreateTab( "Información", tabPanel,_,_,tocolor(  193,202,216,255) )
 local tabRules = dgsCreateTab( "Reglas", tabPanel,_,_,tocolor(  193,202,216,255)  )
 local tabCommands = dgsCreateTab( "Comandos", tabPanel,_,_,tocolor(  193,202,216,255) )
 local tabClans = dgsCreateTab( "Clanes", tabPanel,_,_,tocolor(  193,202,216,255) )
 local tabLevels = dgsCreateTab( "Niveles", tabPanel,_,_,tocolor(  193,202,216,255) )
 
 dgsSetFont(tabPanel,font)
 dgsSetFont(tabInfo,font)
 dgsSetFont(tabRules,font)
 dgsSetFont(tabCommands,font)
 dgsSetFont(tabClans,font)
 dgsSetFont(tabLevels,font)
 
 lbl[1]=dgsCreateLabel(0.02,0.04,0.94,0.2,"El servidor UNDERWORLD fue creado únicamente con el propósito de entretenimiento para sus usuarios, en este servidor puedes pasar el rato con tus amigos realizando\nvarias actividades que ofrece como: \n\n • Matar zombies \n • Realizar trabajos\n • Formar parte de eventos automáticos o creados por el equipo Staff\n • Unirte a clanes\n • Realizar Clan war\n • Realizar PVP\n • Realizar Carreras\n\nPuedes también unirte a nuestra comunidad en el servidor de discord o en la página web del servidor www.Underworld.com, donde podrá realizar diferentes actividades\nde acuerdo a las diferentes categorías que se encuentran publicadas . Para subir de nivel necesitas adquirir la experiencia necesaria de acuerdo a cada nivel requerido\ncomo se muestra en la lista de niveles y experiencia, para adquirir experiencia puedes realizar las actividades mencionadas anteriormente. \n\n •	Matar a un usuario con mayor nivel -> 20 exp\n •	Matar a un usuario con el mismo nivel -> 10 exp\n •	Matar a un usuario con un nivel menor ->5 exp\n •	Ganar eventos (depende del evento) \n\nTambién puedes realizar compras únicamente con Sxcoin adquiriéndolo desde la página web del servidor, para recuperar vida, comprar armas, entrar a zonas especiales\nentre otros servicios puedes hacerlo en los refugios que se encuentran en las diferentes ciudades.\nEn servicios exclusivos del servidor puedes adquirir en www.Underworld.com vehículos únicos, VIP, dinero, bases para clanes, entre otras cosas más. ",true,tabInfo,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 local image1 = dgsCreateImage(x*0.78,y*0.56,150,150,"logo.png",true,tabInfo,tocolor(255,255,255,255))
 
--REGLAS USUARIO EN GENERAL
 lbl[2]=dgsCreateLabel(0.02,0.04,0.94,0.2,"- Reglas para usuarios en general -",true,tabRules,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[3]=dgsCreateLabel(0.02,0.08,0.94,0.2,"Prohibido realizar spawn kill\nProhibido abusar de bugs\nProhibido realizar spam\nProhibido realizar estafas\nProhibido pedir cosas al equipo staff\nProhibido faltar el respeto al equipo staff\nProhibido realizar publicidad de otros servidores ajenos a la comunidad\n\n",true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 lbl[3]=dgsCreateLabel(0.4,0.04,0.94,0.2,"Sanciones",true,tabRules,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[5]=dgsCreateLabel(0.4,0.08,0.94,0.2,"[KICK]\n[BAN]\n[BAN]\n[KICK/BAN]\n[MUTE/KICK]\n[MUTE/KICK]\n[BAN]\n",true,tabRules,tocolor(165,255,51,255),1,1,1,1,tocolor(0,0,0,255))
for i,v in ipairs(rules)do
	-- dgsSetFont(lbl[i],font)
	dgsSetFont(dgsCreateLabel(0.02,0.04+(i*0.04),0.94,0.2,"► "..rules[i][1],true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	dgsSetFont(dgsCreateLabel(0.4,0.04+(i*0.04),0.94,0.2,rules[i][2],true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.2,0.08+(i*0.05),0.94,0.2,command[i],true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.02,0.08+(i*0.045),1,0.2,"-----------------------------------------------------------------------------------------------------------------------*",true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
 end



--REGLAS STAFF
 lbl[4]=dgsCreateLabel(0.02,0.47,0.94,0.2,"- Reglas para STAFF -",true,tabRules,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[7]=dgsCreateLabel(0.02,0.35,0.94,0.2,"Prohibido ocultar reportes de jugadores\nProhibido abusar del panel según el rango\nProhibido dar cosas mediante el panel\nProhibido sancionar sin razón\n",true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 
for i,v in ipairs(rulesStaff)do
	-- dgsSetFont(lbl[i],font)
	dgsSetFont(dgsCreateLabel(0.02,0.47+(i*0.04),0.94,0.2,"► "..rulesStaff[i],true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.4,0.04+(i*0.04),0.94,0.2,rulesStaff[i][2],true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.2,0.08+(i*0.05),0.94,0.2,command[i],true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.02,0.08+(i*0.045),1,0.2,"-----------------------------------------------------------------------------------------------------------------------*",true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
 end 
 
 lbl[5]=dgsCreateLabel(0.02,0.04,0.94,0.2,"Comandos en general",true,tabCommands,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 lbl[6]=dgsCreateLabel(0.2,0.0425,0.94,0.2,"Acción",true,tabCommands,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[10]=dgsCreateLabel(0.025,0.08,0.94,0.2,"/kill\n/rweapon\n/ra_weapons\n/fogata\n/dmoney\n/dweapon\n/dron\n/xdron\n",true,tabCommands,tocolor(94,216,77,255),1,1,1,1,tocolor(0,0,0,100))
 for i,v in ipairs(command)do
	-- dgsSetFont(lbl[i],font)
	dgsSetFont(dgsCreateLabel(0.02,0.08+(i*0.04),0.94,0.2,command[i][1],true,tabCommands,tocolor(7,232,152,255),1,1,1,1,tocolor(0,0,0,255)),font)
	dgsSetFont(dgsCreateLabel(0.2,0.08+(i*0.04),0.94,0.2,command[i][2],true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.2,0.08+(i*0.05),0.94,0.2,command[i],true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	-- dgsSetFont(dgsCreateLabel(0.02,0.08+(i*0.045),1,0.2,"-----------------------------------------------------------------------------------------------------------------------*",true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
 end
 -- lbl[11]=dgsCreateLabel(0.4,0.08,0.94,0.2,"Suicidarse\nEliminar arma\nEliminar todas las armas\nCrear fogata\nSoltar dinero\nSoltar Arma\nActiva el dron si el jugador posee uno\nActiva el dron de ataque si el jugador posee uno",true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 -- lbl[12]=dgsCreateLabel(0.02,0.35,0.94,0.2,"- Comandos Team Depredador--",true,tabCommands,tocolor(216,129,77,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[13]=dgsCreateLabel(0.02,0.37,0.94,0.2,"- Comandos Team Titan-",true,tabCommands,tocolor(216,129,77,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[14]=dgsCreateLabel(0.02,0.39,0.94,0.2,"- Comandos Team Legendario-",true,tabCommands,tocolor(216,129,77,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[]=dgsCreateLabel(0.02,0.31,0.94,0.2,"- Comandos Team Legendario-",true,tabCommands)
 -- lbl[15]=dgsCreateLabel(0.02,0.43,0.94,0.2,"- Comandos humanos -",true,tabCommands,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[16]=dgsCreateLabel(0.02,0.45,0.94,0.2,"- Comandos wolfman -",true,tabCommands,tocolor(236,171,12,255),1,1,1,1,tocolor(0,0,0,255))
 -- lbl[17]=dgsCreateLabel(0.02,0.47,0.94,0.2,"- Comandos vampire -",true,tabCommands,tocolor(167,41,255,255),1,1,1,1,tocolor(0,0,0,255))
 
 lbl[7]=dgsCreateLabel(0.02,0.04,0.94,0.2,"Se muestran todos los clanes oficiales con las victorias alcanzadas en las CW oficiales.",true,tabClans,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
local clanes = {"SOX","Fairy Tail","Debian","Soldier","Rosa"}
local desClanes={"1","2","0","5","2"}
local logoClanes={"logo.png","logo.png","logo.png","logo.png","logo.png"}
xc=0
	for i, v in ipairs(clanes) do
      -- lbl[]=dgsCreateLabel(0.044+xc,0.32,0.94,0.2,clanes[i],true,tabClans,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255))
	  dgsCreateImage(0.028+xc,0.15,0.07,0.14,logoClanes[i],true,tabClans,tocolor(255,255,255,255))
	  dgsSetFont(dgsCreateLabel(0.035+xc,0.32,0.94,0.2,"Victorias: "..desClanes[i],true,tabClans,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255)),font)
	  xc=xc+0.218
    end
			
 dgsSetFont(dgsCreateLabel(0.02,0.04,0.94,0.2,"La siguiente lista corresponde a los niveles y la experiencia requerida para cada uno.",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100)),font)
 dgsSetFont(dgsCreateLabel(0.27,0.1,0.94,0.2,"Formas de ganar experiencia",true,tabLevels,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,100)),font)
 dgsSetFont(dgsCreateLabel(0.27,0.14,0.94,0.2,"► Matar zombies da 1 de experiencia",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100)),font)
 dgsSetFont(dgsCreateLabel(0.27,0.18,0.94,0.2,"► Ganar evento spar 200 de experiencia",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100)),font)
 dgsSetFont(dgsCreateLabel(0.27,0.22,0.94,0.2,"► Ganar evento carrera 100 de experiencia",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100)),font)
 dgsSetFont(dgsCreateLabel(0.27,0.26,0.94,0.2,"► Matar player Wolfman/Vampire transformado 20 experiencia",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100)),font)
 -- dgsSetFont(dgsCreateLabel(0.27,0.30,0.94,0.2,"► Ganar PVP 50 exp",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100)),font)
 scrollpane = dgsCreateScrollPane(0.02,0.09,0.2,0.85,true,tabLevels)
 Llenar()


function guiToggleVisible ( )        
        if ( dgsGetVisible ( Panel ) == true ) then -- check if the dgs element is visible               
                dgsSetVisible ( Panel, false ) -- if it is, we hide it
				showCursor(false)
				-- PanelPrincipal()
        else              
                dgsSetVisible ( Panel, true ) -- if not, we make it visible
				showCursor(true)
        end
end

-- myWindow = dgsCreateWindow ( 0, 0, .5, .5, "my window", true ) -- Create the dgs window
bindKey ( "F1", "down", guiToggleVisible )


for i,v in ipairs(lbl)do
	dgsSetFont(lbl[i],font)
end


end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), PanelPrincipal )

	function Llenar()
		-- if the scrollpane exists
		if   scrollpane then
			-- if guiGetEnabled(Panel) then
			-- delete all the existing labels
				for i,v in ipairs(dgsGetChildren(scrollpane)) do
					destroyElement(v)
				end
				lbl[8]=dgsCreateLabel(5,5,90,20,"Nivel",false,scrollpane,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
				lbl[9]=dgsCreateLabel(120,5,90,20,"Experiencia",false,scrollpane,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
				-- for every player in the server
				for i,v in ipairs(Niveles) do
					-- create a label with their name on the scrollpane
					dgsCreateLabel(120,i*20,90,20,tostring(Niveles[i]),false,scrollpane)
					dgsCreateLabel(5,i*20,90,20,i,false,scrollpane)
				end
			-- end
		end
	end

