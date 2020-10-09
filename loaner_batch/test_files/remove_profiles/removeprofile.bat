REM    This command will delete user profiles unused for 5 days

powershell -Command "Set-ExecutionPolicy unrestricted; C:\ProgramData\LoanerBatchFile\RemoveLocalUserProfile_NoPrompt.ps1 -DeleteUnusedDay 5"