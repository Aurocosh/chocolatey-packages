Get-Process -Name "PhotoDemon" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Process -Name "exiftool" -ErrorAction SilentlyContinue | Stop-Process -Force