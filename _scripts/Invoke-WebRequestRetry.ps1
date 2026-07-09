function Invoke-WebRequestRetry {
    [CmdletBinding(DefaultParameterSetName = 'Standard')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Uri,

        [Parameter(Mandatory = $false)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = 'Get',

        [Parameter(Mandatory = $false)]
        [System.Collections.IDictionary]$Headers,

        [Parameter (Mandatory = $false)]
        [System.String]$ContentType,

        [Parameter(Mandatory = $false)]
        [System.Object] $Body,

        [Parameter(Mandatory = $false)]
        [Switch] $DisableKeepAlive,

        [Parameter(Mandatory = $false)]
        [Switch] $UseBasicParsing,

        [Parameter(Mandatory = $false)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential,

        [Parameter(Mandatory = $false)]
        [double]$Buffered,

        # Custom Retry parameters
        [int]$MaxRetries = 3,
        [int]$RetryDelaySec = 5,
        [int]$TimeoutInSec = 600,

        [string]$LikeCondition,
        [string]$RegexCondition,
        [string]$NotLikeCondition,
        [string]$NotRegexCondition
    )

    $params = @{
        'Headers'     = $Headers;
        'ContentType' = $ContentType;
        'Method'      = $Method;
        'Uri'         = $Uri;
        'TimeoutSec'  = $TimeoutInSec
    }

    if ($null -ne $Body) {
        $params.Add('Body', $Body)
    }

    if ($DisableKeepAlive.IsPresent) {
        $params.Add('DisableKeepAlive', $true)
    }

    if ($UseBasicParsing.IsPresent) {
        $params.Add('UseBasicParsing', $true)
    }

    if ($Credential -ne [System.Management.Automation.PSCredential]::Empty -and $null -ne $Credential) {
        $params.Add('Credential', $Credential)
    }
    else {
        $params.Add('UseDefaultCredentials', $true)
    }

    if ($PSBoundParameters.ContainsKey('Buffered')) {
        $bufferFile = Get-InvokeWebRequestRetryBufferFile -Uri $Uri
        $cachedResponse = Get-InvokeWebRequestRetryBufferedResponse -BufferFile $bufferFile -BufferedMinutes $Buffered
        if ($null -ne $cachedResponse) {
            return $cachedResponse
        }
    }

    $retryCount = 0
    $response = $null

    do {
        try {
            $response = Invoke-WebRequest @params

            if ($PSBoundParameters.ContainsKey('Buffered')) {
                Save-InvokeWebRequestRetryBufferedResponse -BufferFile $bufferFile -Response $response
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

function Get-InvokeWebRequestRetryBufferFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Uri
    )

    $bufferDir = Join-Path ([System.IO.Path]::GetTempPath()) 'Invoke-WebRequestRetry-buffer'
    if (-not (Test-Path $bufferDir)) {
        New-Item -ItemType Directory -Path $bufferDir -Force | Out-Null
    }

    $hash = [BitConverter]::ToString(
        [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Uri))
    ).Replace('-', '').ToLower()

    Join-Path $bufferDir "$hash.json"
}

function Get-InvokeWebRequestRetryBufferedResponse {
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

        return ConvertFrom-InvokeWebRequestRetryCacheEntry -CacheEntry $cached.Response
    }
    catch {
        return $null
    }
}

function Save-InvokeWebRequestRetryBufferedResponse {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BufferFile,

        [Parameter(Mandatory = $true)]
        $Response
    )

    $cacheEntry = [ordered]@{
        BufferedAt = (Get-Date).ToString('o')
        Response   = ConvertTo-InvokeWebRequestRetryCacheEntry -Response $Response
    }

    $json = $cacheEntry | ConvertTo-Json -Depth 5 -Compress
    [System.IO.File]::WriteAllText($BufferFile, $json, [System.Text.UTF8Encoding]::new($false))
}

function ConvertTo-InvokeWebRequestRetryCacheEntry {
    param(
        [Parameter(Mandatory = $true)]
        $Response
    )

    $headers = @{}
    if ($null -ne $Response.Headers) {
        foreach ($key in $Response.Headers.Keys) {
            $headers[$key] = [string]$Response.Headers[$key]
        }
    }

    [ordered]@{
        Content            = [string]$Response.Content
        StatusCode         = [int]$Response.StatusCode
        StatusDescription  = [string]$Response.StatusDescription
        Headers            = $headers
        RawContentLength   = $Response.RawContentLength
    }
}

function ConvertFrom-InvokeWebRequestRetryCacheEntry {
    param(
        [Parameter(Mandatory = $true)]
        $CacheEntry
    )

    $headers = @{}
    if ($null -ne $CacheEntry.Headers) {
        foreach ($property in $CacheEntry.Headers.PSObject.Properties) {
            $headers[$property.Name] = [string]$property.Value
        }
    }

    [PSCustomObject]@{
        Content            = [string]$CacheEntry.Content
        StatusCode         = [int]$CacheEntry.StatusCode
        StatusDescription  = [string]$CacheEntry.StatusDescription
        Headers            = $headers
        RawContentLength   = $CacheEntry.RawContentLength
    }
}
