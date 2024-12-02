function Replace-MarkersInFile {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$InputFilePath,

		[Parameter(Mandatory = $true, Position = 1)]
		[string]$OutputFilePath,

		[Parameter(Mandatory = $true, Position = 2)]
		[hashtable]$MarkerHashtable,

		[string]$MarkerTemplate = "{marker}"
	)

	# Read the input file contents
	$fileContent = Get-Content -Path $InputFilePath -Raw

	# Iterate through the hashtable and replace each marker with its value
	foreach ($key in $MarkerHashtable.Keys) {
		$marker = $MarkerTemplate -replace "marker", $key
		$fileContent = $fileContent -replace [regex]::Escape($marker), [string]$MarkerHashtable[$key]
	}

	# Write the modified content to the output file
	Set-Content -Path $OutputFilePath -Value $fileContent
}