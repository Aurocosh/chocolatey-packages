function Get-LatestBitbucketDownloads {
  param(
    [Parameter(Position = 0, mandatory = $true)]
    [string]$UserName,
    [Parameter(Position = 1, mandatory = $true)]
    [string]$RepoName,
    [string]$NameRegex,
    [Switch]$FirstOnly,
    [Switch]$NameOnly,
    [Switch]$UrlOnly
  )
  
  $bitbucketUrl = "https://api.bitbucket.org/2.0/repositories/$UserName/$RepoName/downloads"
  $response = Invoke-RestMethod -Uri $bitbucketUrl -Method Get

  $values = $response.values

  if($NameRegex){
    $values = $values | Where-Object name -Match $NameRegex
  }
  if($FirstOnly){
    $values = $values | Select-Object -First 1
  }

  if($NameOnly){
    return $values | Select-Object -expand name
  }
  if($UrlOnly){
    return $values | Select-Object -expand links | Select-Object -expand self | Select-Object -expand href
  }

  return $values
}
