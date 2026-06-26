Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.Url64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\DotNet3.5.nuspec" = @{
            "(?i)(^\s*<releaseNotes>)[^<]*(</releaseNotes>)`$" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $downloadPage = 'https://dotnet.microsoft.com/en-us/download/dotnet-framework/net35-sp1'
    $response = Invoke-WebRequest -Uri $downloadPage -UseBasicParsing

    $link = $response.Links | Where-Object {
        $_.'data-bi-dlnm' -eq '.NET Framework 3.5 Standalone' -and
        $_.'data-bi-name' -eq 'Download' -and
        $_.'data-bi-id' -eq 'download'
    } | Select-Object -First 1

    if (-not $link) {
        throw "Standalone .NET Framework 3.5 download link not found on $downloadPage"
    }

    $url = $link.href

    $installScriptPath = "$PSScriptRoot/tools/chocolateyinstall.ps1"
    (Get-Content -Path $installScriptPath -Raw) -match "(?i)url64bit\s*=\s*'([^']*)'"
    $currentUrl = $matches[1]

    $nuspecFile = "$PSScriptRoot/DotNet3.5.nuspec"
    (Get-Content -Path $nuspecFile -Raw) -match '<version>([^<]*)<\/version>'
    $version = $matches[1]

    if ($url -and ($url -ne $currentUrl)) {
        $version = '3.5.' + (Get-Date).ToString('yyyyMMdd')
    }

    @{
        Url64        = $url
        Version      = $version
        ReleaseNotes = $downloadPage
    }
}

update -ChecksumFor 64
