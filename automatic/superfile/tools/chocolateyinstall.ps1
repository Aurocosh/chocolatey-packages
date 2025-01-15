$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'spf*'
  url64bit       = 'https://github.com/yorukot/superfile/releases/download/v1.1.7.1/superfile-windows-v1.1.7.1-amd64.zip'
  checksum64     = '4087aedd461942b0ebfa767d5ba1803d35e4ef2fbc211fc5bd9d4061d59e0f76'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$programExe = (Get-ChildItem $packagePath -filter "spf.exe" -File -Recurse | Select-Object -First 1).FullName
Move-Item -Path $programExe -Destination $packagePath

$distPath = Join-Path $packagePath 'dist'
Remove-Item -Path $distPath -Force -Recurse
