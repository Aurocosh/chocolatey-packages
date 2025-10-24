$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName     = $Env:ChocolateyPackageName
    Url             = 'https://github.com/buckets/application/releases/download/v0.75.0/Buckets-Setup-0.75.0.exe'
    Checksum        = '68D66AABB167E4A33121041987B75401837D8A0D5336F31F1A9CC2CF876D17A1'
    ChecksumType    = 'sha256'
    FileType        = 'exe'
    silentArgs      = '/S'
    validExitCodes  = @(0)
}

Install-ChocolateyPackage @packageArgs
