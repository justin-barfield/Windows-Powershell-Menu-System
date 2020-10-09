$env:username
$name= $env:username
$log= (Get-Date).ToString('dd-MM-yyy_hh_mm_ss')
$itemsToDel= (Get-ChildItem C:\Users\$name\ -Include * -Exclude "OneDrive*", "Six Continents*" -File -Recurse)
$itemsToDel | ForEach-Object { 

    New-Item -Path 'C:\temp' -ItemType File -Name $log.txt -Force -ErrorAction SilentlyContinue
    Add-Content -Path C:\temp\$log.txt -Value ($_)
    Remove-Item -Path $_

}

Remove-Item -Path 'C:\Users\$name\AppData\Local\Google\Chrome\User Data\' -Recurse
Remove-Item -Path 'C:\Users\$name\AppData\Local\Mozilla\Firefox\Profiles\' -Recurse
Remove-Item -Path 'C:\Users\$name\AppData\Local\Microsoft\Outlook\' -Recurse

# Second loop needed for hidden items using !Directory+Hidden
# Want to add log file output for deletion