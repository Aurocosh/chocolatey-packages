$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage 'InputDirector' 'https://inputdirector.com/downloads/InputDirector.v2.2.zip' $drop -Checksum dd3ffab3cea386a421deaf54dbbf8c175efe0eef0f33e1e759331870e6e6ff5f -ChecksumType SHA256
."$drop/InputDirector.v2.2.build164.Domain.Setup.exe" /S
