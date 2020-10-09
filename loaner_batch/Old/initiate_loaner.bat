:: Script to setup loaner computers

:: Change Log

:: 2-5-20 - username - 	
::	Added restart switch with message. Added option to abort reboot if necessary.
:: 		Change locations of files within share drive. Adjust file path to hide 
::		background image folder on C. Add description for each process. Move reg
::		placement script below image copy. Add script to uninstall MS Teams. Add
::		process to uninstall default Windows Apps with Powershell. Replace pause
::		with timeout before reboot to ensure everything finishes. Add lines to
::		delete x: connections before and after script.
::
:: 2-6-20 - username - 	
::	Added line to copy dialogue_box.bat to startup. Add line to adjust the batch files.
::		Batch files will now be run via a VBS script to prevent cmd windows from
::		showing while the process is executing. All batch files have been set to
::		copy into LoanerBatchFile in its new location in ProgramData.
::
:: 2-7-20 - username - 
::	Added lines from Butler's user config batch used for normal laptop imaging.
::		Batch file will now install WebEx and FireFox, but is erroring when
::		trying to uninstall Windows Store apps after updates are installed by
::		Security Scan. Script has been added as a secondary batch to initiate
::		on the second login.
::
::	Add GPO for user. Delete existing common startup apps before copying. Adjust Connected
::		Backup description name so it can be uninstalled successfully. Copy all
::		GPO settings to computer. Remove deletion batch from startup because it is
::		now in the GPO settings.
::
:: 2-10-20 - username - 
::	Add line to install the latest MS Office. Latest installer includes MS Teams. Teams
::		uninstall script has been moved below MS Office installer. MS Teams uninstall
::		script created and added to login script for GPO. Connected Backup uninstall
::		script adjusted to better capture Connected.
::
:: 2-11-20 - username - 	
::	Add lines to map shared drives from Matt's folder. Percentage signs added to the MS
::		Teams uninstall script to be compatible with batch files. Change made with the GPO
::		to actually set the scripts to run on log-in and log-out.
::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

net use x: "\\FILEPATH\"
X:\Webex\webexapp.msi
X:\Firefox\Firefox.exe
regedit.exe /S X:\1709\update.reg
regedit.exe /S X:\O365\OfficeUpdateReg_WebPortalInstall.reg
regedit.exe /S X:\User_Config_Batch\SSOFix.reg
regedit.exe /S X:\User_Config_Batch\Add-DNS-Suffix.reg
regedit.exe /S X:\exclamation\NSI.reg

REM :removes network issues
netsh int ip reset

net use x: /delete

net use s: \\FILEPATH\

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Delete pre-existing y:\ connections
net use y: /delete

:: Set shortcut to drive
net use y: "\\FILEPATH\loaner_batch"

:: Create directory for background image
mkdir C:\ProgramData\LoanerBatchFile

:: Delete current common startup apps
del /S /F /Q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\*"

:: Copy background image, delete batch, GPO, and instructions to local folders
xcopy /S /Y y:\background\1.jpg C:\ProgramData\LoanerBatchFile

xcopy /S /Y y:\finished_batches\dialogue_box.ps1 C:\ProgramData\LoanerBatchFile
xcopy /S /Y y:\finished_batches\dialogue_box.bat C:\ProgramData\LoanerBatchFile
xcopy /S /Y y:\finished_batches\dialogue_box.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"

xcopy /S /Y y:\finished_batches\uninstall_windows_apps.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\"

xcopy /S /Y y:\finished_batches\layout.xml C:\ProgramData\LoanerBatchFile
xcopy /S /Y y:\finished_batches\GroupPolicy\* C:\Windows\System32\GroupPolicy\

xcopy /S /Y y:\ChangeLog.txt C:\ProgramData\LoanerBatchFile


:: Install MS Office
y:\app_installers\Setup.X64.en-us_O365ProPlusRetail_009ce7fa-26c2-410a-b331-f1e9ee5ddf0c_TX_PR_b_64_.exe

:: Uninstall MS Teams
::wmic product where "description like '%%Teams%%' " uninstall

:: Uninstall Connected Backup
::wmic product where "description='Connected Backup/PC Agent'" uninstall

:: Place registry file for background
:: regedit.exe /S y:\background\background-policy.reg

:: Make folder hidden
attrib +h "C:\ProgramData\LoanerBatchFile"

::::

REM Installs all Security Updates and does inventory scan
"\FILEPATH\"

::::

:: Delete y:\ connection
net use y: /delete

gpupdate /force

timeout /t 5

shutdown /r /f /t 10 /c "Reboot to initialize background. Verify on startup"

rem continue to abort reboot

pause

shutdown /a