function Get-LatestGithubRelease {
  param(
    [Parameter(Position = 0, mandatory = $true)]
    [string]$GitUser,
    [Parameter(Position = 1, mandatory = $true)]
    [string]$RepoName,
    [Switch]$UsePreRelease,
    [Switch]$IncludeAssets,
    [Switch]$IncludeAssetUrls,
    [Switch]$IncludeReleaseUrl,
    [Switch]$IncludeReleaseBody,
    [string]$MainUrl32Regex,
    [string]$MainUrl64Regex,
    [string]$PortableUrl32Regex,
    [string]$PortableUrl64Regex
  )
  
  $githubUrl = "https://api.github.com/repos/$($GitUser)/$($RepoName)/releases"
  if ($UsePreRelease) {
    $githubUrl += "?per_page=1"
  }
  else {
    $githubUrl += "/latest"
  }
  
  $headers = @{}
  if (Test-Path Env:\github_api_key) {
    $headers.Authorization = "token " + $env:github_api_key
  }

  $response = Invoke-RestMethod -Uri $githubUrl -Headers $headers
  $versionRegex = "(\d+(?:\.\d+){0,3})(?:\-([a-z]+)\.?([0-9]+)?)?$"
  $release = $response | Where-Object tag_name -Match $versionRegex | Select-Object -First 1
  
  if (!$release) {
    return @{};
  }
  
  $version = Get-ProcessDetectedTagVersion $matches[1] $matches[2] $matches[3]

  $releaseData = @{
    Name         = $release.name
    Version      = $version
    IsPreRelease = $release.prerelease -eq "true"
  };
  
  if ($IncludeAssets) {
    $releaseData["Assets"] = $release.assets;
  }
  if ($IncludeAssetUrls) {
    $releaseData["AssetUrls"] = $release.assets | Select-Object -expand browser_download_url
  }
  if ($IncludeReleaseUrl) {
    $releaseData["ReleaseUrl"] = $release.html_url
  }
  if ($IncludeReleaseBody) {
    $releaseData["Body"] = $release.body
  }
  
  if ($MainUrl32Regex) {
    $releaseData["MainUrl32"] = ($release.assets | Where-Object name -match $MainUrl32Regex | Select-Object -First 1).browser_download_url
  }
  if ($MainUrl64Regex) {
    $releaseData["MainUrl64"] = ($release.assets | Where-Object name -match $MainUrl64Regex | Select-Object -First 1).browser_download_url
  }
  
  if ($PortableUrl32Regex) {
    $releaseData["PortableUrl32"] = ($release.assets | Where-Object name -match $PortableUrl32Regex | Select-Object -First 1).browser_download_url
  }
  if ($PortableUrl64Regex) {
    $releaseData["PortableUrl64"] = ($release.assets | Where-Object name -match $PortableUrl64Regex | Select-Object -First 1).browser_download_url
  }
  return $releaseData
}

function Get-ProcessDetectedTagVersion {
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Version,

    [Parameter(Mandatory = $false, Position = 1)]
    [string]$ReleaseType,

    [Parameter(Mandatory = $false, Position = 2)]
    [string]$ReleaseVersion
  )

  if ($ReleaseVersion) {
    $Version = "$Version.$ReleaseVersion"
  }

  if ($ReleaseType) {
    if ($ReleaseType -match "(?i)(a|alpha)") {
      $Version = "$Version-alpha"
      Write-Host "Alpha version"
    }
    elseif ($ReleaseType -and $ReleaseType -match "(?i)(b|beta)") {
      $Version = "$Version-beta"
      Write-Host $release.Version
      Write-Host "Beta version"
    }
    else {
      $Version = "$Version-$ReleaseType"
    }
  }

  $Version
}
