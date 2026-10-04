$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'NVEnc*'
  url            = 'https://github.com/rigaya/NVEnc/releases/download/9.37/NVEncC_9.37_Win32.7z'
  checksum       = '716b6204977ca08ed382dfeecb8d903f032bef1e636bc1d972d53b28bc320e66'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/NVEnc/releases/download/9.37/NVEncC_9.37_x64.7z'
  checksum64     = '26358c59fa4f97a2b3a1f25dd1e001ad13ce18a02e57f597277f3e2302b0acbf'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'NVEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "NVEncC.exe"
}
