--//

--|| Created by M[e]D

local number = dxCreateFont("number.ttf",10)
local x, y = guiGetScreenSize ( )
local resWtes,resHtes = 1280,720
local sWtes,sHtes =  (x/resWtes), (y/resHtes)
local color = {0, 255, 0, 255}
addEventHandler("onClientRender",root,
function()
local BoneX,BoneY,BoneZ = getPedBonePosition(getLocalPlayer(), 26)
local SBX,SBY = getScreenFromWorldPosition ( BoneX,BoneY,BoneZ )
local ammo= getPedTotalAmmo(getLocalPlayer())-getPedAmmoInClip(getLocalPlayer())
local clip = getPedAmmoInClip(getLocalPlayer())
	if SBX and SBY then	
   		if getPedWeapon (getLocalPlayer()) ~= 0 and  getPedWeapon (getLocalPlayer()) ~= 46 then 
			-- if clip < 30 then
			-- color =  {255, 195, 0 , 255} 
			-- end
			-- outputChatBox("<50")		
			--if clip < clip * 0.10 then color = {255, 0, 0, 255} else  color = {0, 255, 0, 255} end
			dxDrawText("Ammo: "..ammo, SBX,SBY+10, 290*sWtes, 250*sHtes, tocolor (unpack(color)), 0.8*sWtes,0.8*sHtes,"default-bold","left","top",false,false,false,true)
			dxDrawText("Clip: "..getPedAmmoInClip(getLocalPlayer()), SBX,SBY-10, 290*sWtes, 250*sHtes, tocolor (unpack(color)), sWtes,sHtes,"default-bold","left","top",false,false,false,true)
			 
		end
	end
end
)

--|| Don't remove my Copyright ;)
--\\
