function Stop-MyChTestVm {
    param(
        [switch]$TurnOff,
        [switch]$Save
    )

    if ($TurnOff -and $Save) {
        throw 'Cannot use -TurnOff and -Save together.'
    }

    $vm = Get-MyChTestVm
    if ($vm.State -eq 'Off') {
        Write-Host "VM '$($vm.Name)' is already off."
        return
    }

    if ($TurnOff) {
        Write-Host "Turning off VM '$($vm.Name)'..."
        Stop-VM -VM $vm -TurnOff -Force | Out-Null
    } elseif ($Save) {
        Write-Host "Saving VM '$($vm.Name)'..."
        Stop-VM -VM $vm -Save | Out-Null
    } else {
        Write-Host "Shutting down VM '$($vm.Name)'..."
        Stop-VM -VM $vm | Out-Null
    }

    Write-Host "VM '$($vm.Name)' stopped."
}
