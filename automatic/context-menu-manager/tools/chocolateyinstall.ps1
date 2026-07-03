$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'ContextMenuManager.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = $exeFile
  softwareName   = 'ContextMenuManager*'
  url            = 'https://github.com/BluePointLilac/ContextMenuManager/releases/download/3.3.3.1/ContextMenuManager.NET.3.5.exe'
  checksum       = '31ddf9a0738103f0a11c4826f4e385750445ffb8b6a19503d29ee6c3e5157072'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\ContextMenuManager.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\ContextMenuManager.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
