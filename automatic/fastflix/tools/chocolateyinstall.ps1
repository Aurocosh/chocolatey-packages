$ErrorActionPreference = 'Stop' # stop on all errors

$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $tempPath
  softwareName   = 'FastFlix*'
  url64bit       = 'https://github.com/cdgriffith/FastFlix/releases/download/5.9.0/FastFlix_5.9.0_installer.zip'
  checksum64     = '9192b731b7155b74de9c1b12e2a4aa8b34dcac0f0cc2e6f53fc4b9b14deb1496'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
  disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$installerExe = (Get-ChildItem $tempPath -filter "FastFlix_*_installer.exe" -File | Select-Object -First 1).FullName
$packageArgs.file64 = $installerExe
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
