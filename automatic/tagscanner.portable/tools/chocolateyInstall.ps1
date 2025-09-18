$ErrorActionPreference = 'Stop'

$InstallPath = "$([Environment]::GetFolderPath('ApplicationData'))\\TagScanner Portable"

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    UnzipLocation  = $InstallPath
    url            = 'https://www.xdlab.ru/files/tagscan-6.1.20.zip'
    url64          = 'https://www.xdlab.ru/files/tagscan-6.1.20_x64.zip'
    checksum       = '1bb4bf042c2f5cf4316a089cb754e81c3dac82253c1a3f6510b64e8b786b917f'
    checksum64     = '888a8f228a36accf2f7793b991c0260d36cea5a3489405431b7a051c7fcd474d'
    checksumtype   = 'sha256'
    checksumtype64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$shortcutArgs = @{
    ShortcutFilePath = "$([Environment]::GetFolderPath('Desktop'))\\TagScanner Portable.lnk"
    TargetPath       = "$InstallPath\\Tagscan.exe"
}

Install-ChocolateyShortcut @shortcutArgs
