$ErrorActionPreference = "Stop"

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = "https://public-cdn.cloud.unity3d.com/hub/prod/4.0.1/UnityHubSetup-4.0.1-x64-msix-converter.exe"
$checksum64 = "eeb7f99330eb516d3e6b03191bb2e31cfff9add5c263042a8ad123ee8d559b90"

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
