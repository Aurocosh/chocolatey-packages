$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'NoteGen*'
  url64bit       = 'https://github.com/codexu/note-gen/releases/download/note-gen-v0.38.0/NoteGen_0.38.0_x64-setup.exe'
  checksum64     = '6650d9603bb005995e4679aa6d2c6f43eacc9e4e14913efe316e825f93bcd2d2'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/S'  # NSIS
}

Install-ChocolateyPackage @packageArgs

