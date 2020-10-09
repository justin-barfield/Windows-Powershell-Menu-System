function mainMenu(){
    # This section is used for Loading Main Menu Option 1, .
    
    [bool]$loopMainMenu = $true
    while ($loopMainMenu){
            
        $Host.UI.RawUI.WindowTitle = "Password Syncronization Tool"
        Clear-Host  # Clear the screen.
        Write-Host " -----------------------------------------------------------------------------------"
        Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
        Write-Host " -----------------------------------------------------------------------------------"
        Write-Host "¦`tPlease read through the steps in option 1 before continuing.`t¦"
        Write-Host " -----------------------------------------------------------------------------------`n"
        Write-Host "`t`t+ Main Menu`t`t`n"
        
        Write-Host "`t`t`t1. Steps to follow`n"
        Write-Host "`t`t`t2. MyPassword Site`n"
        Write-Host "`t`t`t3. Sync to Computer`n"
        Write-Host "`t`t`t4. Sync to Encryption`n"

        Write-Host "`t`t`t0. Quit and Return to Main Menu`n"
        $mainItems = Read-Host "`t`tEnter the Option Number desired"

        switch ($mainItems){

            1   {subMenu0}      # Written steps
            2	{subMenu1}
            3   {subMenu2}
            4   {subMenu3}
            0     #Quit
                {
                    $loopMainMenu = $false
                }
            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "`n`tYou did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
}

function subMenu0(){
    # This section is used for Loading Main Menu Option 1, .
    
    [bool]$loopSubMenu0 = $true
    while ($loopSubMenu0){
            
        $Host.UI.RawUI.WindowTitle = "Password Syncronization Tool"
        Clear-Host  # Clear the screen.
        Write-Host " ------------------------------------------------------------------------------"
        Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
        Write-Host " ------------------------------------------------------------------------------`n"
        Write-Host "`t`t+ Instructions to Change & Syncronize Your Password`t`t`n"
        
        Write-Host "`t`t`t1. Continue to change password at MyPassword`n"

        Write-Host "`t`t`t0. Quit and Return to Main Menu`n"
        $sub0 = Read-Host "`t`tEnter the Option Number desired"

        switch ($sub0){

            1   {subMenu1}	    # Continue to change password
                
            0     # Main Menu
                {
                    $loopSubMenu0 = $false
                }
            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "`n`tYou did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
}

function subMenu1(){
    # This section is used for Loading Main Menu Option 1.
    Clear-Host

    Write-Host " ------------------------------------------------------------------------------"
    Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
    Write-Host " ------------------------------------------------------------------------------`n"
    Write-Host (
        "
        `n`tIn this step you will create a new password at SITE.
        `n`tReturn to this screen once the password has been set!
        "
    )
    Pause
    Start-Process -FilePath "chrome.exe" -ArgumentList "SITE"
    
    [bool]$loopSubMenu1 = $true
    while ($loopSubMenu1){
            
        $Host.UI.RawUI.WindowTitle = "Password Syncronization Tool"
        Clear-Host  # Clear the screen.
        Write-Host " ------------------------------------------------------------------------------"
        Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
        Write-Host " ------------------------------------------------------------------------------`n"
        Write-Host "`t`t+ Setting your password at MyPassword`t`t`n"
        
        Write-Host "`t`t`t1. Continue to sync password to computer`n"

        Write-Host "`t`t`t0. Quit and Return to Main Menu`n"
        $sub1 = Read-Host "`t`tEnter the Option Number desired"

        switch ($sub1){

            1	{subMenu2}
            0     #Quit
                {
                    $loopSubMenu1 = $false
                }
            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "`n`tYou did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
}

function subMenu2(){

    loopDomainTest

    [bool]$loopSubMenu2 = $true
    while ($loopSubMenu2){
            
        $Host.UI.RawUI.WindowTitle = "Password Syncronization Tool"
        # Clear-Host  # Clear the screen.
        Write-Host " ------------------------------------------------------------------------------"
        Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
        Write-Host " ------------------------------------------------------------------------------`n"
        Write-Host "`t`t+ Update your Local Computer password`t`t`n"
        
        Write-Host "`t`t`t1. Continue to sync password to Encryption`n"

        Write-Host "`t`t`t0. Quit and Return to Main Menu`n"
        $sub1 = Read-Host "`t`tEnter the Option Number desired"

        switch ($sub1){

            1	{subMenu3}
            0     #Quit
                {
                    $loopSubMenu2= $false
                }
            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "You did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
    
}

function subMenu3(){

    Write-Host " ------------------------------------------------------------------------------"
    Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
    Write-Host " ------------------------------------------------------------------------------`n"

    Write-Host (
        "
        `n`tIn this step you will synchronize your password to the Encryption.
        "
    )
    Pause

    
    [bool]$loopSubMenu3 = $true
    while ($loopSubMenu3){
            
        $Host.UI.RawUI.WindowTitle = "Password Syncronization Tool"
        Clear-Host  # Clear the screen.
        Write-Host " ------------------------------------------------------------------------------"
        Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
        Write-Host " ------------------------------------------------------------------------------`n"
        Write-Host "`t`t+ Setting your password at MyPassword`t`t`n"
        
        Write-Host "`t`t`t1. Email for questions, concerns, and feedback!`n"

        Write-Host "`t`t`t0. Quit and Return to Main Menu`n"
        $sub1 = Read-Host "`t`tEnter the Option Number desired"

        switch ($sub1){

            1	{""}
            0     #Quit
                {
                    $loopSubMenu3 = $false
                }
            default
                {
                    Write-Host -BackgroundColor Red -ForegroundColor White "`n`tYou did not enter a valid sub-menu selection. Please enter a valid selection."
                    Start-Sleep -Seconds 3
                }
        }
    }
}

function testDomain(){
    
    try {
        $null = [System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain()
        $isDomain = $true
    }
    catch {
        $isDomain = $false
    }
    Return $isDomain
}

function testLocal(){
    Get-NetAdapter -Name "Ethernet*" | ForEach-Object {
        if( $_.Status -eq "Up"){
            $true
        }
    }
}

function loopDomainTest() {

    [bool]$loopDomainTest= $true
    while( $loopDomainTest ){

        Clear-Host

        if( testDomain ){

            if( testLocal ){
                Write-Host " ------------------------------------------------------------------------------"
                Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
                Write-Host " ------------------------------------------------------------------------------`n"
                Write-Host (
                    "
                    `n`tIn this step you will Synchronize your new password with Windows.
                    `n`tReturn to this screen once the synchronized!
                    "
                )
                
                    pause
                    Invoke-Expression -Command "rundll32.exe user32.dll,LockWorkStation"
                    $loopDomainTest= $false

            } else {
                Write-Host " ------------------------------------------------------------------------------"
                Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
                Write-Host " ------------------------------------------------------------------------------`n"
                Write-Host 
                "
                    `n`tComputer is not connected to VPN or Ethernet. Please connect to an internal network.
                    `n`tClose this window to cancel.
                    `n`tRetrying connection in 10 seconds...
                "

                Start-Sleep -Seconds 10
            }

        } else {
            Write-Host " ------------------------------------------------------------------------------"
            Write-Host "¦`tCreated by the Atlanta SSB team to assist in updating your password!`t¦"
            Write-Host " ------------------------------------------------------------------------------`n"
            Write-Host
            "
                `n`tComputer cannot establish connection with the domain.
                `n`tPlease connect your computer to the internal Corporate network.
            "
            # pause

            Start-Sleep -Seconds 5
        }
    }
}


mainMenu


# Invoke-Expression -Command "rundll32.exe user32.dll,LockWorkStation"
# $userCred= Get-Credential
# Reset-ComputerMachinePassword -Server "amer.corp.local" -Credential $userCred