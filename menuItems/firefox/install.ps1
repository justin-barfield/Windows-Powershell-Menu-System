# Install FireFox
$firefox= "C:\temp\Firefox.exe"

Write-Host "`n`tStart Firefox install"

# Copy local to prevent UNC prompt...
Write-Host "`nCopy to local"
Copy-Item -Path "\\FILEPATH\menuItems\firefox\Firefox.exe" -Destination "C:\temp" -Force

# Start install
Write-Host "`nStart install"

Start-Process $firefox -Wait

Write-Host "`nInstall complete"

# Remove local installer
Write-Host "`nCleaning up"
Remove-Item $firefox

Write-Host "`nComplete"

Start-Sleep -Seconds 5

Exit-PSSession