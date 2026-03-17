$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'dorion.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Dorion*'
  url64bit       = 'https://github.com/SpikeHD/Dorion/releases/download/v6.12.2/Dorion_6.12.2_win64_portable.zip'
  checksum64     = '1bb042a9542087a1a642bc1ecdbfb08b743ea0e50061ea466bd19253b3762c45'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Dorion.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Dorion.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath

New-Item (Join-Path $installPath 'updater.exe.ignore') -type File
