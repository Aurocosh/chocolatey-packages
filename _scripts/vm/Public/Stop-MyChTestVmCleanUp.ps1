function Stop-MyChTestVmCleanUp {
    param(
        [switch]$TurnOff,
        [switch]$Save,
        [string]$RepoRoot
    )

    Stop-MyChTestVm -TurnOff:$TurnOff -Save:$Save
    Clear-MyChPackageArtifacts -RepoRoot $RepoRoot
}
