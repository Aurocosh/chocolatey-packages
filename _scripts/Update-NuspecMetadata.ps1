$ErrorActionPreference = 'Stop'

<#
.SYNOPSIS
Updates metadata elements in a Chocolatey nuspec file.

.DESCRIPTION
Sets one or more child elements under package/metadata in the specified nuspec.
Only simple metadata elements are supported (e.g. version, releaseNotes, title).

.PARAMETER key
The metadata element to update.

.PARAMETER value
The value to set.

.PARAMETER data
Hashtable of metadata element names and values. Accepts pipeline input.

.PARAMETER NuspecFile
Path to the nuspec file. Defaults to ./*.nuspec in the current directory.

.EXAMPLE
Update-NuspecMetadata -key releaseNotes -value "https://github.com/owner/repo/releases/latest"

.EXAMPLE
@{ title = 'Example Package'; version = '1.0.0' } | Update-NuspecMetadata

.NOTES
    NuspecFile accepts wildcards but is expected to match a single file.
    A warning is emitted when a key is not present under metadata.
#>
function Update-NuspecMetadata {
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Single')]
        [string]$key,

        [Parameter(Mandatory = $true, ParameterSetName = 'Single')]
        [string]$value,

        [Parameter(Mandatory = $true, ParameterSetName = 'Multiple', ValueFromPipeline = $true)]
        [hashtable]$data = @{$key = $value},

        [ValidateScript({ Test-Path $_ })]
        [SupportsWildcards()]
        [string]$NuspecFile = '.\*.nuspec'
    )

    process {
        $nuspecPath = Resolve-Path $NuspecFile

        $doc = New-Object xml
        $doc.PreserveWhitespace = $true
        $doc.Load($nuspecPath)

        foreach ($name in $data.Keys) {
            $element = $doc.package.metadata.$name
            if ($element) {
                $doc.package.metadata.$name = $data[$name]
            }
            else {
                Write-Warning "$name does not exist on the metadata element in the nuspec file"
            }
        }

        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($nuspecPath, $doc.InnerXml, $utf8NoBom)
    }
}
