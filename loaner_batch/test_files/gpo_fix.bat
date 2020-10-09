:: Temp fix to stop Global GPO from overwriting Local GPO

timeout /t 5

:: Copy GPO settings and xml layout to loaner

xcopy /S /Y \\FILEPATH\loaner_batch\finished_batches\layout.xml C:\ProgramData\LoanerBatchFile
xcopy /S /Y \\FILEPATH\loaner_batch\finished_batches\GroupPolicy\* C:\Windows\System32\GroupPolicy\