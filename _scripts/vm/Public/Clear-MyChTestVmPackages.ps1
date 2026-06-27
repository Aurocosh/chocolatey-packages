function Clear-MyChTestVmPackages {
    param([string]$Vagrant)

    $vagrantPath = Get-MyChVagrantPath -Vagrant $Vagrant
    $packagesDir = Join-Path $vagrantPath 'packages'
    if (-not (Test-Path -LiteralPath $packagesDir)) {
        throw "Packages directory not found: $packagesDir"
    }

    foreach ($pattern in @('*.nupkg', '*.xml')) {
        Get-ChildItem -LiteralPath $packagesDir -Filter $pattern -File -ErrorAction SilentlyContinue |
            ForEach-Object {
                try {
                    Remove-Item -LiteralPath $_.FullName -Force
                    Write-Host "Deleted file: $($_.FullName)"
                } catch {
                    Write-Warning "Failed to delete file: $($_.FullName). Error: $_"
                }
            }
    }
}
