$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'NoteGen*'
  url64bit       = 'https://github.com/codexu/note-gen/releases/download/note-gen-v0.39.1/NoteGen_0.39.1_x64_en-US.msi'
  checksum64     = '2288ab77a6916479c75852e3712fb141de12608977f81fff76759dd3d1b75bd9'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

