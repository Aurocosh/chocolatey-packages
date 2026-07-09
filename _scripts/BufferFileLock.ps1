function Get-BufferFileMutexName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile
    )

    $hash = [BitConverter]::ToString(
        [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($BufferFile))
    ).Replace('-', '').ToLower()

    "Local\ChocolateyPackages-BufferFile-$hash"
}

function Invoke-WithBufferFileLock {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile,

        [Parameter(Mandatory = $true)]
        [scriptblock]$ScriptBlock
    )

    $mutexName = Get-BufferFileMutexName -BufferFile $BufferFile
    $mutex = New-Object System.Threading.Mutex($false, $mutexName)

    $mutex.WaitOne() | Out-Null
    try {
        return & $ScriptBlock
    }
    finally {
        $mutex.ReleaseMutex()
        $mutex.Dispose()
    }
}

function Invoke-BufferedCacheLookup {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile,

        [Parameter(Mandatory = $true)]
        [scriptblock]$TryGetCached,

        [Parameter(Mandatory = $true)]
        [scriptblock]$FetchFresh,

        [Parameter(Mandatory = $true)]
        [scriptblock]$SaveCached
    )

    $cached = & $TryGetCached
    if ($null -ne $cached) {
        return $cached
    }

    $fresh = & $FetchFresh

    Invoke-WithBufferFileLock -BufferFile $BufferFile -ScriptBlock {
        $cached = & $TryGetCached
        if ($null -ne $cached) {
            return $cached
        }

        & $SaveCached $fresh
        return $fresh
    }
}
