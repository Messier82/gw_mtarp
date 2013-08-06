function checkChat(msg)
    if not chatFuncCheck("!kick",msg) and not chatFuncCheck("!ban",msg) then
        outputChatBox("#cccccc"..getPlayerName(source)..": #ffffff"..msg,getRootElement(),255,255,255,true)
    end
    cancelEvent()
end

addEventHandler("onPlayerChat",getRootElement(),checkChat)