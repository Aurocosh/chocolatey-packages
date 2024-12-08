$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'
$exeFile = Join-Path $installPath 'proxychecker.exe'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'Proxy Checker*'
  url            = 'https://files.vovsoft.com/proxy-checker-portable.zip?v=1.3'
  checksum       = 'cfd7ef1a3df6d90ea064935687dbb057fdfc0d9c78890e2212b923430d011cfb'
  checksumType = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -ShortcutFilePath "$env:ALLUSERSPROFILE\Desktop\Proxy Checker.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
Install-ChocolateyShortcut -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Proxy Checker.lnk" -TargetPath $exeFile -WorkingDirectory $packagePath
