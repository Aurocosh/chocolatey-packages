Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot/../../_scripts/my_functions.psm1"

$release = Get-LatestGithubRelease `
    -GitUser ozwaldorf `
    -RepoName lutgen-rs `
    -MainUrl64Regex "lutgen-cli-v\d+\.\d+(?:\.\d+)?-x86_64-pc-windows-msvc.exe" `
    -VersionRegex "^lutgen-v(\d+\.\d+\.\d+(?:\.\d+)?)$"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    @{
        Url64       = $release.MainUrl64
        Checksum64  = $release.MainUrl64_Sha256
        Version     = $release.Version
    }
}

update -ChecksumFor $release.ChocoChecksumFor

Remove-Item -Path "$PSScriptRoot/lutgen-cli.exe" -Force -ErrorAction SilentlyContinue
