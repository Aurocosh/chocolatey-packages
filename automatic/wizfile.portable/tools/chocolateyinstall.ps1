$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'WizFile.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'WizFile*'
  url64bit       = 'https://antibody-software.com/files/wizfile_3_14_portable.zip'
  checksum64     = '51cc0567f908be6a765ac281b4e3159aeb85a89d3a3f7229fad7883cc1846048'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\WizFile.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WizFile.lnk" -TargetPath $exeFile -IconLocation $exeFile
