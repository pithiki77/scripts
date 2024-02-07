function Rename-Files {
    param (
        [string]$Part1,
        [string]$Part2,
        [string]$Part3,
        [string]$SourceDirectory
    )
	
	Get-Process *acro* | Stop-Process
	
	start-sleep 1
	
    $directorydest = "U:\documents\TIM_AGORAS\$(($part1.tostring()).substring(0,4))\$Part1"

    # Check if the destination directory exists
    if (!(Test-Path -Path $directorydest -PathType Container)) {
        New-Item -Path $directorydest -ItemType Directory
        Write-Host "Directory created at the specified path." $directorydest
    } else {
	Write-Host "Directory already exists at the specified path"
	}
# Check if the source directory exists
if (Test-Path -Path $directorydest -PathType Container) {


# Check if the source directory exists
    if (Test-Path -Path $SourceDirectory -PathType Container) {
        # Get the first file in the directory
		Write-Host "getting file ." 
        $fileToRename = Get-ChildItem -Path $SourceDirectory -File | Select-Object -First 1
		Write-Host "got file" $fileToRename 
        # Check if a file was found
        if ($fileToRename) {
            # Get the directory and base name of the file
            $fileDirectory = Split-Path -Path $fileToRename.FullName -Parent
            $fileBaseName = [System.IO.Path]::GetFileNameWithoutExtension($fileToRename.FullName)
            
            # Generate the new file name with underscores separating the parts
            $newFileName = "$Part1" + "_" + "$Part2" + "_" + "$Part3"  + $fileToRename.Extension

            # Build the new path with the renamed file name
            $newFilePath = Join-Path -Path $directorydest -ChildPath $newFileName

				# Check if a file already exists
				if (!(test-path $newFilePath)) {
					# Rename the file
					Write-Host "item to rename" $fileToRename.FullName
					move-Item $fileToRename.FullName $newFilePath
					Write-Host "File renamed successfully." $newFilePath
					Invoke-Item $newFilePath
					start-sleep 1
					Invoke-Item $directorydest
					
					$part2 | clip
				}else{
				Write-Host "File already exists ." $newFilePath
				}
				
            
        } else {
            Write-Host "No files found in the specified directory."
        }
    } else {
        Write-Host "Source directory not found at the specified path."
    }
} else {
    Write-Host "DESTINATION directory not found at the specified path."
}
get-childitem \\192.168.0.3\scan\*.pdf | Measure-Object |ForEach-Object {write-host ""nas remaining ($psitem.count)""}
get-childitem u:\scan\*.pdf | Measure-Object |ForEach-Object {write-host ""U remaining ($psitem.count)""}
}

Export-ModuleMember -Function 'Rename-Files'