$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = "xyplorer"
$installerType = "EXE"
$packageVersion = "26.30.0000"
$url = "https://www.xyplorer.com/free-zer/26.30/xyplorer_full.zip"
$silentArgs = "/S"
$validExitCodes = @(0)
$checksum = "2be73adfec1935381869f511f18c0649912d5bd9207a6c54aff8c0499f7d01ab"
$checksumType = "sha256"


#extract filename from source URL
$filename = $url.Substring($url.LastIndexOf("/") + 1)


#establish temp folder path
$tempPath = $env:temp, $packageName, $packageVersion -join "\"


#establish full path to local copy of downloaded zip file
$pathToZip = ($tempPath, $filename -join "\")


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
$pathToExe = Join-Path $tempPath (get-childitem $tempPath | where { $_.extension -eq ".exe" }).Name


# install package
Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$pathToExe" -validExitCodes $validExitCodes
