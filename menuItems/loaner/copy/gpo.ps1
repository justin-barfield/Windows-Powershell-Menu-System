# Install local GPO settings on computer

Write-Host "`nStart GPO copy"

Write-Host "`nCopying GPO locally"
Copy-Item -Path "$loanerItems\GroupPolicy\*" -Recurse -Destination "C:\Windows\System32\GroupPolicy" -Force

Write-Host "`nGPO copy complete"

Start-Sleep -Seconds 5