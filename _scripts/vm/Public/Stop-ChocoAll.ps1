function Stop-ChocoAll {
    param(
        [switch]$TurnOff,
        [switch]$Save,
        [string]$RepoRoot,
        [string]$Vagrant
    )

    Stop-ChocoVm -TurnOff:$TurnOff -Save:$Save
    Clear-ChocoPackages -Type All -RepoRoot $RepoRoot -Vagrant $Vagrant
}
