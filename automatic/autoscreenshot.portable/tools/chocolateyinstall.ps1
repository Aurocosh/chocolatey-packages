$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'AutoScreenshot.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AutoScreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.4/AutoScreenshot_v1.23.4_Windows_x86_portable.zip'
  checksum       = '6cab1cf9f2b055249a338457652853b5a24f3828835cdd72b8dd74b8f040ab1a'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.4/AutoScreenshot_v1.23.4_Windows_x64_portable.zip'
  checksum64     = '8c5f78c07b21f71ee20dc646821c0fc4aaddcc19651ea17f065296c8b6e866fe'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
