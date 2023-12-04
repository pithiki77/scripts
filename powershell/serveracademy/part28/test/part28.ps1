#requires -RunAsAdministrator

import-csv -path .\powershell\serveracademy\part28\test\aliases.csv | New-Alias -verbose

import-csv -path .\powershell\serveracademy\part28\test\bits.csv | Stop-Service -PassThru