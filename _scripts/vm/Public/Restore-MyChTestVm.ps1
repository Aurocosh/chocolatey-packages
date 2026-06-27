function Restore-MyChTestVm {
    param([string]$Snapshot)

    $vmName = Get-MyChTestVmName
    $snap = Get-MyChTestVmSnapshot -Snapshot $Snapshot
    Write-Host "Restoring checkpoint '$($snap.Name)' on VM '$vmName'..."
    Restore-VMSnapshot -VMSnapshot $snap -Confirm:$false | Out-Null
    Write-Host 'Checkpoint restored.'
}
