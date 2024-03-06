<#PowerShell Text To Speech

As we all know, Powershell is built on top of .NET Framework, so we can directly point to a class such System.Speech.Syntesis.SpeechSynthesizer .

Looking at the object’s properties we can modify:

Rate (speed /speaking rate)
State ( status of the SpeechSynthesizer)
Voice (Change voice gender/ culture/ etc..)
Volume (Volume of the SpeechSynthesizer).
#>

Add-Type -AssemblyName System.Speech
$SpeechSynthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
$SpeechSynthesizer.Speak('Hello, World!')

$SpeechSynthesizer

<#Now, let’s check the voice used#>

$SpeechSynthesizer.voice

<#List all the installed voice#>

Foreach ($voice in $SpeechSynthesizer.GetInstalledVoices()){
    $Voice.VoiceInfo | Select-Object Gender, Name, Culture, Description
}

$SpeechSynthesizer.GetInstalledVoices() | select -ExpandProperty VoiceInfo | select Name, Gender, Description


<#How to change/select the voice#>

$SpeechSynthesizer.SelectVoice("Microsoft Zira Desktop")
$SpeechSynthesizer.Speak('Hello, World!')




#===============================
<#It solved the problem for me (the Dutch TTS not showing up). 
If you download a new language in the Windows settings rerun the script. 
Huge thanks to https://github.com/hiepxanh for finding this solution originally. #>


$sourcePath = 'HKLM:\software\Microsoft\Speech_OneCore\Voices\Tokens' #Where the OneCore voices live
$destinationPath = 'HKLM:\SOFTWARE\Microsoft\Speech\Voices\Tokens' #For 64-bit apps
$destinationPath2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\SPEECH\Voices\Tokens' #For 32-bit apps
cd $destinationPath
$listVoices = Get-ChildItem $sourcePath
foreach($voice in $listVoices)
{
$source = $voice.PSPath #Get the path of this voices key
copy -Path $source -Destination $destinationPath -Recurse
copy -Path $source -Destination $destinationPath2 -Recurse
}


#==================================================================

$SpeechSynthesizer.SelectVoice("Microsoft Stefanos")
$SpeechSynthesizer.Speak('Καλημέρα')
$SpeechSynthesizer.Speak('γεια σου αποστολε και αργυρω')



$Message = 'This is awesome.  We now know how to use Powershell Text To Speech'
$SpeechSynthesizer.Speak($Message)


#================================
<#Powershell Text To Speech Script
Now that we know how to do it manually, 
let’s leverage Powershell to do this automatically.
After all, Powershell is a scripting language so it’s really suitable for our situation. 
We’ll name this function New-TextToSpeechMessage.   #>

Function New-TextToSpeechMessage {
    <#
    .SYNOPSIS
        This will use Powershell to have a message read out loud through your computer speakers.
     
     
    .NOTES
        Name: New-TextToSpeechMessage
        Author: theSysadminChannel
        Version: 1.0
        DateCreated: 2021-Feb-28
     
    .LINK
        https://thesysadminchannel.com/powershell-text-to-speech-how-to-guide -
     
    .EXAMPLE
        New-TextToSpeechMessage -Message 'This is the text I want to have read out loud' -Voice Zira
    #>
        [CmdletBinding()]
        param(
            [Parameter(
                Position = 0,
                Mandatory = $true
            )]
     
            [string]    $Message,
     
     
            [Parameter(
                Position = 1,
                Mandatory = $false
            )]
     
            [ValidateSet('David', 'Zira')]
            [string]    $Voice = 'Zira'
        )
     
        BEGIN {
            if (-not ([appdomain]::currentdomain.GetAssemblies() | Where-Object {$_.Location -eq 'C:\Windows\Microsoft.Net\assembly\GAC_MSIL\System.Speech\v4.0_4.0.0.0__31bf3856ad364e35\System.Speech.dll'})) {
                Add-Type -AssemblyName System.Speech
            }
        }
     
        PROCESS {
            try {
                $NewMessage = New-Object System.Speech.Synthesis.SpeechSynthesizer
     
                if ($Voice -eq 'Zira') {
                    $NewMessage.SelectVoice("Microsoft Zira Desktop")
                } else {
                    $NewMessage.SelectVoice("Microsoft David Desktop")
                }
         
                $NewMessage.Speak($Message)
         
            } catch {
                Write-Error $_.Exception.Message
            }        
        }
     
        END {}
    }