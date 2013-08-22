--Spawn player
addEvent('spawnPlayer',false)
addEventHandler('spawnPlayer',root,function() --First, initial spawn stage
    local charData = getPlayerCharacterData(getElementData(source,'gid')) --Get character data for skin
    if charData then
        if charData['skin'] and charData['skin']==''  then --Check for skin availability
            local skinsConfig = xmlLoadFile('config.xml') --Open config file
            if skinsConfig then --Check if file was successfully opened
                local skinsNode = xmlFindChild(skinsConfig,'new_player_skins',0) --Read new player skins child in config
                if skinsNode then --Check if child is successfully readed
                    local skinsData = xmlNodeGetAttributes(skinsNode) --Get node attributes
                    if skinsData then
                        --Get skins id's for gender
                        local skins
                        if charData['gender']=='man' then
                            skins = split(skinsData['male'],' ')
                        elseif charData['gender']=='woman' then
                            skins = split(skinsData['female'],' ')
                        end
                        local skinsNum=0
                        for _,_ in pairs(skins) do skinsNum=skinsNum+1 end --get skins number
                        local randSkin = skins[math.random(1,skinsNum)] --get random skin
                        local setSkin = changeCharacterData(charData['cid'],'skin',randSkin) --Set it to the MySQL
                        if setSkin then
                            spawnStageTwo(source) --Init stage 2 of spawn
                        else
                            outputChatBox('#ff0000ERROR: Code 10.',source,255,255,255,true)
                        end
                    else
                        outputChatBox('#ff0000ERROR: Code 9.',source,255,255,255,true)
                    end
                end
            else
                outputChatBox('#ff0000ERROR: Code 1.',source,255,255,255,true)
            end
        else
            spawnStageTwo(source) --Init stage 2 of spawn
        end
    else
        outputChatBox('#ff0000ERROR: Code 8.',source,255,255,255,true)
    end
end)

function spawnStageTwo(player)
    local charData = getPlayerCharacterData(getElementData(player,'gid')) --Get character data
    if charData then
        -- Get spawn city
        local spawnCity
        if charData['spawn_city']=='1' then
            spawnCity = 'ls'
        elseif charData['spawn_city']=='2' then
            spawnCity = 'sf'
        end
        --Get random number
        local spawnsNum = 4
        local spawnnum = math.random(1,spawnsNum)
        --Get marker position
        local spawnElement = getElementByID(spawnCity..'_spawn'..spawnnum)
        if spawnElement then
            local x,y,z = getElementPosition(spawnElement)
            local z=z+2
            local spawn = spawnPlayer(player,x,y,z) --Spawn player
            if spawn then --Check if player was spawned
                fadeCamera(player,true)
                setElementModel(player,tonumber(charData['skin']))
                setCameraTarget(player,player)
            else
                outputChatBox('#ff0000ERROR: Code 12.',player,255,255,255,true)
            end
        else
            outputChatBox('#ff0000ERROR: Code 11.',player,255,255,255,true)
        end
    else
        outputChatBox('#ff0000ERROR: Code 8.',source,255,255,255,true)
    end
end