$ipAddress = "155.207.172.59"  # Replace with the IP address you want to check
$smtpServer = "smtp.hostinger.com"  # Replace with your SMTP server address
$smtpPort = 587  # Replace with the SMTP server port
$senderAddress = "panos@smtp.techniki.gr"  # Replace with the sender's email address
$receiverAddress = "p.efstratiou@techniki.gr"  # Replace with the receiver's email address
$subject = "IP Online Alert"
$username = "panos@smtp.techniki.gr"  # Replace with your SMTP server username
$password = "fdgd4r4fA#"  # Replace with your SMTP server password

while ($true) {
    $pingReply = Test-Connection -ComputerName $ipAddress -Count 1 -Quiet
    
    if ($pingReply) {
        $body = "The IP address $ipAddress is online."
        
        # Create email message
        $message = New-Object System.Net.Mail.MailMessage
        $message.From = $senderAddress
        $message.To.Add($receiverAddress)
        $message.Subject = $subject
        $message.Body = $body
        
        # Create SMTP client
        $smtpClient = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
        $smtpClient.EnableSsl = $true
        $smtpClient.Credentials = New-Object System.Net.NetworkCredential($username, $password)
        
        # Send email
        $smtpClient.Send($message)
    }
    else{
        $body = "The IP address $ipAddress is down."
        
        # Create email message
        $message = New-Object System.Net.Mail.MailMessage
        $message.From = $senderAddress
        $message.To.Add($receiverAddress)
        $message.Subject = $subject
        $message.Body = $body
        
        # Create SMTP client
        $smtpClient = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
        $smtpClient.EnableSsl = $true
        $smtpClient.Credentials = New-Object System.Net.NetworkCredential($username, $password)
        
        # Send email
        $smtpClient.Send($message)       
    }
    Start-Sleep -Seconds 300  # Wait for 5 minutes
}
#Replace the placeholder values with your actual IP address, SMTP server details (including port), sender 
#and receiver email addresses, subject line, username, and password.

#Save the updated script with a .ps1 extension (e.g., ip_online_check_ssl.ps1), open a PowerShell 
#window, navigate to the script's directory, and execute the following command:

#powershell
#Copy code
#.\ip_online_check_ssl.ps1
#The script will run continuously, checking the IP address every 5 minutes and sending an email alert via SSL/TLS encryption if it's online. 
#To stop the script, press Ctrl+C in the PowerShell window.
