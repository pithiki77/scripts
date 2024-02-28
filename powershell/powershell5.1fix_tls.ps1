[Net.ServicePointManager]::SecurityProtocol

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

 notepad $PSHOME\Profile.ps1

[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12



set-PSRepository -Name psgallery -InstallationPolicy Trusted

install-module psreadline
import-module psreadline
