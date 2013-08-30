--Markers triggers

addEventHandler('onResourceStart',getResourceRootElement(getThisResource()),function()
    local getMarkers = dbQuery(sqliteH,'SELECT * FROM markers_trigger')
    local res,num,err = dbPoll(getMarkers,5)
    if num>0 then
        for _,row in pairs(res) do
            local x,y,z = getElementPosition(getElementByID(row['element_id']))
            local scale = getMarkerSize(getElementByID(row['element_id']))
            local shape = createColSphere(x,y,z,scale+0.5)
            if shape then setElementData(shape,'marker',row['element_id']) else outputDebugString('ERROR: Code 14. '..row['element_id']) end
        end
    end
end)

addEventHandler('onColShapeHit',root,function(element,dim)
    if dim and getElementType(element)=='player' and not isPedInVehicle(element) then
        local markerID = getElementData(source,'marker')
        if markerID then
        local findInDB = dbQuery(sqliteH,'SELECT * FROM markers_trigger WHERE element_id="'..markerID..'"')
        local res,num,err = dbPoll(findInDB,5)
        if num==1 then
            for _,row in pairs(res) do
                triggerEvent(row['event']..'Hit',element)
            end
        end
        dbFree(findInDB)
        end
    end
end)

addEventHandler('onColShapeLeave',root,function(element,dim)
    if dim and getElementType(element)=='player' then
        local markerID = getElementData(source,'marker')
        if markerID then
        local findInDB = dbQuery(sqliteH,'SELECT * FROM markers_trigger WHERE element_id="'..markerID..'"')
        local res,num,err = dbPoll(findInDB,5)
        if num==1 then
            for _,row in pairs(res) do
                triggerEvent(row['event']..'Leave',element)
            end
        end
        dbFree(findInDB)
        end
    end
end)