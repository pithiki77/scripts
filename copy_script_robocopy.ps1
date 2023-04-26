$S = Read-Host -Prompt 'Input Source Directory'
$D = Read-Host -Prompt 'Input Destination Directory'
$logpath = Read-Host -Prompt 'Give me logpath'
robocopy $S $D /e /w:0 /r:0 /COPY:DATSOU /DCOPY:DAT /MT:1 /LOG+:$logpath\Backup.log /tee


<#
Here’s what each switch does:
/e: Copies subdirectories, including empty ones.
/w:5: Specifies the wait time between retries in seconds. The default value is 30 seconds. The value of 5 means that Robocopy will wait for 5 seconds before retrying a failed copy operation.
/r:2: Specifies the number of retries on failed copies. The default value is 1 million retries.
/COPY:DATSOU: Copies data, attributes, timestamps, security, owner information, and auditing information for files and directories.
/DCOPY:DAT: Copies data, attributes, and timestamps for directories only.
/MT: Multithreaded copying with n threads (default n=8).
I hope this helps! Let me know if you have any other questions or if there’s anything else I can help you with.
#>

<#
--------------------------------------------
new script
-----------------------------------
rem set logfolder
set lpath=c:\mybckp

rem set source
set bpath=c:\users\user-pc
set cpath=c:\nikolaidou


rem set userid
set user=user170

rem correct codepage for greek filenames export
chcp 1253

robocopy %bpath%\Documents \\10.65.142.70\PC_Bkps\%user%\Documents /MIR /FFT /R:3 /W:10 /Z /MT:32 /V /NP /LOG+:%lpath%\Backup.log /tee
robocopy %bpath%\Desktop \\10.65.142.70\PC_Bkps\%user%\Desktop /MIR /FFT /R:3 /W:10 /Z /MT:32 /V /NP /LOG+:%lpath%\Backup.log /tee
robocopy %cpath% \\10.65.142.70\PC_Bkps\%user%\Nikolaidou /MIR /FFT /R:3 /W:10 /Z /MT:32 /V /NP /LOG+:%lpath%\Backup.log /tee




REM DATE STAMP AND RENAME LOG FILES TO KEEP AS A RECORD
rem use time0 instead of time
rem time0 replaces spaces in time with leading 0
rem example 9:43 to 09:43 or else robocopy rename fails

set time0=%time: =0%
echo %time0%   
set mydate=%date:~10,4%%date:~7,2%%date:~4,2%%time0:~0,2%%time0:~3,2%
echo %mydate%



ren %lpath%\Backup.log backuplog%mydate%.log
copy %lpath%\backuplog%mydate%.log \\DESTINATION_IP\PC_Bkps\%user%\backuplog%mydate%.log


#>
