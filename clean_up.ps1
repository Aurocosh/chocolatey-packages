$folderPaths = @(
    "./automatic",
    "./manual"
)
$extension = ".nupkg"

foreach ($folderPath in $folderPaths) {
    $files = Get-ChildItem -Path $folderPath -Recurse -File -Filter "*$extension"

    foreach ($file in $files) {
        try {
            Remove-Item -Path $file.FullName -Force
            Write-Host "Deleted file: $($file.FullName)"
        } catch {
            Write-Host "Failed to delete file: $($file.FullName). Error: $_"
        }
    }
}
