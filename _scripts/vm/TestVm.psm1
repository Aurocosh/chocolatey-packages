#Requires -Version 5.1

$script:DefaultVmName = 'choco-test-vm'
$script:ChocoPackagesRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$script:WinRmPort = 55985
$script:GuestWinRmPort = 5985
$script:WinRmTarget = $null
$script:GuestTestAllPackagesScript = '& "$env:USERPROFILE/TestAllPackages.ps1"'

$privatePath = Join-Path $PSScriptRoot 'Private'
$publicPath = Join-Path $PSScriptRoot 'Public'

Get-ChildItem -LiteralPath $privatePath -Filter '*.ps1' -File | Sort-Object Name | ForEach-Object {
    . $_.FullName
}

Get-ChildItem -LiteralPath $publicPath -Filter '*.ps1' -File | Sort-Object Name | ForEach-Object {
    . $_.FullName
}

Export-ModuleMember -Function @(
    'Start-MyChTestVm',
    'Stop-MyChTestVm',
    'Connect-MyChTestVm',
    'Restore-MyChTestVm',
    'Stage-MyChTestPackage',
    'Start-MyChTestPackageManual',
    'Test-MyChPackageVm',
    'Clear-MyChPackageArtifacts',
    'Start-MyChTestPackageCleanUp',
    'Stop-MyChTestVmCleanUp'
)
