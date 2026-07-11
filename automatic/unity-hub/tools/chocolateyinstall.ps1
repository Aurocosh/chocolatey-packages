$ErrorActionPreference = "Stop"

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup-x64.exe"
$checksum64 = "06d09ea17e7973ff9889e46b20ddc9b61221b6c3e9e722d69e34b508616f0497"

$installArgs = '/S'  # NSIS

$pp = Get-PackageParameters
if ($pp.InstallationPath) {
    $installArgs += " /D=$($pp.InstallationPath)"
    Write-Host "Param: installing to $($pp.InstallationPath)"
}

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = "EXE"
    url64bit       = $url64
    softwareName   = "Unity Hub"
    checksum64     = $checksum64
    checksumType64 = "sha256"
    silentArgs     = $installArgs
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
