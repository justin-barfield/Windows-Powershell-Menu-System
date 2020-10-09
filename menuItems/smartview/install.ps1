# Determine MS Office bit version and install the correct Smart View MSI

Write-Host "`nDetermining Microsoft Office Bit Version"

$getBitVersion= Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" | Select-Object Platform

if( $getBitVersion.Platform -eq "x86" ){
    Write-Host "`nInstalling 32-bit Smart View"
    Start-Process -FilePath "\\\FILEPATH\\Oracle Smart View 32-bit for Office.msi" -Wait
} elseif ( $getBitVersion.Platform -eq "x64" ) {
    Write-Host "`nInstalling 64-bit Smart View"
    Start-Process -FilePath "\\FILEPATH\Oracle Smart View 64-bit for Office.msi" -Wait
} else {
    Write-Host "`nError has occurred"
    Write-Host $getBitVersion.Platform
}

Write-Host "`nInstall complete"

Start-Sleep -Seconds 5

Exit-PSSession