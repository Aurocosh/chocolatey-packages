$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'IntelliFile'
$exeFile = Join-Path $installPath 'IntelliFile.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'IntelliFile*'
  url64bit       = 'https://github.com/mihaimoga/IntelliFile/releases/download/v1.45/IntelliFile.zip'
  checksum64     = '2b56b3b2e8a1fb1293b1a451968be2fe8366cce72f233e1d5ea083c7fc74a91b'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\IntelliFile.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\IntelliFile.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
}
