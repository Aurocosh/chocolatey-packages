$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Equalizer APO*'
  url            = 'https://sourceforge.net/projects/equalizerapo/files/1.4.1/EqualizerAPO-x86-1.4.1.exe/download'
  checksum       = '8d573bed17997baa1f696665211c15794381c97f8d28be843fe23c91723047e0'
  checksumType   = 'sha256'
  url64bit       = 'https://sourceforge.net/projects/equalizerapo/files/1.4.1/EqualizerAPO-x64-1.4.1.exe/download'
  checksum64     = '8793693663b17089063788235583d08a18016d20422b76ac39a6dc08dbc8ecb7'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
  silentArgs     = '/S'
}

#Create monitor for "DeviceSelector" ahead of actually installing the software
$DeviceSelectorScriptBlock = {
  #Wait for DeviceSelector.exe to start running
  $device_selector_open = $false;
  while (!$device_selector_open) {
    Start-Sleep -Seconds 5;
    $device_selector_open = (Get-Process 'DeviceSelector' -ErrorAction:SilentlyContinue).count -eq 1;
  } #loop ends when we find the process running
  Get-Process 'DeviceSelector' | Stop-Process;
}

#Create monitor for "Configurator" ahead of actually installing the software
$ConfiguratorScriptBlock = {
  #Wait for Configurator.exe to start running
  $configurator_open = $false;
  while (!$configurator_open) {
    Start-Sleep -Seconds 5;
    $configurator_open = (Get-Process 'configurator' -ErrorAction:SilentlyContinue).count -eq 1;
  } #loop ends when we find the process running
  Get-Process 'configurator' | Stop-Process;
}

Start-Job -Name "Kill DeviceSelector.exe" -ScriptBlock $DeviceSelectorScriptBlock | Out-Null;
Start-Job -Name "Kill Configurator.exe" -ScriptBlock $ConfiguratorScriptBlock | Out-Null;
#Install the package
Install-ChocolateyPackage @packageArgs;
#Cleanup the Job
Remove-Job -Name "Kill DeviceSelector.exe" -Force | Out-Null;
Remove-Job -Name "Kill Configurator.exe" -Force | Out-Null;
