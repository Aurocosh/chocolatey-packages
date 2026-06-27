function Start-MyChTestVm {
    $vm = Get-MyChTestVm
    if ($vm.State -eq 'Running') {
        Write-Host "VM '$($vm.Name)' is already running."
        return
    }

    Write-Host "Starting VM '$($vm.Name)'..."
    Start-VM -VM $vm | Out-Null

    $deadline = (Get-Date).AddMinutes(10)
    while ((Get-Date) -lt $deadline) {
        $vm = Get-MyChTestVm
        if ($vm.State -eq 'Running') {
            Write-Host "VM '$($vm.Name)' is running."
            return
        }
        Start-Sleep -Seconds 2
    }
    throw "Timed out waiting for VM '$($vm.Name)' to reach Running state."
}
