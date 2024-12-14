$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Snipaste.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Snipaste*'
  url            = 'https://dl.snipaste.com/win-x86'
  checksum       = '3d5d6f3879784c2e501ea147aff9a5280455bfa5cb94687b594cd75716a1aa85'
  checksumType   = 'sha256'
  url64bit       = 'https://dl.snipaste.com/win-x64'
  checksum64     = 'b56507c858d112b5983a49f775e185e2849aa38f3735a5a1ecc684975211b4e1'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
icacls $installPath /grant "Authenticated Users:(OI)(CI)(M)"

$PackageParameters = Get-PackageParameters

If (!$PackageParameters.NoDesktopShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Snipaste.lnk" -TargetPath $exeFile
}

If (!$PackageParameters.NoStartMenuShortcut) {
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Snipaste.lnk" -TargetPath $exeFile
}
