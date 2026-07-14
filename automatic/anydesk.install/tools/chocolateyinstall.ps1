$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://download.anydesk.com/AnyDesk.exe'
$checksum32   = '46872febd9684df716d392b457aef6611ae7b8716d2ece6bca30fb97271bce1d'
$pp           = Get-PackageParameters
$fileFullPath = (Join-Path $toolsDir 'AnyDesk.exe')
$defaultInstallDir = Join-Path ([Environment]::GetFolderPath('ProgramFilesX86')) 'AnyDesk'

$downloadArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url32
  softwareName  = 'AnyDesk'
  checksum      = $checksum32
  checksumType  = 'sha256'
  fileFullPath  = $fileFullPath
  ForceDownload = $true
}

Get-ChocolateyWebFile @downloadArgs

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = ' '
  file           = $fileFullPath
  validExitCodes = @(0)
}

$silentArgs = ' --install '

if ($pp['path']) {
  $silentArgs = $silentArgs + ' ' + $pp['path'] + ' '
} else {
  $silentArgs = $silentArgs + ' "' + $defaultInstallDir + '" '
}

if (!$pp['noautostart']) {
  $silentArgs = $silentArgs + ' --start-with-win '
}

$silentArgs = $silentArgs + ' --silent --remove-first '

if (!$pp['nostartmenu']) {
  $silentArgs = $silentArgs + ' --create-shortcuts '
}

if ($pp['desktopicon']) {
  $silentArgs = $silentArgs + ' --create-desktop-icon '
}

if ((!$pp['updatetype']) -or ($pp['updatetype'] -ieq 'disabled')) {
  $silentArgs = $silentArgs + ' --update-disabled'
} elseif ($pp['updatetype'] -ieq 'manually') {
  $silentArgs = $silentArgs + ' --update-manually'
} elseif ($pp['updatetype'] -ieq 'auto') {
  $silentArgs = $silentArgs + ' --update-auto'
}

$installArgs['silentArgs'] = $silentArgs

Install-ChocolateyInstallPackage @installArgs
