function Connect-MyChTestVm {
    $vmName = Get-MyChTestVmName
    $existing = (Get-Process | Where-Object {  $_.Name -match 'vmconnect' -and $_.MainWindowTitle  -match "^$vmName on .* - Virtual Machine Connection" }).Count -gt 0
    if ($existing) {
        Write-Verbose 'Test environment VM connection already open'
    }
    else {
        Start-Process -FilePath 'vmconnect.exe' -ArgumentList 'localhost', $vmName
    }
}
