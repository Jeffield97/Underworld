function replaceModel()
txd = engineLoadTXD('87458_Werewolf.txd',1)
engineImportTXD(txd,1)
dff = engineLoadDFF('87458_Werewolf.dff',1)
engineReplaceModel(dff,1)
end
addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()), replaceModel)
