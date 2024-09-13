$packageName = 'keyboard-layout-creator'
$fileType = 'msi'
$silentArgs = '/qn'
$url = 'http://download.microsoft.com/download/1/1/8/118aedd2-152c-453f-bac9-5dd8fb310870/MSKLC.exe'

$unpackDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$unpackFile = Join-Path $unpackDir 'mklc.zip'

Get-ChocolateyWebFile $packageName $unpackFile $url
Get-ChocolateyUnzip $unpackFile $unpackDir
$fileMsi = Join-Path $unpackDir "MSKLC.msi"
$fileExe = Join-Path $unpackDir "setup.exe"

Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $fileMsi
Remove-Item $unpackFile -Recurse -Force
Remove-Item $fileExe -Recurse -Force
Remove-Item $fileMsi -Recurse -Force