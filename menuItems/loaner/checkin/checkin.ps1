# This will cause the loaner to write to a CSV file matching its name with the login time and user ID

## Error checking for network path will be needed to prevent stop error
## File creation checking will be needed if else
## Possible addition for future: Show login\logoff action in csv file. Currently not exploring because it appears event viewer would need to be queried


Set-ExecutionPolicy Unrestricted -Force -Scope Process

$date= (Get-Date).ToString("dd-MM-yyy")
$time= (Get-Date).ToString("hh_mm_ss")
$shareLocation= "\\FILEPATH\log"
$compName= "$env:COMPUTERNAME.csv"
$currentUser= $env:USERNAME.ToString()
$localPath= "C:\ProgramData\LoanerBatchFile\$compName"

# Start network path error check

if( Test-Path $shareLocation ){

    # Start local file check
    if( Test-Path "$localPath" ){
        # Append existing local file to network share
        Write-Host "`nStart local file check"
        Get-Item -Path "$localPath" | Select-Object -ExpandProperty FullName | Import-Csv | Export-Csv -Path "$shareLocation\$compName" -NoTypeInformation -Append -NoClobber
        Remove-Item -Path "$localPath" -Force
    }

    if( !(Test-Path "$shareLocation\$compName") ){
        Write-Host "`n Start new network file"
        New-Item -Path "$shareLocation\$compName"
    }

    Write-Host "`nStart network file check"
    # Start file check
    if( Test-Path "$shareLocation\$compName" ){
        Write-Host "`nStart append to network"
        Add-Content -Path "$shareLocation\$compName" -Value "$currentUser, $date, $time"
        # $newLines | Export-Csv -Path "$shareLocation\$compName" -Append -InputObject $newLines -Force -NoClobber
        # $newLines | Select-Object Username, Date, Time | Export-Csv -Path "$shareLocation\$compName" -Append -NoTypeInformation -Force
    } else {
        # Write-Host "`n Start new network file"
        # New-Item -Path "$shareLocation\$compName"
        # Start-Sleep -Milliseconds 500
        # Add-Content -Path "$shareLocation\$compName" -Value "$currentUser, $date, $time" -NoTypeInformation
        # Export-Csv -Path "$shareLocation\$compName" -InputObject $newCsv -Force -NoClobber
        # $newCsv | Select-Object Username, Date, Time, test | Export-Csv -Path "$shareLocation\$compName"
    }

} else {
    Write-Host "`nStart local file"

    # Test if local file exists
    if( !(Test-Path "$localPath") ){
        Write-Host "`n Start new network file"
        # Create CSV file for upload later
        New-Item -Path "$localPath"
    }

    #Create local CSV to be updated to network later if network is unavailable
    if( Test-Path "$localPath" ){
        Write-Host "`nStart append to local"
        # Append information to existing CSV
        # Export-Csv -Path "$localPath" -Append -InputObject $newLines -Force -NoClobber
        Add-Content -Path "$localPath" -Value "$currentUser, $date, $time"
    } else {
        # Write-Host "`nStart new local file"
        # # Create CSV file for upload later
        # Export-Csv -Path "$localPath" -InputObject $newLines -Force
    }

}

Import-Csv -Path "$shareLocation\$compName"