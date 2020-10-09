Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run & objShell.Run("C:\ProgramData\LoanerBatchFile\UserDataDeletion.bat") & Chr(34), 0
WshShell.Run chr(34) & objShell.Run("C:\ProgramData\LoanerBatchFile\dialogue.bat") & Chr(34), 0
Set WshShell = Nothing