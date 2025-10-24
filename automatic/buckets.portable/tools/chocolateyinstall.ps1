$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    PackageName     = $Env:ChocolateyPackageName
    Url             = 'https://github.com/buckets/application/releases/download/v0.75.0/Buckets-0.75.0.exe'
    Checksum        = '7D456008196EEB2BCF29665A0C3CBE4DF9539CC37808F9F3170D85F12A3B0571'
    ChecksumType    = 'sha256'
    FileFullPath    = Join-Path $toolsDir 'buckets.exe'
}

Get-ChocolateyWebFile @packageArgs
