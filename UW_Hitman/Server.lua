-- HitmanEvent = { 
    -- reward = 0, 
-- } 
  
function Hitman( player, ammo, attacker, weapon, bodypart ) 
    if((killer) and (killer ~= source)) and (getElementType(killer) ~= "ped") then 
         if ( getElementType ( attacker ) == "player" ) then 
             local reward = getElementData(source,"reward")
             if ( reward >0) then 
                 givePlayerMoney(attacker,reward) 
                 setElementData(source,"reward",0)
                 outputChatBox("Has ganado una recompensa por matar a "..getPlayerName(source))
             end 
         end 
     end 
end 
addEventHandler("onPlayerWasted",getRootElement(),Hitman) 


function greetPlayer ( )
 -- we store the player's name
 -- local joinedPlayerName = getPlayerName ( source )
 -- local serverName = getServerName( )
 -- and send him a greeting
 setElementData(source,"reward",0)
 -- outputChatBox ( "Welcome " .. joinedPlayerName .. " to ".. serverName .."!" , source, 255, 255, 255 )
end
addEventHandler ( "onPlayerJoin", root, greetPlayer )
