$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'AutoScreenshot.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AutoScreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.1/AutoScreenshot_v1.23.1_Windows_x86_portable.zip'
  checksum       = '16a547da4274957ea29d18b5993fc1b78b17aca8f4e8d13e855d5847211e8162'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.1/AutoScreenshot_v1.23.1_Windows_x64_portable.zip'
  checksum64     = '1062905ed4cd9e69721b7ae30b28ff1424bb6843bdf1d55351e499811d9e849b'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
