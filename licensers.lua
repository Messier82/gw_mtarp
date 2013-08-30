-- License system
local asgates = {}
local g2x,g2y,g2z = getElementPosition(getElementByID('as_gate_2'))
local g1x,g1y,g1z = getElementPosition(getElementByID('as_gate_1'))
asgates['x2'] = g2x
asgates['y2'] = g2y
asgates['z2'] = g2z
asgates['x1'] = g1x
asgates['y1'] = g1y
asgates['z1'] = g1z
asgates['gate1'] = false
asgates['gate2'] = false

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
    local inInterior = getElementInterior(getElementByID('as_'..outin..'_entry'..entry))
    local imx,imy,imz = getElementPosition(getElementByID('as_'..outin..'_entry'..entry))
    setElementPosition(player,imx,imy,imz+0.3)
    setElementInterior(player,inInterior)
end

addEventHandler('onVehicleStartEnter',root,function(player)
    if isKeyBound(player,'f','up',enterAS) then
        cancelEvent()
    end
end)

addEventHandler('onResourceStart',getResourceRootElement(getThisResource()),function()
    local x1,y1,z1 = getElementPosition(getElementByID('as_gate_2'))
    local x2,y2,z2 = getElementPosition(getElementByID('as_gate_1'))
    local gateshape1 = createColCuboid(x1,y1,z1-1.3,7,8,4)
    local gateshape2 = createColCuboid(x2-7,y2-8,z2-1.3,7,8,4)
    setElementID(gateshape1,'as_gate_2_shape')
    setElementID(gateshape2,'as_gate_1_shape')
end)

addEventHandler('onColShapeHit',root,function(element,dim)
    if dim and getElementType(element)=='player' then
        if getElementID(source)=='as_gate_2_shape' then
            local bind = bindKey(element,'r','up',openASGate,2)
            if bind then
                triggerClientEvent(element,'showTip',element,'Для открытия ворот нажмите R')
            end
        elseif getElementID(source)=='as_gate_1_shape' then
            local bind = bindKey(element,'r','up',openASGate,1)
            if bind then
                triggerClientEvent(element,'showTip',element,'Для открытия ворот нажмите R')
            end
        end
    end
end)

addEventHandler('onColShapeLeave',root,function(element,dim)
    if dim and getElementType(element)=='player' then
        if getElementID(source)=='as_gate_1_shape' or getElementID(source)=='as_gate_2_shape' then
            triggerClientEvent(element,'hideTip',element)
            unbindKey(element,'r','up',openASGate)
        end
    end
end)

function openASGate(presser,ket,state,gate)
    if not asgates['gate'..gate] then
        local gatee = getElementByID('as_gate_'..gate)
        local y
        if gate==1 then y=90 else y=-90 end
        moveObject(gatee,1000,asgates['x'..gate],asgates['y'..gate],asgates['z'..gate],0,y,0,'InOutQuad')
        asgates['gate'..gate] = true
        setTimer(closeASGate,5000,1,gate)
    end
end

function closeASGate(gate)
    local gatee = getElementByID('as_gate_'..gate)
    if gate==1 then y=-90 else y=90 end
    moveObject(gatee,1000,asgates['x'..gate],asgates['y'..gate],asgates['z'..gate],0,y,0,'InOutQuad')
    setTimer(function() asgates['gate'..gate] = false end,1000,1)
end