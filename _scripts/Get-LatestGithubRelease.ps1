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
    [string]$PortableUrl64Regex,
    [string]$VersionRegex,
		[ValidateSet('browser_download_url', 'name', 'label')]
		[string]$AassetRegexParameter = 'browser_download_url'
  )
  
  $githubUrl = "https://api.github.com/repos/$($GitUser)/$($RepoName)/releases"

  if(!$VersionRegex)
  {
    $VersionRegex = "(\d+(?:\.\d+){0,3})\-?([a-z]+\.?(?:[0-9]+)?)?$"

    if ($UsePreRelease) {
      $githubUrl += "?per_page=1"
    }
    else {
      $githubUrl += "/latest"
    }
  }

  $headers = @{}
  if (Test-Path Env:\github_api_key) {
    $headers.Authorization = "token " + $env:github_api_key
  }

  $response = Invoke-RestMethod -Uri $githubUrl -Headers $headers
  $release = $response | Where-Object tag_name -Match $VersionRegex | Select-Object -First 1
  
  if (!$release) {
    return @{};
  }

  $version = $matches[1]
  $betaPart = $matches[2] -replace "\.", ""
  if($betaPart){
    $version += "-" + $betaPart
  }

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
    $asset = $release.assets | Where-Object $AassetRegexParameter -match $MainUrl32Regex | Select-Object -First 1
    $releaseData["MainUrl32"] = $asset.browser_download_url
    $remoteSha = $asset.digest -replace "^sha256:"
    $requireShaMain32 = [string]::IsNullOrEmpty($remoteSha)
    if ($remoteSha) {
      $releaseData["MainUrl32_Sha256"] = $remoteSha
    }
  }
  if ($MainUrl64Regex) {
    $asset = $release.assets | Where-Object $AassetRegexParameter -match $MainUrl64Regex | Select-Object -First 1
    $releaseData["MainUrl64"] = $asset.browser_download_url
    $remoteSha = $asset.digest -replace "^sha256:"
    $requireShaMain64 = [string]::IsNullOrEmpty($remoteSha)
    if ($remoteSha) {
      $releaseData["MainUrl64_Sha256"] = $remoteSha
    }
  }
  
  if ($PortableUrl32Regex) {
    $asset = $release.assets | Where-Object $AassetRegexParameter -match $PortableUrl32Regex | Select-Object -First 1
    $releaseData["PortableUrl32"] = $asset.browser_download_url
    $remoteSha = $asset.digest -replace "^sha256:"
    $requireShaPortable32 = [string]::IsNullOrEmpty($remoteSha)
    if ($remoteSha) {
      $releaseData["PortableUrl32_Sha256"] = $remoteSha
    }
  }
  if ($PortableUrl64Regex) {
    $asset = $release.assets | Where-Object $AassetRegexParameter -match $PortableUrl64Regex | Select-Object -First 1
    $releaseData["PortableUrl64"] = $asset.browser_download_url
    $remoteSha = $asset.digest -replace "^sha256:"
    $requireShaPortable64 = [string]::IsNullOrEmpty($remoteSha)
    if ($remoteSha) {
      $releaseData["PortableUrl64_Sha256"] = $remoteSha
    }
  }

  $requireShaFor32 = $requireShaMain32 -or $requireShaPortable32
  $requireShaFor64 = $requireShaMain64 -or $requireShaPortable64

  $chocoChecksumFor = 'none'
  if ($requireShaFor32 -and $requireShaFor64) {
    $chocoChecksumFor = 'all'
  }
  elseif ($requireShaFor32) {
    $chocoChecksumFor = '32'
  }
  elseif ($requireShaFor64) {
    $chocoChecksumFor = '64'
  }
  
  $releaseData["ChocoChecksumFor"] = $chocoChecksumFor
  return $releaseData
}
