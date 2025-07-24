$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'spf*'
  url64bit       = 'https://github.com/yorukot/superfile/releases/download/v1.3.3/superfile-windows-v1.3.3-amd64.zip'
  checksum64     = '288686c6e806a803698c58f9cca3e4c5e4ac5be4f82e1a099a6f7da41be53877'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$programExe = (Get-ChildItem $packagePath -filter "spf.exe" -File -Recurse | Select-Object -First 1).FullName
Move-Item -Path $programExe -Destination $packagePath

$distPath = Join-Path $packagePath 'dist'
Remove-Item -Path $distPath -Force -Recurse
