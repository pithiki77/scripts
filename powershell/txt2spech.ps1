Add-Type -AssemblyName System.Speech
$SpeechSynthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
$SpeechSynthesizer.Speak('Hello, World!')

$SpeechSynthesizer

$SpeechSynthesizer.voice


Foreach ($voice in $SpeechSynthesizer.GetInstalledVoices()){
    $Voice.VoiceInfo | Select-Object Gender, Name, Culture, Description
}

$SpeechSynthesizer.SelectVoice("Microsoft Zira Desktop")
$SpeechSynthesizer.Speak('Hello, World!')




#===============================

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