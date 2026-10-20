function Start-ChocoManualTest {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Snapshot,
        [switch]$NoConnect,
        [string]$Vagrant
    )

    Stage-ChocoPackage -Nu $Nu -NoClear:$NoClear -Vagrant $Vagrant
    Restore-ChocoVm -Snapshot $Snapshot
    Start-ChocoVm
    if (-not $NoConnect) {
        Connect-ChocoVm
    }

    Write-Host ''
    Write-Host 'Package staged. In the guest, run:' -ForegroundColor Cyan
    Write-Host '  ~\TestAllPackages.ps1'
    Write-Host '  ~\TestAllPackages.ps1 -UninstallAfterInstall'
}
