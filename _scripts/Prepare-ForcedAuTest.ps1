param(
    [Parameter(Mandatory = $true)]
    [string[]]$Name,

    [string]$Root = (Join-Path $PSScriptRoot '..\automatic')
)

$rootPath = Resolve-Path $Root

foreach ($id in $Name) {
    $dir = Join-Path $rootPath $id
    if (-not (Test-Path $dir)) {
        Write-Warning "Package directory not found: $id"
        continue
    }

    $nuspec = Get-ChildItem $dir -Filter '*.nuspec' | Select-Object -First 1
    if ($nuspec) {
        $text = [System.IO.File]::ReadAllText($nuspec.FullName)
        $updated = [regex]::Replace($text, '(?m)(<version>)[^<]+(</version>)', '${1}1.0.0${2}')
        if ($updated -ne $text) {
            [System.IO.File]::WriteAllText($nuspec.FullName, $updated, [System.Text.UTF8Encoding]::new($false))
            Write-Host "  $($nuspec.Name): version -> 1.0.0"
        }
    }

    $install = Join-Path $dir 'tools\chocolateyinstall.ps1'
    if (Test-Path $install) {
        $text = [System.IO.File]::ReadAllText($install)
        $updated = $text
        $updated = [regex]::Replace($updated, "(?m)(^\s*url64bit\s*=\s*)('.*')", "`${1}''")
        $updated = [regex]::Replace($updated, "(?m)(^\s*checksum64\s*=\s*)('.*')", "`${1}''")
        $updated = [regex]::Replace($updated, "(?m)(^\s*url\s*=\s*)('.*')", "`${1}''")
        $updated = [regex]::Replace($updated, "(?m)(^\s*checksum\s*=\s*)('.*')", "`${1}''")
        if ($updated -ne $text) {
            [System.IO.File]::WriteAllText($install, $updated, [System.Text.UTF8Encoding]::new($false))
            Write-Host "  chocolateyinstall.ps1: cleared url/checksum fields"
        }
    }

    Write-Host "Prepared: $id"
}
