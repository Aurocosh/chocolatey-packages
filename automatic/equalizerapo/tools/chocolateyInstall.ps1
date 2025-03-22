$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Equalizer APO*'
  url            = 'https://sourceforge.net/projects/equalizerapo/files/1.4.2/EqualizerAPO-x86-1.4.2.exe/download'
  checksum       = '15bdaba028b8a7805e17805e4596c27ab240381b5d5044cf247fa80717341b35'
  checksumType   = 'sha256'
  url64bit       = 'https://sourceforge.net/projects/equalizerapo/files/1.4.2/EqualizerAPO-x64-1.4.2.exe/download'
  checksum64     = '7403be7427bbe1936a40dded082829b6e217fc4f5990fee5cba501f0ae055afa'
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
