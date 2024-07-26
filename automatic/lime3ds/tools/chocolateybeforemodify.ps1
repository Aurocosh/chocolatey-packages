Get-Process -Name "lime3ds-cli" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Process -Name "lime3ds-gui" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Process -Name "lime3ds-room" -ErrorAction SilentlyContinue | Stop-Process -Force


