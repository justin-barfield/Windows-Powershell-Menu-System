$menuItems= "\\FILEPATH\menuItems"
$lbf= "C:\ProgramData\LBF"

. "$menuItems\functions\functions.ps1"
. "$menuItems\loaner\scriptblocks\installs.ps1"

function loanerDays(){
    [bool]$daysLoop= $true
    while( $daysLoop ) {
        Clear-Host

        $customCheckout= Read-Host "`n`t`tSet checkout days (default 7) "

        if( $customCheckout | IsNumeric ){
            Remove-Item -Path "$lbf\chckdys.txt" -Force
            New-Item -Path "$lbf\chckdys.txt" -ItemType File -Force | Add-Content -Value $customCheckout -Force | Set-ItemProperty -Name IsReadOnly -Value $true
            
            # Remove-Item -Path "C:\temp\chckdys.txt" -Force
            # New-Item -Path "C:\temp\chckdys.txt" -ItemType File -Force
            # Add-Content -Path "C:\temp\chckdys.txt" -Value $customCheckout -Force
            # Set-ItemProperty -Path "C:\temp\chckdys.txt" -Name IsReadOnly -Value $true
            $daysLoop= $false
        } else {
            Write-Host -BackgroundColor Red -ForegroundColor White "`nInvalid entry"
            Start-Sleep -Seconds 3
        }

    }

}

function loanerSoftware(){
    # Create software text file if it does not exist
    if( !(Test-Path -Path "$lbf\sftwr.txt") ){
        New-Item -Path "$lbf\sftwr.txt" -ItemType File -Force
    }

    # Start menu for software to install
    [bool]$Script:loopSoftwareMenu= $true
    while( $Script:loopSoftwareMenu ){

        Clear-Host
        Write-Host "`n`t`tSelect necessary software`n"
        Write-Host “`t`t`t1. CheckPoint`n”
        Write-Host “`t`t`t2. Connected Backup`n”
        Write-Host “`t`t`t3. Microsoft 1903 update`n”
        Write-Host “`t`t`t4. Microsoft Office 32-bit`n”
        Write-Host “`t`t`t5. Microsoft Office 64-bit`n”
        Write-Host “`t`t`t6. Update Microsoft Office`n”
        Write-Host “`t`t`t7. Mozilla FireFox`n”
        Write-Host “`t`t`t8. Oracle Smartview 11.2.2.5.810`n”
        Write-Host “`t`t`t9. OneDrive`n”
        Write-Host “`t`t`t10. SnagIt 20.0.0.4460`n”
        Write-Host “`t`t`t11. Teradata 16.20.17`n”
        Write-Host “`t`t`t12. WebEx`n”
        Write-Host “`t`t`t0. Quit And Return To Main Menu`n”
        $customSoftware= Read-Host "`t`tSingle numbers only"

        # Check if number is valid
        if( $customSoftware | IsNumeric ){

            Add-Content "$lbf\sftwr.txt" -Value $customSoftware
            Invoke-Command -ScriptBlock ${function:installSwitch} -ArgumentList $customSoftware
            
        } else {

            Write-Host -BackgroundColor Red -ForegroundColor White "`nInvalid entry"
            Start-Sleep -Seconds 3
            
        }

    }
}

function test-Group(){

    Test-Cred

    $deskside= Get-ADGroupMember -Identity "?" -Credential $Script:credentials
    $Script:authorized= $false

    try{
        $deskside
    }
    catch{
        Write-Host "`nNot authorized for this action..."
        Write-Host $_
    }

    foreach( $i in $deskside ){
        if( $i.name -eq $Script:credentials.UserName ) {

            Write-Host "`nAuthorized`n"
            $Script:authorized=$true
            loanerDays
            loanerSoftware
            
            # Prompt for days for loaner
            # Prompt for software install
            # If promted, add software to list to be uninstalled
            # Script to run in paralel with remv loaner

        }
    }

    if( !($Script:authorized)){
        Write-Host "`nNot authorized for this action..."
        Write-Host $Script:credentials.UserName
    }
}

test-Group
