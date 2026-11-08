$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'AutoScreenshot.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AutoScreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.3.1/AutoScreenshot_v1.23.3.1_Windows_x86_portable.zip'
  checksum       = '291c66d0c5a8dfeaff28e8f961a73d6f02e1474949609779c8a054f14ce03bcc'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.23.3.1/AutoScreenshot_v1.23.3.1_Windows_x64_portable.zip'
  checksum64     = '3897be75039b729d0041f92adef995b64426512f701f3f834ca112c13bc0c916'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
