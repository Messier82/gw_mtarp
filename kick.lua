function checkKick(msg)
    if chatFuncCheck("!kick",msg) then
        local gid = getElementData(source,"gid")
        if ifPlayerHaveFlag(gid,"kick") then
            local id = string.gsub(msg, "!kick ","")
            local without = strw_to_table(id)
            if without[1] ~= nil and tonumber(without[1])~=nil then
                local player = getOnlinePlayerByGID(without[1])
                local reason = string.gsub(id,without[1].." ","")
                if reason==id then reason='No reason' end
                if player then
                    if not ifPlayerHaveImmunity(id,"a") and compareAccLevels(getElementData(source,'character'),getElementData(player,'character')) then
                        local charData = getPlayerCharacterData(getElementData(player,"character"))
                        local kickingData = getPlayerCharacterData(getElementData(source,"character"))
                        outputChatBox("#ff0000Вы кикнули игрока "..charData['name'].." "..charData['surname'].."("..getElementData(player,"nickname")..")",source,255,255,255,true)
                        outputDebugString(charData['name'].." "..charData['surname'].."("..getElementData(player,"nickname")..") kicked by "..kickingData['name'].." "..kickingData['surname'].."("..getElementData(source,"nickname").."). Reason: "..reason)
                        kickPlayer(player,"Kicked by "..kickingData['name'].." "..kickingData['surname'].."("..getElementData(source,"nickname").."): "..reason)
                    else
                        outputChatBox("#ff0000Вы не можете кикнуть этого игрока.",source,255,255,255,true)
                    end
                else
                    outputChatBox("#ff0000Этого игрока не существует или его нет на сервере.",source,255,255,255,true)
                end
            else
                outputChatBox("#ff0000Неверный формат команды: !kick [gID] [reason]",source,255,255,255,true)
            end
        else
            outputChatBox("#ff0000У вас нет прав на использование этой команды.",source,255,255,255,true)
        end
    end
end

addEventHandler("onPlayerChat",getRootElement(),checkKick)