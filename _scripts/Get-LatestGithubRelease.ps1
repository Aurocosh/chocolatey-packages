function Get-LatestGithubRelease {
  param(
	[Parameter(Position=0,mandatory=$true)]
    [string]$GitUser,
	[Parameter(Position=1,mandatory=$true)]
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
  
  $githubUrl = "https://api.github.com/repos/$($GitUser)/$($RepoName)/releases";
  if ($UsePreRelease) {
    $githubUrl += "?per_page=1";
  }
  else {
    $githubUrl += "/latest";
  }
  
  $response = Invoke-RestMethod -Uri $githubUrl;
  $versionRegex = "((\d+)(\.\d+){0,3}(\-[a-z]+[0-9]+)?)$";
  $release = $response | Where-Object tag_name -Match $versionRegex | Select-Object -First 1;
  
  if (!$release) {
    return @{};
  }
  
  $version = $matches[1];

  $releaseData = @{
    Name         = $release.name
    Version      = $version
    IsPreRelease = $release.prerelease -eq "true"
  };
  
  if ($IncludeAssets) {
	  $releaseData["Assets"] = $release.assets;
  }
  if ($IncludeAssetUrls) {
	  $releaseData["AssetUrls"] = $release.assets | Select-Object -expand browser_download_url;
  }
  if ($IncludeReleaseUrl) {
	  $releaseData["ReleaseUrl"] = $release.html_url;
  }
  if ($IncludeReleaseBody) {
	  $releaseData["Body"] = $release.body;
  }
  
  if (![string]::IsNullOrEmpty($MainUrl32Regex)) {
	$releaseData["MainUrl32"] = ($release.assets | Where-Object name -match $MainUrl32Regex | Select-Object -First 1).browser_download_url;
  }
  if (![string]::IsNullOrEmpty($MainUrl64Regex)) {
	$releaseData["MainUrl64"] = ($release.assets | Where-Object name -match $MainUrl64Regex | Select-Object -First 1).browser_download_url;
  }
  
  if (![string]::IsNullOrEmpty($PortableUrl32Regex)) {
	$releaseData["PortableUrl32"] = ($release.assets | Where-Object name -match $PortableUrl32Regex | Select-Object -First 1).browser_download_url;
  }
  if (![string]::IsNullOrEmpty($PortableUrl64Regex)) {
	$releaseData["PortableUrl64"] = ($release.assets | Where-Object name -match $PortableUrl64Regex | Select-Object -First 1).browser_download_url;
  }
  return $releaseData;
}