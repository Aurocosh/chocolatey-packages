. "$PSScriptRoot\BufferFileLock.ps1"

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
    [string]$AassetRegexParameter = 'browser_download_url',
    [double]$Buffered
  )

  $freshParams = @{
    GitUser              = $GitUser
    RepoName             = $RepoName
    UsePreRelease        = $UsePreRelease
    IncludeAssets        = $IncludeAssets
    IncludeAssetUrls     = $IncludeAssetUrls
    IncludeReleaseUrl    = $IncludeReleaseUrl
    IncludeReleaseBody   = $IncludeReleaseBody
    MainUrl32Regex       = $MainUrl32Regex
    MainUrl64Regex       = $MainUrl64Regex
    PortableUrl32Regex   = $PortableUrl32Regex
    PortableUrl64Regex   = $PortableUrl64Regex
    VersionRegex         = $VersionRegex
    AassetRegexParameter = $AassetRegexParameter
  }

  if (-not $PSBoundParameters.ContainsKey('Buffered')) {
    return Get-LatestGithubReleaseFresh @freshParams
  }

  $cacheKey = @(
    $GitUser,
    $RepoName,
    [bool]$UsePreRelease,
    [bool]$IncludeAssets,
    [bool]$IncludeAssetUrls,
    [bool]$IncludeReleaseUrl,
    [bool]$IncludeReleaseBody,
    $MainUrl32Regex,
    $MainUrl64Regex,
    $PortableUrl32Regex,
    $PortableUrl64Regex,
    $VersionRegex,
    $AassetRegexParameter
  ) -join '|'

  $bufferFile = Get-LatestGithubReleaseBufferFile -CacheKey $cacheKey

  return Invoke-BufferedCacheLookup `
    -BufferFile $bufferFile `
    -TryGetCached {
      Get-LatestGithubReleaseBuffered -BufferFile $bufferFile -BufferedMinutes $Buffered
    } `
    -FetchFresh {
      Get-LatestGithubReleaseFresh @freshParams
    } `
    -SaveCached {
      param($Result)

      if ($Result.Version) {
        Save-LatestGithubReleaseBuffered -BufferFile $bufferFile -Result $Result
      }
    }
}

function Get-LatestGithubReleaseFresh {
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

  if (!$VersionRegex) {
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
  if ($betaPart) {
    $version += "-" + $betaPart
  }

  $releaseData = @{
    Name         = $release.name
    ReleaseUrl   = $release.html_url
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

function Get-LatestGithubReleaseBufferFile {
  param(
    [Parameter(Mandatory = $true)]
    [string]$CacheKey
  )

  $bufferDir = Join-Path ([System.IO.Path]::GetTempPath()) 'Get-LatestGithubRelease-buffer'
  if (-not (Test-Path $bufferDir)) {
    New-Item -ItemType Directory -Path $bufferDir -Force | Out-Null
  }

  $hash = [BitConverter]::ToString(
    [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($CacheKey))
  ).Replace('-', '').ToLower()

  Join-Path $bufferDir "$hash.json"
}

function Get-LatestGithubReleaseBuffered {
  param(
    [Parameter(Mandatory = $true)]
    [string]$BufferFile,

    [Parameter(Mandatory = $true)]
    [double]$BufferedMinutes
  )

  if (-not (Test-Path $BufferFile)) {
    return $null
  }

  try {
    $cached = Get-Content -Path $BufferFile -Raw -Encoding UTF8 | ConvertFrom-Json
    $bufferedAt = [datetime]$cached.BufferedAt

    if ((Get-Date) -gt $bufferedAt.AddMinutes($BufferedMinutes)) {
      return $null
    }

    return ConvertFrom-GetLatestGithubReleaseCachedResult -InputObject ($cached.ResultJson | ConvertFrom-Json)
  }
  catch {
    return $null
  }
}

function Save-LatestGithubReleaseBuffered {
  param(
    [Parameter(Mandatory = $true)]
    [string]$BufferFile,

    [Parameter(Mandatory = $true)]
    [hashtable]$Result
  )

  $cacheEntry = [ordered]@{
    BufferedAt = (Get-Date).ToString('o')
    ResultJson = ($Result | ConvertTo-Json -Depth 10 -Compress)
  }

  $json = $cacheEntry | ConvertTo-Json -Depth 10 -Compress
  [System.IO.File]::WriteAllText($BufferFile, $json, [System.Text.UTF8Encoding]::new($false))
}

function ConvertFrom-GetLatestGithubReleaseCachedResult {
  param(
    [Parameter(Mandatory = $true)]
    $InputObject
  )

  if ($null -eq $InputObject) {
    return @{}
  }

  if ($InputObject -is [hashtable]) {
    return $InputObject
  }

  $result = @{}
  foreach ($property in $InputObject.PSObject.Properties) {
    $value = $property.Value

    if ($value -is [System.Management.Automation.PSCustomObject]) {
      $result[$property.Name] = ConvertFrom-GetLatestGithubReleaseCachedResult -InputObject $value
    }
    elseif ($null -ne $value -and $value.GetType().IsArray) {
      $result[$property.Name] = @(
        foreach ($item in $value) {
          if ($item -is [System.Management.Automation.PSCustomObject]) {
            ConvertFrom-GetLatestGithubReleaseCachedResult -InputObject $item
          }
          else {
            $item
          }
        }
      )
    }
    else {
      $result[$property.Name] = $value
    }
  }

  return $result
}
