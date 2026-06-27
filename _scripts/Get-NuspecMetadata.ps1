$ErrorActionPreference = 'Stop'

<#
.SYNOPSIS
Reads metadata elements from a Chocolatey nuspec file.

.DESCRIPTION
Gets one or more child elements under package/metadata in the specified nuspec.
Only simple metadata elements are supported (e.g. version, releaseNotes, title).

.PARAMETER key
The metadata element to read. Returns the element value.

.PARAMETER keys
Metadata element names to read. Returns a hashtable of name/value pairs.
Accepts pipeline input.

.PARAMETER NuspecFile
Path to the nuspec file. Defaults to ./*.nuspec in the current directory.

.EXAMPLE
Get-NuspecMetadata -key version

.EXAMPLE
Get-NuspecMetadata -keys version, title, releaseNotes

.EXAMPLE
@('version', 'title') | Get-NuspecMetadata

.NOTES
    NuspecFile accepts wildcards but is expected to match a single file.
    A warning is emitted when a key is not present under metadata.
#>
function Get-NuspecMetadata {
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Single')]
        [string]$key,

        [Parameter(Mandatory = $true, ParameterSetName = 'Multiple', ValueFromPipeline = $true)]
        [string[]]$keys,

        [ValidateScript({ Test-Path $_ })]
        [SupportsWildcards()]
        [string]$NuspecFile = '.\*.nuspec'
    )

    process {
        $nuspecPath = Resolve-Path $NuspecFile

        $doc = New-Object xml
        $doc.Load($nuspecPath)
        $metadata = $doc.package.metadata

        if ($PSCmdlet.ParameterSetName -eq 'Single') {
            $element = $metadata.$key
            if ($element) {
                if ($element -is [System.Xml.XmlElement]) {
                    return $element.InnerText
                }
                return [string]$element
            }

            Write-Warning "$key does not exist on the metadata element in the nuspec file"
            return
        }

        $result = @{}
        foreach ($name in $keys) {
            $element = $metadata.$name
            if ($element) {
                if ($element -is [System.Xml.XmlElement]) {
                    $result[$name] = $element.InnerText
                }
                else {
                    $result[$name] = [string]$element
                }
            }
            else {
                Write-Warning "$name does not exist on the metadata element in the nuspec file"
            }
        }

        return $result
    }
}
