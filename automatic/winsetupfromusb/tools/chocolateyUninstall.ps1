
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installFolder = (Get-ChildItem $packagePath -filter "WinSetupFromUSB-*-*" -Directory | Select-Object -First 1).Name

Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName "$installFolder.exe"

Remove-Item -Path "$env:ALLUSERSPROFILE\Desktop\WinSetupFromUSB.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WinSetupFromUSB.lnk" -ErrorAction SilentlyContinue
