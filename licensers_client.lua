local sx,sy = guiGetScreenSize()
local tipAlpha = {}
tipAlpha['1'] = 0
tipAlpha['2'] = 0

addEvent('showASEntryTip',true)
addEventHandler('showASEntryTip',root,function()
    tipAlpha['1'] = 255
    tipAlpha['2'] = 150
end)

addEvent('hideASEntryTip',true)
addEventHandler('hideASEntryTip',root,function()
    tipAlpha['1'] = 0
    tipAlpha['2'] = 0
end)

addEventHandler('onClientRender',root,function()
    dxDrawRectangle(sx/2-dxGetTextWidth('Для входа нажмите F')/2-10,sy-0.15*sy-5,dxGetTextWidth('Для входа нажмите F')+20,dxGetFontHeight()+10,tocolor(0,0,0,tipAlpha['2']))
    dxDrawText('Для входа нажмите F',sx/2-dxGetTextWidth('Для входа нажмите F')/2,sy-0.15*sy,'right','top',tocolor(255,255,255,tipAlpha['1']))
end)