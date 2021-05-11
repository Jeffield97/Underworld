--Codigo hecho por <~KaMiKaZe~> / Code made by <~KaMiKaZe~>
local autorized_ranks = {"VIP"} --Los rangos que podrán hacer el wall run. Use "Everyone" para que todos puedan hacerlo. / the ranks who can do the wall run. Use "Everyone" for a public use. 

function isPlayerDoingWallRun(player)
if not isElement(player) then return false end if ( getElementData( player, "WallRun" ) == true ) then return true else return false end
end

function isPlayerAutorized(player)
if not isElement(player) then return false end if ( getElementData( player, "WALLRUN:autorized" ) == true ) then return true else return false end
end

function setPlayerAutorized(player,state)
if not isElement(player) then return false end if not state then return false end
setElementData( player, "WALLRUN.autorized", state )
end

addEvent("WALLRUN:autorizePlayer", true)
addEventHandler("WALLRUN:autorizePlayer", root,
function()
for k,v in ipairs(autorized_ranks) do
--if getElementType ( source ) == "player" then
local acc = getPlayerAccount(source)
if acc then
if not isGuestAccount(acc) then
-- if isObjectInACLGroup ("user."..getAccountName(acc), aclGetGroup ( v ) ) then
-- setElementData( source, "WALLRUN:autorized", true )
-- end
--end
end
end
end
end
)

addEvent("onPlayerWallRunFinish", true)
addEventHandler("onPlayerWallRunFinish", root,
function(motive)
if motive == "lostWall" then
setElementData( source, "WallRun", false )
setTimer( triggerClientEvent, 100, 1, root, "WALLRUN:doCustomAnimation", source, "BLANSH", false, false, false, false )
local ax, ay, az = getElementVelocity(source)
local r = getPedRotation ( source ) 
ax = ax - math.sin ( math.rad ( r ) ) * 0.02
ay = ay + math.cos ( math.rad ( r ) ) * 0.02
setElementVelocity( source, ax, ay, az+0.1 )
setTimer( setElementVelocity, 50, 1, source, ax, ay, az )
elseif motive == "player" then
setElementData( source, "WallRun", false )
setTimer( triggerClientEvent, 100, 1, root, "WALLRUN:doCustomAnimation", source, "BLANSH", false, false, false, false )
local ax, ay, az = getElementVelocity(source)
local r = getPedRotation ( source ) 
ax = ax - math.sin ( math.rad ( r ) ) * -0.1
ay = ay + math.cos ( math.rad ( r ) ) * -0.1
setElementVelocity( source, ax, ay, az )
end
end
)

addEvent("onPlayerWallRunStart", true)
addEventHandler("onPlayerWallRunStart", root,
function()
setElementData( source, "WallRun", true )
setTimer( triggerClientEvent, 100, 1, root, "WALLRUN:doCustomAnimation", source, "WALLRUN", true, false, false, false )
local ax, ay, az = getElementVelocity(source)
setElementVelocity( source, ax, ay, az+0.2 )
end
)