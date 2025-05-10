$ErrorActionPreference = 'Stop' # stop on all errors
$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $tempPath
    softwareName   = 'Russian - Phonetic - SI*'
    url            = 'https://github.com/Aurocosh/keyboard-layout-ru-si/releases/download/2.0.0/kl-ru-si-2.0.0-1.zip'
    checksum       = '534f84a2a51d71493c9489105473b9ba097e11371c9ab8b2c35950df8997165f'
    checksumType   = 'sha256'
    validExitCodes = @(0, 3010, 1641)
    silentArgs     = '/quiet /qn /norestart'  # MSI
    disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs.file = Join-Path $tempPath "Ru_SI_i386.msi"
$packageArgs.file64 = Join-Path $tempPath "Ru_SI_amd64.msi"
$packageArgs.fileType = 'msi'

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
