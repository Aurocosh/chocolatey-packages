function Start-MyChTestPackageManual {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Snapshot,
        [switch]$NoConnect,
        [string]$Vagrant
    )

    Stage-MyChTestPackage -Nu $Nu -NoClear:$NoClear -Vagrant $Vagrant
    Restore-MyChTestVm -Snapshot $Snapshot
    Start-MyChTestVm
    if (-not $NoConnect) {
        Connect-MyChTestVm
    }

    Write-Host ''
    Write-Host 'Package staged. In the guest, run:' -ForegroundColor Cyan
    Write-Host '  ~\TestAllPackages.ps1'
    Write-Host '  ~\TestAllPackages.ps1 -UninstallAfterInstall'
}
