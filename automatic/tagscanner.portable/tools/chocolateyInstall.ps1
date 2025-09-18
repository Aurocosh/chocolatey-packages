
$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'Tagscan.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Tagscan*'
  url            = 'https://www.xdlab.ru/files/tagscan-6.1.20.zip'
  checksum       = '1bb4bf042c2f5cf4316a089cb754e81c3dac82253c1a3f6510b64e8b786b917f'
  checksumType   = 'sha256'
  url64bit       = 'https://www.xdlab.ru/files/tagscan-6.1.20_x64.zip'
  checksum64     = '888a8f228a36accf2f7793b991c0260d36cea5a3489405431b7a051c7fcd474d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Tagscan.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Tagscan.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
