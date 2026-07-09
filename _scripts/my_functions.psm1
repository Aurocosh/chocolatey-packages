$funcs = @(
  'Get-LatestGithubRelease'
  'Get-LatestWingetPkgsRelease'
  'Get-LatestBitbucketDownloads'
  'Get-RedirectedUrl'
  'Get-NuspecMetadata'
  'Set-ReplaceMarkersInFile'
  'Invoke-WebRequestRetry'
  'Get-RemoteBufferedChecksum'
  'Update-NuspecMetadata'
)

. "$PSScriptRoot\BufferFileLock.ps1"

$funcs | ForEach-Object {
  if (Test-Path "$PSScriptRoot\$_.ps1") {
    . "$PSScriptRoot\$_.ps1"
    if (Get-Command $_ -ea 0) {
      Export-ModuleMember -Function $_
    }
  }
}
