addEvent("onZombieWasted",true)
addEventHandler("onZombieWasted",root,
function (killer)
    givePlayerMoney(killer,50) 
	local experiencie=getElementData(killer,"exp")-- default 50$
	setElementData(killer,"exp",experiencie+1)
end)	
