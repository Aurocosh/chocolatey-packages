Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"   = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://jugglinglab.org' -UseBasicParsing

    $regex32 = "https://storage.googleapis.com/jugglinglab-dl/JugglingLab-(\d+\.\d+(?:\.\d+)?).exe"
    $url32 = $download_page.links | Where-Object href -match $regex32 | Select-Object -First 1 -expand href

    $version = $matches[1]

    @{
        Url32   = $url32
        Version = $version
    }
}

update -ChecksumFor 32

