function Stage-MyChTestPackage {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Vagrant
    )

    Clear-MyChPackageArtifacts
    Clear-MyChTestVmPackages -Vagrant $Vagrant
    
    $vagrantPath = Get-MyChVagrantPath -Vagrant $Vagrant
    $Nu = Resolve-MyChNupkg -Nu $Nu

    $packageName = $Nu.Name -replace '(\.\d+)+(-[^-]+)?\.nupkg$'
    $packageVersion = ($Nu.BaseName -replace [regex]::Escape($packageName)).Substring(1)

    Write-Host ''
    Write-Host 'Package info'
    Write-Host ('  Path:'.PadRight(15)) $Nu.FullName
    Write-Host ('  Name:'.PadRight(15)) $packageName
    Write-Host ('  Version:'.PadRight(15)) $packageVersion
    Write-Host ('  Vagrant:'.PadRight(15)) $vagrantPath

    $packagesDir = Join-Path $vagrantPath 'packages'
    if (-not (Test-Path -LiteralPath $packagesDir)) {
        throw "Packages directory not found: $packagesDir"
    }

    if (-not $NoClear) {
        Clear-MyChTestVmPackages -Vagrant $Vagrant
    }

    Copy-Item -LiteralPath $Nu.FullName -Destination $packagesDir -Force
    Write-Host "Copied to $packagesDir"
}
