Write-Host 'Clean up and manual package test' -ForegroundColor Green
Import-Module "$PSScriptRoot\_scripts\vm\TestVm.psm1" -Force
Start-MyChTestPackageCleanUp @args
