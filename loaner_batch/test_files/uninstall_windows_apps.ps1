# Remove Windows Mail and Calendar
Get-AppxPackage Microsoft.windowscommunicationsapps | Remove-AppxPackage


# Remove Get Office
Get-AppxPackage *officehub* | Remove-AppxPackage

# Remove Skype(consumer)
Get-AppxPackage *skypeapp* | Remove-AppxPackage

# Remove Solitare
Get-AppxPackage *solitairecollection* | Remove-AppxPackage

# Uninstall OneNote
Get-AppxPackage *onenote* | Remove-AppxPackage

#Uninstall Microsoft Store
Get-AppxPackage *windowsstore* | Remove-AppxPackage

pause