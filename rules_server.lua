function introduce(player,gid)
    local data = getPlayerAccountData(gid)
    if not data['introduced'] or data['introduced']=='0' then
        local changeIntroduced0 = changeAccountData(gid,'introduced','0')
        if changeIntroduced0 then
            triggerClientEvent(player,'showIntroducing',root)
        end
    end
end

addEvent('introduced',true)
addEventHandler('introduced',root,function()
    local gid = getElementData(source,'gid')
    local intro_change = changeAccountData(gid,'introduced','1')
    if intro_change then
    
    else
        outputChatBox('#ff0000ERROR: Code 7.',source,255,255,255,true)
    end
end)