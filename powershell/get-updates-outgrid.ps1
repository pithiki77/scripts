
#from https://gist.github.com/nouseforname/a8b7ebcb9d0c05e380c7e3c81c300923


#enconding to fix indetions errors
[Console]::InputEncoding = [Console]::OutputEncoding = $InputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()

# get rid of PSSA warning
$null = $InputEncoding

# object to be used basically for view only
class Software {
  [string]$Name
  [string]$Id
  [string]$Version
  [string]$AvailableVersion
}

# get the available upgrades
$upgradeResult = winget upgrade -u

# run through the list and get the app data
$upgrades = @()
$idStart = -1
$isStartList = 0
$upgradeResult | ForEach-Object -Process {

  if ($isStartList -lt 1 -and -not $_.StartsWith("Name") -or $_.StartsWith("---") -or $_.StartsWith("The following packages"))
  {
    return
  }

  if ($_.StartsWith("Name"))
  {
    $idStart = $_.toLower().IndexOf("id")
    $isStartList = 1
    return
  }

  if ($_.Length -lt $idStart)
  {
    return
  }

  $Software = [Software]::new()
  $Software.Name = $_.Substring(0, $idStart-1)
  $info = $_.Substring($idStart) -split '\s+'
  $Software.Id = $info[0]
  $Software.Version = $info[1]
  $Software.AvailableVersion = $info[2]

  $upgrades += $Software
}

# view the list
# $upgrades | Format-Table

#select and upgrade install only selected
$upgrades | out-gridview -passthru| ForEach-Object { winget upgrade --id $_.Id }