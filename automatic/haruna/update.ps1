Import-Module Chocolatey-AU

$releases = 'https://download.kde.org/stable/haruna/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $versions = $download_page.Links |
        Where-Object href -match '^(\d+\.\d+\.\d+)/?$' |
        ForEach-Object { [version]$matches[1] } |
        Sort-Object -Descending

    if (-not $versions) {
        throw "Could not find Haruna versions on $releases"
    }

    $version = $versions[0].ToString()
    $version_page = Invoke-WebRequest -Uri "${releases}${version}/" -UseBasicParsing
    $installer = $version_page.Links |
        Where-Object href -match "^haruna-${version}-windows-.+-x86_64\.exe$" |
        Select-Object -ExpandProperty href -First 1

    if (-not $installer) {
        throw "Could not find Windows x86_64 installer for Haruna $version"
    }

    @{
        URL64        = "${releases}${version}/$installer"
        Version      = $version
        ReleaseNotes = 'https://haruna.kde.org/blog/'
    }
}

update -ChecksumFor 64
