# Remove user profiles older than 7 days

$profiles= Get-ChildItem -Path "C:\Users" -Exclude "Administrator", "CSEP_ALS_SVC", "Default", "Public"
$lbf= "C:\ProgramData\LBF\chckdys.txt"

# Test to see if custom checkout days exists. If so, set the number in the file. If not, set default to 7.
if( Test-Path -Path $lbf ) {
    $checkoutDays= Get-Content -Path $lbf
} else {
    $checkoutDays= 7
}

# Iterate through each profile in Users folder
foreach ( $i in $profiles ){
    # Check each user profile to see if the profiles are older than 7 days.

    if ( $i.CreationTime -gt ($checkoutDays) ){
        # If user folder is older than 7 days, delete the user profile.
        Get-CimInstance -ClassName Win32_UserProfile | Where-Object {$_.LocalPath.split("\")[-1] -eq $i.Name} | Remove-CimInstance
    }
}

Remove-Item -Path $lbf -Force

<# 

On logon, check if user ID folder is existing
    if so
        check if checkout time has expired
            if so
                delete user profile from computer
                remove custom software
            
            else
                display checkout days remaining?

    else
        delete other user profile from computer
        register new file with new user ID
        remove custom software
        restart checkout time file

#>

function loanerSoftware(){
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
                DisplayName = $name
                }
            }
        }
    }
}

