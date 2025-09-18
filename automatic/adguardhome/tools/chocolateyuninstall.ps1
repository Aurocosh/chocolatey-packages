$ErrorActionPreference = 'SilentlyContinue';

adguardhome -s stop
adguardhome -s uninstall
Uninstall-BinFile -Name 'adguardhome'

try {
    Remove-Item "$(Get-ToolsLocation)\\AdGuardHome" -recurse
} catch {
    Write-host("Package folder has already been removed by other means, skipping...")
}