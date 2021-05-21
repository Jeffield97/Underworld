-- exports [ "scoreboard" ]:addScoreboardColumn ("Dinero",root,2) -- Add the "Money" column to the scoreboard.
call(getResourceFromName("scoreboard"),"addScoreboardColumn","Dinero",5,"Dinero",60)
     
    function updatePlayersMoney ( ) -- Create "updatePlayersMoney" function.
        for index, player in ipairs ( getElementsByType "player" ) do -- Loop through all online players.
            setElementData ( player, "Dinero", getPlayerMoney ( player ) ) -- Set "Money" element data to the player money.
        end -- End our loop.
    end -- End our function.
    setTimer ( updatePlayersMoney, 2500, 0 ) -- Set a infinite 2.5 seconds timer to execute "updatePlayersMoney" function.