# Copy uninstaller to loaner

Write-Host "`nStart Uninstaller copy"

Write-Host "`nCopying Uninstaller locally"
Copy-Item -Path "$menuItems\uninstaller\Uninstaller.ps1" -Destination $localFolder

Write-Host "`nChangeLog copy complete"

Start-Sleep -Seconds 5