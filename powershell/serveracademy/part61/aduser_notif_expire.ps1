function Send-Email() {
    param(
        [Parameter(mandatory=$true)][string]$To,
        [Parameter(mandatory=$true)][string]$Subject,
        [Parameter(mandatory=$true)][string]$Body
    )
   
    # Get user credentials
    $username = (Get-Content -Path "C:\Scripts\gmail_creds.txt")[0]
    $password = (Get-Content -Path "C:\Scripts\gmail_creds.txt")[1] | ConvertTo-SecureString -AsPlainText -Force
 
    # Create hash for email
    $email = @{
        from = $username
        to = $To
        subject = $Subject
        smtpserver = "smtp.gmail.com"
        body = $Body
        credential = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $password
        usessl = $true
        verbose = $true
    }
 
    Send-MailMessage @email
}
 
# Get all AD Users
$ADUsers = (Get-ADUser -Filter * -Properties mail, msDS-UserPasswordExpiryTimeComputed)
 
# Variables
$DoesNotExpire = 9223372036854775807 # This is the value of msDS-UserPasswordExpiryTimeComputed when the users password is set to never expire
 
# Iterate over all the AD users
foreach($User in $ADUsers) {
   
    # Does the password expire?
    if($User.'msDS-UserPasswordExpiryTimeComputed' -ne $DoesNotExpire) {
        # Find out how long until the password expires
        $ExpirationDate = [DateTime]::FromFileTime($User.'msDS-UserPasswordExpiryTimeComputed')
        $Difference = New-TimeSpan -Start (Get-Date) -End $ExpirationDate
 $Difference
        # Is the difference in days less than 14 days until the account expires?
        if($Difference.Days -lt 45) {
            if($User.mail) {
                # Logging
                Write-Host "$($User.SamAccountName)'s password expires in $($Difference.Days) days. Sending email for them to reset their password."
                Send-Email -To $User.mail -Subject "Please reset your AD Password" -Body "You account password will expire in $($Difference.Days) days. Please log in and reset your password now."
            } else {
                Write-Host "!!! $($User.SamAccountName)'s password expires in $($Difference.Days) days. They have no email account configured in Active Directory."
            }
        } else {
            # Logging
            Write-Host "$($User.SamAccountName)'s password expires in $($Difference.Days) days."
        }
    } else {
        # Logging
        Write-Host "$($User.SamAccountName)'s password is configured to never expire."
    }
}