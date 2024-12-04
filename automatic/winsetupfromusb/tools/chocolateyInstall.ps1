$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$archiveFile = (Get-ChildItem $toolsDir -filter "WinSetupFromUSB-*-*.exe" -File | Select-Object -First 1).FullName

$packageArgs = @{
  packageName            = $env:ChocolateyPackageName
  file                   = $archiveFile
  checksum               = 'F1F2DB8CC6E02A8C7ABD3E91A7AAD23D1F3730EB16763B9041E73A55B817A7EB'
  checksumType           = 'sha256'
  unzipLocation          = $packagePath
}
Install-ChocolateyZipPackage @packageArgs

Remove-Item -Path $archiveFile -Force

$installPath = (Get-ChildItem $packagePath -filter "WinSetupFromUSB-*-*" -Directory | Select-Object -First 1).FullName
$ignoreDir = Join-Path $installPath 'files'

$ignoredFiles = Get-ChildItem $ignoreDir -include *.exe -recurse
foreach ($file in $ignoredFiles) {
  New-Item "$file.ignore" -type file -force | Out-Null
}

if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne $true) {
  $exeFile = (Get-ChildItem $installPath -filter "WinSetupFromUSB_*-*_x64.exe" -File | Select-Object -First 1).FullName
} 
else {
  $exeFile = (Get-ChildItem $installPath -filter "WinSetupFromUSB_*-*.exe" -File | Select-Object -First 1).FullName
}

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\WinSetupFromUSB.lnk" -TargetPath $exeFile -IconLocation $exeFile
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\WinSetupFromUSB.lnk" -TargetPath $exeFile -IconLocation $exeFile
