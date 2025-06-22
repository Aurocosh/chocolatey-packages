$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/8.37/VCEEncC_8.37_Win32.7z'
  checksum       = '1149975786cef87dc064d6e7cacd9081d8ed3ad54c77afa6bbe3ccb6df68a905'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/8.37/VCEEncC_8.37_x64.7z'
  checksum64     = 'f4bd9f7df92537f1036de8c123ef6d3e9fd616898558a02dd1d8baf5883813ef'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
