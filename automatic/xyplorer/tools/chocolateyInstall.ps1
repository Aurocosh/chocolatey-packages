$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = "xyplorer"
$installerType  = "EXE"
$packageVersion = "24.90.0100"
$url            = "https://www.xyplorer.com/download/xyplorer_full.zip"
$silentArgs     = "/S"
$validExitCodes = @(0)
$checksum       = "f005cc8f413c4d312f7f9b25f4cb53415561e7695db274a9f48c5549452475cd"
$checksumType   = "sha256"


#extract filename from source URL
$filename       = $url.Substring($url.LastIndexOf("/") + 1)


#establish temp folder path
$tempPath       = $env:temp,$packageName,$packageVersion -join "\"


#establish full path to local copy of downloaded zip file
$pathToZip      = ($tempPath,$filename -join "\")


# download zip package
Get-ChocolateyWebFile  `
    -PackageName $packageName `
    -FileFullPath $pathToZip `
    -Url $url `
    -Checksum $checksum `
    -ChecksumType $checksumType


# extract it
Get-ChocolateyUnzip $pathToZip $tempPath


# establish path to extracted installer (exe)
$pathToExe = Join-Path $tempPath (get-childitem $tempPath | where {$_.extension -eq ".exe"}).Name


# install package
Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$pathToExe" -validExitCodes $validExitCodes
