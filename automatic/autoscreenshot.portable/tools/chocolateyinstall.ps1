$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'AutoScreenshot.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'AutoScreenshot*'
  url            = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.22.3/AutoScreenshot_v1.22.3_Windows_x86_portable.zip'
  checksum       = '03a88d62c8dec0c222b0095fc0b98c05c5f2f57a787842b2e8fc9efb820b2147'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/artem78/AutoScreenshot/releases/download/v1.22.3/AutoScreenshot_v1.22.3_Windows_x64_portable.zip'
  checksum64     = '6bae6b23767fb0c0c6a6783b1facf23e342c9a868658f8db5a34687006c02be8'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFolder = (Get-ChildItem $packagePath -filter "AutoScreenshot_v*" -Directory | Select-Object -First 1).Name
$installPath = Join-Path $packagePath $installFolder
$exeFile = Join-Path $installPath 'AutoScreenshot.exe'

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\AutoScreenshot.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
