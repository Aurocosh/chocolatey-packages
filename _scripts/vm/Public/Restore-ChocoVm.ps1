function Restore-ChocoVm {
    param([string]$Snapshot)

    $vmName = Get-ChocoVmName
    $snap = Get-ChocoVmSnapshot -Snapshot $Snapshot
    Write-Host "Restoring checkpoint '$($snap.Name)' on VM '$vmName'..."
    Restore-VMSnapshot -VMSnapshot $snap -Confirm:$false | Out-Null
    Write-Host 'Checkpoint restored.'
}
