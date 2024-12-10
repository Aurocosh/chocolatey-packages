$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PhotoDemon.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installPath
  softwareName  = 'PhotoDemon*'
  url           = 'https://github.com/tannerhelland/PhotoDemon/releases/download/v2024.12/PhotoDemon-2024.12.zip'
  checksum      = '89a405442fa346900348176265718ad874f65e3ad073d76dd5b1d57179afc7bd'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PhotoDemon.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PhotoDemon.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
