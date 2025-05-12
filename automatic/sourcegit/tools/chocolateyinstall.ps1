$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'SourceGit*'
  url64bit       = 'https://github.com/sourcegit-scm/sourcegit/releases/download/v2025.17/sourcegit_2025.17.win-x64.zip'
  checksum64     = '94c9e0d63ed6f6d6eaf4ff61ec8e3ac259cdf0276f1b4be308e43bf2d76237d1'
  checksumType64 = 'sha256'
}

$installPath = Join-Path $packagePath 'SourceGit'
$exeFile = Join-Path $installPath 'SourceGit.exe'

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
