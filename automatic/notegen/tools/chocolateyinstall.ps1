$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'NoteGen*'
  url64bit       = 'https://github.com/codexu/note-gen/releases/download/note-gen-v0.40.0/NoteGen_0.40.0_x64_en-US.msi'
  checksum64     = 'e02aa0584fc622a6b9792f8857ce33b498e99615f697da0cd5be07eca75679d0'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

