$ErrorActionPreference = 'Stop';

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    UnzipLocation  = "$(Split-Path $MyInvocation.MyCommand.Definition)"
    url            = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.12/librespeed-cli_1.0.12_windows_386.zip'
    url64          = 'https://github.com/librespeed/speedtest-cli/releases/download/v1.0.12/librespeed-cli_1.0.12_windows_amd64.zip'
    checksum       = '8d77d44169725722b52c6fb63758310c258894b1ea3778ef3ee9cf2efe4c1967'
    checksum64     = '10d22d509bc4d99af7b78683e0018593c53a627b2be860a5cd661ca443a4071f'
    checksumtype   = 'sha256'
    checksumtype64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
