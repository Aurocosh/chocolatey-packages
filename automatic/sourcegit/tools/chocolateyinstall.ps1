$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'SourceGit*'
  url64bit       = 'https://github.com/sourcegit-scm/sourcegit/releases/download/v2025.18/sourcegit_2025.18.win-x64.zip'
  checksum64     = 'fb20564f4401d001f8d7bb42c9f4d98d8a6959e7062c819b6ec44487389975b3'
  checksumType64 = 'sha256'
}

$installPath = Join-Path $packagePath 'SourceGit'
$exeFile = Join-Path $installPath 'SourceGit.exe'

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
