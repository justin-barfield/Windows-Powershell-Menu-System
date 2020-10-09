function installCheckpoint(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File  $menuItems\checkpoint\install.ps1" -Wait
}

function installConnectedBackup(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File  $menuItems\connectedbackup\install.ps1" -Wait
}

function installMS1903(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\1903\transfer.ps1" -Wait
}

function installMS32Bit(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\ms_office\32-bit\install.ps1" -Wait
}

function installMS64Bit(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\ms_office\64-bit\install.ps1" -Wait
}

function updateMSOffice(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\ms_office\64-bit\install.ps1" -Wait
}

function installFireFox(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\firefox\install.ps1" -Wait
}

function installSmartView(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\smartview\install.ps1" -Wait
}

function installSnagIt(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\snagit\transfer.ps1" -Wait
}
function installTeraData(){   
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\TeraData\transfer.ps1" -Wait
}

function installWebEx() {
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\webex\install.ps1" -Wait
}

function installPowerSettings(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\power_settings\install.ps1" -Wait
}

function installRegFix(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\regfix\install.ps1" -Wait
}

function installOneDrive(){
    Start-Process -FilePath powershell.exe -ArgumentList "-File $menuItems\onedrive\install.ps1" -Wait
}

function Test-Cred {

    # Credit: https://www.powershellbros.com/test-credentials-using-powershell-function/
           
    [CmdletBinding()]
    [OutputType([String])] 
       
    Param ( 
        [Parameter( 
            Mandatory = $false, 
            ValueFromPipeLine = $true, 
            ValueFromPipelineByPropertyName = $true
        )] 
        [Alias( 
            'PSCredential'
        )] 
        [ValidateNotNull()] 
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()] 
        $Script:credentials
    )
    $Domain = $null
    $Root = $null
    $Username = $null
    $Password = $null
      
    If($Script:credentials -eq $null)
    {
        Try
        {
            $Script:credentials = Get-Credential "$env:username" -ErrorAction Stop
        }
        Catch
        {
            $ErrorMsg = $_.Exception.Message
            Write-Warning "Failed to validate credentials: $ErrorMsg "
            Pause
            Break
        }
    }
      
    # Checking module
    Try
    {
        # Split username and password
        $Username = $Script:credentials.username
        $Password = $Script:credentials.GetNetworkCredential().password
  
        # Get Domain
        $Root = "LDAP://" + ([ADSI]'').distinguishedName
        $Domain = New-Object System.DirectoryServices.DirectoryEntry($Root,$UserName,$Password)
    }
    Catch
    {
        $_.Exception.Message
        Continue
    }
  
    If(!$domain)
    {
        Write-Warning "Something went wrong"
    }
    Else
    {
        If ( $null -ne $domain.name )
        {
            return "Authenticated"
        }
        Else
        {
            return "Not authenticated"
        }
    }
}

function IsNumeric { 

    # Credit: https://gallery.technet.microsoft.com/scriptcenter/IsNumeric-c50ecf05
 
    <#    
    .SYNOPSIS    
        Analyse whether input value is numeric or not 
       
    .DESCRIPTION    
        Allows the administrator or programmer to analyse if the value is numeric value or  
        not. 
         
        By default, the return result value will be in 1 or 0. The binary of 1 means on and  
        0 means off is used as a straightforward implementation in electronic circuitry  
        using logic gates. Therefore, I have kept it this way. But this IsNumeric cmdlet  
        will return True or False boolean when user specified to return in boolean value  
        using the -Boolean parameter. 
     
    .PARAMETER Value 
         
        Specify a value 
     
    .PARAMETER Boolean 
         
        Specify to return result value using True or False 
     
    .EXAMPLE 
        Get-ChildItem C:\Windows\Logs | where { $_.GetType().Name -eq "FileInfo" } | Select -ExpandProperty Name | IsNumeric -Verbose 
        DirectX.log 
        VERBOSE: False 
        0 
        IE9_NR_Setup.log 
        VERBOSE: False 
        0 
     
        The default return value is 0 when we attempt to get the files name through the  
        pipeline. You can see the Verbose output stating False when you specified the  
        -Verbose parameter 
     
    .EXAMPLE 
        Get-ChildItem C:\Windows\Logs | where { $_.GetType().Name -eq "FileInfo" } | Select -ExpandProperty Length | IsNumeric -Verbose 
        119155 
        VERBOSE: True 
        1 
        2740 
        VERBOSE: True 
        1 
         
        The default return value is 1 when we attempt to get the files length through the  
        pipeline. You can see the Verbose output stating False when you specified the  
        -Verbose parameter 
             
    .EXAMPLE 
        $IsThisNumbers? = ("1234567890" | IsNumeric -Boolean) ; $IsThisNumbers? 
        True 
         
        The return value is True for the input value 1234567890 because we specified the  
        -Boolean parameter 
         
    .EXAMPLE     
        $IsThisNumbers? = ("ABCDEFGHIJ" | IsNumeric -Boolean) ; $IsThisNumbers? 
        False 
     
        The return value is False for the input value ABCDEFGHIJ because we specified the  
        -Boolean parameter 
     
    .NOTES    
        Author  : Ryen Kia Zhi Tang 
        Date    : 20/07/2012 
        Blog    : ryentang.wordpress.com 
        Version : 1.0 
         
    #> 
     
    [CmdletBinding( 
        # SupportsShouldProcess=$True, 
        ConfirmImpact='High')] 
     
    param ( 
     
    [Parameter( 
        Mandatory=$True, 
        ValueFromPipeline=$True, 
        ValueFromPipelineByPropertyName=$True)] 
         
        $Value, 
         
    [Parameter( 
        Mandatory=$False, 
        ValueFromPipeline=$True, 
        ValueFromPipelineByPropertyName=$True)] 
        [alias('B')] 
        [Switch] $Boolean 
         
    ) 
         
    BEGIN { 
     
        #clear variable 
        $IsNumeric = 0 
     
    } 
     
    PROCESS { 
     
        #verify input value is numeric data type 
        try { 0 + $Value | Out-Null 
        $IsNumeric = 1 }catch{ $IsNumeric = 0 } 
     
        if($IsNumeric){  
            $IsNumeric = 1 
            if($Boolean) { $Isnumeric = $True } 
        }else{  
            $IsNumeric = 0 
            if($Boolean) { $IsNumeric = $False } 
        } 
         
        if($PSBoundParameters['Verbose'] -and $IsNumeric) {  
        Write-Verbose "True" }else{ Write-Verbose "False" } 
         
        
        return $IsNumeric
    } 
     
    END {} 
     
} #end of #function IsNumeric


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

function Get-InstalledAppNames {
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

function trimAppNames() {

    $temp= "C:\temp\software.txt"

    Get-InstalledAppNames | Out-File $temp -Force

    Get-Content $temp | Where-Object {$_.trim() -ne "" } | Where-Object {$_.trim() -ne "DisplayName" } | Where-Object {$_.trim() -ne "-----------" } | ForEach-Object{ $_.Trim()} | ForEach-Object{ "*"+$_+"*" } | Out-File "C:\ProgramData\LBF\sftwr.txt" -Force
    
    Remove-item $temp

}

function initStandardLoaner(){
    [bool]$loopMenu= $true
    while( $loopMenu ){
        Clear-Host
        Write-Host "------------------------------------"
        Write-Host "¦`tATL SSB Loaner Checkout`t¦"
        Write-Host "------------------------------------`n"

        Write-Host "SSB Technician Credenials:`n"
        Get-Credential

        Write-Host "Select the number of days you would like to checkout for:"
        $checkoutDays= Read-Host -Prompt "`t`tDays: "

    }
}

function loanerGpo() {
    Write-Host "`n`t`tStart Init Copy"

    Get-ChildItem -Path "C:\Windows\System32\GroupPolicy\Machine" -Include @("*.ps1", "*.bat", "*.ini") -File -Recurse | ForEach-Object { Remove-Item $_}

    Get-ChildItem -Path "C:\Windows\System32\GroupPolicy\User" -Include @("*.ps1", "*.bat", "*.ini") -File -Recurse | ForEach-Object { Remove-Item $_}

    . "$loanerItems\copy\background.ps1" -Wait
    . "$loanerItems\copy\changelog.ps1" -Wait
    . "$loanerItems\copy\gpo.ps1" -Wait
    . "$loanerItems\copy\gpoScripts.ps1" -Wait
    . "$loanerItems\copy\uninstaller.ps1" -Wait
}

function removeLoanerConfig() {
    Write-Host "`n`t`tStart Remove Loaner Config"

    Get-ChildItem -Path "C:\Windows\System32\GroupPolicy\Machine" -Include @("*.ps1", "*.bat", "*.ini") -File -Recurse | ForEach-Object { Remove-Item $_}
    Get-ChildItem -Path "C:\Windows\System32\GroupPolicy\User" -Include @("*.ps1", "*.bat", "*.ini") -File -Recurse | ForEach-Object { Remove-Item $_}
    
    if( Test-Path "C:\ProgramData\LBF" ) {
        Remove-Item -Path "C:\ProgramData\LBF" -Recurse -Force
    }
    if( Test-Path "C:\ProgramData\LoanerBatchFile" ){
        Remove-Item -Path "C:\ProgramData\LoanerBatchFile" -Recurse -Force
    }
}

function checkAccountStatuses(){
    $searchUsers= @("")

    $searchUsers | ForEach-Object { Get-ADUser $_ -Properties CN, EmployeeID, EmailAddress, GivenName, LastBadPasswordAttempt, LastLogonDate, Manager, PasswordExpired, PasswordLastSet, SamAccountName}

}

function termBackupLocal(){
    $userIds= @()
    $dates= @()
    $badIds= @()
    foreach ($line in $File){
        $dates+= @($line.Split(' ')[0])
        $userIds+= @($line.Split(' ')[1])
    }
    $userIds | ForEach-Object {
        try{
            Get-ADUser $_ -Properties * 
        }
        catch{
            $badIds+= [pscustomobject]@{
                BadID = $_
            }
        }
    
    } | Select-Object CN, EmployeeID, EmailAddress, SamAccountName | Export-Csv C:\temp\termbackupInfo.csv -NoTypeInformation
    $badIds | Export-CSV C:\temp\termbackupBadIds.csv -NoTypeInformation
}

function termBackupMenu(){

}

function termBackupServer() {
    <# 

    Solutions assisted with from here:
    https://stackoverflow.com/questions/60724590/powershell-using-class-with-foreach/60725630#60725630
    
    #>

    [bool]$loopTermMenu= $true
    while( $loopTermMenu ){

        Write-Host "`n`n`t`tStarting Backup Capture`n`n"

        $folderNames= Get-ChildItem -Path "\\FILEPATH\" | Where-Object{ $_.PSIsContainer } | Select-Object Name | Out-String

        $folderNames
        
        $termFolder= Read-Host "`n`nPaste the name of the backup folder"

        Get-ChildItem -Path "\\FILEPATH\$termFolder" | Where-Object{ $_.PSIsContainer } | Select-Object Name | Format-Table -Property * -AutoSize | Out-String -Width 4096 | Out-File C:\temp\foldernames.txt
        
        $items = Import-Csv -Path C:\temp\foldernames.txt -Delimiter '.' -Header Date, TermId, TechId
        
        $badItems = New-Object -TypeName 'Collections.ArrayList'

        foreach ($item in $items){
            try{
                Get-ADUser $item.TermId -Properties * | Select-Object CN, EmployeeID, EmailAddress, SamAccountName | Export-Csv "C:\Users\$env:USERNAME\downloads\$termFolder.csv" -NoTypeInformation -Append
            }
            catch{
                $badItems.Add($item) | Out-Null
            }
        }

        $badItems | Export-Csv -Path "C:\Users\$env:USERNAME\downloads\$termFolder-invalid_ids.csv" -NoTypeInformation

        Write-Host "`n`n`t`Backup Capture Complete`n`n"

    }

}

<# Ideas for improvement
    export split and trimmed data to csv, then import IDs to be used in the Get-ADUser
#>

function testServerConnection(){
    
    Start-Transcript -Path C:\Users\$env:USERNAME\Downloads\VPN_Connection-Test.txt
    
    Enable-WindowsOptionalFeature -online -FeatureName "TelnetClient"

    $server= Read-Host "Enter the server IP address or url"
    
    $ipV4= ( Test-Connection $server | ForEach-Object{ $_.IPV4Address.IPAddressToString } )

    ping $server

    tracert $server

    Get-NetTCPConnection | ForEach-Object{ if( $_.RemoteAddress -eq $ipV4[0] ){
        # Start-Process telnet -ArgumentList $ipv4[0], $_.RemotePort -NoNewWindow -Wait
        Test-NetConnection $server -Port $_.RemotePort
    } }

    Stop-Transcript
}

function incrementFolderName(){

    $increment= for( $i=2; $i -le 30; $i++ ){
        $folderName= "4-$i-2020"
        New-Item -Name $folderName -ItemType Directory
    }
    $increment
}