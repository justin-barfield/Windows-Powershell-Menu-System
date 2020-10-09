# Copy scripts from server to loaner GPO

$menuItems= "\\FILEPATH\menuItems"
$loanerItems= "\\FILEPATH\menuItems\loaner"
$localGpo= "C:\Windows\System32\GroupPolicy\User\Scripts"
$localLbf= "C:\ProgramData\LBF"

Write-Host "`nStart GPO script copy"

if( Test-Path -Path "C:\Windows\System32\GroupPolicy\User\CommonScripts" ){

    Write-Host "Removing old GPO init folders"
    Remove-Item -Path "C:\Windows\System32\GroupPolicy\User\CommonScripts" -Recurse -Force
    Start-Sleep -Seconds 3

}

New-Item -Path "$localGpo\CommonScripts" -ItemType Directory -Force

Write-Host "`nRemoving existing files"
Remove-Item -Path "$localGpo\CommonScripts\*" -Recurse -Force
Remove-Item -Path "$localGpo\Logon\*" -Recurse -Force
Remove-Item -Path "$localGpo\Logoff\*" -Recurse -Force
Start-Sleep -Seconds 3

Write-Host "`nCopying scripts locally"

Copy-Item -Path "$loanerItems\copy\gpoScripts.ps1" -Destination $localLbf -Force
Copy-Item -Path "$menuItems\uninstaller\uninstaller.ps1" -Destination $localLbf -Force
Start-Sleep -Seconds 3

Copy-Item -Path "$loanerItems\checkin\checkin.ps1" -Destination "$localGpo\CommonScripts" -Force
Copy-Item -Path "$loanerItems\dataDelete\delete.ps1" -Destination "$localGpo\CommonScripts" -Force
Start-Sleep -Seconds 3

Copy-Item -Path "$loanerItems\dialogue\dialogue_box.ps1" -Destination "$localGpo\Logon" -Force
Copy-Item -Path "$loanerItems\updater\updater.ps1" -Destination "$localGpo\Logon" -Force
Start-Sleep -Seconds 3

Write-Host "Finish copy"

Start-Sleep -Seconds 5