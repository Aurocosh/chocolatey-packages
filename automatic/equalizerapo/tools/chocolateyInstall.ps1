$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Equalizer APO*'
  url            = 'https://sourceforge.net/projects/equalizerapo/files/1.4/EqualizerAPO32-1.4.exe/download'
  checksum       = '7da45cad07048eaaecd4fb2edcb7f534bef6035c63e3e20a6878816cf729ba4d'
  checksumType   = 'sha256'
  url64bit       = 'https://sourceforge.net/projects/equalizerapo/files/1.4/EqualizerAPO64-1.4.exe/download'
  checksum64     = '77374fb48cda6e8739732672bbe6fed90e2e4a0ceed0a4e460f193135485fe50'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
  silentArgs     = '/S'
}

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
