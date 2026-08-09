$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.12/VCEEncC_9.12_Win32.7z'
  checksum       = '79270d80ff3ea46b04efb480ed224be0ffa4e13f0d3f49bcfb43a7d1f580d92d'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.12/VCEEncC_9.12_x64.7z'
  checksum64     = '0b99e7f96f4d3c94d4beb9d0e6712d3a3fc5bedc20d6ec76669b7aec0fc706f0'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
