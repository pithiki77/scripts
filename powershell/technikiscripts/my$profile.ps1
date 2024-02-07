# Configuring Oh-my-posh Terminal
oh-my-posh init pwsh --config ""C:\Users\panos\AppData\Local\Programs\oh-my-posh\themes\clean-detailed-my.omp.json"" | Invoke-Expression

# Importing Terminal-Icons Module
#Import-Module Terminal-Icons

# Importing Z Module
#Import-Module Z

# Importing Fuzzy finder tool
#Import-Module PSFzf

# Configuring Fuzzy Finder
Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
#Set-PsFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSreadLineChordReverseHistory 'Ctrl+r'





# Setting Alias's
#Set-Alias vim nvim
#Set-Alias g git
#Set-Alias grep Find-String
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


#myfunctions
import-module C:\test\filerenamermodule\FileRenamer.psm1
Import-Module "C:\test\fileOPENmodule\fileOPENmodule.psm1"