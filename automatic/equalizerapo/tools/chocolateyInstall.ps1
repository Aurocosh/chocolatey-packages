$ErrorActionPreference = 'Stop';

$packageName = 'equalizerapo'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = 'https://sourceforge.net/projects/equalizerapo/files/1.3.2/EqualizerAPO32-1.3.2.exe/download'
  url64bit       = 'https://sourceforge.net/projects/equalizerapo/files/1.3.2/EqualizerAPO64-1.3.2.exe/download'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Equalizer APO*'
  checksum       = '580d8e5253a6610f8089d5a60597620c6ecb619f7bbb4d28ed75393342fbb708'
  checksumType   = 'sha256'
  checksum64     = '96a126e677b6d6f51b7d1407aa159b04e31d6dcf8b9d9dda49d0f00976e872ef'
  checksumType64 = 'sha256'
};

#Create monitor for "Configurator" ahead of actually installing the software
$ScriptBlock = {
  #Wait for Configurator.exe to start running
  $configurator_open = $false;
  while (!$configurator_open) {
    Start-Sleep -Seconds 5;
    $configurator_open = (Get-Process 'configurator' -ErrorAction:SilentlyContinue).count -eq 1;
  } #loop ends when we find the process running
  Get-Process 'configurator' | Stop-Process;
}

Start-Job -Name "Kill Configurator.exe" -ScriptBlock $ScriptBlock | Out-Null;
#Install the package
Install-ChocolateyPackage @packageArgs;
#Cleanup the Job
Remove-Job -Name "Kill Configurator.exe" -Force | Out-Null;
