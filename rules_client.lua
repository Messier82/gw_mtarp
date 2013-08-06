local pageNum = 3
pageAlpha = {}
local sx,sy = guiGetScreenSize()
local curPage = 1
local timers = {}
for i=0,pageNum,1 do
        pageAlpha[tostring(i)]=0
end
local introduce = false
local allowCont = false

addEvent('showIntroducing',true)
addEventHandler('showIntroducing',root,function()
    fadeCamera(false,1)
    introduce = true
    timers['showPage1'] = setTimer(showPage,1000,1,1)
end)

addEventHandler('onClientKey',root,function(but,state)
    if not state and allowCont then
        allowCont = false
        hidePage(curPage) 
        hideContText()
        showPage(curPage+1)
        curPage = curPage+1
    end
end)

function showPage(page)
    addEventHandler('onClientRender',root,function()
        if pageAlpha[tostring(page)]~=255 then
            if pageAlpha[tostring(page)]+15>255 then
                pageAlpha[tostring(page)] = pageAlpha[tostring(page)]+(255-pageAlpha[tostring(page)])
            else
                pageAlpha[tostring(page)] = pageAlpha[tostring(page)]+15 
            end
        end
    end)
    timers['showContinueText'] = setTimer(showContText,4000,1)
end

function showContText()
    addEventHandler('onClientRender',root,function()
        if pageAlpha['0']~=255 then
            if pageAlpha['0']+22>255 then
                pageAlpha['0'] = pageAlpha['0']+(255-pageAlpha['0'])
                allowCont=true
            else
                pageAlpha['0'] = pageAlpha['0']+22
            end
        end
    end)
end

function hidePage(page)
    addEventHandler('onClientRender',root,function()
        if pageAlpha[tostring(page)]~=0 then
            if pageAlpha[tostring(page)]-15<0 then
                pageAlpha[tostring(page)] = pageAlpha[tostring(page)]-pageAlpha[tostring(page)]
            else
                pageAlpha[tostring(page)] = pageAlpha[tostring(page)]-15 
            end
        end
    end)
end

function hideContText()
    addEventHandler('onClientRender',root,function()
        if pageAlpha['0']~=0 then
            if pageAlpha['0']-15<0 then
                pageAlpha['0'] = pageAlpha['0']-pageAlpha['0']
            else
                pageAlpha['0'] = pageAlpha['0']-15
            end
        end
    end)
end


addEventHandler('onClientRender',root, function()
    if introduce then
        dxDrawText('Page 1',sx/2-dxGetTextWidth('Page 1')/2,sy/2-dxGetFontHeight()/2,'left','top',tocolor(255,255,255,pageAlpha['1']))
        dxDrawText('Page 2',sx/2-dxGetTextWidth('Page 2')/2,sy/2-dxGetFontHeight()/2,'left','top',tocolor(255,255,255,pageAlpha['2']))
        dxDrawText('Page 3',sx/2-dxGetTextWidth('Page 3')/2,sy/2-dxGetFontHeight()/2,'left','top',tocolor(255,255,255,pageAlpha['3']))
        dxDrawText('Для продолжения нажмите на любую кнопку',sx/2-dxGetTextWidth('Для продолжения нажмите на любую кнопку')/2,800,'left','top',tocolor(255,255,255,pageAlpha['0']))
    end
    dxDrawText(pageAlpha['0'],10,10)
    dxDrawText(pageAlpha['1'],10,10+dxGetFontHeight())
    dxDrawText(pageAlpha['2'],10,10+dxGetFontHeight()*2)
    dxDrawText(pageAlpha['3'],10,10+dxGetFontHeight()*3)
end)

    