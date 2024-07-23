$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'topgrade*'
  url64bit       = 'https://github.com/topgrade-rs/topgrade/releases/download/v15.0.0/topgrade-v15.0.0-x86_64-pc-windows-msvc.zip'
  checksum64     = 'e2f271fb1b6361c785c7d311483ea77739d4d5bfe73b7b694e76a0a6d08ec7ce'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# To work properly with Chocolatey we need to enable self renaming in the configuration. Otherwise choco will not be able to update the package when update is launched by topgrade.

# Paths for the configuration files
$topgradePrimaryConfig = "$env:APPDATA/topgrade.toml"
$topgradeSecondaryConfig = "$env:APPDATA/topgrade/topgrade.toml"
$defaultConfigFile = Join-Path $toolsDir 'topgrade.toml'

# Check if either of the configuration files exists
if (!((Test-Path $topgradePrimaryConfig) -or (Test-Path $topgradeSecondaryConfig))) {
  # Neither config file exists. Copy our default config file to the config location
  $destinationDir = Join-Path $env:APPDATA 'topgrade'
  if (!(Test-Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir
  }
  Copy-Item -Path $defaultConfigFile -Destination $topgradeSecondaryConfig
  Write-Output "Copied default config to $topgradeSecondaryConfig"
}
else {
  # At least one of the files exists. Perform regex replacement to uncomment the line "self_rename = true"
  $configFile = if (Test-Path $topgradePrimaryConfig) { $topgradePrimaryConfig } else { $topgradeSecondaryConfig }
  $content = Get-Content -Path $configFile -Raw

  # Regex to uncomment the line '# self_rename = true'
  $updatedContent = $content -replace '#\s*self_rename\s*=\s*true', 'self_rename = true'

  # Save the updated content back to the file
  Set-Content -Path $configFile -Value $updatedContent
  Write-Output "Updated $configFile to uncomment 'self_rename = true'"
}
