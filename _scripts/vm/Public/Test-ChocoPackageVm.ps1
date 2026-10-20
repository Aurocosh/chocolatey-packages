function Test-ChocoPackageVm {
    param(
        $Nu,
        [switch]$UninstallAfterInstall,
        [switch]$ShowOutput,
        [string]$Snapshot,
        [string]$Vagrant
    )

    $exitCode = 1
    $snap = Get-ChocoVmSnapshot -Snapshot $Snapshot
    $snapName = $snap.Name
    $restoredForTest = $false

    try {
        Stage-ChocoPackage -Nu $Nu -Vagrant $Vagrant
        Restore-ChocoVm -Snapshot $snapName
        $restoredForTest = $true
        Start-ChocoVm

        $remote = $script:GuestTestAllPackagesScript
        if ($UninstallAfterInstall) {
            $remote = '& "$env:USERPROFILE/TestAllPackages.ps1" -UninstallAfterInstall'
        }

        $exitCode = Invoke-ChocoVmScript -Script $remote -Vagrant $Vagrant -ShowOutput:$ShowOutput
        if ($null -eq $exitCode) { $exitCode = 0 }
        $exitCode = [int]$exitCode
    } finally {
        if ($restoredForTest) {
            Restore-ChocoVm -Snapshot $snapName
        }
        Clear-ChocoPackages -Vagrant $Vagrant
    }

    if ($exitCode -ne 0) {
        Write-Host "Test failed with exit code $exitCode" -ForegroundColor Red
    } else {
        Write-Host 'Test passed.' -ForegroundColor Green
    }

    return $exitCode
}
