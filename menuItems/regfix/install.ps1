# Install reg fixes from Matt's user config batches

$mattPath= "\\FILEPATH"

regedit.exe /S "$mattpath\1709\update.reg"
regedit.exe /S "$mattpath\O365\OfficeUpdateReg_WebPortalInstall.reg"
regedit.exe /S "$mattpath\User_Config_Batch\SSOFix.reg"
regedit.exe /S "$mattpath\User_Config_Batch\Add-DNS-Suffix.reg"
regedit.exe /S "$mattpath\exclamation\NSI.reg"

netsh int ip reset