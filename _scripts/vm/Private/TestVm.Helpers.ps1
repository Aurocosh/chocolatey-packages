function Get-MyChTestVmName {
    if ($Env:au_TestVmName) { return $Env:au_TestVmName }
    return $script:DefaultVmName
}

function Get-MyChVagrantPath {
    param([string]$Vagrant)

    $path = if ($Vagrant) { $Vagrant } else { $Env:au_Vagrant }
    if (-not $path) {
        throw 'au_Vagrant is not set. Run init.ps1 in my-chocolatey-test-environment or set $Env:au_Vagrant.'
    }
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Vagrant path not found: $path"
    }
    return (Resolve-Path -LiteralPath $path).Path
}

function Get-MyChTestVm {
    $vmName = Get-MyChTestVmName
    $vm = Get-VM -Name $vmName -ErrorAction SilentlyContinue
    if (-not $vm) {
        throw "Hyper-V VM not found: $vmName. Run init.ps1 or check au_TestVmName."
    }
    return $vm
}

function Get-MyChTestVmSnapshot {
    param([string]$Snapshot)

    $vmName = Get-MyChTestVmName
    $name = if ($Snapshot) { $Snapshot } elseif ($Env:au_VmSnapshot) { $Env:au_VmSnapshot } else { $null }

    if ($name) {
        $snap = Get-VMSnapshot -VMName $vmName -Name $name -ErrorAction SilentlyContinue
        if (-not $snap) {
            throw "Checkpoint not found: '$name' on VM '$vmName'."
        }
        return $snap
    }

    $snaps = @(Get-VMSnapshot -VMName $vmName -ErrorAction SilentlyContinue | Sort-Object CreationTime -Descending)
    if ($snaps.Count -eq 0) {
        throw "No checkpoints found on VM '$vmName'. Create one with: Checkpoint-VM -VMName $vmName -Name good"
    }
    return $snaps[0]
}

function Resolve-MyChNupkg {
    param($Nu)

    if (-not $Nu) {
        $dir = Get-Item -LiteralPath $PWD
    } else {
        if (-not (Test-Path -LiteralPath $Nu)) { throw "Path not found: $Nu" }
        $Nu = Get-Item -LiteralPath $Nu
        if ($Nu.PSIsContainer) {
            $dir = $Nu
            $Nu = $null
        } else {
            $dir = $Nu.Directory
        }
    }

    if (-not $Nu) {
        $Nu = Get-ChildItem -LiteralPath $dir.FullName -Filter '*.nupkg' -File |
            Sort-Object CreationTime -Descending |
            Select-Object -First 1
        if (-not $Nu) {
            $Nu = Get-ChildItem -LiteralPath $dir.FullName -Filter '*.nuspec' -File | Select-Object -First 1
        }
        if (-not $Nu) {
            throw @"
Can't find nupkg or nuspec file in the directory: $($dir.FullName)
Run from a package folder (e.g. automatic\<id>) or pass -Nu with a path to a .nupkg, .nuspec, or package directory.
"@
        }
    }

    if ($Nu.Extension -eq '.nuspec') {
        Write-Host 'Nuspec file given, running choco pack'
        & choco pack -r $Nu.FullName --OutputDirectory $Nu.DirectoryName
        if ($LASTEXITCODE -ne 0) { throw "choco pack failed with exit code $LASTEXITCODE" }
        $Nu = Get-ChildItem -LiteralPath $Nu.DirectoryName -Filter '*.nupkg' -File |
            Sort-Object CreationTime -Descending |
            Select-Object -First 1
        if (-not $Nu) { throw 'choco pack did not produce a nupkg file' }
    } elseif ($Nu.Extension -ne '.nupkg') {
        throw 'File is not nupkg or nuspec file'
    }

    return $Nu
}
