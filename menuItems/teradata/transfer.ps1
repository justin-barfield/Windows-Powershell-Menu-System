Write-Host "`n`nStart TeraData install"

$serverTeradataFolder= "\\FILEPATH\"
$localTeradataFolder= "C:\FILEPATH\Teradata"
$localTeradataPath= "C:\FILEPATH\Teradata\16.20.17"

if( Test-Path -Path $localTeradataFolder ){

    Write-Host "IF"

    Write-Host "`nStart folder creation"
    Copy-Item -Path $serverTeradataFolder -Recurse -Destination $localTeradataFolder -Force
    
    Write-Host "`nStart Install"
    Push-Location $localTeradataPath
    Start-Process -FilePath "$localTeradataPath\INSTALL - TeraData16.20.17.bat" -NoNewWindow -Wait
    Pop-Location

    Write-Host "`nInstall complete"  

    Start-Sleep -Seconds 5

} elseif ( !(Test-Path -Path $localTeradataFolder) ) {

    Write-Host "ELSEIF"

    Write-Host "`nStart folder creation"
    New-Item -Path $localTeradataFolder -ItemType Directory -Force
    
    Write-Host "`nStart Copy to local drive"
    Copy-Item -Path $serverTeradataFolder -Recurse -Destination $localTeradataFolder -Force

    Write-Host "`nStart Install"
    Push-Location $localTeradataPath
    Start-Process "$localTeradataPath\INSTALL - TeraData16.20.17.bat" -NoNewWindow -Wait
    Pop-Location

    Start-Sleep -Seconds 5

} else {

    Write-Host "`nError has occurred"

    Start-Sleep -Seconds 5

}

$paFiles= Read-Host "Install PAfiles? (Y/N)"

switch ( $paFiles ) {
    Y 
    { 
        Write-Host "`nCopy PAfiles to C:"
        Copy-Item -Path "\\FILEPATH\menuItems\teradata\PAfiles" -Recurse -Destination "C:\" -Force

        Write-Host "`nCopy Complete"

        Start-Sleep -Seconds 5
    }
    Default
    {
        Exit-PSSession
    }
}

Exit-PSSession