function Get-LatestWingetPkgsRelease {
  param(
    [Parameter(Mandatory = $true)]
    [string]$ManifestPath,
    [Parameter(Mandatory = $true)]
    [string]$InstallerManifest,
    [Parameter(Mandatory = $true)]
    [string]$InstallerUrlRegex,
    [string]$VersionRegex,
    [string]$Branch = 'master'
  )

  $apiHeaders = @{}
  if ($env:github_api_key) {
    $apiHeaders.Authorization = "token " + $env:github_api_key
  }

  $apiUrl = "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/$ManifestPath"
  $apiResponse = Invoke-RestMethod -Uri $apiUrl -Headers $apiHeaders
  $entries = @($apiResponse | Where-Object type -eq 'dir')

  $candidates = if ($VersionRegex) {
    $entries | Where-Object name -match $VersionRegex
  }
  else {
    $entries
  }

  $versionEntry = $candidates | Sort-Object { [version]$_.name } -Descending | Select-Object -First 1
  if (-not $versionEntry) {
    return @{}
  }

  $version = $versionEntry.name
  $manifestHeaders = @{ Accept = 'application/vnd.github.raw' }
  if ($env:github_api_key) {
    $manifestHeaders.Authorization = "token " + $env:github_api_key
  }

  $manifestUrl = "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/$ManifestPath/$version/$InstallerManifest"
  $manifestContent = Invoke-RestMethod -Uri $manifestUrl -Headers $manifestHeaders

  if ($manifestContent -notmatch $InstallerUrlRegex) {
    return @{}
  }
  $url64 = $Matches[1]

  if ($manifestContent -notmatch 'InstallerSha256:\s*([a-fA-F0-9]{64})') {
    return @{}
  }

  @{
    Url64      = $url64
    Version    = $version
    Checksum64 = $Matches[1].ToLower()
  }
}
