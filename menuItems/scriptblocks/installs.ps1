function installSwitch($customSoftware){

    switch ($customSoftware){

        1		#	CheckPoint
            {
                Write-Host "`nCheckPoint..." -ForegroundColor Yellow

                installCheckpoint

                Start-Sleep -Seconds 2
            }
        2		#	Connected Backup
            {
                Write-Host "`nConnected Backup..." -ForegroundColor Yellow

                installConnectedBackup

                Start-Sleep -Seconds 2
            }
        3		#	Microsoft 1903 Update
            {
                Write-Host "`nMicrosoft 1903 Update..." -ForegroundColor Yellow

                installMS1903

                Start-Sleep -Seconds 2
                
            }
        4		#	Microsoft Office 32-bit
            {
                Write-Host "`nMicrosoft Office 32-bit..." -ForegroundColor Yellow

                installMS32Bit

                Start-Sleep -Seconds 2
            }
        5		#	Microsoft Office 64-bit
            {
                Write-Host "`nMicrosoft Office 64-bit..." -ForegroundColor Yellow

                installMS64Bit

                Start-Sleep -Seconds 2
            }

        6       #   Update MS Office
            {
                Write-Host "`nUpdate Microsoft Office..." -ForegroundColor Yellow

                updateMSOffice

                Start-Sleep -Seconds 2

            }
        7		#	Mozilla FireFox
            {
                Write-Host "`nMozilla FireFox..." -ForegroundColor Yellow

                installFireFox

                Start-Sleep -Seconds 2
            }
        8		#	OneDrive
            {
                Write-Host "`nOneDrive..." -ForegroundColor Yellow

                installOnedrive

                Start-Sleep -Seconds 2
            }
        9		#	Oracle Smartview 11.2.2.5.810 32-bit
            {
                Write-Host "`nOracle Smartview 11.2.2.5.810..." -ForegroundColor Yellow

                installSmartView

                Start-Sleep -Seconds 2
            }
        10		#	SnagIt 20.0.0.4460
            {
                Write-Host "`nSnagIt 20.0.0.4460..." -ForegroundColor Yellow

                installSnagIt

                Start-Sleep -Seconds 2
            }
        11		#	Teradata 16.20.10
            {
                Write-Host "`nTeradata 16.20.10..." -ForegroundColor Yellow

                installTeraData

                Start-Sleep -Seconds 2
            }
        12
            {
                Write-Host "`nWebEx Productivity Tools & Meetings"

                installWebEx

                Start-Sleep -Seconds 2
            }
        0     #Quit
            {
                RETURN $Script:loopSoftwareMenu= $false
                Start-Sleep -Seconds 2
            }
        default
            {
                Write-Host -BackgroundColor Red -ForegroundColor White "You did not enter a valid sub-menu selection. Please enter a valid selection."
                Start-Sleep -Seconds 3
            }
    }
}