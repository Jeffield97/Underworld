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

loadstring(exports.dgs:dgsImportFunction())()
x,y= guiGetScreenSize()
DGS = exports.dgs
Panel= dgsCreateWindow(0.05,0.05,0.9,0.8,"Panel de ayuda Underworld",true)
-- DGS:dgsCloseWindow(Panel
DGS:dgsSetVisible ( Panel, false )
dgsWindowSetCloseButtonEnabled(Panel,false)
function PanelPrincipal()





-- DGS:dgsSetVisible ( Panel, true )
-- DGS:dgsSetEnabled ( Panel, true )
 dgsWindowSetMovable ( Panel, false )
 dgsWindowSetSizable ( Panel, false )
 local tabPanel = DGS:dgsCreateTabPanel ( 0, 0.0, 1, 1, true, Panel )
 local tabInfo = DGS:dgsCreateTab( "Información", tabPanel )
 local tabRules = DGS:dgsCreateTab( "Reglas", tabPanel )
 local tabCommands = DGS:dgsCreateTab( "Comandos", tabPanel )
 local tabClans = DGS:dgsCreateTab( "Clanes", tabPanel )
 local tabLevels = DGS:dgsCreateTab( "Niveles", tabPanel )
 
 
 DGS:dgsCreateLabel(0.02,0.04,0.94,0.2,"El servidor UNDERWORLD fue creado únicamente con el propósito de entretenimiento para sus usuarios, en este servidor puedes pasar el rato con tus amigos realizando\nvarias actividades que ofrece como: \n\n •	Matar zombies \n •	Realizar trabajos\n •	Formar parte de eventos automáticos o creados por el equipo Staff\n •	Unirte a clanes\n •	Realizar Clan war\n •	Realizar PVP\n •	Realizar Carreras\n\nPuedes también unirte a nuestra comunidad en el servidor de discord o en la página web del servidor www.Underworld.com, donde podrá realizar diferentes actividades\nde acuerdo a las diferentes categorías que se encuentran publicadas . Para subir de nivel necesitas adquirir la experiencia necesaria de acuerdo a cada nivel requerido\ncomo se muestra en la lista de niveles y experiencia, para adquirir experiencia puedes realizar las actividades mencionadas anteriormente. \n\n •	Matar a un usuario con mayor nivel -> 20 exp\n •	Matar a un usuario con el mismo nivel -> 10 exp\n •	Matar a un usuario con un nivel menor ->5 exp\n •	Ganar eventos (depende del evento) \n\nTambién puedes realizar compras únicamente con Sxcoin adquiriéndolo desde la página web del servidor, para recuperar vida, comprar armas, entrar a zonas especiales\nentre otros servicios puedes hacerlo en los refugios que se encuentran en las diferentes ciudades.\nEn servicios exclusivos del servidor puedes adquirir en www.Underworld.com vehículos únicos, VIP, dinero, bases para clanes, entre otras cosas más. ",true,tabInfo,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 local image1 = DGS:dgsCreateImage(x*0.78,y*0.56,150,150,":imagenes/logo.png",true,tabInfo,tocolor(255,255,255,255))
 
 DGS:dgsCreateLabel(0.02,0.04,0.94,0.2,"- Reglas para usuarios en general -",true,tabRules,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.08,0.94,0.2,"Prohibido realizar spawn kill\nProhibido abusar de bugs\nProhibido realizar spam\nProhibido realizar estafas\nProhibido pedir cosas al equipo staff\nProhibido faltar el respeto al equipo staff\nProhibido realizar publicidad de otros servidores ajenos a la comunidad\n\n",true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 DGS:dgsCreateLabel(0.4,0.04,0.94,0.2,"Sanciones",true,tabRules,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.4,0.08,0.94,0.2,"[KICK]\n[BAN]\n[BAN]\n[KICK/BAN]\n[MUTE/KICK]\n[MUTE/KICK]\n[BAN]\n",true,tabRules,tocolor(165,255,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.31,0.94,0.2,"- Reglas para STAFF -",true,tabRules,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.35,0.94,0.2,"Prohibido ocultar reportes de jugadores\nProhibido abusar del panel según el rango\nProhibido dar cosas mediante el panel\nProhibido sancionar sin razón\n",true,tabRules,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 
 DGS:dgsCreateLabel(0.02,0.04,0.94,0.2,"- Comandos en general -",true,tabCommands,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.4,0.04,0.94,0.2,"Acción",true,tabCommands,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.025,0.08,0.94,0.2,"/kill\n/rweapon\n/ra_weapons\n/fogata\n/dmoney\n/dweapon\n/dron\n/xdron\n",true,tabCommands,tocolor(94,216,77,255),1,1,1,1,tocolor(0,0,0,100))
 DGS:dgsCreateLabel(0.4,0.08,0.94,0.2,"Suicidarse\nEliminar arma\nEliminar todas las armas\nCrear fogata\nSoltar dinero\nSoltar Arma\nActiva el dron si el jugador posee uno\nActiva el dron de ataque si el jugador posee uno",true,tabCommands,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 DGS:dgsCreateLabel(0.02,0.35,0.94,0.2,"- Comandos Team Depredador--",true,tabCommands,tocolor(216,129,77,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.37,0.94,0.2,"- Comandos Team Titan-",true,tabCommands,tocolor(216,129,77,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.39,0.94,0.2,"- Comandos Team Legendario-",true,tabCommands,tocolor(216,129,77,255),1,1,1,1,tocolor(0,0,0,255))
 -- DGS:dgsCreateLabel(0.02,0.31,0.94,0.2,"- Comandos Team Legendario-",true,tabCommands)
 DGS:dgsCreateLabel(0.02,0.43,0.94,0.2,"- Comandos humanos -",true,tabCommands,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.45,0.94,0.2,"- Comandos wolfman -",true,tabCommands,tocolor(236,171,12,255),1,1,1,1,tocolor(0,0,0,255))
 DGS:dgsCreateLabel(0.02,0.47,0.94,0.2,"- Comandos vampire -",true,tabCommands,tocolor(167,41,255,255),1,1,1,1,tocolor(0,0,0,255))
 
 DGS:dgsCreateLabel(0.02,0.04,0.94,0.2,"Se muestran todos los clanes oficiales con las respectivas victorias alcanzadas en las CW oficiales.",true,tabClans,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
local clanes = {"SOX","Fairy Tail","Debian","Soldier","Rosa"}
local desClanes={"1","2","0","5","2"}
local logoClanes={":imagenes/logo.png",":imagenes/background2.png",":imagenes/background3.png",":imagenes/redbar.png",":imagenes/bluebar.png"}
xc=0
	for i, v in ipairs(clanes) do
      -- DGS:dgsCreateLabel(0.044+xc,0.32,0.94,0.2,clanes[i],true,tabClans,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255))
	  DGS:dgsCreateImage(0.028+xc,0.15,0.07,0.14,logoClanes[i],true,tabClans,tocolor(255,255,255,255))
	  DGS:dgsCreateLabel(0.035+xc,0.32,0.94,0.2,"Victorias: "..desClanes[i],true,tabClans,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,255))
	  xc=xc+0.218
    end
			
 DGS:dgsCreateLabel(0.02,0.04,0.94,0.2,"La siguiente lista corresponde a los niveles y la experiencia requerida para cada uno.",true,tabLevels,tocolor(200,200,200,255),1,1,1,1,tocolor(0,0,0,100))
 scrollpane = DGS:dgsCreateScrollPane(0.02,0.09,0.2,0.85,true,tabLevels)
 Llenar()
 -- if scrollpane then
	 -- for i,v in ipairs(DGS:dgsGetChildren(scrollpane)) do
					-- destroyElement(v)
				-- end	
	 
	 -- for i,v in ipairs(Niveles) do
				
				-- DGS:dgsCreateLabel(5,i*20,90,20,tostring(Niveles[i]),false,scrollpane)
	-- end
 -- end
-- DGS = exports.dgs

function guiToggleVisible ( )        
        if ( DGS:dgsGetVisible ( Panel ) == true ) then -- check if the dgs element is visible               
                DGS:dgsSetVisible ( Panel, false ) -- if it is, we hide it
				showCursor(false)
				-- PanelPrincipal()
        else              
                DGS:dgsSetVisible ( Panel, true ) -- if not, we make it visible
				showCursor(true)
        end
end

-- myWindow = DGS:dgsCreateWindow ( 0, 0, .5, .5, "my window", true ) -- Create the dgs window
bindKey ( "F1", "down", guiToggleVisible )



end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), PanelPrincipal )



-- DGS = exports.dgs --get exported functions from dgs

-- local effect3d = DGS:dgsCreateEffect3D(20)  --Create the 3D effect plugin
-- local sp = DGS:dgsCreateScrollPane(300,300,500,500,false)  --Create a scroll pane
-- local Panel2= dgsCreateWindow(0.05,0.05,0.9,0.8,"Panel de ayuda Underworld",true)
-- local img = DGS:dgsCreateImage(0,0,1,1,_,true,sp,tocolor(0,0,0,180))  --Create an image
-- DGS:dgsEffect3DApplyToScrollPane(effect3d,Panel2)  --Apply the plugin to scroll pane
-- edit1 = DGS:dgsCreateEdit(0,0,200,100,"DGS 3D Effect Edit 1",false,img)
-- edit2 = DGS:dgsCreateEdit(0,400,200,50,"DGS 3D Effect Edit 2",false,img)


-- DGS = exports.dgs
-- addEventHandler("onClientResourceStart",resourceRoot,
	-- function()
		-- create a window and create a scrollpane on it
		-- local window = DGS:dgsCreateWindow(5,5,130,150,"",false)
		-- the width and height values here are largely irrelevant as the scrollpane will automatically resize when needed
		-- scrollpane = DGS:dgsCreateScrollPane(0,0,130,150,false,window)
	-- end
-- )

-- addCommandHandler("",
	function Llenar()
		-- if the scrollpane exists
		if   scrollpane then
			-- if guiGetEnabled(Panel) then
			-- delete all the existing labels
				for i,v in ipairs(DGS:dgsGetChildren(scrollpane)) do
					destroyElement(v)
				end
				DGS:dgsCreateLabel(5,5,90,20,"Nivel",false,scrollpane,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
				DGS:dgsCreateLabel(120,5,90,20,"Experiencia",false,scrollpane,tocolor(255,51,51,255),1,1,1,1,tocolor(0,0,0,255))
				-- for every player in the server
				for i,v in ipairs(Niveles) do
					-- create a label with their name on the scrollpane
					DGS:dgsCreateLabel(120,i*20,90,20,tostring(Niveles[i]),false,scrollpane)
					DGS:dgsCreateLabel(5,i*20,90,20,i,false,scrollpane)
				end
			-- end
		end
	end
	
	--bindKey( "F1", "down",Llenar)
	-- bindKey( "F1", "down",PanelPrincipal)
-- )

