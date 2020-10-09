# Install WebEx Meetings and WebEx Productivity Tools

Write-Host "`nClosing MS Office apps"
Stop-Process -Name EXCEL -Force -ErrorAction SilentlyContinue
Stop-Process -Name OUTLOOK -Force -ErrorAction SilentlyContinue
Stop-Process -Name lync -Force -ErrorAction SilentlyContinue
Stop-Process -Name WINWORD -Force -ErrorAction SilentlyContinue
Stop-Process -Name POWERPNT -Force -ErrorAction SilentlyContinue

$remove= "*WebEx*"
. \\FILEPATH\menuItems\uninstaller\uninstaller.ps1 -Wait

Write-Host "`nStart WebEx Meetings install"
Start-Process -FilePath msiexec.exe -ArgumentList @("/qb", "/i", "\\FILEPATH\menuItems\webex\webexapp.msi"<# , "SITEURL=SITE OI=1 OFFICE=1 IE=1" #>) -Wait

Write-Host "`nStart WebEx Productivity Tools install"
Start-Process -FilePath msiexec.exe -ArgumentList @("/qb", "/i", "\\FILEPATH\menuItems\webex\webexplugin.msi"<# , "SITEURL=SITE OI=1 OFFICE=1 IE=1 SKYPE=1" #>) -Wait

Write-Host "`nInstalls complete"

Start-Sleep -Seconds 5

Exit-PSSession