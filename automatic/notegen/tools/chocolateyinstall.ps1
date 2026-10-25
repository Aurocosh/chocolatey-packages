$ErrorActionPreference = 'Stop' # stop on all errors

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  softwareName   = 'NoteGen*'
  url64bit       = 'https://github.com/codexu/note-gen/releases/download/note-gen-v0.39.0/NoteGen_0.39.0_x64_en-US.msi'
  checksum64     = 'ea3cf1cb138c743addb59acf98199260a14ce230611186f963c16a12423bad33'
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'  # MSI
}

Install-ChocolateyPackage @packageArgs

