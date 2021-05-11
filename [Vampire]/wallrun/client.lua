--﻿--Codigo hecho por <~KaMiKaZe~> / Code made by <~KaMiKaZe~>
local wallRunVelocityDefault = 0.02 -- La velocidad del wall run / The velocity of the wall run ( default : 0.02 )
local wallRunVelocity = wallRunVelocityDefault
local wallRunKey = "lshift" --La tecla para activar el wall run / The key of the wall run ( default : "lshift" )
local wallSprintKey = "space" --La tecla para esprintar usando el wall run / The key to sprint using the wall run ( default : "space" )
local showSprintBar = true -- Mostrar la barra de carga de sprint / show the sprint charge bar ( default : true )
--NO EDITAR / DON'T EDIT !
local sW, sH = guiGetScreenSize()
local currentSprintBar = 0

addEventHandler ( "onClientResourceStart", resourceRoot,
function()
engineLoadIFP( "ifp/wallrun.ifp", "WallRun" )
end
)

setTimer(function()
triggerServerEvent( "WALLRUN:autorizePlayer", getLocalPlayer() )
end, 10000, 0 )

function isPlayerDoingWallRun()
if ( getElementData( localPlayer, "WallRun" ) == true ) then return true else return false end
end

function isPlayerAutorized()
if ( getElementData( localPlayer, "WALLRUN:autorized" ) == true ) then return true else return false end
end

function setPlayerAutorized(state)
if not state then return false end
setElementData( localPlayer, "WALLRUN.autorized", state )
end

addEvent("WALLRUN:doCustomAnimation", true)
addEventHandler("WALLRUN:doCustomAnimation", root,
function( anim, loop, updatePos, interrupt, freeze )
setPedAnimation( source, "WallRun", anim, -1, loop, updatePos, interrupt, freeze )
end
)

setTimer(function()
if isPlayerDoingWallRun() then
playSFX( "feet", 0, math.random(0,5), false )
end
end, 300, 0 )

function doWallRun()
if isPlayerAutorized() then
if ( getKeyState(wallRunKey) == true ) then
if not isPedDoingTask( localPlayer, "TASK_SIMPLE_CLIMB" ) then
local x,y,z = getElementPosition( localPlayer )
local xx, xy, xz = getElementPosition(localPlayer)
local r = getPedRotation ( localPlayer ) 
xx = xx - math.sin ( math.rad ( r ) ) * 1.2
xy = xy + math.cos ( math.rad ( r ) ) * 1.2
if not (isLineOfSightClear(x, y, z, xx, xy, xz )) then
triggerServerEvent( "onPlayerWallRunStart", getLocalPlayer() )
end
end
elseif ( getKeyState(wallRunKey) == false ) then
if isPlayerDoingWallRun() then
triggerServerEvent( "onPlayerWallRunFinish", getLocalPlayer(), "player" )
end
end
end
end
bindKey( wallRunKey, "both", doWallRun )

bindKey(wallSprintKey, "down",
function()
if isPlayerDoingWallRun() then
if ( getElementData( localPlayer, "WALLRUN:timeUse" ) == false ) then
setElementData( localPlayer, "WALLRUN:timeUse", true )
wallRunVelocity = wallRunVelocity+4
setElementData( localPlayer, "WALLRUN:chargeSprintBar", true )
setTimer(function()
wallRunVelocity = wallRunVelocityDefault
setElementData( localPlayer, "WALLRUN:timeUse", false )
setElementData( localPlayer, "WALLRUN:chargeSprintBar", false )
end, 300, 1 )
end
end
end
)

addEventHandler("onClientRender", root,
function()
if isPlayerDoingWallRun() then
local x,y,z = getElementPosition( localPlayer )
local xx, xy, xz = getElementPosition(localPlayer)
local r = getPedRotation ( localPlayer ) 
xx = xx - math.sin ( math.rad ( r ) ) * 1
xy = xy + math.cos ( math.rad ( r ) ) * 1
if (isLineOfSightClear(x, y, z, xx, xy, xz )) then
triggerServerEvent( "onPlayerWallRunFinish", getLocalPlayer(), "lostWall" )
else
local sx, sy, sz = getElementVelocity(localPlayer)
setElementVelocity( localPlayer, sx, sy, sz+wallRunVelocity )
end
end
--SPRINT BAR
-- if isPlayerDoingWallRun() then
-- if ( showSprintBar == true ) then
-- dxDrawLine((sW * 0.0417) - 1, (sH * 0.9479) - 1, (sW * 0.0417) - 1, sH * 0.9917, tocolor(0, 0, 0, 255), 1, false)
-- dxDrawLine(sW * 0.2264, (sH * 0.9479) - 1, (sW * 0.0417) - 1, (sH * 0.9479) - 1, tocolor(0, 0, 0, 255), 1, false)
-- dxDrawLine((sW * 0.0417) - 1, sH * 0.9917, sW * 0.2264, sH * 0.9917, tocolor(0, 0, 0, 255), 1, false)
-- dxDrawLine(sW * 0.2264, sH * 0.9917, sW * 0.2264, (sH * 0.9479) - 1, tocolor(0, 0, 0, 255), 1, false)
-- dxDrawRectangle(sW * 0.0417, sH * 0.9479, sW * 0.1847, sH * 0.0437, tocolor(100, 100, 100, 100), false)
-- dxDrawRectangle(sW * 0.0417, sH * 0.9479, sW * currentSprintBar, sH * 0.0437, tocolor(0, 255, 255, 150), false)
-- if ( getElementData( localPlayer, "WALLRUN:chargeSprintBar" ) == true ) then
-- if currentSprintBar < 0.1800 then
-- currentSprintBar = currentSprintBar + 0.0100
-- end
-- else
-- if currentSprintBar > 0.0090 then
-- currentSprintBar = currentSprintBar - 0.0100
-- end
-- end
-- end
-- end
end
)


