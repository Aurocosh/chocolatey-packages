$ErrorActionPreference = 'Stop'
$modulePath = Join-Path $PSScriptRoot '_scripts/vm/TestVm.psm1'
Import-Module $modulePath -Force
Write-Host "TestVm module loaded. Commands: $(@(Get-Command -Module TestVm).Name -join ', ')"
