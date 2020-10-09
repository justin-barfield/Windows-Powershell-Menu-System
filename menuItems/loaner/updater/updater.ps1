Set-ExecutionPolicy Unrestricted -Force -Scope Process

$time= (Get-Date).ToString("dd-MM-yyy_hh_mm_ss")

$serverPath= "\\FILEPATH\loaner_batch\ChangeLog.txt"

$loanerChangeVersion= (Get-Item "C:\ProgramData\LBF\ChangeLog.txt").LastWriteTime
$serverChangeVersion= (Get-Item "\\FILEPATH\loaner_batch\ChangeLog.txt").LastWriteTime

# $loanerUpdaterVersion = (Get-Item "C:\ProgramData\LBF\updater.ps1").LastWriteTime
# $serverUpdaterVersion = (Get-Item "\\FILEPATH\loaner_batch\finished_batches\updater\updater.ps1").LastWriteTime

$serverGpo= "\\FILEPATH\loaner_batch\finished_batches\GroupPolicy\*"
$localGpo= "C:\Windows\System32\GroupPolicy"

function updateLog {

    Add-Content -Path "C:\ProgramData\LBF\updaterLog.txt" -Value "Update checked: $time"
    
}

if ( !(Test-Path "C:\ProgramData\LBF\updater.txt")) {
    New-Item -Path "C:\ProgramData\LBF" -ItemType File -Name updaterLog.txt -Force <# -ErrorAction SilentlyContinue #>
}

if ($loanerChangeVersion -lt $serverChangeVersion) {
    #Start update
    Write-Host "There is an update to the Loaner configuration. This process will begin momentarily. Please be patient while this update is implemented."
    Write-Host "Begin update"
    Write-Host "$loanerChangeVersion | $serverChangeVersion"

    Copy-Item -Path $serverGpo -Recurse -Destination $localGpo -Container -force

    updateLog
    #Final line
    #Update local ChangeLog
    Copy-Item -Path $serverPath -Destination "C:\ProgramData\LBF\" -Force

    Write-Host "Finished change"

} else {
    #Do something else
    Write-Host "No update seen"
    Write-Host "$loanerChangeVersion | $serverChangeVersion"
    updateLog
    
}

# if ($loanerUpdaterVersion -lt $serverUpdaterVersion) {
#     #Update Update script
#     $loanerUpdaterVersion
#     $serverUpdaterVersion

#     Copy-Item -Path "\\FILEPATH\loaner_batch\finished_batches\updater\updater.ps1" -Destination "C:\ProgramData\LoanerBatchFile\" -Force

#     Write-Host("Finished updater")

# } else {
#     #Do something else
# }