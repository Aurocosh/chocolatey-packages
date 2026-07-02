$ErrorActionPreference = "Stop"

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = "https://public-cdn.cloud.unity3d.com/hub/prod/UnityHubSetup-x64.exe"
$checksum64 = "efeee9301e162f140bcdf46e8d622db137dcd8887056a728e2d58d0644896626"

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
