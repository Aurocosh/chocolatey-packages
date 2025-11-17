$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $packagePath
  softwareName  = 'Auto Screenshot*'
  url           = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.16.1/AutoScreenshot_v1.16.1_Windows_portable.zip'
  checksum      = '31e2ee4ee1df363c2975fb1c022cee8c71e694efbad28957a0ba5e7f992bf51b'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -IconLocation $exeFile
