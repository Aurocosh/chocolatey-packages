Remove-Item -Path "$env:ALLUSERSPROFILE\Desktop\EasyAutoClicker.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\EasyAutoClicker.lnk" -ErrorAction SilentlyContinue

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$exeFile = Join-Path $packagePath 'EACLib'
Remove-Item -Path $exeFile -Force -Recurse -ErrorAction SilentlyContinue 