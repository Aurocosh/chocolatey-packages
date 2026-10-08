$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'NoteGen*'
  url64bit       = 'https://github.com/codexu/note-gen/releases/download/note-gen-v0.38.1/NoteGen_0.38.1_x64-setup.exe'
  checksum64     = 'be53911a8d47e09494c82149bd594612a2b04aaf5938cc0fcefbb9940e49aafb'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

