$tempPath = Join-Path $env:temp $env:ChocolateyPackageName

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $tempPath
    softwareName   = 'Microsoft Keyboard Layout Creator*'
    url            = 'https://download.microsoft.com/download/6/f/5/6f5ce43a-e892-4fd1-b9a6-1a0cbb64e6e2/MSKLC.exe'
    checksum       = 'cd12a6b08066133dc4ad71bdcaccf1492e3d9a1de93cf84b7b2824309f0d7255'
    checksumType   = 'sha256'
    validExitCodes = @(0, 3010, 1641)
    silentArgs     = '/quiet /qn /norestart'  # MSI
    disableLogging = $true
}

Install-ChocolateyZipPackage @packageArgs

$installerFolder = Join-Path $tempPath "MSKLC"
$installerExe = Join-Path $installerFolder "MSKLC.msi"
$packageArgs.file = $installerExe
$packageArgs.fileType = 'msi'

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
