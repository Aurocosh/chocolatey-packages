$ErrorActionPreference = "Stop"

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup-x64.exe"
$checksum64 = "3a79e4a9407f0bc8614fd5fe23ab4222a8a5dbb3d32f7d5845f398283380d3b0"

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
