# 20240207
# rename to fileopenmodule.psm1
# place on same folder fileopenmodule.psd1
#------------------------------------------------------
# add to powershell $profile
#Import-Module "C:\test\fileOPENmodule\fileOPENmodule.psm1"
#------------------------------------------------------

function Open-Files {
    param (
        [string]$SourceDirectory
    )
	
	Get-Process *acro* | Stop-Process


    # Check if the source directory exists
    if (Test-Path -Path $SourceDirectory -PathType Container) {
        # Get the first file in the directory
		Write-Host "getting file ." 
        $fileToRename = Get-ChildItem -Path $SourceDirectory -File | Select-Object -First 1
		Write-Host "got file" $fileToRename 
        # Check if a file was found
        if ($fileToRename) {
		$newFilePath = Join-Path -Path $SourceDirectory -ChildPath $fileToRename
			ii $newFilePath
            # Get the directory and base name of the file

				
            
        } else {
            Write-Host "No files found in the specified directory."
        }
    } else {
        Write-Host "Source directory not found at the specified path."
    }
    get-childitem \\192.168.0.3\scan\*.pdf | Measure-Object |ForEach-Object {write-host ""nas remaining ($psitem.count)""}
    get-childitem u:\scan\*.pdf | Measure-Object |ForEach-Object {write-host ""U remaining ($psitem.count)""}
}

Export-ModuleMember -Function 'open-Files'
