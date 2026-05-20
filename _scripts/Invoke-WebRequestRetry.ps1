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

    $retryCount = 0
    $response = $null

    do {
        try {
            $response = Invoke-WebRequest @params
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