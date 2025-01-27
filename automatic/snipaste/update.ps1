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
    $regex64 = "Snipaste-(\d+\.\d+(?:\.\d+))(-Beta)?-x64.zip"

    $release64 = Get-LatestBitbucketDownloads `
        -UserName liule `
        -RepoName snipaste `
        -NameRegex $regex64 `
        -FirstOnly

    $release64.name -Match $regex64
    $version = $matches[1]
    $isBeta = $matches[2]

    $url64 = $release64.links.self.href

    if ($version -and $isBeta) {
        $version += "-Beta"
    }
    
    @{
        URL64   = $url64
        Version = $version
    }
}

update -ChecksumFor 64