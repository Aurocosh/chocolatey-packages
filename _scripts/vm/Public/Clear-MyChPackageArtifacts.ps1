function Clear-MyChPackageArtifacts {
    param([string]$RepoRoot)

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
