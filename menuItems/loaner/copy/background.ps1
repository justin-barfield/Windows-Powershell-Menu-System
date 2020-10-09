# Copy background image to loaner

Write-Host "`nStart Loaner Background Copy"

Write-Host "`nCopying image locally"
Copy-Item -Path "$loanerItems\background\1.jpg" -Destination $localFolder

Write-Host "`nImage copy complete"

Start-Sleep -Seconds 5