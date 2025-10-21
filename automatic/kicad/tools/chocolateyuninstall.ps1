$ErrorActionPreference = 'Stop' # stop on all errors
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'KiCad*'  #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  fileType       = 'exe'
  silentArgs     = '/S /allusers'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    if($_.UninstallString -match '"([^"]+)"(?:\s*\/allusers|\s*\/s)') {
      $packageArgs['file'] = $matches[1]
    }
    else {
      $packageArgs['file'] = "$($_.UninstallString)" #NOTE: You may need to split this if it contains spaces, see below
    }

    Uninstall-ChocolateyPackage @packageArgs
  }
}
elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

