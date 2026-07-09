Import-Module Chocolatey-AU
. $([System.IO.Path]::Combine($PSScriptRoot, '..', 'anydesk.install', 'update.ps1'))

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            "(?i)(\<dependency id=`"anydesk.install`" version=`"\[).*?(\]`" /\>)" = "`${1}$($Latest.Version)`$2"
        }
    }
}

function global:au_BeforeUpdate() {
}

Update-Package -ChecksumFor none
