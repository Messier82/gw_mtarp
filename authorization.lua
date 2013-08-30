function showBanInfo(player,gid)
    local player = getPlayerAccountData(gid)
    local ban = mysql_query(mysqlH,"SELECT * FROM mta_bans WHERE gid = '"..gid.."' and unbanned = '0'")
    outputConsole("/*********************************/",player)
    outputConsole("Bans for "..player['nick'],player)
    outputConsole("/*********************************/",player)
    while true do
        local bandata = mysql_fetch_assoc(ban)
        if not bandata then break end
        local banned
        local bantime = getTsData(bandata['ban_time'])
        local unbantime = getTsData(bandata['unban_time'])
        local banner = getPlayerAccountData(bandata['banner'])
        local bany = bantime['year']+1900
        local unbany = unbantime['year']+1900
        bantime = bantime['day'].."."..bantime['month'].."."..bany..", "..bantime['hour']..":"..bantime['minute']..":"..bantime['second']
        if bandata['unban_time']=="0" then unbantime="Never" else unbantime = unbantime['day'].."."..unbantime['month'].."."..unbany..", "..unbantime['hour']..":"..unbantime['minute']..":"..unbantime['second'] end
        outputConsole("Banned by "..banner['nick']..", banned at "..bantime..", will unbanned at "..unbantime.."; Ban reason: "..bandata['reason'],player)
    end
end

function kickBanned(player)
    kickPlayer(player,"YOU HAVE BEEN BANNED FROM THIS SERVER! CHECK YOUR CONSOLE(~)")
end

function checkPlayerForBan(player,gid)
    local getban = mysql_query(mysqlH,"SELECT * FROM mta_bans WHERE gid = '"..gid.."' and unbanned = '0'")
    if mysql_num_rows(getban)>0 then
        local bandata = mysql_fetch_assoc(getban)
        local time = getRealTime()
        if tonumber(time['timestamp'])>=tonumber(bandata['unban_time']) and bandata['unban_time']~="0" then
            local unbanned = mysql_query(mysqlH,"UPDATE mta_bans SET unbanned='1' WHERE id = '"..bandata['id'].."'")
        else
            showBanInfo(player,gid)
            setTimer(kickBanned,100,1,player)
        end
    end
    mysql_free_result(getban)
end

addEventHandler("onPlayerJoin",getRootElement(),function()
    outputChatBox("#00c0ffЗагрузка. Пожалуйста, подождите...",source,255,255,255,true)
end)

function loginInit()
    if not isLogged(source) then
        triggerClientEvent(source,"showAuthGUI",source)
    else
        local getGID = mysql_query(mysqlH,"SELECT * FROM mta_sessions WHERE  cd = '"..getPlayerSerial(source).."'")
        local gid = mysql_fetch_assoc(getGID)
        local getCharacter = mysql_query(mysqlH,"SELECT * FROM characters WHERE owner_user = '"..gid['gid'].."'")
        local characterData = mysql_fetch_assoc(getCharacter)
        setElementData(source,"gid",gid['gid'],true)
        local acc = getPlayerAccountData(gid['gid'])
        setElementData(source,"character",characterData['cid'],true)
        setElementData(source,"nickname",acc['nick'],true)
        mysql_free_result(getGID)
        mysql_free_result(getCharacter)
        outputChatBox("#00c0ffВы были автоматически авторизированы.",source,255,255,255,true)
        introduce(source,gid['gid'])
        checkPlayerForBan(source,gid['gid'])
    end
end

addEvent("loginInit",true)
addEventHandler("loginInit",getRootElement(),loginInit)

function checkAuthData(login, password, remember)
    if login~="Логин" and login~="" and password~="Пароль" and password~="" then
        local check = mysql_query(mysqlH,"SELECT * FROM users WHERE login = '"..mysql_escape_string(mysqlH,login).."'")
        if mysql_num_rows(check)==1 then
            local passwordD = mysql_fetch_assoc(check)
            if passwordD['pass'] == string.lower(md5(password)) then
                local remem
                if remember then remem = 1 else remem = 0 end
                local session = mysql_query(mysqlH,"INSERT INTO mta_sessions (cd,gid,remembered) VALUES ('"..getPlayerSerial(source).."','"..passwordD['gid'].."','"..remem.."')")
                if session then
                    triggerClientEvent(source,"successAuth",source)
                    local getCharacter = mysql_query(mysqlH,"SELECT * FROM characters WHERE owner_user = '"..passwordD['gid'].."'")
                    local characterData = mysql_fetch_assoc(getCharacter)
                    setElementData(source,"character",characterData['cid'],true)
                    setElementData(source,"gid",passwordD['gid'],true)
                    setElementData(source,"nick",passwordD['nick'],true)
                    checkPlayerForBan(source,passwordD['gid'])
                    introduce(source,passwordD['gid'])
                    mysql_free_result(getCharacter)
                else
                    outputChatBox("#ff0000ERROR! Code 4.",source,255,255,255,true)
                end
            else
                triggerClientEvent(source,"changeAuthLabel",source,"Неверный пароль!",true)
            end
        else
            triggerClientEvent(source,"changeAuthLabel",source,"Такой пользователь не найден!",true)
        end
        mysql_free_result(check)
    else
        triggerClientEvent(source,"changeAuthLabel",source,"Введите свои данные и нажмите 'Вход'",false)
    end 
end

addEvent("checkAuthData",true)
addEventHandler("checkAuthData",getRootElement(),checkAuthData)

function discSession()
    if isLogged(source) then
        local sesQuery = mysql_query(mysqlH,"SELECT * FROM mta_sessions WHERE cd = '"..getPlayerSerial(source).."'")
        local sesData = mysql_fetch_assoc(sesQuery)
        if sesData['remembered']=="0" then
            outputDebugString(tostring(sesData['remembered']))
            local sesRemove = mysql_query(mysqlH,"DELETE FROM mta_sessions WHERE cd = '"..getPlayerSerial(source).."'")
            if not sesRemove then
                outputConsole("ERROR! Code 6.",source)
            end
        end
        mysql_free_result(sesQuery)
    end
end

addEventHandler("onPlayerQuit",getRootElement(),discSession)