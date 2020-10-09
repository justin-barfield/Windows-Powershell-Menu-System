# Map common network drives

Write-Host "`nStart drive map"

Write-Host "`nRemove existing drives"
Remove-PSDrive -Name * -PSProvider "FileSystem" -Force

Write-Host "`nMap network drived"
New-PSDrive -Name S -PSProvider "FileSystem" -Root "\\FILEPATH\"
New-PSDrive -Name J -PSProvider "FileSystem" -Root "\\FILEPATH\"
New-PSDrive -Name K -PSProvider "FileSystem" -Root "\\FILEPATH\"
New-PSDrive -Name P -PSProvider "FileSystem" -Root "\\FILEPATH\"

Write-Host "`nDrive map complete"