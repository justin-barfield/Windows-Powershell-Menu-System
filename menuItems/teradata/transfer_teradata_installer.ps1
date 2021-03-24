<# 
    Use to capture data for creation or update of new ODBC driver information:
    Get-OdbcDsn -Name "Teradata Production" -Platform "32-bit" | Select-Object Attribute | ConvertTo-Json -Depth 100
#>

# Variables
$catchError= $ErrorActionPreference = "stop"
$teradataFolder= "\\PATh"+$bitV+"PATH"
$localTemp= "C:\temp"
$getMSBitVersion= (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" -Name Platform).Platform

function createTemp() {
    try {
        Write-Host "`nTemp folder does not exist"
        Write-Host "`nStart temp folder creation"
        New-Item -Path $localTemp -ItemType Directory -Force $catchError
        Write-Host "`nTemp folder created"
    }
    catch {
        Write-Warning "Error encountered with creation of temp folder"
    }
    finally {
        Write-Host "`nTemp folder creation block complete"
    }
}
function copyToLocal() {
    try {
        Write-Host "`nStart copy to local temp"
        Copy-Item -Path $teradataFolder -Recurse -Destination $localTemp -Force $catchError
        Write-Host "`Copy to local temp successful"
    }
    catch {
        Write-Warning "Copy to local failed"
    }
    finally {
        Write-Host "`nCopy to local block complete"
    }
}
function installTeradata64() {
    try {
        Write-Host "`nStart Install"
        Start-Process msiexec.exe -ArgumentList '/I "PATH.msi" ALLUSERS=2 /qb' -Wait $catchError
        Write-Host "`nInstall complete"
    }
    catch {
        Write-Warning "Teradata installation failed"
    }
    finally {
        Write-Host "`nTeradata installation block complete"
    }
}
function installTeradata32() {
    try {
        Write-Host "`nStart Install"
        Start-Process msiexec.exe -ArgumentList '/I "PATH.msi" ALLUSERS=2 /qb' -Wait $catchError
        Write-Host "`nInstall complete"
    }
    catch {
        Write-Warning "Teradata installation failed"
    }
    finally {
        Write-Host "`nTeradata installation block complete"
    }
}
function removePriorOdbc() {
    try {
        Write-Host "`nRemoving existing ODBC connection"
        Remove-OdbcDsn -Name "Teradata Production" -DsnType "System" -Platform "64-bit" $catchError
        Write-Host "`nRomoval complete"
    }
    catch {
        Write-Warning "No prior ODBC connection found"
    }
    finally {
        Write-Host "`nRemove prior ODBC block complete"
    }
}
function configureOdbcConnection() {
    try {
        Write-Host "`nStart ODBC driver configuration"
        Add-OdbcDsn -Name "Teradata Production" -DriverName "Teradata Database ODBC Driver 16.20" -DsnType "System" -Platform "64-bit" -SetPropertyValue @("DBCName=SITE", "CharacterSet=UTF8") $catchError
        Write-Host "`nODBC driver configuration successful"
    }
    catch {
        Write-Warning "Driver configuration failed"
    }
    finally {
        Write-Host "`nConfigure ODBC connection block complete"
    }
}
function cleanup() {
    try {
        Write-Host "`nCleaning up"
        Remove-Item -Path "C:\temp\TDODBC-"+$bitV+"bit" -Force -Recurse $catchError
        Write-Host "`nCleanup complete"
    }
    catch {
        Write-Warning "Error while cleaning up install files"
    }
    finally {
        Write-Host "`nCleanup block complete"
    }
}

if( $getMSBitVersion -eq "x64" ){
    Write-Host "`n64-bit Office recognized"
    Write-Host "`n`nStart TeraData x64 installer copy"
    $bitV="64"

    if( Test-Path -Path $localTemp ){

        Write-Host "`nTemp folder exists"
        copyToLocal
        installTeraData64
        removePriorOdbc
        configureOdbcConnection
        cleanup
        Start-Sleep -Seconds 5
    
    } elseif ( !(Test-Path -Path $localTemp) ) {
    
        createTemp
        copyToLocal
        installTeraData64
        removePriorOdbc
        configureOdbcConnection
        cleanup
        Start-Sleep -Seconds 5
    
    } else {
    
        Write-Host "`nError has occurred"
        Start-Sleep -Seconds 5
    
    }
} elseif ($getMSBitVersion -eq "x32") {
    Write-Host "`n32-bit Office recognized"
    Write-Host "`n`nStart TeraData x32 installer copy"
    $bitV= "32"

    if( Test-Path -Path $localTemp ){

        Write-Host "`nTemp folder exists"
        copyToLocal
        installTeraData32
        removePriorOdbc
        configureOdbcConnection
        cleanup
        Start-Sleep -Seconds 5

    } elseif ( !(Test-Path -Path $localTemp) ) {

        createTemp
        copyToLocal
        installTeraData64
        removePriorOdbc
        configureOdbcConnection
        cleanup
        Start-Sleep -Seconds 5
        
    } else {

        Write-Host "`nError has occurred"
        Start-Sleep -Seconds 5

    }

} else {
    Write-Warning "No instance of Microsoft Office recognized"
}