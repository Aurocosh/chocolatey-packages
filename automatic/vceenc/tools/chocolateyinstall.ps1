$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'VCEEnc*'
  url            = 'https://github.com/rigaya/VCEEnc/releases/download/9.13/VCEEncC_9.13_Win32.7z'
  checksum       = '2132e3a053abceb7a7fca2f3a04242878f1960ebabfda044d197432de82434ae'
  checksumType   = 'sha256'
  url64bit       = 'https://github.com/rigaya/VCEEnc/releases/download/9.13/VCEEncC_9.13_x64.7z'
  checksum64     = 'abe54d5db132e95eec067bf01230a94fdb0e8db44ce110f54d493fb17fbb3867'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exePath64 = Join-Path $installPath 'VCEEncC64.exe'
if (Test-Path $exePath64) {
  Rename-Item -Path $exePath64 -NewName "VCEEncC.exe"
}
