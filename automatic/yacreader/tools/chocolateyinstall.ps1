$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'YACReader*winx86.exe'
$file64Location = Join-Path $toolsDir 'YACReader*winx64.exe'
$url        = 'https://github.com/YACReader/yacreader/releases/download/9.15.0/YACReader-v9.15.0.2501014-winx86-7z.exe'
$url64      = 'https://github.com/YACReader/yacreader/releases/download/9.15.0/YACReader-v9.15.0.2501014-winx64-7z-qt6.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64
  file			= $fileLocation
  file64		= $file64Location
  softwareName  = 'YACReader*'
  checksum      = '5b1ca85223415e6a01f826a7a9ca1242ebe0a691a982a35179883a8926059ae1'
  checksumType  = 'sha256'
  checksum64    = 'eb7f96d550e1bccbeca9a8f52af0dabd1215810dc6232f9883d7e955892a5276'
  checksumType64= 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
