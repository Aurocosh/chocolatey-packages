$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'CherryTree*'
  url64bit       = 'https://github.com/giuspen/cherrytree/releases/download/v1.5.0/cherrytree_1.5.0.0_win64_setup.exe'
  checksum64     = '20e374c866973570fbb258289a2a6206b991e22417f2775d56b47d48e456a423'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'  # Inno Setup
}

Install-ChocolateyPackage @packageArgs

