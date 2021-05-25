sw, sh = guiGetScreenSize()
stream = {}
cctvC = {}
cctvT = {}
localC = {}
active = {}
active.modes = {}
active.currentmode = 1
active.switch = false
localT = {}
playerMatrix = {}
viewList = {}
viewID = 0
localObject = false
localMarker = false
markerType = "cylinder"
wallcam = 2921
ceilcam = 1886
terminalModel = 2190
inMarker = false
offsets = {}
offsets.wallAngle = -53
offsets.wallZ = 0.225
offsets.wallLens = 1.03  
offsets.ceilAngle = -180
offsets.ceilZ = -0.525
offsets.ceilLens = 0.33
offsets.interference = 1
black = tocolor(0, 0, 0, 255)
white = tocolor(255, 255, 255, 255)
gray = tocolor(128, 128, 128, 255)
viewCamera = false
scan = "gfx/scanlines.png"
flicker = 1
camDist = 50
placing = false

buttons = {
  ["num_1"] = {0,2, 64,128},
  ["num_2"] = {1,2, 64,64},
  ["num_3"] = {2,2, 64,192},
  ["num_4"] = {0,1, 0,0},
  ["num_5"] = {1,1, 128,0},
  ["num_6"] = {2,1, 64,0},
  ["num_7"] = {0,0, 0,128},
  ["num_8"] = {1,0, 0,64},
  ["num_9"] = {2,0, 0,192},
-- ["num_add"] = {3,0, 192,0}
}

buttonColors = {}
buttonColors.active = tocolor(255,255,255,192)
buttonColors.inactive = tocolor(128,128,128,128)
buttonColors.pressed = tocolor(255,255,255,255)

addEventHandler("onClientResourceStart", resourceRoot, 
	function ()
    sw, sh = guiGetScreenSize()
    addEventHandler("onClientRender", root, cctvView)
    
    -- error window
		cctvErrorWindow = guiCreateWindow(sw/2 - 200, sh/2 - 50, 400, 100, "Error!", false)
    cctvErrorText = guiCreateLabel(.1, .35, .94, .3, "Error:",true, cctvErrorWindow)
    cctvErrorClose = guiCreateButton(.3, .7, .4, .3, "OK", true, cctvErrorWindow)    
    guiLabelSetColor(cctvErrorText, 255, 5, 5)
    guiSetFont(cctvErrorText, "default-bold-small")
    guiWindowSetSizable(cctvErrorWindow, false)	
    guiSetVisible(cctvErrorWindow, false)
    
    -- camera view controls
    cctvControl = guiCreateWindow(sw-180, sh-200, 152, 187, "CCTV", false)
    cctvControlInfo = guiCreateLabel(.1,.87,.9,.2, "PRESS NUM+ TO EXIT", true, cctvControl)
    guiLabelSetColor(cctvControlInfo, 125, 125, 125)
    guiSetFont(cctvControlInfo, "default-bold-small")
    guiWindowSetSizable(cctvControl, false)	
    guiSetVisible(cctvControl, false)
    
    -- main setup window   
    cctvWindow = guiCreateWindow(sw/2-300, sh/2-200, 600, 400, "CCTV Setup", false)
    setElementData(cctvWindow, "tooltip-color", "#222222", false)
    setElementData(cctvWindow, "tooltip-background", "#bbbbbb", false)
    guiWindowSetSizable(cctvWindow, false)	
    cctvTabs = guiCreateTabPanel(0, .07, 1, .8, true, cctvWindow) 
    cctvSetup = guiCreateTab("Management", cctvTabs)  
    cctvAddCam = guiCreateTab("Add/Edit camera", cctvTabs)  
    cctvAddTerminal = guiCreateTab("Add/Edit terminal", cctvTabs)  
    cctvRR = guiCreateTab("Reset/Reload", cctvTabs)  
    cctvClose = guiCreateButton(.82, .9, .2, .1, "Close", true, cctvWindow)    
    cctvBB = guiCreateLabel(.03,.91,.6,.08, "Big Brother is watching you.", true, cctvWindow)
    guiLabelSetColor(cctvBB, 55, 55, 55)
    cctvClr = guiCreateButton(.67, .9, .14, .1, "Clear", true, cctvWindow)    
    setElementData(cctvClr, "tooltip-text", "Clear all settings in camera/terminal editing tabs", false)
    
    -- Management tab
    guiSetFont(guiCreateLabel(.03,.03,.44,.07, "Terminals list:", true, cctvSetup),"default-bold-small")
    guiSetFont(guiCreateLabel(.53,.03,.44,.07, "Cameras list:", true, cctvSetup),"default-bold-small")
    cctvTList = guiCreateGridList(.03, .1, .44, .75, true, cctvSetup)
    setElementData(cctvTList, "tooltip-text", "Double click a terminal to display connected cameras", false)
    cctvTListName = guiGridListAddColumn(cctvTList, "Terminal ID", .6)
    cctvTListCams = guiGridListAddColumn(cctvTList, "Cams", .31)
    cctvCList = guiCreateGridList(.53, .1, .44, .75, true, cctvSetup)
    setElementData(cctvCList, "tooltip-text", "Double click a camera to view", false)
    cctvCListName = guiGridListAddColumn(cctvCList, "Camera ID", .5)
    cctvCListTerminal = guiGridListAddColumn(cctvCList, "Connected to", .41)
    guiSetFont(cctvTList,"default-small")
    guiSetFont(cctvCList,"default-small")
    cctvFreeCams = guiCreateButton(.47, .1, .055, .22, "---", true, cctvSetup)    
    setElementData(cctvFreeCams, "tooltip-text", "Show all disconnected cameras", false)
    cctvCamList = guiCreateButton(.47, .33, .055, .22, "All", true, cctvSetup)    
    setElementData(cctvCamList, "tooltip-text", "Show all cameras", false)
    cctvConnect = guiCreateButton(.47, .56, .055, .22, "<<", true, cctvSetup)    
    setElementData(cctvConnect, "tooltip-text", "Connect selected camera to selected terminal", false)
    --guiSetFont(cctvPort,"default-small")
    cctvTDelete = guiCreateButton(.03, .87, .11, .1, "Delete", true, cctvSetup)    
    cctvTView = guiCreateButton(.15, .87, .1, .1, "View", true, cctvSetup)    
    cctvTEdit = guiCreateButton(.26, .87, .1, .1, "Edit", true, cctvSetup)    
    cctvPort = guiCreateButton(.37, .87, .1, .1, "Port", true, cctvSetup)    
    setElementData(cctvPort, "tooltip-text", "Teleport to selected terminal location", false)
    cctvCDelete = guiCreateButton(.53, .87, .14, .1, "Delete", true, cctvSetup)    
    cctvCDisc = guiCreateButton(.68, .87, .14, .1, "Disconnect", true, cctvSetup)    
    cctvCEdit = guiCreateButton(.83, .87, .14, .1, "Edit", true, cctvSetup)    
    
    -- Add camera tab
    guiSetFont(guiCreateLabel(.03,.04,.22,.06, "Camera ID:", true, cctvAddCam),"default-small")
    cctvAddCamName = guiCreateEdit(.03, .1, .22, .1, "", true, cctvAddCam)
    guiEditSetMaxLength(cctvAddCamName, 10)
    guiSetFont(guiCreateLabel(.25,.04,.22,.06, "Terminal ID (optional):", true, cctvAddCam),"default-small")
    cctvAddCamTerminal = guiCreateEdit(.25, .1, .22, .1, "", true, cctvAddCam)
    setElementData(cctvAddCamTerminal, "tooltip-text", "Camera will be connected to this terminal (leave it blank to leave camera disconnected)", false)
    guiEditSetMaxLength(cctvAddCamTerminal, 10)
    guiSetFont(guiCreateLabel(.03,.22,.4,.06, "Camera options:", true, cctvAddCam),"default-bold-small")
    cctvAddCamMotor = guiCreateCheckBox(.03,.27,.22,.1, "Motorized", false, true, cctvAddCam)
    setElementData(cctvAddCamMotor, "tooltip-text", "Allows panning and tilting camera in view mode", false)
    cctvAddCamZoom = guiCreateCheckBox(.25,.27,.22,.1, "Zoom enabled", false, true, cctvAddCam)
    cctvAddCamIR = guiCreateCheckBox(.03,.34,.22,.1, "Thermal (IR)*", false, true, cctvAddCam)
    --cctvAddCamIRP = guiCreateCheckBox(.03,.41,.22,.1, "Thermal Plus*", false, true, cctvAddCam)
    cctvAddCamNight = guiCreateCheckBox(.25,.34,.22,.1, "Nightvision*", false, true, cctvAddCam)
    cctvNote11 = guiCreateLabel(.03,.44,.44,.05, " * thermal/nightvision modes work only MTA 1.1+ ", true, cctvAddCam)
    guiSetFont(cctvNote11,"default-small")
    guiLabelSetColor(cctvNote11, 128, 128, 128)

    guiSetFont(guiCreateLabel(.03,.5,.4,.06, "Camera placement:", true, cctvAddCam),"default-bold-small")
    cctvWall = guiCreateRadioButton(.03, .55, .22, .1, "Wall mount",true,cctvAddCam)
    cctvCeiling = guiCreateRadioButton(.25, .55, .22, .1, "Ceiling mount",true,cctvAddCam)
    guiRadioButtonSetSelected(cctvWall, true)
    cctvAddCamX = guiCreateEdit(.03, .65, .11, .1, "", true, cctvAddCam)
    cctvAddCamY = guiCreateEdit(.14, .65, .11, .1, "", true, cctvAddCam)
    cctvAddCamZ = guiCreateEdit(.25, .65, .11, .1, "", true, cctvAddCam)
    cctvAddCamPlace = guiCreateButton(.36, .65, .11, .1, "Place", true, cctvAddCam)
    guiSetFont(guiCreateLabel(.03,.76,.44,.06, "* X/Y/Z of the camera, click 'Place' to place camera", true, cctvAddCam),"default-small")
    cctvAddCamLive = guiCreateCheckBox(.03,.85,.22,.1, "Setup live view", false, true, cctvAddCam)
    cctvAddCamSave = guiCreateButton(.25,.85,.22,.1, "SAVE CAMERA", true, cctvAddCam)
    guiSetFont(cctvAddCamSave, "default-bold-small")
    guiSetFont(guiCreateLabel(.95,.04,.1,.06, "U/D", true, cctvAddCam),"default-small")
    cctvAddCamUp = guiCreateScrollBar(.95, .1, .033, .86, false, true, cctvAddCam)
    guiSetFont(guiCreateLabel(.5,.04,.4,.06, "Scanlines RGB colorization:", true, cctvAddCam),"default-small")
    cctvAddCamR = guiCreateScrollBar(.5, .1, .44, .07, true, true, cctvAddCam)
    cctvAddCamG = guiCreateScrollBar(.5, .17, .44, .07, true, true, cctvAddCam)
    cctvAddCamB = guiCreateScrollBar(.5, .24, .44, .07, true, true, cctvAddCam)
    guiSetFont(guiCreateLabel(.5,.31,.4,.06, "Scanlines intensity:", true, cctvAddCam),"default-small")
    cctvAddCamS = guiCreateScrollBar(.5, .37, .44, .07, true, true, cctvAddCam)
    guiSetFont(guiCreateLabel(.5,.44,.4,.06, "Scanline size:", true, cctvAddCam),"default-small")
    cctvAddCamSS = guiCreateScrollBar(.5, .5, .44, .07, true, true, cctvAddCam)
    guiSetFont(guiCreateLabel(.5,.57,.4,.06, "Flicker level:", true, cctvAddCam),"default-small")
    cctvAddCamF = guiCreateScrollBar(.5, .63, .44, .07, true, true, cctvAddCam)
    guiSetFont(guiCreateLabel(.5,.7,.4,.06, "Field of View:", true, cctvAddCam),"default-small")
    cctvAddCamFov = guiCreateScrollBar(.5, .76, .44, .07, true, true, cctvAddCam)
    guiScrollBarSetScrollPosition(cctvAddCamFov, 90)
    guiSetFont(guiCreateLabel(.5,.83,.4,.06, "Horizontal angle:", true, cctvAddCam),"default-small")
    cctvAddCamPan = guiCreateScrollBar(.5, .89, .44, .07, true, true, cctvAddCam)

    -- Add terminal tab
    guiSetFont(guiCreateLabel(.03,.04,.22,.06, "Terminal ID:", true, cctvAddTerminal),"default-small")
    cctvAddTerName = guiCreateEdit(.03, .1, .22, .1, "", true, cctvAddTerminal)
    guiEditSetMaxLength(cctvAddTerName, 10)
    guiSetFont(guiCreateLabel(.25,.04,.22,.06, "Password/Team/ACL:", true, cctvAddTerminal),"default-small")
    cctvAddTerAccess = guiCreateEdit(.25, .1, .22, .1, "", true, cctvAddTerminal)
    setElementData(cctvAddTerAccess, "tooltip-text", "Type password/team name or ACL group name here, depending on acces option selected", false)
    guiEditSetMaxLength(cctvAddTerAccess, 32)
    guiSetFont(guiCreateLabel(.03,.22,.4,.06, "Terminal access restriction:", true, cctvAddTerminal),"default-bold-small")
    cctvAddTerPublic = guiCreateRadioButton(.03,.28,.22,.1, "Public", true, cctvAddTerminal)
    setElementData(cctvAddTerPublic, "tooltip-text", "Everyone will be able to use this terminal", false)
    cctvAddTerPass = guiCreateRadioButton(.25,.28,.22,.1, "by Password*", true, cctvAddTerminal)
    setElementData(cctvAddTerPass, "tooltip-text", "Everyone who knows the password will be able to use this terminal", false)
    cctvAddTerTeam = guiCreateRadioButton(.03,.36,.22,.1, "by Team*", true, cctvAddTerminal)
    setElementData(cctvAddTerTeam, "tooltip-text", "Only specific team will be able to use this terminal", false)
    cctvAddTerAcl = guiCreateRadioButton(.25,.36,.22,.1, "by ACL Group*", true, cctvAddTerminal)
    setElementData(cctvAddTerAcl, "tooltip-text", "Only specific ACL group will be able to use this terminal", false)
    guiRadioButtonSetSelected(cctvAddTerPublic, true)
    guiSetFont(guiCreateLabel(.03,.46,.44,.2, "* Don't forget to specify Password/Team/ACL in the field\n above according to the selected option!", true, cctvAddTerminal),"default-small")
    guiSetFont(guiCreateLabel(.03,.83,.4,.06, "Rotation:", true, cctvAddTerminal),"default-small")
    cctvAddTerRot = guiCreateScrollBar(.03, .89, .44, .07, true, true, cctvAddTerminal)
    guiSetFont(guiCreateLabel(.03,.57,.4,.06, "Terminal placement:", true, cctvAddTerminal),"default-bold-small")
    cctvAddTerX = guiCreateEdit(.03, .65, .11, .1, "", true, cctvAddTerminal)
    cctvAddTerY = guiCreateEdit(.14, .65, .11, .1, "", true, cctvAddTerminal)
    cctvAddTerZ = guiCreateEdit(.25, .65, .11, .1, "", true, cctvAddTerminal)
    cctvAddTerPlace = guiCreateButton(.36, .65, .11, .1, "Place", true, cctvAddTerminal)
    guiSetFont(guiCreateLabel(.03,.76,.44,.06, "* X/Y/Z of the terminal, click 'Place' to place it", true, cctvAddTerminal),"default-small")
    guiSetFont(guiCreateLabel(.5,.04,.4,.06, "Terminal marker RGB color:", true, cctvAddTerminal),"default-small")
    cctvAddTerR = guiCreateScrollBar(.5, .1, .48, .07, true, true, cctvAddTerminal)
    cctvAddTerG = guiCreateScrollBar(.5, .17, .48, .07, true, true, cctvAddTerminal)
    cctvAddTerB = guiCreateScrollBar(.5, .24, .48, .07, true, true, cctvAddTerminal)
    guiSetFont(guiCreateLabel(.5,.31,.4,.06, "Marker opacity:", true, cctvAddTerminal),"default-small")
    cctvAddTerA = guiCreateScrollBar(.5, .37, .48, .07, true, true, cctvAddTerminal)
    guiScrollBarSetScrollPosition(cctvAddTerA, 50)
    guiSetFont(guiCreateLabel(.5,.44,.4,.06, "Marker size:", true, cctvAddTerminal),"default-small")
    cctvAddTerSize = guiCreateScrollBar(.5, .5, .48, .07, true, true, cctvAddTerminal)
    guiScrollBarSetScrollPosition(cctvAddTerSize, 20)
    cctvAddTerMO = guiCreateCheckBox(.5,.57,.48,.1, "Use only marker (without PC object)", false, true, cctvAddTerminal)
    cctvAddTerMView = guiCreateCheckBox(.5,.85,.22,.1, "Preview marker", false, true, cctvAddTerminal)
    cctvAddTerSave = guiCreateButton(.75,.85,.23,.1, "SAVE TERMINAL", true, cctvAddTerminal)
    guiSetFont(cctvAddTerSave, "default-bold-small")
    
    -- Reset tab
    cctvRReload = guiCreateButton(.03,.85,.46,.1, "Reload everything from DB", true, cctvRR)
    cctvRReset = guiCreateButton(.51,.85,.46,.1, "Reset/delete everything", true, cctvRR)
    
    guiSetVisible(cctvWindow, false)
    
    addEventHandler("onClientGUIScroll", source, 
      function(bar)
        if bar == cctvAddCamR then localC.r = guiScrollBarGetScrollPosition(cctvAddCamR)*2  
        elseif bar == cctvAddCamG then localC.g = guiScrollBarGetScrollPosition(cctvAddCamG)*2 
        elseif bar == cctvAddCamB then localC.b = guiScrollBarGetScrollPosition(cctvAddCamB)*2 
        elseif bar == cctvAddCamS then localC.scanlines = guiScrollBarGetScrollPosition(cctvAddCamS) 
        elseif bar == cctvAddCamF then localC.flicker = 1 + math.floor(guiScrollBarGetScrollPosition(cctvAddCamF)/10) 
        elseif bar == cctvAddCamSS then localC.scansize = guiScrollBarGetScrollPosition(cctvAddCamSS)*5 
        elseif bar == cctvAddCamFov then
          localC.fov = 20+guiScrollBarGetScrollPosition(cctvAddCamFov)
          if viewCamera then updateCam() end
        elseif bar == cctvAddCamUp then
          localC.height = guiScrollBarGetScrollPosition(cctvAddCamUp)
          if viewCamera then updateCam() end
        elseif bar == cctvAddCamPan then
          localC.angle = math.floor(guiScrollBarGetScrollPosition(cctvAddCamPan)*3.6)
          local offA = 0
          if localC.type == wallcam then offA = offsets.wallAngle
          else offA = offsets.ceilAngle end
          if localObject and isElement(localObject) then setElementRotation(localObject, 0, 0, offA - localC.angle) end
          if viewCamera then updateCam() end
        elseif bar == cctvAddTerRot then 
          localT.rz = math.floor(guiScrollBarGetScrollPosition(cctvAddTerRot)*3.6)
          if localObject and isElement(localObject) then setElementRotation(localObject, 0, 0, localT.rz) end
          if localMarker and isElement(localMarker) then
            local mx, my = getRotation(localT.x, localT.y, 0.7, 195 - localT.rz)      
            setElementPosition(localMarker, mx, my, localT.z-0.5)
          end
        elseif bar == cctvAddTerR then 
          localT.mr = math.floor(guiScrollBarGetScrollPosition(cctvAddTerR)*2.5) 
          if isElement(localMarker) then setMarkerColor(localMarker, localT.mr, localT.mg, localT.mb, localT.ma) end
        elseif bar == cctvAddTerG then 
          localT.mg = math.floor(guiScrollBarGetScrollPosition(cctvAddTerG)*2.5) 
          if isElement(localMarker) then setMarkerColor(localMarker, localT.mr, localT.mg, localT.mb, localT.ma) end
        elseif bar == cctvAddTerB then 
          localT.mb = math.floor(guiScrollBarGetScrollPosition(cctvAddTerB)*2.5) 
          if isElement(localMarker) then setMarkerColor(localMarker, localT.mr, localT.mg, localT.mb, localT.ma) end
        elseif bar == cctvAddTerA then 
          localT.ma = math.floor(guiScrollBarGetScrollPosition(cctvAddTerA)*2.5) 
          if isElement(localMarker) then setMarkerColor(localMarker, localT.mr, localT.mg, localT.mb, localT.ma) end
        elseif bar == cctvAddTerSize then 
          localT.markersize = guiScrollBarGetScrollPosition(cctvAddTerSize)/10
          if isElement(localMarker) then setMarkerSize(localMarker, localT.markersize) end
        end  
      end
    )
    addEventHandler("onClientKey", root,
      function(key, press)
        if viewCamera and viewCamera ~= "EDIT" then
          if press then return false end
          if key == "num_add" then -- exit camera view
            cctvController("close")
          elseif key == "num_9" and active.switch then -- next camera
            cctvController("next")
          elseif key == "num_3" and active.switch then -- prev camera
            cctvController("prev")
          elseif key == "num_5" then -- mode switch
            if #active.modes > 1 then
              active.currentmode = active.currentmode == #active.modes and 1 or (active.currentmode + 1)
              cctvController(active.modes[active.currentmode])
            end  
          end
        end
      end
    )  
    addEventHandler("onClientGUIClick", source,
			function(button, state)
				if source == cctvErrorClose then guiSetVisible(cctvErrorWindow, false)
        elseif source == cctvRReload then sendServer(true, "dbreload")
        elseif source == cctvRReset then sendServer(true, "dbreset")
        elseif source == cctvClr then cctvGUIClear()
				elseif source == cctvClose then 
          toggleCCTV(false)
          if guiCheckBoxGetSelected(cctvAddCamLive) then cctvSetLiveView("EDIT", false) end
          cctvGUIClear()
        elseif source == cctvCDelete then
          local cid = guiGridListGetItemText(cctvCList, guiGridListGetSelectedItem(cctvCList), 1)   
          if cid and cctvC[cid] then sendServer(true, "delcam", cid) end
        elseif source == cctvTDelete then
          local tid = guiGridListGetItemText(cctvTList, guiGridListGetSelectedItem(cctvTList), 1)   
          if tid and cctvT[tid] then sendServer(true, "delterm", tid) end
        elseif source == cctvCEdit then
          local cid = guiGridListGetItemText(cctvCList, guiGridListGetSelectedItem(cctvCList), 1)   
          if cid and cctvC[cid] then
            localC = nil
            localC = table.copy(cctvC[cid])
            localToGUI()
            guiSetSelectedTab(cctvTabs,cctvAddCam)
          end
        elseif source == cctvConnect then
          local tid = guiGridListGetItemText(cctvTList, guiGridListGetSelectedItem(cctvTList), 1)   
          local cid = guiGridListGetItemText(cctvCList, guiGridListGetSelectedItem(cctvCList), 1)   
          if (cid ~= "") and (tid ~= "") then 
            if cctvC[cid].terminal ~= tid then sendServer(true, "c2t", cid, tid) end
          end
        elseif source == cctvPort then
          local tid = guiGridListGetItemText(cctvTList, guiGridListGetSelectedItem(cctvTList), 1)   
          if tid and (tid ~= "") then 
            sendServer(true, "port2t", tid) 
          end  
        elseif source == cctvCDisc then
          local cid = guiGridListGetItemText(cctvCList, guiGridListGetSelectedItem(cctvCList), 1)   
          if cid and cid ~= "" then sendServer(true, "c2t", cid, "--------") end
        elseif source == cctvFreeCams then
          cctvListRefresh("--------")
        elseif source == cctvCamList then
          cctvListRefresh("--------", true)
				elseif source == cctvTView then 
          local tid = guiGridListGetItemText(cctvTList, guiGridListGetSelectedItem(cctvTList), 1)      
          if tid and cctvT[tid] then
            viewList = nil
            viewList = {}
            for id, cam in pairs(cctvC) do
              if cam.terminal == tid then table.insert(viewList, id) end
            end  
            if #viewList > 0 then
              cctvSetLiveView("VIEW", true, viewList[1])
              toggleCCTV(false)
              cctvController("open", viewList[1])
              if guiCheckBoxGetSelected(cctvAddCamLive) then cctvSetLiveView("EDIT", false) end
              if isElement(localObject) then destroyElement(localObject) end            
            end  
          end  
        elseif source == cctvTEdit then
          local tid = guiGridListGetItemText(cctvTList, guiGridListGetSelectedItem(cctvTList), 1)   
          if tid and cctvT[tid] then
            localT = nil
            localT = table.copy(cctvT[tid])
            localToGUI(tid)
            guiSetSelectedTab(cctvTabs,cctvAddTerminal)
          end
        elseif source == cctvAddCamLive then
          cctvSetLiveView("EDIT", guiCheckBoxGetSelected(cctvAddCamLive))
        elseif source == cctvAddCamSave then
          if guiCheckBoxGetSelected(cctvAddCamLive) then cctvSetLiveView("EDIT", false) end
          if guiToLocal() then 
            sendServer(true, "savecam", localC.name, localC)
            guiSetSelectedTab(cctvTabs,cctvSetup)
            if isElement(localObject) then destroyElement(localObject) end
          else cctvError("Not enough parameters to save camera!")
          end
        elseif source == cctvAddTerSave then
          if guiToLocal(true) then 
            sendServer(true, "saveterm", localT.name, localT)
            guiSetSelectedTab(cctvTabs,cctvSetup)
            if isElement(localObject) then destroyElement(localObject) end
            if isElement(localMarker) then destroyElement(localMarker) end
            if guiCheckBoxGetSelected(cctvAddTerMView) then guiCheckBoxSetSelected(cctvAddTerMView, false) end
          else cctvError("Not enough parameters to save terminal!")
          end
        elseif source == cctvWall then
          if guiRadioButtonGetSelected(cctvWall) then localC.type = wallcam end
        elseif source == cctvCeiling then
          if guiRadioButtonGetSelected(cctvCeiling) then localC.type = ceilcam end
        elseif source == cctvAddCamPlace and state == "up" then
          if placing then 
            guiSetText(cctvAddCamPlace, "Place")
            guiSetInputEnabled(true)
            placing = false
          else 
            local x,y,z = getElementPosition(localPlayer)
            local model = wallcam
            if guiRadioButtonGetSelected(cctvCeiling) then model = ceilcam end
            if isElement(localObject) then destroyElement(localObject) end
            localObject = createObject(model, x, y, z)
            setElementInterior(localObject, getCameraInterior())
            setElementDimension(localObject, getElementDimension(localPlayer))
            guiSetText(cctvAddCamPlace, "---")
            guiSetInputEnabled(false)
            guiSetVisible(cctvWindow,false)
            placing = true
          end
        elseif source == cctvAddTerPlace and state == "up" then
          if placing then 
            guiSetText(cctvAddTerPlace, "Place")
            guiSetInputEnabled(true)
            placing = false
          else 
            local x,y,z = getElementPosition(localPlayer)
            if isElement(localObject) then destroyElement(localObject) end
            localObject = createObject(terminalModel, x, y, z-100, 0, 0, math.floor(guiScrollBarGetScrollPosition(cctvAddTerRot)*3.6))
            setElementInterior(localObject, getCameraInterior())
            setElementDimension(localObject, getElementDimension(localPlayer))
            setElementCollisionsEnabled(localObject, false)
            guiSetText(cctvAddTerPlace, "---")
            guiSetInputEnabled(false)
            guiSetVisible(cctvWindow,false)
            placing = "terminal"
          end
        elseif source == cctvAddTerMView then
          if guiCheckBoxGetSelected(cctvAddTerMView) and guiToLocal(true) then
            if localMarker and isElement(localMarker) then destroyElement(localMarker) end
            local mx, my = getRotation(localT.x, localT.y, 0.7, 195 - localT.rz)      
            localMarker = createMarker(mx, my, localT.z-0.5, markerType, localT.markersize, localT.mr, localT.mg, localT.mb, localT.ma)
            setElementInterior(localMarker, getCameraInterior())
            setElementDimension(localMarker, getElementDimension(localPlayer))
          else 
            if localMarker and isElement(localMarker) then destroyElement(localMarker) end
          end
        end
      end
    ) 
    addEventHandler("onClientGUIDoubleClick", source,
      function()
				if source == cctvCList then 
          local cid = guiGridListGetItemText(cctvCList, guiGridListGetSelectedItem(cctvCList), 1)      
          if cid and cctvC[cid] then
            viewList = nil
            viewList = {}
            for id, cam in pairs(cctvC) do
              table.insert(viewList, id)
            end  
            cctvSetLiveView("VIEW", true, cid)
            toggleCCTV(false)
            cctvController("open", cid)
            if guiCheckBoxGetSelected(cctvAddCamLive) then cctvSetLiveView("EDIT", false) end
            if isElement(localObject) then destroyElement(localObject) end            
          end  
				elseif source == cctvTList then 
          local tid = guiGridListGetItemText(cctvTList, guiGridListGetSelectedItem(cctvTList), 1)      
          if tid and cctvT[tid] then
            cctvListRefresh(tid)
          end
        end   
      end
    )      
  end
)  

addEventHandler("onClientGUITabSwitched", root, 
  function(tab)
    if tab ~= cctvAddCam then
      if guiCheckBoxGetSelected(cctvAddCamLive) then cctvSetLiveView("EDIT", false) end
    end  
    if tab ~= cctvAddTerminal then
      if isElement(localMarker) then destroyElement(localMarker) end
      if guiCheckBoxGetSelected(cctvAddTerMView) then guiCheckBoxSetSelected(cctvAddTerMView, false) end
    end  
  end
)

function guiToLocal(terminal)
  if terminal then
    localT.name = idFormat(guiGetText(cctvAddTerName), true) 
    guiSetText(cctvAddTerName, localT.name)
    if not guiGetText(cctvAddTerX) or guiGetText(cctvAddTerX) == "" then return false end
    localT.mr = math.floor(guiScrollBarGetScrollPosition(cctvAddTerR)*2.5)
    localT.mg = math.floor(guiScrollBarGetScrollPosition(cctvAddTerG)*2.5)
    localT.mb = math.floor(guiScrollBarGetScrollPosition(cctvAddTerB)*2.5)
    localT.ma = math.floor(guiScrollBarGetScrollPosition(cctvAddTerA)*2.5)
    localT.markersize = guiScrollBarGetScrollPosition(cctvAddTerSize)/10
    localT.onlymarker = 0
    if guiCheckBoxGetSelected(cctvAddTerMO) then localT.onlymarker = 1 end    
    localT.x = tonumber(guiGetText(cctvAddTerX)) 
    localT.y = tonumber(guiGetText(cctvAddTerY)) 
    localT.z = tonumber(guiGetText(cctvAddTerZ)) 
    localT.rz = math.floor(guiScrollBarGetScrollPosition(cctvAddTerRot)*3.6)
    if not localT.interior then localT.interior = getCameraInterior() end
    if not localT.dimension then localT.dimension = getElementDimension(localPlayer) end
    localT.restricted = 0
    if guiRadioButtonGetSelected(cctvAddTerPass) then localT.restricted = 1 
    elseif guiRadioButtonGetSelected(cctvAddTerTeam) then localT.restricted = 2 
    elseif guiRadioButtonGetSelected(cctvAddTerAcl) then localT.restricted = 3 
    end
    localT.access = tostring(cctvEscape(guiGetText(cctvAddTerAccess)))
    if not localT.access or localT.access == "" then 
      if localT.restricted ~= 0 then return false end
    end
    guiSetText(cctvAddTerAccess, localT.access)
    localT.camcount = 0  
    return true
  else
    localC.name = idFormat(guiGetText(cctvAddCamName))
    guiSetText(cctvAddCamName, localC.name)
    if guiRadioButtonGetSelected(cctvWall) then localC.type = wallcam
    else localC.type = ceilcam end
    localC.terminal = setCamTerminal(guiGetText(cctvAddCamTerminal))
    guiSetText(cctvAddCamTerminal, localC.terminal)
    if not guiGetText(cctvAddCamX) or guiGetText(cctvAddCamX) == "" then return false end
    localC.x = tonumber(guiGetText(cctvAddCamX))
    localC.y = tonumber(guiGetText(cctvAddCamY))
    localC.z = tonumber(guiGetText(cctvAddCamZ))
    if not localC.interior then localC.interior = getCameraInterior() end
    if not localC.dimension then localC.dimension = getElementDimension(localPlayer) end
    localC.angle = math.floor(guiScrollBarGetScrollPosition(cctvAddCamPan)*3.6)
    localC.height = guiScrollBarGetScrollPosition(cctvAddCamUp)
    localC.fov = 20+guiScrollBarGetScrollPosition(cctvAddCamFov)
    localC.r = guiScrollBarGetScrollPosition(cctvAddCamR)*2
    localC.g = guiScrollBarGetScrollPosition(cctvAddCamG)*2
    localC.b = guiScrollBarGetScrollPosition(cctvAddCamB)*2
    localC.scanlines = guiScrollBarGetScrollPosition(cctvAddCamS)
    localC.scansize = guiScrollBarGetScrollPosition(cctvAddCamSS)*5
    localC.flicker = 1 + math.floor(guiScrollBarGetScrollPosition(cctvAddCamF)/10)
    localC.zoom = 0
    if guiCheckBoxGetSelected(cctvAddCamZoom) then localC.zoom = 1 end
    localC.motor = 0
    if guiCheckBoxGetSelected(cctvAddCamMotor) then localC.motor = 1 end
    localC.ir = 0
    if guiCheckBoxGetSelected(cctvAddCamIR) then localC.ir = 1 end
    localC.nv = 0
    if guiCheckBoxGetSelected(cctvAddCamNight) then localC.nv = 1 end
    return true
  end  
end

function localToGUI(terminal)
  if terminal then
    guiSetText(cctvAddTerName, localT.name)
    guiScrollBarSetScrollPosition(cctvAddTerR, math.ceil(localT.mr/2.5))
    guiScrollBarSetScrollPosition(cctvAddTerG, math.ceil(localT.mg/2.5))
    guiScrollBarSetScrollPosition(cctvAddTerB, math.ceil(localT.mb/2.5))
    guiScrollBarSetScrollPosition(cctvAddTerA, math.ceil(localT.ma/2.5))
    guiScrollBarSetScrollPosition(cctvAddTerSize, localT.markersize*10)
    guiSetText(cctvAddTerX, localT.x) 
    guiSetText(cctvAddTerY, localT.y) 
    guiSetText(cctvAddTerZ, localT.z) 
    guiScrollBarSetScrollPosition(cctvAddTerRot, math.ceil(localT.rz/3.6))
    if localT.restricted == 0 then guiRadioButtonSetSelected(cctvAddTerPublic, true) end
    if localT.restricted == 1 then guiRadioButtonSetSelected(cctvAddTerPass, true) end
    if localT.restricted == 2 then guiRadioButtonSetSelected(cctvAddTerTeam, true) end
    if localT.restricted == 3 then guiRadioButtonSetSelected(cctvAddTerAcl, true) end
    if localT.onlymarker == 1 then guiCheckBoxSetSelected(cctvAddTerMO, true) 
    else guiCheckBoxSetSelected(cctvAddTerMO, false) end    
    guiSetText(cctvAddTerAccess, tostring(localT.access)) 
  else
    guiSetText(cctvAddCamName, localC.name)
    if localC.type == wallcam then guiRadioButtonSetSelected(cctvWall, true)
    else guiRadioButtonSetSelected(cctvCeiling, true) end
    guiSetText(cctvAddCamTerminal, localC.terminal)
    guiSetText(cctvAddCamX, localC.x)
    guiSetText(cctvAddCamY, localC.y)
    guiSetText(cctvAddCamZ, localC.z)
    guiScrollBarSetScrollPosition(cctvAddCamPan, math.ceil(localC.angle/3.6))
    guiScrollBarSetScrollPosition(cctvAddCamUp, localC.height)
    guiScrollBarSetScrollPosition(cctvAddCamFov, localC.fov-20)
    guiScrollBarSetScrollPosition(cctvAddCamR, math.floor(localC.r/2))
    guiScrollBarSetScrollPosition(cctvAddCamG, math.floor(localC.g/2))
    guiScrollBarSetScrollPosition(cctvAddCamB, math.floor(localC.b/2))
    guiScrollBarSetScrollPosition(cctvAddCamS, localC.scanlines)
    guiScrollBarSetScrollPosition(cctvAddCamSS, math.floor(localC.scansize/5))
    guiScrollBarSetScrollPosition(cctvAddCamF, math.floor(localC.flicker*10)-1)
    if tonumber(localC.zoom) == 1 then guiCheckBoxSetSelected(cctvAddCamZoom, true) 
    else guiCheckBoxSetSelected(cctvAddCamZoom, false) end
    if tonumber(localC.motor) == 1 then guiCheckBoxSetSelected(cctvAddCamMotor, true) 
    else guiCheckBoxSetSelected(cctvAddCamMotor, false) end
    if tonumber(localC.ir) == 1 then guiCheckBoxSetSelected(cctvAddCamIR, true) 
    else guiCheckBoxSetSelected(cctvAddCamIR, false) end
    if tonumber(localC.nv) == 1 then guiCheckBoxSetSelected(cctvAddCamNight, true) 
    else guiCheckBoxSetSelected(cctvAddCamNight, false) end
  end  
end

function cctvGUIClear()
  guiSetText(cctvAddTerName, "")
  guiSetText(cctvAddTerX, "") 
  guiSetText(cctvAddTerY, "") 
  guiSetText(cctvAddTerZ, "") 
  guiScrollBarSetScrollPosition(cctvAddTerRot, 1)
  guiScrollBarSetScrollPosition(cctvAddTerR, 1)
  guiScrollBarSetScrollPosition(cctvAddTerG, 80)
  guiScrollBarSetScrollPosition(cctvAddTerB, 80)
  guiScrollBarSetScrollPosition(cctvAddTerA, 50)
  guiScrollBarSetScrollPosition(cctvAddTerSize, 20)
  guiCheckBoxSetSelected(cctvAddTerMView, false)
  guiCheckBoxSetSelected(cctvAddTerMO, false)
  guiRadioButtonSetSelected(cctvAddTerPublic, true)
  guiSetText(cctvAddTerAccess, "") 
  guiSetText(cctvAddCamName, "")
  guiRadioButtonSetSelected(cctvWall, true)
  guiSetText(cctvAddCamTerminal, "")
  guiSetText(cctvAddCamX, "")
  guiSetText(cctvAddCamY, "")
  guiSetText(cctvAddCamZ, "")
  guiScrollBarSetScrollPosition(cctvAddCamPan, 50)
  guiScrollBarSetScrollPosition(cctvAddCamUp, 50)
  guiScrollBarSetScrollPosition(cctvAddCamFov, 50)
  guiScrollBarSetScrollPosition(cctvAddCamR, 11)
  guiScrollBarSetScrollPosition(cctvAddCamG, 22)
  guiScrollBarSetScrollPosition(cctvAddCamB, 33)
  guiScrollBarSetScrollPosition(cctvAddCamS, 11)
  guiScrollBarSetScrollPosition(cctvAddCamSS, 1)
  guiScrollBarSetScrollPosition(cctvAddCamF, 1)
  guiCheckBoxSetSelected(cctvAddCamZoom, false)
  guiCheckBoxSetSelected(cctvAddCamMotor, false)
  guiCheckBoxSetSelected(cctvAddCamIR, false)
  guiCheckBoxSetSelected(cctvAddCamNight, false)
  localC = {}
  active.modes = {}
  active.currentmode = 1
  active.switch = false
  localT = {}
  if isElement(localMarker) then destroyElement(localMarker) end
  if isElement(localObject) then destroyElement(localObject) end
end

addCommandHandler("cctv", 
  function(cmd, action, id)
    sendServer(true, "gui")
  end
)

addCommandHandler("watch", 
  function(cmd, pass)
    if viewCamera then return false end
    sendServer(true, "viewterminal", inMarker, pass)
  end
)

addEventHandler("onClientClick", root, 
  function(button, state, _, _, wx, wy, wz, element)
    if element and element ~= localObject and element ~= localPlayer then return false end
    if placing == "terminal" and button == "left" and state == "down" then
      guiSetText(cctvAddTerPlace, "Place")
      placing = false
      guiSetVisible(cctvWindow,true)
      guiSetInputEnabled(true)
      localT.x, localT.y, localT.z = wx, wy, wz
      guiSetText(cctvAddTerX, wx)
      guiSetText(cctvAddTerY, wy)
      guiSetText(cctvAddTerZ, wz)
    elseif placing and button == "left" and state == "down" then
      guiSetText(cctvAddCamPlace, "Place")
      placing = false
      guiSetVisible(cctvWindow,true)
      guiSetInputEnabled(true)
      localC.x, localC.y, localC.z = wx, wy, wz
      guiSetText(cctvAddCamX, wx)
      guiSetText(cctvAddCamY, wy)
      guiSetText(cctvAddCamZ, wz)
    elseif placing and button == "right" then
      guiSetText(cctvAddCamPlace, "Place")
      guiSetText(cctvAddTerPlace, "Place")
      placing = false
      guiSetVisible(cctvWindow,true)
      guiSetInputEnabled(true)
    end
  end
)  

addEventHandler("onClientCursorMove", root, 
  function(_, _, sx, sy, wx, wy, wz)
    if placing == "terminal" and localObject then
      local px, py, pz = getCameraMatrix()
      local hit, x, y, z = processLineOfSight(px, py, pz, wx, wy, wz, true, false, false, false)
      if hit then setElementPosition(localObject, x, y, z)
        if isElement(localMarker) then
          local mx, my = getRotation(x, y, 0.7, 195 - localT.rz)      
          setElementPosition(localMarker, mx, my, z-0.5)
        end
      else setElementPosition(localObject, wx, wy, wz) 
        if isElement(localMarker) then
          local mx, my = getRotation(wx, wy, 0.7, 195 - localT.rz)      
          setElementPosition(localMarker, mx, my, wz-0.5)
        end
      end
    elseif placing and localObject then
      local px, py, pz = getCameraMatrix()
      local hit, x, y, z = processLineOfSight(px, py, pz, wx, wy, wz, true, false, false, false)
      if hit then setElementPosition(localObject, x, y, z)
      else setElementPosition(localObject, wx, wy, wz) end
    end  
  end
)  

function toggleCCTV(show)
  if placing then return false end  
  if show then
	  guiSetVisible(cctvWindow, true)
		guiBringToFront(cctvWindow)
		showCursor(true)
    guiSetInputEnabled(true)
	else 
	  guiSetVisible(cctvWindow, false)
		showCursor(false)
    guiSetInputEnabled(false)
	end
end

function cctvController(action, cam)
  if action == "open" and #viewList > 0 then
    viewID = 1
    active.switch = #viewList > 1
    if cam then while viewList[viewID] ~= cam do viewID = viewID + 1 end end
    active.modes = {}
    active.modes[1] = "normal"
    if cctvC[viewList[viewID]].nv == 1 then table.insert(active.modes, "nightvision") end
    if cctvC[viewList[viewID]].ir >= 1 then table.insert(active.modes, "thermalvision") end
    guiSetText(cctvControl,"Terminal ID: "..cctvC[viewList[viewID]].terminal)
	  guiSetVisible(cctvControl, true)
    active.currentmode = 1
	  guiBringToFront(cctvControl)
		showCursor(true)
  elseif action == "next" then
    viewID = viewID >= #viewList and 1 or (viewID + 1)
    active.modes = {}
    active.modes[1] = "normal"
    if cctvC[viewList[viewID]].nv == 1 then table.insert(active.modes, "nightvision") end
    if cctvC[viewList[viewID]].ir >= 1 then table.insert(active.modes, "thermalvision") end
    guiSetText(cctvControl,"Terminal ID: "..cctvC[viewList[viewID]].terminal)
    active.currentmode = 1
    updateCam(false, "normal")
    updateCam(viewList[viewID])
  elseif action == "prev" then
    viewID = viewID <= 1 and #viewList or (viewID - 1)
    active.modes = {}
    active.modes[1] = "normal"
    if cctvC[viewList[viewID]].nv == 1 then table.insert(active.modes, "nightvision") end
    if cctvC[viewList[viewID]].ir >= 1 then table.insert(active.modes, "thermalvision") end
    guiSetText(cctvControl,"Terminal ID: "..cctvC[viewList[viewID]].terminal)
    active.currentmode = 1
    updateCam(false, "normal")
    updateCam(viewList[viewID])
  elseif action == "nightvision" then
    if localC.nv == 1 then 
      if viewCamera then updateCam(false, action) end
    end
  elseif action == "thermalvision" then
    if localC.ir == 1 then 
      if viewCamera then updateCam(false, action) end
    end
  elseif action == "normal" then
    if viewCamera then updateCam(false, action) end
  elseif action == "close" then
    viewID = 0
    viewList = {}
    localC = {}
    active.modes = {}
    active.currentmode = 1
    active.switch = false    
    cctvSetLiveView("VIEW", false)
    guiSetVisible(cctvControl, false)
		showCursor(false)
	end
end

function cctvSetLiveView(view, on, cid)
  if view == "EDIT" then
    if not guiToLocal() then 
      cctvError("Not enough parameters for live view, place camera first.")
      guiCheckBoxSetSelected(cctvAddCamLive, false)
      return false 
    end 
    if on then
      guiSetAlpha(cctvWindow, 0.3)
      sendServer(true, "editcam")
      guiSetEnabled(cctvAddCamPlace, false)    
    else 
      sendServer(true, "editcam", "exit unfreeze")
      viewCamera = false 
      switchCam("player")
      guiSetAlpha(cctvWindow, 1)
      guiSetEnabled(cctvAddCamPlace, true)  
      guiCheckBoxSetSelected(cctvAddCamLive, false)      
    end
  elseif view == "VIEW" then
    if on then
      sendServer(true, "viewcam", cid)
    else
      sendServer(true, "viewcam", "exit unfreeze")
      viewCamera = false 
      switchCam("player")
    end   
  end  
end

function switchCam(to,cid)
  if to == "cctv" then
    playerMatrix.x, playerMatrix.y, playerMatrix.z, playerMatrix.tx, playerMatrix.ty, playerMatrix.tz, playerMatrix.roll, playerMatrix.fov = getCameraMatrix()
    playerMatrix.interior = getElementInterior(localPlayer)
    playerMatrix.dimension = getElementDimension(localPlayer)
    playerMatrix.px, playerMatrix.py, playerMatrix.pz = getElementPosition(localPlayer)
    if getCameraGoggleEffect then playerMatrix.effect = getCameraGoggleEffect() end
    updateCam(cid)
  else
    setCameraMatrix(playerMatrix.x, playerMatrix.y, playerMatrix.z, playerMatrix.tx, playerMatrix.ty, playerMatrix.tz, playerMatrix.roll, playerMatrix.fov)
    setCameraInterior(playerMatrix.interior)
    if setCameraGoggleEffect then setCameraGoggleEffect(playerMatrix.effect) end
    setElementDimension(localPlayer, playerMatrix.dimension)
    setElementInterior(localPlayer, playerMatrix.interior, playerMatrix.px, playerMatrix.py, playerMatrix.pz)
    setCameraTarget(localPlayer)    
  end  
end

function updateCam(cid,mode)
  if mode then
    if setCameraGoggleEffect then setCameraGoggleEffect(mode) end
    return true
  end
  if cid and cctvC[cid] then localC = table.copy(cctvC[cid]) end
  local offZ = 0
  local offL = 0
  if localC.type == wallcam then
    offZ = offsets.wallZ
    offL = offsets.wallLens
  else 
    offZ = offsets.ceilZ
    offL = offsets.ceilLens
  end
  local tx, ty = getRotation(localC.x, localC.y, camDist, localC.angle)
  local lx, ly = getRotation(localC.x, localC.y, offL, localC.angle)
  if localC.interior ~= getElementInterior(localPlayer) then setElementInterior(localPlayer,localC.interior) end
  if localC.dimension ~= getElementDimension(localPlayer) then setElementDimension(localPlayer,localC.dimension) end
  if getCameraInterior() ~= localC.interior then setCameraInterior(localC.interior) end
  offsets.zone = cctvZone(getZoneName(localC.x, localC.y, localC.z))
  setCameraMatrix(lx, ly, localC.z + offZ, tx, ty, (40 - localC.height) + localC.z, 0, localC.fov)  
end

function sendServer(admin, action, id, data)
  local event = "cctvGate"
  -- if admin then event = "cctvAdminGate" end -- redundant
  triggerServerEvent(event, localPlayer, action, id, data)
end

function cctvListRefresh(tid, allcams)
  if tid then
    guiGridListClear(cctvCList)
    for id,cam in pairs(cctvC) do
      if cam.terminal == tid then
        local row = guiGridListAddRow(cctvCList)
        guiGridListSetItemText(cctvCList, row, cctvCListName, id, false, false)
        guiGridListSetItemText(cctvCList, row, cctvCListTerminal, cam.terminal, false, false)
      elseif allcams then 
        local row = guiGridListAddRow(cctvCList)
        guiGridListSetItemText(cctvCList, row, cctvCListName, id, false, false)
        guiGridListSetItemText(cctvCList, row, cctvCListTerminal, cam.terminal, false, false)
      end  
    end
  else
    guiGridListClear(cctvTList)
    guiGridListClear(cctvCList)
    for id,trm in pairs(cctvT) do
      local row = guiGridListAddRow(cctvTList)
      guiGridListSetItemText(cctvTList, row, cctvTListName, id, false, false)
      guiGridListSetItemText(cctvTList, row, cctvTListCams, tostring(trm.camcount), false, false)
      --outputChatBox(trm.camcount)
    end
    for id,cam in pairs(cctvC) do
      local row = guiGridListAddRow(cctvCList)
      guiGridListSetItemText(cctvCList, row, cctvCListName, id, false, false)
      guiGridListSetItemText(cctvCList, row, cctvCListTerminal, cam.terminal, false, false)
    end
  end  
end  

addEvent("cctvListUpdate", true)
addEventHandler("cctvListUpdate", root, 
  function(ts,cs)
    cctvT = ts
    cctvC = cs
    cctvListRefresh()
  end
)  

addEvent("cctvOpen", true)
addEventHandler("cctvOpen", root, 
  function()
	  guiSetVisible(cctvWindow, true)
		guiBringToFront(cctvWindow)
		showCursor(true)
    guiSetInputEnabled(true)
  end
)  

addEvent("cctvCamData", true)
addEventHandler("cctvCamData", root, 
  function(camData, mode)
    if mode == "VIEWTERMINAL" then
      viewList = camData
      viewCamera = "VIEW"
      cctvController("open", viewList[1])    
      switchCam("cctv", viewList[1])
    else
      if camData then localC = camData end
      viewCamera = mode
      switchCam("cctv")
    end  
  end
)  

addEventHandler("onClientMarkerHit", root, 
  function()
    if getElementData(source,"cctv.tid") and getElementDimension(source) == getElementDimension(localPlayer) then inMarker = getElementData(source,"cctv.tid") end
  end
)  

addEventHandler("onClientMarkerLeave", root, 
  function()
    if getElementData(source,"cctv.tid") then inMarker = false end
  end
)  

function idFormat(text, terminal)
  local id = string.gsub(text, "%D", "")
  text = string.gsub(text, "%A", "")
  if text == "" then 
    if terminal then text = "TM" 
    else text = "CM" end
    id = math.random(100000,999999)
    while cctvT["TM"..id] or cctvC["CM"..id] do
      id = math.random(100000,999999)
    end
  end
  return string.upper(text)..id
end

function setCamTerminal(terminal)
  if not terminal or terminal == "" then return "--------" end
  terminal = string.upper(terminal)
  if not cctvT[terminal] then return "--------" end
  return terminal
end

function getTimeStamp()
  local timeT = getRealTime()  
  local hh = timeT.hour
  local mm = timeT.minute
  local ss = timeT.second
  if ss < 10 then ss = tostring("0" .. ss) end
  if mm < 10 then mm = tostring("0" .. mm) end
  if hh < 10 then hh = tostring("0" .. hh) end
  return hh..":"..mm..":"..ss
end

function getDateStamp()
  local timeT = getRealTime()  
  local fday = timeT.monthday
  if fday < 10 then fday = "0"..fday end
  local fmonth = 1 + timeT.month
  if fmonth < 10 then fmonth = "0"..fmonth end
  local fyear = timeT.year - 100
  return fday.."/"..fmonth.."/"..fyear
end

function table.copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function cctvEscape(text)
  text = string.gsub(text, "\'", "")
  text = string.gsub(text, "\"", "")
  text = string.gsub(text, "\`", "")
  text = string.gsub(text, " ", "")
  return text
end

function getRotation(x, y, dist, angle)
  local a = math.rad(90 - angle)
  local dx = math.cos(a) * dist
  local dy = math.sin(a) * dist
  return x+dx, y+dy
end

function cctvZone(zone)
  zone = string.gsub(string.upper(zone)," ","")
  if string.len(zone) > 16 then zone = string.sub(zone, 1, 16) end
  return zone
end


function cctvError(txt)
  guiSetText(cctvErrorText, txt)
  guiSetVisible(cctvErrorWindow, true)
  guiBringToFront(cctvErrorWindow)
end

function cctvView()
  if viewCamera then
    flicker = 0 - flicker
    local tx,ty = sw/2, sh-100
    if offsets.interference > sh then offsets.interference = 0 - (87+localC.scansize/5) end
    offsets.interference = offsets.interference + 1 + localC.scansize/100
    --dxDrawRectangle(tx-300, ty, 600, 33, black)
    --dxDrawRectangle(tx-300, ty+42, 600, 33, black)
    dxDrawImage(tx-313, ty+25, 626, 49, "gfx/tcrbg.png", 0, 0, 0, black)  
    if viewCamera == "EDIT" then dxDrawText("EDIT", tx+256, ty+29, sw, sh, tocolor(255, 20, 20, 255), 1.2, "default-bold")
    else 
      if active.modes[active.currentmode] == "nightvision" then 
        dxDrawText("NIGHT", tx+244, ty+29, tx+291, sh, tocolor(25, 255, 25, 255), 1.2, "default-bold", "right")
      elseif active.modes[active.currentmode] == "thermalvision" then 
        dxDrawText("THERMAL", tx+244, ty+29, tx+291, sh, tocolor(255, 25, 25, 255), 1.2, "default-bold", "right")
      else dxDrawText("NORMAL", tx+244, ty+29, tx+291, sh, white, 1.2, "default-bold", "right") end
    end
    dxDrawText("TERMINAL ID: "..localC.terminal, tx-295, ty+29, sw, sh, white, 1.2, "default-bold")
    dxDrawText("ZONE: "..offsets.zone, tx-50, ty+29, sw, sh, white, 1.2, "default-bold") 
    dxDrawText(localC.name, tx-295, ty+44, sw, sh, white, 2, "default-bold")
    if not localC.motor or localC.motor == 1 then dxDrawText("R="..localC.angle, tx-100, ty+44, sw, sh, white, 2, "default-bold")
    else dxDrawText("R="..localC.angle, tx-100, ty+44, sw, sh, gray, 2, "default-bold") end
    --dxDrawText("HGT "..(100-localC.height), tx-160, ty+44, sw, sh, gray, 2, "default-bold")
    if not localC.zoom or localC.zoom == 1 then dxDrawText("F="..localC.fov, tx-11, ty+44, sw, sh, white, 2, "default-bold")
    else dxDrawText("F="..localC.fov, tx-11, ty+44, sw, sh, gray, 2, "default-bold") end
    dxDrawText(getTimeStamp(), tx+190, ty+44, sw, sh, white, 2, "default-bold")
    dxDrawText(getDateStamp(), tx+80, ty+44, sw, sh, white, 2, "default-bold")
    
    if localC.scanlines > 0 then 
      dxDrawImage(0, offsets.interference, sw, 87+localC.scansize/5, "gfx/line.png", 0, 0, 0, tocolor(50+localC.r, 50+localC.g, 50+localC.b, 20+localC.scanlines+(flicker*localC.flicker)))  
      dxDrawImage(0, 0-localC.scansize, sw, sh+localC.scansize, scan, 0, 0, 0, tocolor(50+localC.r, 50+localC.g, 50+localC.b, 50+localC.scanlines+(flicker*localC.flicker)))  
    end  
   
    if viewCamera ~= "EDIT" then 
      if localC.motor == 1 then -- moving with keys if motorized 
        if getKeyState("num_8") then -- up
          localC.height = math.max(localC.height - 1, cctvC[viewList[viewID]].height - 50)
          updateCam()
        elseif getKeyState("num_2") then -- down
          localC.height = math.min(localC.height + 1, cctvC[viewList[viewID]].height + 50)
          updateCam()
        elseif getKeyState("num_4") then -- left
          localC.angle = math.max(localC.angle - 1, cctvC[viewList[viewID]].angle - 50)
          updateCam()
        elseif getKeyState("num_6") then -- right
          localC.angle = math.min(localC.angle + 1, cctvC[viewList[viewID]].angle + 50)
          updateCam()
        end
      end
      
      if localC.zoom == 1 then -- zooming with keys
        if getKeyState("num_7") then -- in
          localC.fov = math.max(localC.fov - 1, 20)
          updateCam()
        elseif getKeyState("num_1") then -- out
          localC.fov = math.min(localC.fov + 1, 120)
          updateCam()
        end 
      end

      drawControls(localC.motor == 1,localC.zoom == 1) 
    end
  end  
end


function drawControls(motor, zoom)
  local x,y = guiGetPosition(cctvControl, false)  
  x, y = math.floor(x), math.floor(y+18)
  for key, pos in pairs(buttons) do
    local mx, my, u, v = unpack(pos)
    local color = getKeyState(key) and buttonColors.pressed or buttonColors.active
    if (key == "num_7" or key == "num_1") and not zoom then color = buttonColors.inactive end
    if (key == "num_2" or key == "num_4" or key == "num_6" or key == "num_8") and not motor then color = buttonColors.inactive end
    if (key == "num_3" or key == "num_9") and not active.switch then color = buttonColors.inactive end
    if key == "num_5" then 
      if #active.modes <= 1 then color = buttonColors.inactive 
      elseif active.modes[active.currentmode] == "nightvision" then v = v + 64
      elseif active.modes[active.currentmode] == "thermalvision" then v = v + 128
      elseif active.modes[active.currentmode] == "thermalvisionplus" then v = v + 192
      end 
    end
    dxDrawImageSection(x+44*mx, y+45*my, 64, 64, u, v, 64, 64, "gfx/buttons.png", 0, 0, 0, color, true)
  end
end
