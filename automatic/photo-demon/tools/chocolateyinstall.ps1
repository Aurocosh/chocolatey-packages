$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PhotoDemon.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installPath
  softwareName  = 'PhotoDemon*'
  url           = 'https://github.com/tannerhelland/PhotoDemon/releases/download/v2025.4/PhotoDemon-2025.4.zip'
  checksum      = '4e2c536e10645261a5dee75434a3198064982f2a2f5c9da31992c2ce1371ae2b'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PhotoDemon.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PhotoDemon.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
