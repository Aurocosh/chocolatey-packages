$packageArgs =@{
  packageName       = 'R.Studio'
  fileType          = 'EXE'
  silentArgs        = '/S'
  validExitCodes    = @(0)
  url64bit          = 'https://download1.rstudio.org/electron/windows/RStudio-2023.12.1-402.exe'
  checksumType64    = 'sha256'
  checksum64        = 'd3c03c42a42c9b5cd4f3d72a0cfc0859f0099b8199af842da762b0584ab4bea0'
  
}
Install-ChocolateyPackage @packageArgs