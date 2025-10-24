$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'Buckets.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'Buckets*'
  url            = 'https://github.com/buckets/application/releases/download/v0.75.0/Buckets-0.75.0.exe'
  checksum       = '7D456008196EEB2BCF29665A0C3CBE4DF9539CC37808F9F3170D85F12A3B0571'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Buckets.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Buckets.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
