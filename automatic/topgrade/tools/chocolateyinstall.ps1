$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packagePath = $(Split-Path -parent $toolsDir)
$installPath = Join-Path $packagePath 'files'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $installPath
  softwareName   = 'topgrade*'
  url64bit       = 'https://github.com/topgrade-rs/topgrade/releases/download/v16.6.1/topgrade-v16.6.1-x86_64-pc-windows-msvc.zip'
  checksum64     = '5493891a9945d6c45d1270a6ab787b71381847e36f51dadb45b2109ac37e441d'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# To work properly with Chocolatey we need to enable the self renaming feature in the configuration. Otherwise choco will not be able to update the package when update is launched by topgrade.

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

  if (!$content) {
    # If config exists, but empty then simply overwrite it with default config
    Copy-Item -Path $defaultConfigFile -Destination $topgradeSecondaryConfig -Force
  }
  else {
    # Regex to uncomment the line '# self_rename = true'
    $updatedContent = $content -replace '#\s*self_rename\s*=\s*true', 'self_rename = true'
  
    # Check if `self_rename = true` line now exists in the updated content
    if ($updatedContent -notmatch 'self_rename\s*=\s*true') {
      # Ensure `[windows]` section exists
      if ($updatedContent -notmatch '\[windows\]') {
        $updatedContent += "`n[windows]"
      }

      # Add `self_rename = true` line after `[windows]`
      $updatedContent = $updatedContent -replace '(\[windows\])', "`$1`nself_rename = true"
    }

    # Save the updated content back to the file
    Set-Content -Path $configFile -Value $updatedContent
    Write-Output "Updated $configFile to ensure that line 'self_rename = true' exists and is uncommented"
  }
}
