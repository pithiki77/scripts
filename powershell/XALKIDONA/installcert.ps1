# Path to your PEM file
$certPath = "\\10.65.142.70\Applications\techniki\certificates\rootCA.PEM"

# Load the certificate content from the PEM file
$certContent = Get-Content $certPath -Raw

# Convert the PEM content to a certificate object
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import([Text.Encoding]::ASCII.GetBytes($certContent))

# Import the certificate to Trusted Root Certification Authorities store
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store -ArgumentList "Root", "LocalMachine"
$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()

Write-Host "Certificate installed to Trusted Root Certification Authorities store."
