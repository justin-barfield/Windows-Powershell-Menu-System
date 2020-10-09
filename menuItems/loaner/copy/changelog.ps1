# Copy changelog to loaner

Write-Host "`nStart ChangeLog copy"

Write-Host "`nCopying ChangeLog locally"
Copy-Item -Path $loanerItems\ChangeLog.txt -Destination $localFolder

Write-Host "`nChangeLog copy complete"

Start-Sleep -Seconds 5