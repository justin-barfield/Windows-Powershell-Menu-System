:: Copy GPO settings and xml layout to loaner

del C:\Windows\System32\GroupPolicy\User\* /F /S /Q

xcopy /S /Y y:\finished_batches\layout.xml C:\ProgramData\LoanerBatchFile
xcopy /S /Y n:\* C:\Windows\System32\GroupPolicy\