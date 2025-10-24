$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'Buckets.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'Buckets*'
  url            = 'https://github.com/buckets/application/releases/download/v0.80.0/Buckets-0.80.0.exe'
  checksum       = 'dc7a4b1429dc20689da58abcad3d6c127811d600c6a26ed35896c726898f78dc'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Buckets.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Buckets.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
