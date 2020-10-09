$loanerVersion= (Get-Item 'C:\ProgramData\LoanerBatchFile\ChangeLog.txt').LastWriteTime
$serverVersion= (Get-Item '\\FILEPATH\loaner_batch\ChangeLog.txt').LastWriteTime

$serverGpo= '\\FILEPATH\loaner_batch\finished_batches\GroupPolicy\'
$localGpo= 'C:\Windows\System32\GroupPolicy\'

if ($serverVersion -lt $loanerVersion) {
    #Start update
    $loanerVersion
    $ServerVersion
    Write-Host('There is an update to the Loaner configuration. This process will begin momentarily. Please be patient while this update is implemented.')
    Copy-Item -Path $serverGpo -Recurse -Destination $localGpo -Container


    #Final line
    #Update local version txt file
    New-Item -Path 'C:\ProgramData\LoanerBatchFile\' -Name 'version' -ItemType 'file' -Value 'Loaner version updater' -Force

    pause

} else {
    #Do something else
}