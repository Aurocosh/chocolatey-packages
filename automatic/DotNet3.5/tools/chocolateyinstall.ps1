$ErrorActionPreference = 'Stop'

if (Test-Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5') {
  Write-Host 'Microsoft .Net 3.5 Framework is already installed on your machine.'
  return
}

$build = [int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild

if ($build -ge 28000) {
  $packageArgs = @{
    packageName      = $env:ChocolateyPackageName
    fileType         = 'exe'
    softwareName     = 'Microsoft .NET Framework 3.5*'
    url64bit         = 'https://go.microsoft.com/fwlink/?LinkID=2337635'
    checksum64       = 'b969d1d0a662bdfd20f42aed9f0ede21122723fbbcee545f16da7150ff01926d'
    checksumType64   = 'sha256'
    validExitCodes   = @(0, 3010, 1641)
    silentArgs       = '/q /norestart'
  }
  Install-ChocolateyPackage @packageArgs
}
else {
  if ((Get-WmiObject -Class win32_operatingsystem).Caption.Contains('Server')) {
    $packageArgs = '/c DISM /Online /NoRestart /Enable-Feature /FeatureName:NetFx3ServerFeatures'
    $statements = "cmd.exe $packageArgs"
    Start-ChocolateyProcessAsAdmin "$statements" -minimized -nosleep -validExitCodes @(0, 1)
  }
  $packageArgs = '/c DISM /Online /NoRestart /Enable-Feature /FeatureName:NetFx3'
  $statements = "cmd.exe $packageArgs"
  Start-ChocolateyProcessAsAdmin "$statements" -minimized -nosleep -validExitCodes @(0)
}
