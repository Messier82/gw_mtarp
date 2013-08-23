-- License system
addEvent('ASOutEntry1Hit',false)
addEvent('ASOutEntry1Leave',false)
addEventHandler('ASOutEntry1Hit',root,function()
    triggerClientEvent(source,'showASEntryTip',source)
end)

addEventHandler('ASOutEntry1Leave',root,function()
    triggerClientEvent(source,'hideASEntryTip',source)
end)