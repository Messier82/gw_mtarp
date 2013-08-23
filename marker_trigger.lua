--Markers triggers

addEventHandler('onMarkerHit',root,function(element,dim)
    if dim and getElementType(element)=='player' and not isPedInVehicle(element) then
        local markerID = getElementID(source)
        local findInDB = dbQuery(sqliteH,'SELECT * FROM markers_trigger WHERE element_id="'..markerID..'"')
        local res,num,err = dbPoll(findInDB,5)
        if num==1 then
            for _,row in pairs(res) do
                triggerEvent(row['event']..'Hit',element)
            end
        end
        dbFree(findInDB)
    end
end)

addEventHandler('onMarkerLeave',root,function(element,dim)
    if dim and getElementType(element)=='player' then
        local markerID = getElementID(source)
        local findInDB = dbQuery(sqliteH,'SELECT * FROM markers_trigger WHERE element_id="'..markerID..'"')
        local res,num,err = dbPoll(findInDB,5)
        if num==1 then
            for _,row in pairs(res) do
                triggerEvent(row['event']..'Leave',element)
            end
        end
        dbFree(findInDB)
    end
end)