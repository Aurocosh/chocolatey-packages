$ErrorActionPreference = "Stop"

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = "https://public-cdn.cloud.unity3d.com/hub/prod/3.21.0/UnityHubSetup-3.21.0-x64.exe"
$checksum64 = "9e418bdfae1d5a6c279cd9dd327af4bc80d5b8b6a75f9a745c5174146221cdd8"

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
