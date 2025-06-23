$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'SourceGit*'
  url64bit       = 'https://github.com/sourcegit-scm/sourcegit/releases/download/v2025.23/sourcegit_2025.23.win-x64.zip'
  checksum64     = '0c00a83354a4f6d28a5e125813fe4ccbe087eb4a68aba7d87734ae6dead93a3e'
  checksumType64 = 'sha256'
}

$installPath = Join-Path $packagePath 'SourceGit'
$exeFile = Join-Path $installPath 'SourceGit.exe'

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\SourceGit.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
