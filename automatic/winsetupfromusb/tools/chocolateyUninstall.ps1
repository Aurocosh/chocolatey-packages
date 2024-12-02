Uninstall-ChocolateyZipPackage 'winsetupfromusb' 'WinSetupFromUSB-1-9.exe'

$shortcut = $env:userprofile  + '\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WinSetupFromUSB.lnk'
Write-Host "`n Removing start menu shortcut..." -ForegroundColor green
Remove-Item -Force $shortcut

$shortcut2 = $env:userprofile  + '\Desktop\WinSetupFromUSB.lnk'
Write-Host "`n Removing desktop shortcut..." -ForegroundColor green
Remove-Item -Force $shortcut2