# Install Connected Backup

$remove= "*Connected Backup*"

. \\FILEPATH\menuItems\uninstaller\uninstaller.ps1 -Wait

# Write-Host "`nStart uninstall"

Write-Host "`nStart install"
Start-Process -FilePath msiexec.exe -ArgumentList @("/i", "\\FILEPATH\menuItems\connectedbackup\AgentSetup.msi", "/passive", "/norestart") -Wait

Write-Host "`nInstall complete"

Start-Sleep -Seconds 5

Exit-PSSession