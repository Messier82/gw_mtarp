function checkBan(msg)
    if chatFuncCheck("!ban",msg) then
        local gid = getElementData(source,"gid")
        if ifPlayerHaveFlag(gid,"b") then
            local chat2 = string.gsub(msg,"!ban ","")
            local param = strw_to_table(chat2)
            local id = param[1]
            local time1 = param[2]
            local time2 = param[3]
            local time
            if tonumber(time1)~=nil or time1=="perm" then time1=time1 else time1=false end
            if tonumber(id)~=nil and time1 then
                if time1=="perm" then time = "perm" else time = time1.." "..time2 end
                local reason = string.gsub(chat2,id.." "..time.." ","")
                if time=="perm" or time2=="minutes" or time2=="hours" or time2=="days" or time2=="weeks" or time2=="months" or time2=="years" then
                    local player = getPlayerAccountData(id)
                    if player then
                        if not ifPlayerHaveImmunity(id,"b") then
                            local exsistban = mysql_query(mysqlH,"SELECT * FROM mta_bans WHERE gid = '"..id.."' and unbanned = '0'")
                            if mysql_num_rows(exsistban)==0 then
                                if reason==id.." "..time then reason="" end
                                if time~="perm" then
                                    local mult
                                    if time2=="minutes" then mult = 1 end
                                    if time2=="hours" then mult = 60 end
                                    if time2=="days" then mult = 1440 end
                                    if time2=="weeks" then mult = 10080 end
                                    if time2=="months" then mult = 43200 end
                                    if time2=="years" then mult = 518400 end
                                    time = time1*mult*60
                                end
                                local curtime = getRealTime()
                                local bantime
                                local serial
                                if time=="perm" then bantime = 0 else bantime = curtime['timestamp']+time end
                                local ifonline = getOnlinePlayerByGID(id)
                                if ifonline then serial = getPlayerSerial(ifonline) else serial = "" end
                                local addRecord = mysql_query(mysqlH,"INSERT INTO mta_bans (gid,ban_time,unban_time,unbanned,banner,reason,serial) VALUES ('"..id.."', '"..curtime['timestamp'].."', '"..bantime.."', '0', '"..gid.."', '"..reason.."','"..serial.."')")
                                if addRecord then
                                    outputChatBox("#ff0000Вы забанили игрока "..player['nick']..".",source,255,255,255,true)
                                    outputDebugString(player['nick'].." banned to "..getRemTimeFromTS(time,'eng').." for "..reason.." by "..getElementData(source,"nickname").." | "..time)
                                    if ifonline then
                                        showBanInfo(ifonline,id)
                                        setTimer(kickBanned,100,1,ifonline)
                                    end
                                else
                                outputChatBox("#ff0000ERROR! Code 5."..mysql_error(mysqlH),source,255,255,255,true)
                                end
                            else
                                outputChatBox("#ff0000У этого игрока уже есть действующий бан.",source,255,255,255,true)
                            end
                            mysql_free_result(exsistban)
                        else
                            outputChatBox("#ff0000Вы не можете забанить этого игрока.",source,255,255,255,true)
                        end
                    else
                        outputChatBox("#ff0000Такого игрока не существует!",source,255,255,255,true)
                    end
                else
                    outputChatBox("#ff0000Неверный формат команды: !ban [gID] [time] [minutes/hours/etc] [reason]",source,255,255,255,true)
                end
            else
                outputChatBox("#ff0000Неверный формат команды: !ban [gID] [time] [minutes/hours/etc] [reason]",source,255,255,255,true)
            end
        else
            outputChatBox("#ff0000У вас нет прав на использование этой команды.",source,255,255,255,true) 
        end
    end
end

addEventHandler("onPlayerChat",root,checkBan)