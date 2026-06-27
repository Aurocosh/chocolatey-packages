function Test-MyChPackageVm {
    param(
        $Nu,
        [switch]$UninstallAfterInstall,
        [switch]$ShowOutput,
        [string]$Snapshot,
        [string]$Vagrant
    )

    $exitCode = 1
    $snap = Get-MyChTestVmSnapshot -Snapshot $Snapshot
    $snapName = $snap.Name
    $restoredForTest = $false

    try {
        Stage-MyChTestPackage -Nu $Nu -Vagrant $Vagrant
        Restore-MyChTestVm -Snapshot $snapName
        $restoredForTest = $true
        Start-MyChTestVm

        $remote = $script:GuestTestAllPackagesScript
        if ($UninstallAfterInstall) {
            $remote = '& "$env:USERPROFILE/TestAllPackages.ps1" -UninstallAfterInstall'
        }

        $exitCode = Invoke-MyChTestVmScript -Script $remote -Vagrant $Vagrant -ShowOutput:$ShowOutput
        if ($null -eq $exitCode) { $exitCode = 0 }
        $exitCode = [int]$exitCode
    } finally {
        if ($restoredForTest) {
            Restore-MyChTestVm -Snapshot $snapName
        }
        Clear-MyChTestVmPackages -Vagrant $Vagrant
        Clear-MyChPackageArtifacts
    }

    if ($exitCode -ne 0) {
        Write-Host "Test failed with exit code $exitCode" -ForegroundColor Red
    } else {
        Write-Host 'Test passed.' -ForegroundColor Green
    }

    return $exitCode
}
