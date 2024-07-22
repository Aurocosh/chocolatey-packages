$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $packagePath
  softwareName  = 'Auto Screenshot*'
  url           = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.16/AutoScreenshot_v1.16_Windows_portable.zip'
  checksum      = '658df6484b8741aae1d77166ce78fa37642adc44648fdea396ed284821e0e711'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -IconLocation $exeFile
