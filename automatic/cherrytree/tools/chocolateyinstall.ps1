$packageName= 'cherrytree'
$toolsDir   = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.giuspen.com/software/cherrytree_0.99.41.0_win64_setup.exe'

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  silentArgs    = "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT"
  softwareName  = 'Cherrytree*'
  checksum      = '7c60e7c6aac949c9862833d92a84e9b76faa4c95f3d689f2448e16296e48e448'
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
