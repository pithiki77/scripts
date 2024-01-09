$testObject = [pscustomobject]@{'foo' = 1; 'bar' = 2}
$testObject | Export-Csv -Path C:\test\TestObject.csv
$testObject

$testObject | Get-Member

Import-Csv -Path C:\test\TestObject.csv

Get-Content -Path C:\test\TestObject.csv