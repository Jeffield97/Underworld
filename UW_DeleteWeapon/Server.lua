addCommandHandler( 'rw',
  function( thePlayer )
  local theWeapon = getPedWeapon( thePlayer )
    takeWeapon( thePlayer,theWeapon)
	outputChatBox("#df1f1f [Servidor]#f0f0f0: El arma ha sido eliminada.", thePlayer, 249, 11, 8,true)
	
  end
)
addCommandHandler( 'RAW',
  function( thePlayer )
  local theWeapon = getPedWeapon( thePlayer )
    takeAllWeapons( thePlayer,theWeapon)
	outputChatBox("#df1f1f [Servidor]#f0f0f0: Todas las armas han sido eliminadas.", thePlayer, 249, 11, 8,true)
  end
)
