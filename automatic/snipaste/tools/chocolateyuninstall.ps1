$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installationLogTxt = (Get-ChildItem $packagePath -filter "Snipaste-*.zip.txt" -File | Select-Object -First 1).Name
$zipName = $installationLogTxt -replace "\.txt"

Uninstall-ChocolateyZipPackage $env:ChocolateyPackageName $zipName

Remove-Item -Path "$env:ALLUSERSPROFILE\Desktop\Snipaste.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Snipaste.lnk" -ErrorAction SilentlyContinue