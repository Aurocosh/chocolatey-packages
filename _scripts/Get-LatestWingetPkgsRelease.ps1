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

  $headers = @{}
  if (Test-Path Env:\github_api_key) {
    $headers.Authorization = "token " + $env:github_api_key
  }

  $apiUrl = "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/$ManifestPath"
  $entries = @(Invoke-RestMethod -Uri $apiUrl -Headers $headers | Where-Object type -eq 'dir')

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
  $manifestUrl = "https://raw.githubusercontent.com/microsoft/winget-pkgs/$Branch/manifests/$ManifestPath/$version/$InstallerManifest"
  $response = Invoke-WebRequest -Uri $manifestUrl -UseBasicParsing

  if ($response.Content -notmatch $InstallerUrlRegex) {
    return @{}
  }
  $url64 = $Matches[1]

  if ($response.Content -notmatch 'InstallerSha256:\s*([a-fA-F0-9]{64})') {
    return @{}
  }

  @{
    Url64      = $url64
    Version    = $version
    Checksum64 = $Matches[1].ToLower()
  }
}
