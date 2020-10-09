# Copy MS Office uninstall and setup to local then run and install 32-bit Office

$msOfficeFolder= "\\FILEPATH\menuItems\ms_office"

Write-Host "`nStart MS Office 64-bit install"

Write-Host "`nCopy Items"
Copy-Item -Path "$msOfficeFolder\setup.exe" -Destination "C:\temp\" -Force
Copy-Item -Path "$msOfficeFolder\uninstall.xml" -Destination "C:\temp\" -Force
Copy-Item -Path "$msOfficeFolder\64-bit\Setup.X64.en-us_O365ProPlusRetail_009ce7fa-26c2-410a-b331-f1e9ee5ddf0c_TX_PR_b_64_.exe" -Destination "C:\temp" -Force

Write-Host "`nStart Uninstall"
Invoke-Expression ("cmd /c 'C:\temp\setup.exe' /configure 'C:\temp\uninstall.xml'")

Write-Host "`nStart Install"
Start-Process -FilePath "C:\temp\Setup.X64.en-us_O365ProPlusRetail_009ce7fa-26c2-410a-b331-f1e9ee5ddf0c_TX_PR_b_64_.exe" -Wait

Write-Host "`nCleaning up"
Remove-Item -Path "C:\temp\" -Include @("setup*", "uninstall.xml")

Write-Host "`nInstall complete"

Start-Sleep -Seconds 5

Exit