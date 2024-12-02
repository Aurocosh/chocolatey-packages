$funcs = @(
  'Get-LatestGithubRelease'
  'Get-RedirectedUrl'
  'Set-ReplaceMarkersInFile'
)

$funcs | ForEach-Object {
  if (Test-Path "$PSScriptRoot\$_.ps1") {
    . "$PSScriptRoot\$_.ps1"
    if (Get-Command $_ -ea 0) {
      Export-ModuleMember -Function $_
    }
  }
}
