$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'SourceGit*'
  url64bit       = 'https://github.com/sourcegit-scm/sourcegit/releases/download/v2025.40/sourcegit_2025.40.win-x64.zip'
  checksum64     = 'a8663bde4a79db6f02e1e8c2d6f233243f0e3a63287f2312635665c49cc88d93'
  checksumType64 = 'sha256'
}

$installPath = Join-Path $packagePath 'SourceGit'
$exeFile = Join-Path $installPath 'SourceGit.exe'

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
