# Generic uninstaller to be called

# Reference in script as . \\FILEPATH\menuItems\uninstaller\uninstaller.ps1 -Wait
# Get app name using Get-Package
# Set $remove to "*appname*" or script will not run

# Credit artvandelay440 https://www.reddit.com/r/PowerShell/comments/7hrpoy/uninstalling_programs/


Write-Host "`nStart Uninstall Process"

function Get-InstalledApps {
    param (
    [Parameter(ValueFromPipeline=$true)]
    [string[]]$ComputerName = $env:COMPUTERNAME,
    [string]$NameRegex = ''
    )
    
    foreach ($comp in $ComputerName) {
    $keys = '','\Wow6432Node'
        foreach ($key in $keys) {
        try {
            $apps = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine',$comp).OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall").GetSubKeyNames()
        } catch {
            continue
        }

            foreach ($app in $apps) {
            $program = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine',$comp).OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall\$app")
            $name = $program.GetValue('DisplayName')
                if ($name -and $name -match $NameRegex) {
                    [pscustomobject]@{
                    ComputerName = $comp
                    DisplayName = $name
                    DisplayVersion = $program.GetValue('DisplayVersion')
                    Publisher = $program.GetValue('Publisher')
                    InstallDate = $program.GetValue('InstallDate')
                    UninstallString = $program.GetValue('UninstallString')
                    Bits = $(if ($key -eq '\Wow6432Node') {'64'} else {'32'})
                    Path = $program.name
                    }
                }
            }
        }
    }
}
    
    $array = Foreach ($r in $remove){
        Get-InstalledApps | Where-Object {$_.DisplayName -like $r } | Select-Object -ExpandProperty UninstallString
    }
    
    ForEach ($a in $array) {
        Write-Host "`nUninstalling $a"
        & "$env:ComSpec" /c $a /quiet
    }
Write-Host "`nUninstalls complete"

Start-Sleep -Seconds 3