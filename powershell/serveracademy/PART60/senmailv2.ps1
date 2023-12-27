#video version

function Send-Email() {
    param(
        [Parameter(mandatory=$true)][string]$To,
        [Parameter(mandatory=$true)][string]$Subject,
        [Parameter(mandatory=$true)][string]$Body
    )
    #get credentials

    #get username from line 1
    $username   = (Get-Content -Path 'C:\Users\Paul Hill\credentials.txt')[0]

    #get password from line 2 and convert to secure string
    $password   = (Get-Content -Path 'C:\Users\Paul Hill\credentials.txt')[1] | ConvertTo-SecureString -AsPlainText -Force


    #create hash for email
    $email = @{
        from       = $username
        to         = $To
        subject    = $Subject
        smtpserver = "smtp.gmail.com"
        body       = $Body
        credential = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
        usessl     = $true
        verbose    = $true
    }
 
    Send-MailMessage @email
}