# Install Check point mobile

$remove= "*Check point*"

. \\FILEPATH\menuItems\uninstaller\uninstaller.ps1 -Wait

# Write-Host "`nStart uninstall"

Write-Host "`nStart install"
Start-Process -FilePath msiexec.exe -ArgumentList @("/i", "\\FILEPATH\menuItems\checkpoint\E80.85_CheckPointVPN.msi", "/passive", "/norestart") -Wait

Write-Host "`nInstall complete"

Start-Sleep -Seconds 5

Exit-PSSession