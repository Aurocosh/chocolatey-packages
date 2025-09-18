$ErrorActionPreference = 'Stop'

try {
    Remove-Item "$([Environment]::GetFolderPath('ApplicationData'))\\TagScanner Portable" -recurse
} catch {
    Write-host("Package folder has already been removed by other means, skipping...")
}

try {
    Remove-Item "$([Environment]::GetFolderPath('Desktop'))\\TagScanner Portable.lnk"
} catch {
    Write-host("Desktop shortcut couldn't be removed, skipping...")
}