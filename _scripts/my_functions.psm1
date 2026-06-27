$funcs = @(
  'Get-LatestGithubRelease'
  'Get-LatestBitbucketDownloads'
  'Get-RedirectedUrl'
  'Get-NuspecMetadata'
  'Set-ReplaceMarkersInFile'
  'Invoke-WebRequestRetry'
  'Update-NuspecMetadata'
)

$funcs | ForEach-Object {
  if (Test-Path "$PSScriptRoot\$_.ps1") {
    . "$PSScriptRoot\$_.ps1"
    if (Get-Command $_ -ea 0) {
      Export-ModuleMember -Function $_
    }
  }
}
