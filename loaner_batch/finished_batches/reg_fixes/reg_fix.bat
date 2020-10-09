regedit.exe /S X:\1709\update.reg
regedit.exe /S X:\O365\OfficeUpdateReg_WebPortalInstall.reg
regedit.exe /S X:\User_Config_Batch\SSOFix.reg
regedit.exe /S X:\User_Config_Batch\Add-DNS-Suffix.reg
regedit.exe /S X:\exclamation\NSI.reg

REM :removes network issues
netsh int ip reset