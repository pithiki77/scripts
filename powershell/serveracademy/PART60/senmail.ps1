##old version ???

function Send-Email() {
    param(
        [Parameter(mandatory=$true)][string]$To,
        [Parameter(mandatory=$true)][string]$Subject,
        [Parameter(mandatory=$true)][string]$Body
    )
 
    #get username from line 1
    $username   = (Get-Content -Path 'C:\Users\Paul Hill\credentials.txt')[0]
    #get password from line2
    $password   = (Get-Content -Path 'C:\Users\Paul Hill\credentials.txt')[1]

    $secstr     = New-Object -TypeName System.Security.SecureString
    $password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
 
    $hash = @{
        from       = $username
        to         = $To
        subject    = $Subject
        smtpserver = "smtp.gmail.com"
        body       = $Body
        credential = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
        usessl     = $true
        verbose    = $true
    }
 
    Send-MailMessage @hash
}