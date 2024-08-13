$ErrorActionPreference = 'Stop';

$packageName = 'equalizerapo'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";
$installerType = 'EXE'
$url = 'http://sourceforge.net/projects/equalizerapo/files/1.2/EqualizerAPO32-1.2.exe/download';
$url64 = 'http://sourceforge.net/projects/equalizerapo/files/1.2/EqualizerAPO64-1.2.exe/download';

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  silentArgs    = '/S'
  validExitCodes= @(0)
  softwareName  = 'equalizerapo*'
  checksum      = '7A554CC24B8DE2710A06EFE0DB762E96DEDD352DDDC592189ECC669AE7059A41'
  checksumType  = 'sha256'
  checksum64      = '29DFF1BA1221939AA805182771FD17FA71AE05A54FA97FD4A3641A521BF19E1C'
  checksumType64  = 'sha256'
};

#Create monitor for "Configurator" ahead of actually installing the software
$ScriptBlock = {
    #Wait for Configurator.exe to start running
	$configurator_open = $false;
	while (!$configurator_open) {
		Sleep -Seconds 5;
		$configurator_open = (Get-Process 'configurator' -ErrorAction:SilentlyContinue).count -eq 1;
	} #loop ends when we find the process running
    Get-Process 'configurator' | Stop-Process;
}

Start-Job -Name "Kill Configurator.exe" -ScriptBlock $ScriptBlock | Out-Null;
#Install the package
Install-ChocolateyPackage @packageArgs;
#Cleanup the Job
Remove-Job -Name "Kill Configurator.exe" -Force | Out-Null;