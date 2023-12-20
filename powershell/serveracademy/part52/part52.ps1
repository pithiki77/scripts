$date = Get-Date
$content = "This is some cool content $date"
add-content c:\scripts\content.txt "$content"
Exit-PSHostProcess