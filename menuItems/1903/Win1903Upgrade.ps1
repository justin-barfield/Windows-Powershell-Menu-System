Write-Output "=== Running PowerShell Script to upgrade Windows 10 version 1903 ==="
    
$ISOForW10v1903px64BitlockerEnabled = Mount-DiskImage -imagePath  'C:\FILEPATH\\Microsoft\1903\Windows10x64Professional1903_tw8075-44367en.iso' -PassThru

$ISODriveLetter = ($ISOForW10V1903PX64BitlockerEnabled | Get-Volume).DriveLetter

$parameter = "/bitlocker alwayssuspend /auto upgrade /telemetry disable /dynamicupdate disable"
$cmdLine = $ISODriveLetter+":\"+"setup.exe"

$cmdLine = $cmdLine

Write-Output "Drive letter is: "$ISODriveLetter
Write-Output "Upgrade command line: "$cmdLine
   
Start-Process -filepath $cmdLine -argumentlist $parameter

Write-Output "succeeded=true"
Write-Output "message=Please reboot the machine to finish the upgrade."
    
Write-Output "=== Finished running PowerShell script to upgrade Windows 10 version 1903 ==="

