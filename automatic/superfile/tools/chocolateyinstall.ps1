$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'spf*'
  url64bit       = 'https://github.com/yorukot/superfile/releases/download/v1.3.0/superfile-windows-v1.3.0-amd64.zip'
  checksum64     = 'f91716ee727e8014eed4b25f0d3016d505e6477f3a8b49390d68439cbfe9ad79'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$programExe = (Get-ChildItem $packagePath -filter "spf.exe" -File -Recurse | Select-Object -First 1).FullName
Move-Item -Path $programExe -Destination $packagePath

$distPath = Join-Path $packagePath 'dist'
Remove-Item -Path $distPath -Force -Recurse
