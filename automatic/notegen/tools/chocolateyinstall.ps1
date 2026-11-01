$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'NoteGen*'
  url64bit       = 'https://github.com/codexu/note-gen/releases/download/note-gen-v0.39.2/NoteGen_0.39.2_x64_en-US.msi'
  checksum64     = 'eda5504c3bd327fb552c8ec248d9d5f7f53102276ff96ae169de002b07180045'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

