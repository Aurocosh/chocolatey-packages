function Connect-MyChTestVm {
    $vmName = Get-MyChTestVmName
    $existing = Get-Process -Name vmconnect -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Verbose 'vmconnect process already running; opening another window.'
    }
    Start-Process -FilePath 'vmconnect.exe' -ArgumentList 'localhost', $vmName
}
