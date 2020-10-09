$date= (Get-Date).ToString("MM-dd-yy")
$time= (Get-Date).ToString("hh_mm_ss")
$dateTime= "$date-$time"

Start-Transcript -Path "\\FILEPATH\logs\menu\$env:COMPUTERNAME-$dateTime.txt" -Force

<# 

This script is based off the GetLDLogs_v0.1 script written my. 
This script was downloaded for free and modified for its menu functionality.

#>

Set-ExecutionPolicy Unrestricted

<#-----------------------------------#>
<#--------- Selection menu ----------#>
<#-----------------------------------#> 

# Share drives
$menuItems= "\\FILEPATH\menuItems"
$loanerItems= "\\FILEPATH\menuItems\loaner"

Import-Module BitsTransfer

. "$menuItems\functions\functions.ps1"
. "$menuItems\scriptblocks\installs"
. "$menuItems\scriptblocks\loanerconfig"


Clear-Host
$Host.UI.RawUI.WindowTitle = "ATL SSB Script Runner"

function loadMainMenu(){

    [bool]$loopMainMenu = $true
    while ($loopMainMenu){
        # Clear the screen.
        Clear-Host  
        Write-Host “ ---------------------------------------”
        Write-Host "¦`tATL SSB Script Runner v0.1`t¦"
        Write-Host “ ---------------------------------------`n”
        $runasAlias = [Environment]::UserName
        Write-Host "Running as: $runasAlias`n"
        Write-Host “`t`t+ Main Menu`t`t`n”
        Write-Host “`t`t`t1. New User Config`n”
        Write-Host “`t`t`t2. Loaner Setup`n”
        Write-Host “`t`t`t3. Individual Actions`n”
        Write-Host “`t`t`t0. Quit And Exit`n”
        # Get user's entry.
        $mainMenu = Read-Host “`t`tEnter Sub-Menu Number”

        switch ($mainMenu){

            1{mainMenuOption1} # Calls New User Config
            2{mainMenuOption2} # Calls Loaner Setup
            3{mainMenuOption3} # Calls Individual Actions
            
            0
                {
                    $loopMainMenu = $false
                    Clear-Host
                    Write-Host -BackgroundColor DarkCyan -ForegroundColor Yellow "`t`t`t`t`t"
                    Write-Host -BackgroundColor DarkCyan -ForegroundColor Yellow "`tGoodbye!`t`t`t"
                    Write-Host -BackgroundColor DarkCyan -ForegroundColor Yellow "`t`t`t`t`t"
                    Start-Sleep -Seconds 3
                    $Host.UI.RawUI.WindowTitle = "Windows PowerShell" # Set back to standard.
                    Clear-Host
                    Exit-PSSession
                }

            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "You did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
    return
}

function mainMenuOption1(){
# This section is used for Loading Main Menu Option 1, .

    [bool]$loopConfigMenu = $true
    while ($loopConfigMenu){
            
        $Host.UI.RawUI.WindowTitle = "New User Config"
        Clear-Host  # Clear the screen.
        Write-Host “ ---------------------------------------”
        Write-Host "¦`tATL SSB Script Runner v0.1`t¦"
        Write-Host “ ---------------------------------------`n”
        Write-Host “`t`t+ New User Config`t`t`n”
        Write-Host “`t`t`t1. Standard`n”
        Write-Host “`t`t`t2. Standard + TeraData`n”
        Write-Host “`t`t`t0. Quit And Return To Main Menu`n”
        $userConfig = Read-Host “`t`tEnter the Option Number desired”

        switch ($userConfig){

            1		#	Option1
                {
                    Write-Host "`nStandard..." -ForegroundColor Yellow

                    installMS64Bit
                    installFireFox
                    installWebEx

                    Start-Sleep -Seconds 2
                }
            2		#	Option2
                {
                    Write-Host "`nStandard + Teradata..." -ForegroundColor Yellow

                    installMS32Bit
                    installTeraData
                    installFireFox
                    installWebEx

                    Start-Sleep -Seconds 2
                }
            0     #Quit
                {
                    $loopConfigMenu = $false
                }
            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "You did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
}

function mainMenuOption2(){
# This section is used for Loading Main Menu Option 2, .  
    [bool]$loopInitMenu = $true
    while ($loopInitMenu){

    $Host.UI.RawUI.WindowTitle = "Loaner Setup"
    Clear-Host  # Clear the screen.
    Write-Host “ ---------------------------------------”
    Write-Host "¦`tATL SSB Script Runner v0.1`t¦"
    Write-Host “ ---------------------------------------`n”
    Write-Host “`t`t+ Loaner Setup`t`t`n”
    Write-Host “`t`t`t1.  Initiate Standard Loaner`n”
    Write-Host “`t`t`t2.  Initiate Presentation Loaner`n”
    Write-Host “`t`t`t3.  Update GPO Settings`n”
    Write-Host “`t`t`t0. Quit And Return To Main Menu`n”
    $loanerConfig = Read-Host “`t`tEnter the Option Number desired”

        if( $loanerConfig | IsNumeric ){

            Invoke-Command -ScriptBlock ${function:loanerSwitch} -ArgumentList $loanerConfig
            Start-Sleep -Seconds 2

        } else {

            Write-Host -BackgroundColor Red -ForegroundColor White "`nInvalid entry"
            Start-Sleep -Seconds 3
            
        }
    }
}

function mainMenuOption3(){
# This section is used for Loading Main Menu Option 3, .

    [bool]$Script:loopSoftwareMenu = $true
    while ($Script:loopSoftwareMenu){
            
        $Host.UI.RawUI.WindowTitle = "Individual Installers"
        Clear-Host  # Clear the screen.
        Write-Host “ ---------------------------------------”
        Write-Host "¦`tATL SSB Script Runner v0.1`t¦"
        Write-Host “ ---------------------------------------`n”
        Write-Host “`t`t+ Individual Actions`t`t`n”
        Write-Host “`t`t`t1. CheckPoint`n”
        Write-Host “`t`t`t2. Connected Backup`n”
        Write-Host “`t`t`t3. Microsoft 1903 update`n”
        Write-Host “`t`t`t4. Microsoft Office 32-bit`n”
        Write-Host “`t`t`t5. Microsoft Office 64-bit`n”
        Write-Host “`t`t`t6. Update Microsoft Office`n”
        Write-Host “`t`t`t7. Mozilla FireFox`n”
        Write-Host “`t`t`t8. OneDrive`n”
        Write-Host “`t`t`t9. Oracle Smartview 11.2.2.5.810`n”
        Write-Host “`t`t`t10. SnagIt 20.0.0.4460`n”
        Write-Host “`t`t`t11. Teradata 16.20.17`n”
        Write-Host “`t`t`t12. WebEx`n”
        Write-Host “`t`t`t0. Quit And Return To Main Menu`n”
        $customSoftware= Read-Host "`t`tSingle numbers only"

        # Check if number is valid
        if( $customSoftware | IsNumeric ){

            Invoke-Command -ScriptBlock ${function:installSwitch} -ArgumentList $customSoftware
            Start-Sleep -Seconds 2

        } else {

            Write-Host -BackgroundColor Red -ForegroundColor White "`nInvalid entry"
            Start-Sleep -Seconds 3
            
        }
    }
}

#Start main menu
loadMainMenu

if ($clearHost) {Clear-Host}
if ($exitSession) {Exit-PSSession};