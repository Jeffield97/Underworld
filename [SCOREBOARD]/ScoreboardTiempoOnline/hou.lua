--[[

original script

http://forum.mtasa.com/viewtopic.php?f=91&t=40132

I just fix it

]]
exports.scoreboard:addScoreboardColumn('Online Time')

local t = { }
 
function checkValues( source,arg1,arg2)
    if (arg2 >= 60) then
        t[ source ][ 'min' ] = tonumber( t[ source ][ 'min' ] or 0 ) + 1
        t[ source ][ 'sec' ] = 0
    end
    if (arg1 >= 60) then
        t[ source ][ 'min' ] = 0
        t[ source ][ 'hour' ] = tonumber( t[ source ][ 'hour' ] or 0 ) + 1
    end
    return arg1, arg2
end
     
setTimer(
    function( )
        for _, v in pairs( getElementsByType( "player" ) ) do
            if (not t[ v ]) then
                t[ v ] = {
                            ["hour"] = 0,
                             ["min"] = 0,
                             ["sec"] = 0
                            }
            end
 
            t[ v ][ 'sec' ] = tonumber( t[ v ][ 'sec' ] or 0 ) + 1
            local min,sec = checkValues (
                    v,
                    t[ v ][ 'min' ] or 0,
                    t[ v ][ 'sec' ] or 0
						)  
	local hour = tonumber( t[ v ][ 'hour' ] or 0 )

            setElementData(
                v,
                "Online Time",
                tostring( hour )..':'..tostring( min )..':'..tostring( sec )
            )
        end
    end,
    1000, 0
)
   
function onPlayerQuit ( )
    local playeraccount = getPlayerAccount ( source )
    if ( playeraccount ) and not isGuestAccount ( playeraccount ) then
        local sValue = getElementData( source,'Online Time' )
        setAccountData ( playeraccount, "Online Time", tostring(sValue) )
    end
    t[ source ] = nil
end
 
function onPlayerLogin (_, playeraccount )
    if ( playeraccount ) then
        local time = getAccountData ( playeraccount, "Online Time" )
        if ( time ) then
            setElementData ( source, "Online Time", time )
                else
            setElementData ( source, "Online Time",0 )
        setAccountData ( playeraccount, "Online Time",0 )
        end
    end
end
addEventHandler ( "onPlayerQuit", root, onPlayerQuit )
addEventHandler ( "onPlayerLogin", root, onPlayerLogin )