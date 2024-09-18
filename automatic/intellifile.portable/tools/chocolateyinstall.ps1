$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'IntelliFile'
$exeFile = Join-Path $installPath 'IntelliFile.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'IntelliFile*'
  url64bit       = 'https://github.com/mihaimoga/IntelliFile/releases/download/v1.33/IntelliFile.zip'
  checksum64     = '95480b49b29943265296149f43afc801f4b03bf2667d657b7aa99a5e6c14e776'
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
