$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'spf*'
  url64bit       = 'https://github.com/yorukot/superfile/releases/download/v1.2.0.0/superfile-windows-v1.2.0.0-amd64.zip'
  checksum64     = 'f3122d375913be1ad273815ed31537cd6ba06770cc3c5fdb0dce900b7f435d49'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$programExe = (Get-ChildItem $packagePath -filter "spf.exe" -File -Recurse | Select-Object -First 1).FullName
Move-Item -Path $programExe -Destination $packagePath

$distPath = Join-Path $packagePath 'dist'
Remove-Item -Path $distPath -Force -Recurse
