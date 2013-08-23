-- License system
addEvent('ASOutEntry1Hit',false)
addEvent('ASOutEntry1Leave',false)
addEventHandler('ASOutEntry1Hit',root,function()
    triggerClientEvent(source,'showTip',source,'Для входа в Автошколу нажмите F')
    bindKey(source,'f','up',enterAS,1,true)
end)

addEventHandler('ASOutEntry1Leave',root,function()
    triggerClientEvent(source,'hideTip',source)
    unbindKey(source,'f','up',enterAS)
end)

addEvent('ASInEntry1Hit',false)
addEvent('ASInEntry1Leave',false)
addEventHandler('ASInEntry1Hit',root,function()
    triggerClientEvent(source,'showTip',source,'Для выхода из Автошколы нажмите F')
    bindKey(source,'f','up',enterAS,1,false)
end)

addEventHandler('ASInEntry1Leave',root,function()
    triggerClientEvent(source,'hideTip',source)
    unbindKey(source,'f','up',enterAS)
end)


addEvent('ASOutEntry2Hit',false)
addEvent('ASOutEntry2Leave',false)
addEventHandler('ASOutEntry2Hit',root,function()
    triggerClientEvent(source,'showTip',source,'Для входа в Автошколу нажмите F')
    bindKey(source,'f','up',enterAS,2,true)
end)

addEventHandler('ASOutEntry2Leave',root,function()
    triggerClientEvent(source,'hideTip',source)
    unbindKey(source,'f','up',enterAS)
end)

addEvent('ASInEntry2Hit',false)
addEvent('ASInEntry2Leave',false)
addEventHandler('ASInEntry2Hit',root,function()
    triggerClientEvent(source,'showTip',source,'Для выхода во двор Автошколы нажмите F')
    bindKey(source,'f','up',enterAS,2,false)
end)

addEventHandler('ASInEntry2Leave',root,function()
    triggerClientEvent(source,'hideTip',source)
    unbindKey(source,'f','up',enterAS)
end)

function enterAS(player,key,state,entry,enter)
    local inout,outin
    if enter then inout = 'out' outin = 'in' else inout = 'in' outin = 'out' end
    local px,py,pz = getElementPosition(player)
    local mx,my,mz = getElementPosition(getElementByID('as_'..inout..'_entry'..entry))
    if getDistanceBetweenPoints3D(px,py,pz,mx,my,mz)<1.1 then
        local inInterior = getElementInterior(getElementByID('as_'..outin..'_entry'..entry))
        local imx,imy,imz = getElementPosition(getElementByID('as_'..outin..'_entry'..entry))
        setElementPosition(player,imx,imy,imz+0.3)
        setElementInterior(player,inInterior)
    else
        triggerClientEvent(player,'showErrMsg',player,'Подойдите ближе!')
    end
end

addEventHandler('onVehicleStartEnter',root,function(player)
    if isKeyBound(player,'f','up',enterAS) then
        cancelEvent()
    end
end)