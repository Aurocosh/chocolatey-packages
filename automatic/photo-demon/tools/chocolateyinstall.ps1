$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'PhotoDemon.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installPath
  softwareName  = 'PhotoDemon*'
  url           = 'https://github.com/tannerhelland/PhotoDemon/releases/download/v2024.7/PhotoDemon-2024.7.zip'
  checksum      = '8b2ee00a926beed6a9e2598c84c0f43afdcff0428ef76ce13c04087272c885f7'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\PhotoDemon.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\PhotoDemon.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
