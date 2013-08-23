function startRes()
    local mysqlConfig = xmlLoadFile("config.xml")
        if mysqlConfig~=false then
            local configMysqlNode = xmlFindChild(mysqlConfig,"mysql",0)
            if configMysqlNode then
                local mysqlConfData = xmlNodeGetAttributes(configMysqlNode)
                if mysqlConfData then
                    mysqlH = mysql_connect(mysqlConfData['hostname'],mysqlConfData['username'],mysqlConfData['password'],mysqlConfData['database'])
                    if mysqlH then
                        outputDebugString("Successfully connected to MySQL!")
                    else
                        outputDebugString("ERROR! Code 3: Cannot connect to MySQL!")
                        cancelEvent()
                    end
                else
                    outputDebugString("ERROR! Code 2: Cannot recieve MySQL config data!")
                    cancelEvent()
                end
            end
        else
            outputDebugString("ERROR! Code 1: Cannot open config(config.xml) file!")
            cancelEvent()
        end
     sqliteH = dbConnect('sqlite','server_db.db')
     if not sqliteH then
        outputDebugString('ERROR! Code 13.')
        cancelEvent()
     end
end

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),startRes)