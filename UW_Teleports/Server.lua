function setDimension(dimension)
    setElementDimension(client,dimension)
end
addEvent("setDimension",true)
addEventHandler("setDimension", getResourceRootElement(getThisResource()),setDimension)