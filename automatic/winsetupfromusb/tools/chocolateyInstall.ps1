$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'winsetupfromusb'
  file                   = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + '\WinSetupFromUSB-1-9.exe'
  checksum               = '25c75a7fb3d6b35dba8313169ea0f031'
  checksumType           = 'md5'
  dest                   = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + '\winsetupfromusb'
}
Install-ChocolateyZipPackage @packageArgs

$ignoredir = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + '\winsetupfromusb\WinSetupFromUSB-1-9\files'
$files = get-childitem $ignoredir -include *.exe -recurse

foreach ($file in $files) {
  #generate an ignore file
  New-Item "$file.ignore" -type file -force | Out-Null
}

if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne $true) {
$shortcutpath = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + '\winsetupfromusb\WinSetupFromUSB-1-9\WinSetupFromUSB_1-9_x64.exe'
$targetpath = $env:userprofile  + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WinSetupFromUSB.lnk'
Install-ChocolateyShortcut -ShortcutFilePath $targetpath -TargetPath $shortcutpath
$targetpath2 = $env:userprofile  + '\Desktop\WinSetupFromUSB.lnk'
Install-ChocolateyShortcut -ShortcutFilePath $targetpath2 -TargetPath $shortcutpath
} 
else {
$shortcutpath = $(Split-Path -parent $MyInvocation.MyCommand.Definition) + '\winsetupfromusb\WinSetupFromUSB-1-9\WinSetupFromUSB_1-9.exe'
$targetpath = $env:userprofile  + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WinSetupFromUSB.lnk'
Install-ChocolateyShortcut -ShortcutFilePath $targetpath -TargetPath $shortcutpath
$targetpath2 = $env:userprofile  + '\Desktop\WinSetupFromUSB.lnk'
Install-ChocolateyShortcut -ShortcutFilePath $targetpath2 -TargetPath $shortcutpath
}