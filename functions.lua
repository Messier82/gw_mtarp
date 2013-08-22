function isLogged(player)
    local serial = getPlayerSerial(player)
    local session = mysql_query(mysqlH,"SELECT * FROM mta_sessions WHERE cd = '"..serial.."'")
    local returnn
    if mysql_num_rows(session)~=0 then
        returnn = true
    else
        returnn = false
    end
    mysql_free_result(session)
    return returnn
end

function getOnlinePlayerByGID(gid)
    local retur = false
    local aliveplayers = getAlivePlayers()
    local deadplayers = getDeadPlayers()
    for aliveKey, aliveValue in ipairs(aliveplayers) do
        local id = getElementData(aliveValue,"gid")
        if tostring(id) == gid then
            retur = aliveValue
            break
        end
    end
    if not retur then
        for deadKey, deadValue in ipairs(deadplayers) do
            local id = getElementData(deadValues,"gid")
            if tostring(id) == gid then
                retur = deadValue
                break
            end
        end
    end
    return retur
end

function ifPlayerHaveFlag(gid,flag)
    local retur = nil
    local playerData = mysql_query(mysqlH,"SELECT * FROM users WHERE gid = '"..tostring(gid).."'")
    if mysql_num_rows(playerData)==1 then
        local data = mysql_fetch_assoc(playerData)
        local getgroup = mysql_query(mysqlH,"SELECT * FROM flags WHERE group_id = '"..data['group'].."' and type='group'")
        local getuser = mysql_query(mysqlH,"SELECT * FROM flags WHERE gid = '"..gid.."' and type='user'")
        if mysql_num_rows(getuser)==1 then
            local userdata = mysql_fetch_assoc(getuser)
            if type(userdata['flags'])=="string" then
                local flags = split(userdata['flags'],' ')
                for _,f in pairs(flags) do
                    if f==flag then
                        retur = true
                        break
                    end
                end
            else
                retur = false
            end
        end
        if not retur then
            if mysql_num_rows(getuser)==1 then
            local groupdata = mysql_fetch_assoc(getgroup)
                if type(groupdata['flags'])=="string" then
                    local flags = split(groupdata['flags'],' ')
                    for _,f in pairs(flags) do
                        if f==flag then
                            retur = true
                            break
                        end
                    end
                else
                    retur = false
                end
            end
        end
        mysql_free_result(getgroup)
        mysql_free_result(getuser)
    end
    mysql_free_result(playerData)
    return retur
end

function ifPlayerHaveImmunity(gid,immunity)
    local retur = nil
    local playerData = mysql_query(mysqlH,"SELECT * FROM users WHERE gid = '"..tostring(gid).."'")
    if mysql_num_rows(playerData)==1 then
        local data = mysql_fetch_assoc(playerData)
        local getgroup = mysql_query(mysqlH,"SELECT * FROM flags WHERE group_id = '"..data['group'].."' and type='group'")
        local getuser = mysql_query(mysqlH,"SELECT * FROM flags WHERE gid = '"..gid.."' and type='user'")
        if mysql_num_rows(getuser)==1 then
            local userdata = mysql_fetch_assoc(getuser)
            if type(userdata['immunity'])=="string" then
                local immunity = split(userdata['immunity'],' ')
                for _,i in pairs(immunity) do
                    if i==immunity then
                        retur = true
                        break
                    end
                end
            else
                retur = false
            end
        end
        if not retur then
        if mysql_num_rows(getgroup)==1 then
        local groupdata = mysql_fetch_assoc(getgroup)
            if type(groupdata['immunity'])=='string' then
            local immunity = split(groupdata['immunity'],' ')
                for _,i in pairs(immunity) do
                    if i==immunity then
                        retur = true
                        break
                    end
                end
            end
            end
        end
        mysql_free_result(getgroup)
        mysql_free_result(getuser)
    end
    mysql_free_result(playerData)
    return retur
end

function getPlayerCharacterData(cid)
    local retur = nil
    local getCharacter = mysql_query(mysqlH,"SELECT * FROM characters WHERE cid = '"..cid.."'")
    if mysql_num_rows(getCharacter)~=0 then
        retur = mysql_fetch_assoc(getCharacter)
    else
        retur = false
    end
    mysql_free_result(getCharacter)
    return retur
end

function getPlayerAccountData(gid)
    local retur
    local getAcc = mysql_query(mysqlH,"SELECT * FROM users WHERE gid = '"..gid.."'")
    if mysql_num_rows(getAcc)~=0 then
        retur = mysql_fetch_assoc(getAcc)
    else
        retur = false
    end
    mysql_free_result(getAcc)
    return retur
end

function getAccountGroupData(gid)
    local retur = nil
    local data = getPlayerAccountData(gid)
    if data then
        local getgroup = mysql_query(mysqlH,"SELECT * FROM flags WHERE group_id = '"..data['group'].."' and type='group'")
        local getuser = mysql_query(mysqlH,"SELECT * FROM flags WHERE gid = '"..gid.."' and type='user'")
        if mysql_num_rows(getuser)==1 then
            retur=mysql_fetch_assoc(getuser)
        end
        if not retur then
            if mysql_num_rows(getgroup)==1 then
                retur=mysql_ferch_assoc(getgroup)
            end
        end
        mysql_free_result(getgroup)
        mysql_free_result(getuser)
    end
    return retur
end

function compareAccLevels(gid1,gid2)
    local retur = nil
    local acc1 = getAccountGroupData(gid1)
    local acc2 = getAccountGroupData(gid2)
    if acc1 and acc2 then
        if acc1['level']<=acc2['level'] then
            retur = true
        else
            retur = false
        end
    end
    return retur
end

function strw_to_table(str)
    local words = {}
    for word in string.gmatch(str,"%w+") do table.insert(words, word) end
    return words
end

function chatFuncCheck(func,msg)
    local check = string.sub(msg,0,string.len(func.." "))
    if check == func.." " then
        return true
    else
        return false
    end
end

function getTsData(timestamp)
    local retur = {}
    local data = getRealTime(timestamp)
    local day = data['monthday']
    local month = data['month']
    local year = data['year']
    local hour = data['hour']
    local minute = data['minute']
    local second = data['second']
    if day<10 then day = "0"..day end
    if month<10 then month = "0"..month end
    if hour<10 then hour = "0"..hour end
    if minute<10 then minute = "0"..minute end
    if second<10 then second = "0"..second end
    retur['day']=day
    retur['month']=month
    retur['year']=year
    retur['hour']=hour
    retur['minute']=minute
    retur['second']=second
    return retur
end

function lastnum(num)
    return tonumber(string.sub(tostring(num),string.len(tostring(num)),string.len(tostring(num))))
end

function getRemTimeFromTS(timestamp,lang)
    local retur
    local times = {}
    local names = {}
    local show
    local div
    if lang=='eng' or lang=='rus' then
    show='seconds'
        if timestamp>=60 then show='minutes' end
        if timestamp>=3600 then show='hours' end
        if timestamp>=86400 then show='days' end
        if timestamp>=2592000 then show='months' end
        if timestamp>=31104000 then show='years' end
        if lang == 'eng' then
            if timestamp==1 then names['seconds']='second' else names['seconds']='seconds' end
            if times['minutes'] and math.floor(timestamp/60)==1 then names['minutes']='minute' else names['minutes']='minutes' end
            if times['hours'] and math.floor(timestamp/3600)==1 then names['hours']='hour' else names['hours']='hours' end
            if times['days'] and math.floor(timestamp/86400)==1 then names['days']='day' else names['days']='days' end
            if times['months'] and math.floor(timestamp/2592000)==1 then names['months']='month' else names['months']='months' end
            if times['years'] and math.floor(timestamp/31104000)==1 then names['years']='year' else names['years']='years' end
            times['seconds']=timestamp..' '..names['seconds']
            if math.floor(timestamp/60)~=0 then times['minutes']=math.floor(timestamp/60)..' '..names['minutes'] end
            if math.floor(timestamp/3600)~=0 then times['hours']=math.floor(timestamp/3600)..' '..names['hours'] end
            if math.floor(timestamp/86400)~=0 then times['days']=math.floor(timestamp/86400)..' '..names['days'] end
            if math.floor(timestamp/2592000)~=0 then times['months']=math.floor(timestamp/2592000)..' '..names['months'] end
            if math.floor(timestamp/31104000)~=0 then times['years']=math.floor(timestamp/31104000)..' '..names['years'] end
        else
            local i
            for i=1,6,1 do
                local merka
                local nazv
                local div
                local divided
                if i==1 then merka='seconds' nazv='секунд' div=nil end
                if i==2 then merka='minutes' nazv='минут' div=60 end
                if i==3 then merka='hours' nazv='час' div=3600 end
                if i==4 then merka='days' nazv='' div=86400 end
                if i==5 then merka='months' nazv='месяц' div=2592000 end
                if i==6 then merka='years' nazv='' div=31104000 end
                if div~=nil then divided=math.floor(timestamp/div) else divided = timestamp end
                local last
                if lastnum(divided)==1 then if i==4 then last='день' elseif i==3 or i==5 then last='' elseif i==6 then last='год' else last='а' end end
                if lastnum(divided)>=2 and lastnum(divided)<=4 then if i==4 then last='дня' elseif i==3 or i==5 then last='а' elseif i==6 then last='года' else last='ы' end end
                if lastnum(divided)>=5 and lastnum(divided)<=9 then if i==4 then last='дней' elseif i==3 or i==5 then last='ов' elseif i==6 then last='лет' else last='' end end
                if lastnum(divided)==0 then if i==4 then last='дней' elseif i==3 or i==5 then last='ов' elseif i==6 then last='лет' else last='' end end
                if divided>=5 and divided<=20 then if i==4 then last='дней' elseif i==3 or i==5 then last='ов' elseif i==6 then last='лет' else last='' end end
                times[merka]=divided..' '..nazv..''..last
                if divided==0 then times[merka]='' end
                if merka==show then break end
            end
        end
        retur = times[show]
    else
        retur = false
    end
    return retur
end

function changeAccountData(gid,row,value)
    local change = mysql_query(mysqlH,'UPDATE users SET '..row..'="'..value..'" WHERE gid="'..gid..'"')
    if change then return true else return false end
end

function changeCharacterData(cid,row,value)
    local change = mysql_query(mysqlH,'UPDATE characters SET '..row..'="'..value..'" WHERE cid="'..cid..'"')
    if change then return true else return false end
end