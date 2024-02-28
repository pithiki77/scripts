[Net.ServicePointManager]::SecurityProtocol

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

 notepad $PSHOME\Profile.ps1

[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12



#================================================
    $ProfileFile = "${PsHome}\Profile.ps1"

if (! (Test-Path $ProfileFile)) {
New-Item -Path $ProfileFile -Type file -Force
}
''                                                                                | Out-File -FilePath $ProfileFile -Encoding ascii -Append
'# It is 2018, SSL3 and TLS 1.0 are no good anymore'                              | Out-File -FilePath $ProfileFile -Encoding ascii -Append
'[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12' | Out-File -FilePath $ProfileFile -Encoding ascii -Append

notepad $ProfileFile

#===================================================

set-PSRepository -Name psgallery -InstallationPolicy Trusted

install-module psreadline
import-module psreadline
