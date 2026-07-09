. "$PSScriptRoot\BufferFileLock.ps1"

function Get-RemoteBufferedChecksum {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Uri,

        [Parameter(Mandatory = $false)]
        [double]$Buffered = 60,

        [int]$MaxRetries = 3,
        [int]$RetryDelaySec = 5,

        [switch]$CumulativeDelay
    )

    $bufferFile = Get-RemoteBufferedChecksumBufferFile -Uri $Uri

    $cachedChecksum = Invoke-WithBufferFileLock -BufferFile $bufferFile -ScriptBlock {
        Get-RemoteBufferedChecksumCached -BufferFile $bufferFile -BufferedMinutes $Buffered
    }
    if ($null -ne $cachedChecksum) {
        return $cachedChecksum
    }

    $retryCount = 0
    $currentDelaySec = $RetryDelaySec

    do {
        try {
            $checksum = Get-RemoteChecksum $Uri

            return Invoke-WithBufferFileLock -BufferFile $bufferFile -ScriptBlock {
                $cachedChecksum = Get-RemoteBufferedChecksumCached -BufferFile $bufferFile -BufferedMinutes $Buffered
                if ($null -ne $cachedChecksum) {
                    return $cachedChecksum
                }

                Save-RemoteBufferedChecksum -BufferFile $bufferFile -Checksum $checksum
                return $checksum
            }
        }
        catch {
            $errorMessage = $_.Exception.Message
            $retryCount++

            if ($retryCount -ge $MaxRetries) {
                throw "Failed to get remote checksum after $MaxRetries attempts. Last error: $errorMessage"
            }

            Write-Host "Get-RemoteChecksum failed. Retrying in $currentDelaySec seconds... (Attempt $retryCount of $MaxRetries)"
            Start-Sleep -Seconds $currentDelaySec

            if ($CumulativeDelay) {
                $currentDelaySec += $RetryDelaySec
            }
        }
    } while ($retryCount -lt $MaxRetries)
}

function Get-RemoteBufferedChecksumBufferFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Uri
    )

    $bufferDir = Join-Path ([System.IO.Path]::GetTempPath()) 'Get-RemoteBufferedChecksum-buffer'
    if (-not (Test-Path $bufferDir)) {
        New-Item -ItemType Directory -Path $bufferDir -Force | Out-Null
    }

    $hash = [BitConverter]::ToString(
        [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Uri))
    ).Replace('-', '').ToLower()

    Join-Path $bufferDir "$hash.json"
}

function Get-RemoteBufferedChecksumCached {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile,

        [Parameter(Mandatory = $true)]
        [double]$BufferedMinutes
    )

    if (-not (Test-Path $BufferFile)) {
        return $null
    }

    try {
        $cached = Get-Content -Path $BufferFile -Raw -Encoding UTF8 | ConvertFrom-Json
        $bufferedAt = [datetime]$cached.BufferedAt

        if ((Get-Date) -gt $bufferedAt.AddMinutes($BufferedMinutes)) {
            return $null
        }

        return [string]$cached.Checksum
    }
    catch {
        return $null
    }
}

function Save-RemoteBufferedChecksum {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile,

        [Parameter(Mandatory = $true)]
        [string]$Checksum
    )

    $cacheEntry = [ordered]@{
        BufferedAt = (Get-Date).ToString('o')
        Checksum   = $Checksum
    }

    $json = $cacheEntry | ConvertTo-Json -Depth 2 -Compress
    [System.IO.File]::WriteAllText($BufferFile, $json, [System.Text.UTF8Encoding]::new($false))
}
