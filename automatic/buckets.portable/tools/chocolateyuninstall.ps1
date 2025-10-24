$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Remove additional files created by the program
$files = @('app.sqlite', 'log.log', 'state.json')
$files | ForEach-Object {
    Join-Path $toolsDir $_ | Remove-Item -ErrorAction SilentlyContinue
}
