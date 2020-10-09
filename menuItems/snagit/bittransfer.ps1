Write-Host "`nStart SnagIt install"

Import-Module BitsTransfer

$serverSnagitFolder= "\\FILEPATH\"
$localSnagitFolder= "C:\FILEPATH\TechSmith\SnagIt"
$localSnagitPath= "C:\FILEPATH\TechSmith\SnagIt\20.0.0.4460"

if(Test-Path -Path "$localSnagitFolder"){
    
    Write-Host "`nC:\FILEPATH\\TechSmith\SnagIt\20.0.0.4460"
    
    Write-Host "`nStart folder creation"
    
    Write-Host "`nStart Copy to local drive"
    Start-BitsTransfer -Source "$serverSnagitFolder" -Destination "$localSnagitFolder"
    
    Write-Host "`nStart Install"
    Push-Location $localSnagitPath
    Start-Process UninstallerTool.exe -ArgumentList "-product Snagit" -Wait
    Start-Process snagit20.0.0.4460.msi -ArgumentList @("/i", "TRANSFORMS=snagit20.0.0.4460.mst TSC_SOFTWARE_KEY=5FZ85-RF94C-C9VMZ-CZFYR-KDE83")
    Pop-Location

    Write-Host "`nInstall complete"

    Start-Sleep -Seconds 5

} elseif ( !(Test-Path -Path $localSnagitFolder) ) {

    Write-Host "`nStart folder creation"
    New-Item -Path $localSnagitFolder -ItemType Directory -Force
    
    Write-Host "`nStart Copy to local drive"
    Start-BitsTransfer -Source "$serverSnagitFolder" -Destination "$localSnagitFolder"

    Write-Host "`nStart Install"
    Push-Location $localSnagitPath
    Start-Process UninstallerTool.exe -ArgumentList "-product Snagit" -Wait
    Start-Process snagit20.0.0.4460.msi -ArgumentList @("/i", "TRANSFORMS=snagit20.0.0.4460.mst TSC_SOFTWARE_KEY=5FZ85-RF94C-C9VMZ-CZFYR-KDE83")
    Pop-Location

    Write-Host "`nInstall complete"

    Start-Sleep -Seconds 5

} else {

    Write-Host "`nError has occurred"

    Start-Sleep -Seconds 5

}

Pause