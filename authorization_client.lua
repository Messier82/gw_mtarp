    local sx, sy = guiGetScreenSize() 
    local authWindow = guiCreateWindow(sx/2-125,sy/2-72,250,144,"Авторизация",false)
    local label = guiCreateLabel(8,20,0,0,"Введите свои данные и нажмите 'Вход'",false,authWindow)
    guiSetSize(label,230, guiLabelGetFontHeight(label),false)
    local login = guiCreateEdit(8,40,234,30,"Логин",false,authWindow)
    local password = guiCreateEdit(8,75,234,30,"Пароль",false,authWindow)
    guiEditSetMasked(password,true)
    local submit = guiCreateButton(171,109,70,30,"Вход!",false,authWindow)
    local remember = guiCreateCheckBox(8,109,100,30,"Запомнить?",false,false,authWindow)
    guiSetVisible(authWindow,false)
    guiWindowSetMovable(authWindow,false)
    guiWindowSetSizable(authWindow,false)
    
function showAuthGUI()
    outputChatBox("#ff9000Приветствуем Вас на сервере Project Pegasus RP!",255,255,255,true)
    outputChatBox("#ff9000Для игры на сервере неоходим аккаунт, который можно завести",255,255,255,true)
    outputChatBox("#ff9000на сайте alah-agbar.com.",255,255,255,true)
    outputChatBox("#ff9000Если у Вас уже есть аккаунт, Вы можете авторизироваться",255,255,255,true)
    outputChatBox("#ff9000в форме у Вас на экране.",255,255,255,true)
    showCursor(true)
    fadeCamera(true,2)
    setPlayerHudComponentVisible("radar",false)
    setPlayerHudComponentVisible("area_name",false)
    setCameraMatrix(-2758.3,1638.3,110.1,-2678.6,1238.1,78.6)
    guiSetVisible(authWindow, true)
end

addEvent("showAuthGUI",true)
addEventHandler("showAuthGUI",getRootElement(),showAuthGUI)

function SendAuthDataToServer()
    local logint = guiGetText(login)
    local passwordt = guiGetText(password)
    triggerServerEvent("checkAuthData",getLocalPlayer(),logint,passwordt,guiCheckBoxGetSelected(remember)) 
end

addEventHandler("onClientGUIClick",submit,SendAuthDataToServer,false)

function changeAuthLabel(text, color)
    local r,g,b
    if color then
        r = 255
        g = 0
        b = 0
    else
        r = 255
        g = 255
        b = 255
    end
    guiSetText(label,text)
    guiLabelSetColor(label,r,g,b)
end

addEvent("changeAuthLabel",true)
addEventHandler("changeAuthLabel",getRootElement(),changeAuthLabel)

function successAuth()
    guiSetVisible(authWindow,false)
    showCursor(false)
    outputChatBox("#00c0ffВы успешно авторизировались!",255,255,255,true)
end

addEvent("successAuth",true)
addEventHandler("successAuth",getRootElement(),successAuth)

function waitForDownload()
    triggerServerEvent("loginInit",getLocalPlayer())
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),waitForDownload)