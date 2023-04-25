$S = Read-Host -Prompt 'Input Source Directory'
$D = Read-Host -Prompt 'Input Destination Directory'
robocopy $S $D /e /w:5 /r:2 /COPY:DATSOU /DCOPY:DAT /MT


<#
Here’s what each switch does:

/e: Copies subdirectories, including empty ones.
/w:5: Specifies the wait time between retries in seconds. The default value is 30 seconds. The value of 5 means that Robocopy will wait for 5 seconds before retrying a failed copy operation.
/r:2: Specifies the number of retries on failed copies. The default value is 1 million retries.
/COPY:DATSOU: Copies data, attributes, timestamps, security, owner information, and auditing information for files and directories.
/DCOPY:DAT: Copies data, attributes, and timestamps for directories only.
/MT: Multithreaded copying with n threads (default n=8)1.
I hope this helps! Let me know if you have any other questions or if there’s anything else I can help you with.
#>
