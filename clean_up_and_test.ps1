Write-Host "Cleaning up" -ForegroundColor Green
& "$PSScriptRoot/clean_up.ps1"

Write-Host ""
Write-Host "Testing package" -ForegroundColor Green
Test-Package