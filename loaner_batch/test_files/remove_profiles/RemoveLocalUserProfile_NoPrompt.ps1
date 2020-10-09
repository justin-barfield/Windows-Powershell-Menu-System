<#
Modified by MaverickSevmont July 18th, 2018 per answer to this request: 
https://gallery.technet.microsoft.com/scriptcenter/How-to-delete-user-d86ffd3c/view/Discussions/0
Written July 11, 2018
jdtherobot
I have the same wuestion as Mike McKay2 and gamer.ajay
Hopefully someone with some more knowledge comes back onto this thread.   
I can verify the script works with windows 10 and deletes the registry entry as well as the profile under the users folder. I just want to find a way to get rid of the prompt for each computer and delete them all at once.  otherwise I may as well select all the entries fron the users folder and babysit that if it's going to take the same amount of time.  
If there's a way to run this remotely to a target computer that would make my life even easier.  
Thanks in advance if someone happens along this post again!
#>

#--------------------------------------------------------------------------------- 
#The sample scripts are not supported under any Microsoft standard support 
#program or service. The sample scripts are provided AS IS without warranty  
#of any kind. Microsoft further disclaims all implied warranties including,  
#without limitation, any implied warranties of merchantability or of fitness for 
#a particular purpose. The entire risk arising out of the use or performance of  
#the sample scripts and documentation remains with you. In no event shall 
#Microsoft, its authors, or anyone else involved in the creation, production, or 
#delivery of the scripts be liable for any damages whatsoever (including, 
#without limitation, damages for loss of business profits, business interruption, 
#loss of business information, or other pecuniary loss) arising out of the use 
#of or inability to use the sample scripts or documentation, even if Microsoft 
#has been advised of the possibility of such damages 
#--------------------------------------------------------------------------------- 

#requires -version 2.0

<#
 	.SYNOPSIS
        The PowerShell script which can be used to list user profile and delete user profile that were specified by user.
    .DESCRIPTION
        The PowerShell script which can be used to list user profile and delete user profile that were specified by user.
    .PARAMETER  ListUnusedDay
		Lists of unused more than a specified number of days in user profile.
	.PARAMETER  ListAll
		Lists all items in user profile.
    .PARAMETER  DeleteUnusedDay
		Delete the user profile that has not been used for more than the number of days as you specified.
    .PARAMETER  ExcludedUsers
		Sepcifies the user that you do not want to remove.
    .EXAMPLE
        C:\PS> C:\Script\RemoveLocalUserProfile.ps1 -ListUnusedDay 10function delprof1
		ComputerName                            LocalPath                               LastUseTime
		------------                            ---------                               -----------
		WS-ANDTEST-01                           C:\Users\Administrator                  11/18/2013 1:37:26 PM
		WS-ANDTEST-01                           C:\Users\User001                        11/22/2013 10:50:35 AM
	.EXAMPLE
        C:\PS> C:\Script\RemoveLocalUserProfile.ps1 -ListAll
		ComputerName                            LocalPath                               LastUseTime
		------------                            ---------                               -----------
		WS-ANDTEST-01                           C:\Users\Administrator                  11/18/2013 1:37:26 PM
		WS-ANDTEST-01                           C:\Users\User001                        11/22/2013 10:50:35 AM
		WS-ANDTEST-01                           C:\Users\User002                        11/22/2012 10:50:35 AM
	.EXAMPLE
        C:\PS> C:\Script\RemoveLocalUserProfile.ps1 -DeleteUnusedDay 60
		ComputerName                  LocalPath                     LastUseTime                   Action
		------------                  ---------                     -----------                   ------
		WS-ANDTEST-01                 C:\Users\User001              11/22/2012 10:50:35 AM        Deleted
		WS-ANDTEST-01                 C:\Users\User002              11/22/2012 10:50:35 AM        Deleted
	.EXAMPLE
        C:\PS> C:\Script\RemoveLocalUserProfile.ps1 -DeleteUnusedDay 60 -ExcludedUsers "User001"
		ComputerName                  LocalPath                     LastUseTime                   Action
		------------                  ---------                     -----------                   ------
		WS-ANDTEST-01                 C:\Users\User002              11/22/2012 10:50:35 AM        Deleted
#>
Param
(
	[Parameter(Mandatory=$true,Position=0,ParameterSetName='ListUnsed', `
	HelpMessage="Lists of unused more than a specified number of days in user profile.")]
	[Alias("lunused")][Int32]$ListUnusedDay,	
	
    [Parameter(Mandatory=$true,Position=0,ParameterSetName='ListAll', `
	HelpMessage="Lists of specified items in user profile.")]
	[Alias("all")][Switch]$ListAll,
	
	[Parameter(Mandatory=$true,Position=0,ParameterSetName='DeleteUnused', `
	HelpMessage="Delete the user profile that has not been used for more than the number of days as you specified.")]
	[Alias("dunused")][Int32]$DeleteUnusedDay,
	
	[Parameter(Mandatory=$false,Position=1,ParameterSetName='DeleteUnused', `
	HelpMessage="Specifies names of the user accounts that should not be removed.")]
	[Alias("excluded")][String[]]$ExcludedUsers = @('Administrator', 'Public', 'CSEP_ALS_SVC')
)

Try
{
	$UserProfileLists = Get-WmiObject -Class Win32_UserProfile | Select-Object @{Expression={$_.__SERVER};Label="ComputerName"},`
	LocalPath,@{Expression={$_.ConvertToDateTime($_.LastUseTime)};Label="LastUseTime"} `
	| Where{$_.LocalPath -notlike "*$env:SystemRoot*"}
}
Catch
{
    Throw "Gathering profile WMI information from $computername failed. Be sure that WMI is functioning on this system."
}
	
If($ListAll)
{
	$UserProfileLists
}

If($ListUnusedDay -gt 0)
{
	$ProfileInfo = $UserProfileLists | Where-Object{$_.LastUseTime -le (Get-Date).AddDays(-$ListUnusedDay)}
	If($ProfileInfo -eq $null)
	{
		Write-Warning -Message "The item not found."
	}
	Else
	{
		$ProfileInfo
	}
}

If($DeleteUnusedDay -gt 0)
{
	$ProfileInfo = Get-WmiObject -Class Win32_UserProfile | `
	Where{$_.ConvertToDateTime($_.LastUseTime) -le (Get-Date).AddDays(-$DeleteUnusedDay) -and $_.LocalPath -notlike "*$env:SystemRoot*" }
	
	If($ExcludedUsers)
	{
		Foreach($ExcludedUser in $ExcludedUsers)
		{
			#Perform the recursion by calling itself.
			$ProfileInfo = $ProfileInfo | Where{$_.LocalPath -notlike "*$ExcludedUser*"}
		}
	}

	If($ProfileInfo -eq $null)
	{
		Write-Warning -Message "The item not found."
	}
	Else
	{
		Foreach($RemoveProfile in $ProfileInfo)
		            {
                        Try{$RemoveProfile.Delete();Write-Host "`nDelete profile '$($RemoveProfile.LocalPath)' successfully."}
						Catch{Write-Host "`nDelete profile failed." -ForegroundColor Red}
					}
	
		}
		$ProfileInfo|Select-Object @{Expression={$_.__SERVER};Label="ComputerName"},LocalPath, `
		@{Expression={$_.ConvertToDateTime($_.LastUseTime)};Label="LastUseTime"},`
		@{Name="Action";Expression={If(Test-Path -Path $_.LocalPath)
						{"Not Deleted"}
						Else
						{"Deleted"}
						}}
	}
