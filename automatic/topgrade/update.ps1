import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $release = Get-LatestGithubRelease `
        -GitUser topgrade-rs `
        -RepoName topgrade `
        -MainUrl64Regex "topgrade-v\d+.\d+.\d+-x86_64-pc-windows-msvc.zip"
    @{
        URL64   = $release.MainUrl64
        Version = $release.Version
    }
}

update -ChecksumFor 64