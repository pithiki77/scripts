# Open the Trusted Root Certification Authorities store
$store = New-Object System.Security.Cryptography.X509Certificates.X509Store -ArgumentList "Root", "LocalMachine"
$store.Open("ReadOnly")

# Get the list of certificates in the store
$certificates = $store.Certificates

# Display certificate information
foreach ($cert in $certificates) {
    Write-Host "Subject: $($cert.Subject)"
    Write-Host "Issuer: $($cert.Issuer)"
    Write-Host "Thumbprint: $($cert.Thumbprint)"
    Write-Host "Expiration Date: $($cert.GetExpirationDateString())"
    Write-Host "Friendly Name: $($cert.FriendlyName)"
    Write-Host "---------------------------------------------------------"
}

# Close the certificate store
$store.Close()
