function Start-MyChTestPackageCleanUp {
    param(
        $Nu,
        [switch]$NoClear,
        [string]$Snapshot,
        [switch]$NoConnect,
        [string]$Vagrant
    )

    Clear-MyChPackageArtifacts
    Start-MyChTestPackageManual -Nu $Nu -NoClear:$NoClear -Snapshot $Snapshot -NoConnect:$NoConnect -Vagrant $Vagrant
}
