local worldElements = {}
worldElements['as_out_entry1'] = 'Автошкола'
worldElements['as_out_entry2'] = 'Автошкола'
worldElements['as_in_entry1'] = 'На улицу'
worldElements['as_in_entry2'] = 'На улицу'

addEventHandler('onClientRender',root, function()
    local playerDim = getElementDimension(getLocalPlayer())
    local camerax,cameray,cameraz = getCameraMatrix()
    for k,v in pairs(worldElements) do
        local markerx,markery,markerz = getElementPosition(getElementByID(k))
        if not processLineOfSight(camerax,cameray,cameraz,markerx,markery,markerz,true,false,false) then
            local px,py,pz = getElementPosition(getLocalPlayer())
            local distance = getDistanceBetweenPoints3D(px,py,pz,markerx,markery,markerz)
            if distance<20 then 
                if distance-8<0 then distance=8 end
                local alpha = 255*getEasingValue(1-(1/12*(distance-8)),'Linear')
                local alpha1 = 150*getEasingValue(1-(1/12*(distance-8)),'Linear')
                local sx,sy = getScreenFromWorldPosition(markerx,markery,markerz+1.2)
                dxDrawRectangle(sx-dxGetTextWidth(v)/2-8,sy-dxGetFontHeight()-4,dxGetTextWidth(v)+16,dxGetFontHeight()+8,tocolor(0,0,0,alpha1))
                dxDrawText(v,sx-dxGetTextWidth(v)/2,sy-dxGetFontHeight(),'left','top',tocolor(255,255,255,alpha))
            end
        end
    end
end)