$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'SourceGit*'
  url64bit       = 'https://github.com/sourcegit-scm/sourcegit/releases/download/v2026.21/sourcegit_2026.21.win-x64.zip'
  checksum64     = '954a458ad3d8c1b537046e051f8427cfebacdf06977510b4b0185b44eb1133eb'
  checksumType64 = 'sha256'
}

$installPath = Join-Path $packagePath 'SourceGit'
$exeFile = Join-Path $installPath 'SourceGit.exe'

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
