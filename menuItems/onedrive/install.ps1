# Install MS OneDrive for Business for all users
$onedrive= "C:\temp\OneDriveSetup.exe"

Write-Host "`n`tStart OneDrive install"

# Copy local to prevent UNC prompt...
Write-Host "`nCopy to local"
Copy-Item -Path "\\FILEPATH\menuItems\onedrive\OneDriveSetup.exe" -Destination "C:\temp" -Force

# Start install
Write-Host "`nStart install"

$arguments= "/silent /allusers"

Start-Process $onedrive $arguments -Wait

Write-Host "`nInstall complete"

# Remove local installer
Write-Host "`nCleaning up"
Remove-Item $onedrive

Write-Host "`nComplete"

Start-Sleep -Seconds 5

Exit-PSSession