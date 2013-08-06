function introduce(player,gid)
    local data = getPlayerAccountData(gid)
    if not data['introduced'] or data['introduced']=='0' then
        local changeIntroduced0 = changeAccountData(gid,'introduced','0')
        if changeIntroduced0 then
            triggerClientEvent(player,'showIntroducing',root)
        end
    end
end