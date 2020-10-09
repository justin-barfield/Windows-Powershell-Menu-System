@echo off

::Set color of script
color 0a

::Title
title Loaner data wipe

::All files and folders within the parent folders below will be deleted.
c:
del /S /F/ Q "C:\Users\%%USERNAME%%\AppData\Local\Microsoft\Outlook\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Contacts\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Desktop\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Documents\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Downloads\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Favorites\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Links\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Music\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\OneDrive\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\OneDrive - Six Continents Hotels, Inc\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Pictures\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Saved Games\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Searches\*"
del /S /F/ Q "C:\Users\%%USERNAME%%\Videos\*"
