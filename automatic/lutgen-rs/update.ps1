import-module au
import-module "$PSScriptRoot/../../_scripts/my_functions.psm1"

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
        -GitUser ozwaldorf `
        -RepoName lutgen-rs `
        -MainUrl64Regex "lutgen-cli-v\d+\.\d+(?:\.\d+)?-x86_64-pc-windows-msvc.exe" `
        -VersionRegex "^lutgen-(?:studio-)?v(\d+\.\d+\.\d+(?:\.\d+)?)$"

    $release.MainUrl64 -match "lutgen-cli-v(\d+\.\d+(?:\.\d+)?)-x86_64-pc-windows-msvc.exe"
    $version = $Matches[1]

    @{
        URL64   = $release.MainUrl64
        Version = $version
    }
}

update -ChecksumFor 64

Remove-Item -Path "$PSScriptRoot/lutgen-cli.exe" -Force -ErrorAction SilentlyContinue
