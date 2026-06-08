$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'spf*'
  url64bit       = 'https://github.com/yorukot/superfile/releases/download/v1.6.0/superfile-windows-v1.6.0-amd64.zip'
  checksum64     = '4264a84d38c5d13804960a5da9ea8dedb8a00439e2612d6b8a28699836ed0143'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$programExe = (Get-ChildItem $packagePath -filter "spf.exe" -File -Recurse | Select-Object -First 1).FullName
Move-Item -Path $programExe -Destination $packagePath

$distPath = Join-Path $packagePath 'dist'
Remove-Item -Path $distPath -Force -Recurse
