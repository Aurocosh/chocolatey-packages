$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    PackageName     = $Env:ChocolateyPackageName
    Url             = 'https://gitea.com/gitea/tea/releases/download/v0.9.2/tea-0.9.2-windows-386.exe'
    Checksum        = '89555C73716414CB8674BBDCFFE62151A02998B80BF1A54AAC68112551AF4707'
    ChecksumType    = 'sha256'
    Url64bit        = 'https://gitea.com/gitea/tea/releases/download/v0.9.2/tea-0.9.2-windows-amd64.exe'
    Checksum64      = '7DBBF98468BC829D26D887058F41EA4505CFDF9C7BFFAA6495AAA30B6FE866B1'
    ChecksumType64  = 'sha256'
    FileFullPath    = Join-Path $toolsDir 'tea.exe'
}

Get-ChocolateyWebFile @packageArgs
