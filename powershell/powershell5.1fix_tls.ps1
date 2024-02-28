[Net.ServicePointManager]::SecurityProtocol

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

 notepad $PSHOME\Profile.ps1

[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12



#================================================

<#    
$ProfileFile = "${PsHome}\Profile.ps1"

if (! (Test-Path $ProfileFile)) {
New-Item -Path $ProfileFile -Type file -Force
}
''                                                                                | Out-File -FilePath $ProfileFile -Encoding ascii -Append
'# It is 2018, SSL3 and TLS 1.0 are no good anymore'                              | Out-File -FilePath $ProfileFile -Encoding ascii -Append
'[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12' | Out-File -FilePath $ProfileFile -Encoding ascii -Append

notepad $ProfileFile
#>



#===================================================

<#
Having taken many steps to overcome the similar problem, I just wanted to document the process in a more clear way. Here are the steps to overcome problems of NuGet and Docker installation in Windows Server (tested in 2016):

Make sure that Powershell version is 5.1 or higher: Get-Host | Select-Object Version

Update SSL/TLS versions supported by the server
x64: Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

x32: Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

Restart the Powershell and check whether the desired effect is achieved: [Net.ServicePointManager]::SecurityProtocol
(You should now see semeting like this:) Tls, Tls11, Tls12, etc.

Install NuGet: Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Install Docker: Install-Module -Name DockerMsftProvider -Force Install-Package -Name docker -ProviderName DockerMsftProvider -Force
#>

#======================================================================================================

set-PSRepository -Name psgallery -InstallationPolicy Trusted

install-module psreadline
import-module psreadline
