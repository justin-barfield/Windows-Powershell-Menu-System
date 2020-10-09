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

function loaner-days(){

}

function loaner-software(){

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
            
            
            # Prompt for days for loaner
            # Prompt for software install
            # If promted, add software to list to be uninstalled
            # Script to run in paralel with remv loaner

        }<#  else {
            Write-Host "`nNot authorized for this action..."
            Write-Host $Script:credentials.UserName
        } #>
    }

    if( !($Script:authorized)){
        Write-Host "`nNot authorized for this action..."
        Write-Host $Script:credentials.UserName
    }
}

test-Group


# Param(
# [Parameter(Mandatory=$true)][string]$DL,
# [Parameter(Mandatory=$true)][string]$UserName)

# $DLdn = (Get-ADGroup $DL).GroupName
# $UsersGroups = (Get-ADUser $UserName -Properties MemberOf).MemberOf

# ForEach ($Group in $UsersGroups) {
# 	If (Get-ADGroup -Filter {memberOf -RecursiveMatch $DLdn} -SearchBase $Group) {
#         Write-Host "`nmember of"
#         Start-Sleep -Seconds 5 #Script exits with Success (Member already in Group or Nested)
#     }else {
#         Write-Host "NOT member of"
#     }
# 	} #Exit ForEach