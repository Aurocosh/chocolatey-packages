$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'WizFile.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'WizFile*'
  url64bit       = 'https://antibody-software.com/files/wizfile_3_15_portable.zip'
  checksum64     = 'd7a1fd121a7182219dcc74d467314b8a764830118321a07410951b66a8b40824'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\WizFile.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WizFile.lnk" -TargetPath $exeFile -IconLocation $exeFile
