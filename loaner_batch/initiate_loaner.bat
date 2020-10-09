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
::		 Security Scan. Script has been added as a secondary batch to initiate
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
:: 2-12-20 - username -
::  Reconfigure of all scripts. Scripts have been simplified into their own individual batch
::      files. Newly added portion for updater tested and is functioning. WebEx installer
::      has been automated to not need input.
::
:: 2-13-20 - username
::  WebEx uninstall added to script because of error with uninstall of older version using
::      the latest installer. Uninstall placed before installers. Map drives moved into
::      batch file. Batch created to delete all existing drives before mapping any new.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM    This is meant only for loaner computers... Press ctrl + C to cancel this process...
pause

:: Delete pre-existing connections
call "\\FILEPATH\\loaner_batch\finished_batches\drives\del_drives.bat"
call "\\FILEPATH\\loaner_batch\finished_batches\drives\map_drives.bat"

:: Registry fixes
:: call g:\reg_fix.bat

:: Delete existing LoanerBatchFile dir files
del C:\ProgramData\LoanerBatchFile\* /F /S /Q

:: Create directory for background image
mkdir C:\ProgramData\LoanerBatchFile

:: Delete current common startup apps
del /S /F /Q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\*"

:: Copy background image, delete batch, GPO, and instructions to local folders
call a:\background.bat
call a:\changelog.bat
call a:\dialogue.bat
call a:\gpo.bat
REM call a:\windows_apps.bat
call a:\updater.bat

:: WebEx uninstall current version
call h:\webex.bat

:: Installers
call f:\ms_office\ms_office.bat
call f:\firefox\firefox.bat
call f:\webex\webex.bat

:: Uninstalls
call h:\teams.bat
call h:\connected.bat

:: Make folder hidden
attrib +h "C:\ProgramData\LoanerBatchFile"

::::

:: Installs all Security Updates and does inventory scan
"C:\FILEPATH\"

::::

:: Delete connections
call l:\del_init_drives.bat

gpupdate /force

timeout /t 5

shutdown /r /f /t 10 /c "Reboot to initialize background. Verify on startup"

REM continue to abort reboot

pause

shutdown /a