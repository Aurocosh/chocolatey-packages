$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)

$addToDesktop = $false
$noStartMenu = $false
$purgeConfig = $false

$pp = Get-PackageParameters

if ($pp.count -gt 0) {
  $pp.GetEnumerator() | foreach-object {
    switch ($_.name) {
      'AddToDesktop' {
        Write-Verbose('A shortcut for the Nekoray will be created on the desktop')
        $addToDesktop = $true
      }
      'NoStartMenu' {
        Write-Verbose('The start menu shortcut for Nekoray will not be created')
        $noStartMenu = $true
      }
      'PurgeConfig' {
        Write-Verbose('Removes all existing config files')
        $purgeConfig = $true
      }
      Default {
        Write-Verbose("Unknown parameter $_ will be ignored")
      }
    }
  }
}
else {
  Write-Verbose('No parameters supplied - using default')
}

$installPath = Join-Path $packagePath 'nekoray'

if ($purgeConfig) {
  Write-Verbose("Removing old configuration")
  Remove-Item -Path $installPath -Force -Recurse -ErrorAction SilentlyContinue
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $packagePath
  softwareName   = 'nekoray*'
  url64bit       = 'https://github.com/MatsuriDayo/nekoray/releases/download/3.26/nekoray-3.26-2023-12-09-windows64.zip'
  checksum64     = 'f33da7548192220486fd082cd6b533d37b909d3b37c4b1ac2738640f9a25ac1b'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$exeFile = Join-Path $installPath 'nekoray.exe'

if ($addToDesktop) {
  Write-Verbose("Added desktop shortcut: Nekoray")
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Nekoray.lnk" -TargetPath $exeFile -IconLocation $exeFile
}

if (-not $noStartMenu) {
  Write-Verbose("Added start menu shortcut: Nekoray")
  Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Nekoray.lnk" -TargetPath $exeFile -IconLocation $exeFile
}
