local sx,sy = guiGetScreenSize()
local curPage = 1
local pageNum = 3
local alpha = {}
alpha['0']=0
alpha['1']=0
alpha['2']=0
alpha['3']=0
local cont=false

addEvent('showIntroducing',true)
addEventHandler('showIntroducing',root,function()
    showChat(false)
    showPlayerHudComponent('all',false)
    setTimer(showPage,1200,1,1)
end)

addEventHandler('onClientKey',root,function(key,state) 
    if not state and cont and not isDebugViewActive() and not isMainMenuActive() and not isConsoleActive() then
        if curPage<pageNum then
            cont=false
            hidePage(curPage)
            showCont(false)
            curPage=curPage+1
            showPage(curPage)
        else
            hidePage(curPage)
            showCont(false)
            showChat(true)
            showPlayerHudComponent('all',true)
            triggerServerEvent('introduced',getLocalPlayer())
        end
    end
end)

function showPage(page)
    alpha[tostring(page)]=255
    outputConsole(page)
    setTimer(showCont,4000,1,true)
end

function hidePage(page)    
    alpha[tostring(page)]=0
end

function showCont(state)
    if state then alpha['0']=255 cont=true else alpha['0']=0 end
end

--Draw basic elements
addEventHandler('onClientRender',root,function()
    dxDrawText('Page 1',sx/2-dxGetTextWidth('Page 1')/2,sy/2-dxGetFontHeight()/2,'left','top',tocolor(255,255,255,alpha['1']))
    dxDrawText('Page 2',sx/2-dxGetTextWidth('Page 2')/2,sy/2-dxGetFontHeight()/2,'left','top',tocolor(255,255,255,alpha['2']))
    dxDrawText('Page 3',sx/2-dxGetTextWidth('Page 3')/2,sy/2-dxGetFontHeight()/2,'left','top',tocolor(255,255,255,alpha['3']))
    
    dxDrawText('Для продолжения нажмите на любую кнопку',sx/2-dxGetTextWidth('Для продолжения нажмите на любую кнопку')/2,sy-100,'left','top',tocolor(255,255,255,alpha['0']))
end)