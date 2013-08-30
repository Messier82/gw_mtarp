local sx,sy = guiGetScreenSize()
local message = ''
local alpha = 0
local timer
local tipAlpha = {}
local tipMsg = ''
tipAlpha['1'] = 0
tipAlpha['2'] = 0

addEvent('showTip',true)
addEventHandler('showTip',root,function(tip)
    tipAlpha['1'] = 255
    tipAlpha['2'] = 150
    tipMsg = tip
end)

addEvent('hideTip',true)
addEventHandler('hideTip',root,function()
    tipAlpha['1'] = 0
    tipAlpha['2'] = 0
end)

addEvent('showErrMsg',true)
addEventHandler('showErrMsg',root,function(msg)
    message = msg
    alpha = 255
    if isTimer(timer) then killTimer(timer) timer = setTimer(hideErr,1500,1) else timer = setTimer(hideErr,1500,1) end
end)

function hideErr()
    alpha = 0
end

addEventHandler('onClientRender',root,function()
    dxDrawText(message,sx/2-dxGetTextWidth(message)/2,(sy-sy*0.15)-20-dxGetFontHeight()/2,'left','top',tocolor(255,0,0,alpha))
    dxDrawRectangle(sx/2-dxGetTextWidth(tipMsg)/2-10,sy-0.15*sy-5,dxGetTextWidth(tipMsg)+20,dxGetFontHeight()+10,tocolor(0,0,0,tipAlpha['2']))
    dxDrawText(tipMsg,sx/2-dxGetTextWidth(tipMsg)/2,sy-0.15*sy,'right','top',tocolor(255,255,255,tipAlpha['1']))
end)


addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),function()
    setDevelopmentMode(true)
end)