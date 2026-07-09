function Get-LatestWingetPkgsRelease {
  param(
    [Parameter(Mandatory = $true)]
    [string]$ManifestPath,
    [Parameter(Mandatory = $true)]
    [string]$InstallerManifest,
    [Parameter(Mandatory = $true)]
    [string]$InstallerUrlRegex,
    [string]$VersionRegex,
    [string]$Branch = 'master',
    [double]$Buffered = 60
  )

  $cacheKey = @($ManifestPath, $InstallerManifest, $InstallerUrlRegex, $VersionRegex, $Branch) -join '|'
  $bufferFile = Get-LatestWingetPkgsReleaseBufferFile -CacheKey $cacheKey

  $cachedResult = Get-LatestWingetPkgsReleaseBuffered -BufferFile $bufferFile -BufferedMinutes $Buffered
  if ($null -ne $cachedResult) {
    return $cachedResult
  }

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

  $result = @{
    Url64      = $url64
    Version    = $version
    Checksum64 = $Matches[1].ToLower()
  }

  Save-LatestWingetPkgsReleaseBuffered -BufferFile $bufferFile -Result $result

  return $result
}

function Get-LatestWingetPkgsReleaseBufferFile {
  param(
    [Parameter(Mandatory = $true)]
    [string]$CacheKey
  )

  $bufferDir = Join-Path ([System.IO.Path]::GetTempPath()) 'Get-LatestWingetPkgsRelease-buffer'
  if (-not (Test-Path $bufferDir)) {
    New-Item -ItemType Directory -Path $bufferDir -Force | Out-Null
  }

  $hash = [BitConverter]::ToString(
    [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($CacheKey))
  ).Replace('-', '').ToLower()

  Join-Path $bufferDir "$hash.json"
}

function Get-LatestWingetPkgsReleaseBuffered {
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

    return @{
      Url64      = [string]$cached.Result.Url64
      Version    = [string]$cached.Result.Version
      Checksum64 = [string]$cached.Result.Checksum64
    }
  }
  catch {
    return $null
  }
}

function Save-LatestWingetPkgsReleaseBuffered {
  param(
    [Parameter(Mandatory = $true)]
    [string]$BufferFile,

    [Parameter(Mandatory = $true)]
    [hashtable]$Result
  )

  $cacheEntry = [ordered]@{
    BufferedAt = (Get-Date).ToString('o')
    Result     = [ordered]@{
      Url64      = $Result.Url64
      Version    = $Result.Version
      Checksum64 = $Result.Checksum64
    }
  }

  $json = $cacheEntry | ConvertTo-Json -Depth 3 -Compress
  [System.IO.File]::WriteAllText($BufferFile, $json, [System.Text.UTF8Encoding]::new($false))
}
