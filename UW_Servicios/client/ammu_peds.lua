function ammustaff_A()
ammu_a1 = createPed ( 179, 0, 0, 0 )
setElementInterior (ammu_a1, 1, 294.94079589844, -40.216415405273, 1001.515625)
setPedVoice(ammu_a1, "PED_TYPE_DISABLED")
setElementFrozen (ammu_a1, true)
setElementDimension (ammu_a1, 0)

end
addEventHandler('onClientResourceStart', getResourceRootElement(),ammustaff_A)
function ammustaff_Base()
ammu_Base1 = createPed ( 179,  1180.255859375, -1434.3662109375, 29.923221588135 )
--setElementInterior (ammu_a1, 1, 294.94079589844, -40.216415405273, 1001.515625)
setPedVoice(ammu_Base1, "PED_TYPE_DISABLED")
setElementFrozen (ammu_Base1, true)
setElementDimension (ammu_Base1, 0)
setElementRotation(ammu_Base1,0,0,95)
function cancelPedDamage ()
	cancelEvent() -- cancel any damage done to peds
end
addEventHandler ( "onClientPedDamage",ammu_Base1, cancelPedDamage )
end
addEventHandler('onClientResourceStart', getResourceRootElement(),ammustaff_Base)

function ammustaff_B()
ammu_b1 = createPed ( 179, 0, 0, 0 )
setElementInterior (ammu_b1, 4, 295.52349853516, -82.529228210449, 1001.515625)
setPedVoice(ammu_b1, "PED_TYPE_DISABLED")
setElementFrozen ( ammu_b1, true )
setElementDimension (ammu_b1, 0)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),ammustaff_B)


function ammustaff_C()
ammu_c1 = createPed ( 179, 0, 0, 0 )
setElementInterior (ammu_c1, 6, 290.03698730469, -111.52514648438, 1001.515625)
setPedVoice(ammu_c1, "PED_TYPE_DISABLED")
setElementFrozen ( ammu_c1, true )
setElementDimension (ammu_c1, 0)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),ammustaff_C)


function ammustaff_D()
ammu_d1 = createPed ( 179, 0, 0, 0 )
setElementInterior (ammu_d1, 6, 312.0705871582, -168.22328186035,999.59375)
setPedVoice(ammu_d1, "PED_TYPE_DISABLED")
setElementFrozen ( ammu_d1, true )
setElementDimension (ammu_d1, 0)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),ammustaff_D)

function ammustaff_E()
ammu_e1 = createPed ( 179, 0, 0, 0, 90 )
setElementInterior (ammu_e1, 7, 316.23028564453, -138.67251586914, 1004.0625)
setPedVoice(ammu_e1, "PED_TYPE_DISABLED")
setElementFrozen ( ammu_e1, true )
setElementDimension (ammu_e1, 0)

ammu_e2 = createPed ( 179, 0, 0, 0, 90 )
setElementInterior (ammu_e2, 7, 316.50741577148, -133.30191040039, 999.6015625)
setPedVoice(ammu_e2, "PED_TYPE_DISABLED")
setElementFrozen ( ammu_e2, true )
setElementDimension (ammu_e2, 0)

ammu_e3 = createPed ( 179, 0, 0, 0 )
setElementInterior (ammu_e3, 7, 308.4040222168, -143.09046936035, 999.6015625)
setPedVoice(ammu_e3, "PED_TYPE_DISABLED")
setElementFrozen ( ammu_e3, true )
setElementDimension (ammu_e3, 0)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),ammustaff_E)