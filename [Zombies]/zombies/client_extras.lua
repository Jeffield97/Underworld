
    function ZombieS ( zomb )

       triggerServerEvent ( "onZombieSpawned", zomb )

    end

    addEvent("Zomb_STFU", true , ZombieS  )
    addEventHandler("Zomb_STFU", root  , ZombieS  )