::Clear credential manager
For /F "tokens=1,2 delims= " %G in ('cmdkey /list') do cmdkey /delete %%H