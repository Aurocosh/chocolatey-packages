function Clear-ChocoPackages {
    param(
        [ValidateSet('All', 'Repo', 'VM')]
        [string]$Type = 'All',
        [string]$RepoRoot,
        [string]$Vagrant
    )

    if ($Type -eq 'All' -or $Type -eq 'Repo') {
        $root = if ($RepoRoot) {
            (Resolve-Path -LiteralPath $RepoRoot).Path
        } else {
            $script:ChocoPackagesRoot
        }

        $folderPaths = @(
            (Join-Path $root 'automatic'),
            (Join-Path $root 'manual')
        )

        foreach ($folderPath in $folderPaths) {
            if (-not (Test-Path -LiteralPath $folderPath)) { continue }

            Get-ChildItem -LiteralPath $folderPath -Recurse -File -Filter '*.nupkg' | ForEach-Object {
                try {
                    Remove-Item -LiteralPath $_.FullName -Force
                    Write-Host "Deleted file: $($_.FullName)"
                } catch {
                    Write-Warning "Failed to delete file: $($_.FullName). Error: $_"
                }
            }
        }
    }

    if ($Type -eq 'All' -or $Type -eq 'VM') {
        $vagrantPath = Get-ChocoVagrantPath -Vagrant $Vagrant
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
}
