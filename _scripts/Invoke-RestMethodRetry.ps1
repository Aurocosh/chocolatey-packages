. "$PSScriptRoot\BufferFileLock.ps1"

function Invoke-RestMethodRetry {
    [CmdletBinding(DefaultParameterSetName = 'Standard')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Uri,

        [Parameter(Mandatory = $false)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = 'Get',

        [Parameter(Mandatory = $false)]
        [System.Collections.IDictionary]$Headers,

        [Parameter(Mandatory = $false)]
        [System.String]$ContentType,

        [Parameter(Mandatory = $false)]
        [System.Object]$Body,

        [Parameter(Mandatory = $false)]
        [double]$Buffered,

        [int]$MaxRetries = 3,
        [int]$RetryDelaySec = 5,
        [int]$TimeoutInSec = 600,

        [string]$LikeCondition,
        [string]$RegexCondition,
        [string]$NotLikeCondition,
        [string]$NotRegexCondition
    )

    $params = @{
        Uri        = $Uri
        Method     = $Method
        TimeoutSec = $TimeoutInSec
    }

    if ($null -ne $Headers) {
        $params.Headers = $Headers
    }

    if ($null -ne $ContentType) {
        $params.ContentType = $ContentType
    }

    if ($null -ne $Body) {
        $params.Body = $Body
    }

    if ($PSBoundParameters.ContainsKey('Buffered')) {
        $bufferFile = Get-InvokeRestMethodRetryBufferFile -Uri $Uri

        $cachedResponse = Invoke-WithBufferFileLock -BufferFile $bufferFile -ScriptBlock {
            Get-InvokeRestMethodRetryBufferedResponse -BufferFile $bufferFile -BufferedMinutes $Buffered
        }
        if ($null -ne $cachedResponse) {
            return $cachedResponse
        }
    }

    $retryCount = 0
    $response = $null

    do {
        try {
            $response = Invoke-RestMethod @params

            if ($PSBoundParameters.ContainsKey('Buffered')) {
                return Invoke-WithBufferFileLock -BufferFile $bufferFile -ScriptBlock {
                    $cachedResponse = Get-InvokeRestMethodRetryBufferedResponse -BufferFile $bufferFile -BufferedMinutes $Buffered
                    if ($null -ne $cachedResponse) {
                        return $cachedResponse
                    }

                    Save-InvokeRestMethodRetryBufferedResponse -BufferFile $bufferFile -Response $response
                    return $response
                }
            }

            return $response
        }
        catch {
            $errorMessage = $_.Exception.Message
            $retryCount++

            if ($NotLikeCondition -and $errorMessage -like $NotLikeCondition) {
                throw $_
            }
            if ($NotRegexCondition -and $errorMessage -match $NotRegexCondition) {
                throw $_
            }

            $hasPositiveFilters = [bool]($LikeCondition -or $RegexCondition)

            if ($hasPositiveFilters) {
                $likeMatch = $LikeCondition -and $errorMessage -like $LikeCondition
                $regexMatch = $RegexCondition -and $errorMessage -match $RegexCondition

                if (-not ($likeMatch -or $regexMatch)) {
                    throw $_
                }
            }

            if ($retryCount -ge $MaxRetries) {
                throw "Failed to get response after $MaxRetries attempts. Last error: $errorMessage"
            }

            Write-Host "Condition met. Retrying in $RetryDelaySec seconds... (Attempt $retryCount of $MaxRetries)"
            Start-Sleep -Seconds $RetryDelaySec
        }
    } while ($retryCount -lt $MaxRetries)
}

function Get-InvokeRestMethodRetryBufferFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Uri
    )

    $bufferDir = Join-Path ([System.IO.Path]::GetTempPath()) 'Invoke-RestMethodRetry-buffer'
    if (-not (Test-Path $bufferDir)) {
        New-Item -ItemType Directory -Path $bufferDir -Force | Out-Null
    }

    $hash = [BitConverter]::ToString(
        [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Uri))
    ).Replace('-', '').ToLower()

    Join-Path $bufferDir "$hash.json"
}

function Get-InvokeRestMethodRetryBufferedResponse {
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

        return ConvertFrom-InvokeRestMethodRetryCacheEntry -CacheEntry $cached.Response
    }
    catch {
        return $null
    }
}

function Save-InvokeRestMethodRetryBufferedResponse {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile,

        [Parameter(Mandatory = $true)]
        $Response
    )

    $cacheEntry = [ordered]@{
        BufferedAt = (Get-Date).ToString('o')
        Response   = ConvertTo-InvokeRestMethodRetryCacheEntry -Response $Response
    }

    $json = $cacheEntry | ConvertTo-Json -Depth 20 -Compress
    [System.IO.File]::WriteAllText($BufferFile, $json, [System.Text.UTF8Encoding]::new($false))
}

function ConvertTo-InvokeRestMethodRetryCacheEntry {
    param(
        [Parameter(Mandatory = $true)]
        $Response
    )

    [ordered]@{
        ResponseJson = ($Response | ConvertTo-Json -Depth 20 -Compress)
        IsArray      = $Response -is [System.Array]
    }
}

function ConvertFrom-InvokeRestMethodRetryCacheEntry {
    param(
        [Parameter(Mandatory = $true)]
        $CacheEntry
    )

    $restored = $CacheEntry.ResponseJson | ConvertFrom-Json

    if ($CacheEntry.IsArray) {
        return ,@($restored)
    }

    return $restored
}
