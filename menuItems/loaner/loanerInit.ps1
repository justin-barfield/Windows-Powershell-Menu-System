$date= (Get-Date).ToString("MM-dd-yy")
$time= (Get-Date).ToString("hh_mm_ss")
$dateTime= "$date-$time"

Start-Transcript -Path "\\FILEPATH\logs\loaner\$env:COMPUTERNAME-$dateTime.txt" -Force
<# 
    This is the main startup for the loaner config.

    Future additions:

        Move dialogue to gpo settings
        
        User/data exclution
        Application install options
        Application uninstall
        Day extention to loaner

#>

Write-Host "`n`t`tStarting loaner initiation"

$menuItems= "\\FILEPATH\menuItems"
$loanerItems= "\\FILEPATH\menuItems\loaner"
$localFolder= "C:\ProgramData\LBF"
$oldLocalFoler= "C:\ProgramData\LoanerBatchFile"

. "$menuItems\functions\functions.ps1"

# Map share drives
Start-Process -FilePath powershell.exe -NoNewWindow -ArgumentList "-File $loanerItems\drives\map.ps1"

# Cleanup old loaner init files
Write-Host "`n`t`tStart Init delete old init folders"
try {
    Remove-Item -Path "$oldLocalFoler" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$localFolder" -Recurse -Force -ErrorAction SilentlyContinue
} catch {
    continue
}

# Create local folder
Write-Host "`n`t`tStart Init local folder"
New-Item -Path $localFolder -ItemType Directory -Force

# Copy settings & files
loanerGPO

# Test GPO item paths


# Uninstalls
Write-Host "`n`t`tStart Init Uninstall"
$remove= @("*Connected Backup*", "*WebEx*")
. $menuItems\uninstaller\uninstaller.ps1 -Wait

# Install apps
Write-Host "`n`t`tStart Init Installs"
. "$menuItems\webex\install.ps1" -Wait
. "$menuItems\ms_office\64-bit\install.ps1" -Wait
. "$menuItems\firefox\install.ps1" -Wait
. "$menuItems\onedrive\install.ps1" -Wait

# Place OneDrive.exe in common startup
Copy-Item -Path "C:\Program Files (x86)\Microsoft OneDrive\OneDrive.exe" -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" -Force

# Hide local files
Write-Host "`n`t`tStart Init hide local folder"
attrib +h $localFolder

# Create initiation date files
Write-Host "`n`t`tStart Init local init date-time file"
New-Item -Path "$localFolder\$dateTime" -ItemType File -Force | Set-ItemProperty -Name IsReadOnly -Value $true -Force

# Capture installed software and write to LBF
trimAppNames

# Log install to local LBF
Stop-Transcript

# Reboot computer
Restart-Computer