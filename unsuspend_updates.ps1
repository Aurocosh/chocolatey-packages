$PackagesPath = Join-Path $PSScriptRoot "automatic"

if (-not (Test-Path $PackagesPath)) {
    Write-Error "Packages folder not found: $PackagesPath"
    exit 1
}

$Today = Get-Date
$RenamedFiles = @()

Get-ChildItem -Path $PackagesPath -Directory | ForEach-Object {
    $Subfolder = $_.FullName
	$PackageName = $_.Name

    # Pattern: update--suspended-to-YYYY-MM-DD.ps1
    $Pattern = "update--suspended-to-(\d{4}-\d{2}-\d{2})\.ps1"
    $Files = Get-ChildItem -Path $Subfolder -Filter "update--suspended-to-*.ps1" -File

    foreach ($File in $Files) {
        if ($File.Name -match $Pattern) {
            $DateString = $matches[1]
            try {
                $SuspendedUntil = [datetime]::ParseExact($DateString, "yyyy-MM-dd", $null)
            } catch {
                Write-Warning "Skipping invalid date format in file: $($File.FullName)"
                continue
            }

            if ($SuspendedUntil -lt $Today) {
                $NewFilePath = Join-Path $Subfolder "update.ps1"
                Write-Host "Unsuspending updates for $($PackageName): $($File.Name) -> update.ps1"
                Rename-Item -Path $File.FullName -NewName "update.ps1" -Force
                $RenamedFiles += [PSCustomObject]@{
                    OriginalFile = $File.FullName
                    UnsuspendedFile = $NewFilePath
                }
            } else {
                Write-Host "Updates for $($PackageName) are suspended"
            }
        }
    }
}

if ($RenamedFiles.Count -gt 0) {
	$Password = $Env:github_api_key
	if ($Password) {
        Push-Location $PSScriptRoot
        $origin  = git config --get remote.origin.url
        $origin -match '(?<=:/+)[^/]+' | Out-Null
        $machine = $Matches[0]

		Write-Host "Setting oauth token for: $machine"
		git config --global credential.helper store
		Add-Content "$env:USERPROFILE\.git-credentials" "https://${Password}:x-oauth-basic@$machine`n"

        $Branch = 'master'
        git checkout -q -B $Branch
        git pull -q origin $Branch
	
		Write-Host "Creating Git commit for the following files:`n"
        $RenamedFiles | ForEach-Object { Write-Host " $($_.OriginalFile) -> $($_.UnsuspendedFile)" }

        foreach ($Item in $RenamedFiles) {
            git rm --cached -q $Item.OriginalFile
            git add $Item.UnsuspendedFile
		}
		$PackageNames = $RenamedFiles | ForEach-Object {$_.UnsuspendedFile.Split('\')[-2]} | Sort-Object -Unique | Out-String -Join ', '
        git commit -m "AU: $($RenamedFiles.Count) unsuspended - $($PackageNames)"
		git push -q
        Pop-Location
	}
	else {
		Write-Host "Cannot unsuspend. Git credentials are not provided"
	}
}
