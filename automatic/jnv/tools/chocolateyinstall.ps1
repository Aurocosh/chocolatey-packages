$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'jnv'
  url64bit       = 'https://github.com/ynqa/jnv/releases/download/v0.4.1/jnv-x86_64-pc-windows-msvc.zip'
  checksum64     = 'fb44d9eb01fb29391f04d27f28ea9590adbb116c0b22c8816b8fc3801addcbbf'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# $programExe = (Get-ChildItem $packagePath -filter "jnv.exe" -File -Recurse | Select-Object -First 1).FullName
# Move-Item -Path $programExe -Destination $packagePath

# $distPath = Join-Path $packagePath 'dist'
# Remove-Item -Path $distPath -Force -Recurse
