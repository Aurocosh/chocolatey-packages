$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'MediaMonkey*'
  url            = 'https://www.mediamonkey.com/sw/MediaMonkey_2024.2.1.3213.exe'
  checksum       = 'd8115fa506a6eb5a76a3f81e9df884add0d13d61ab9fc987d62c1ec63468a9d9'
  checksumType   = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs
