$ErrorActionPreference = 'Stop'

if (-not (Test-Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5')) {
  Write-Host 'Microsoft .Net 3.5 Framework is not installed on your machine.'
  return
}

$build = [int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild

if ($build -ge 28000) {
  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'Microsoft .NET Framework 3.5*'
    fileType       = 'EXE'
    silentArgs     = '/uninstall /q /norestart'
    validExitCodes = @(0, 3010, 1641, 1605, 1614)
  }

  [array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

  if ($key.Count -eq 1) {
    $key | ForEach-Object {
      $packageArgs['file'] = "$($_.UninstallString)"
      Uninstall-ChocolateyPackage @packageArgs
    }
  }
  elseif ($key.Count -eq 0) {
    Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
  }
  elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning 'To prevent accidental data loss, no programs will be uninstalled.'
    Write-Warning 'Please alert package maintainer the following keys were matched:'
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
  }
}
else {
  $packageArgs = '/c DISM /Online /NoRestart /Disable-Feature /FeatureName:NetFx3'
  $statements = "cmd.exe $packageArgs"
  Start-ChocolateyProcessAsAdmin "$statements" -minimized -nosleep -validExitCodes @(0)

  if ((Get-WmiObject -Class win32_operatingsystem).Caption.Contains('Server')) {
    $packageArgs = '/c DISM /Online /NoRestart /Disable-Feature /FeatureName:NetFx3ServerFeatures'
    $statements = "cmd.exe $packageArgs"
    Start-ChocolateyProcessAsAdmin "$statements" -minimized -nosleep -validExitCodes @(0, 1)
  }
}
