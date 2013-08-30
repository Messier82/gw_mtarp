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
     setMarkerColor(getElementByID('ls_spawn1'),0,0,0,0)
     setMarkerColor(getElementByID('ls_spawn2'),0,0,0,0)
     setMarkerColor(getElementByID('ls_spawn3'),0,0,0,0)
     setMarkerColor(getElementByID('ls_spawn4'),0,0,0,0)
     
     setMarkerColor(getElementByID('sf_spawn1'),0,0,0,0)
     setMarkerColor(getElementByID('sf_spawn2'),0,0,0,0)
     setMarkerColor(getElementByID('sf_spawn3'),0,0,0,0)
     setMarkerColor(getElementByID('sf_spawn4'),0,0,0,0)
     
     setMarkerColor(getElementByID('as_msg_table'),0,0,0,0)
     
     local ldr,ldg,ldb = getMarkerColor(getElementByID('licensers_duty'))
     setMarkerColor(getElementByID('licensers_duty'),ldr,ldg,ldb,0)
     
     moveObject(getElementByID('adm_gate_1'),100,1424,-1837.099,12.5)
     moveObject(getElementByID('z51_gate'),100,97,1926.499,18.79)
     moveObject(getElementByID('rus_gate_1'),100,1520.599,2786.79,9.8)
     moveObject(getElementByID('rus_gate_2'),100,1520.599,2768.19,9.8)
end

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),startRes)