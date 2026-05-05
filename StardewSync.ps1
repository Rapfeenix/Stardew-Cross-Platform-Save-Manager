

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
$localSave = "$env:APPDATA\StardewValley\Saves"

$oneDrivePath = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\OneDrive" -ErrorAction SilentlyContinue).UserFolder
if (-not $oneDrivePath) { $oneDrivePath = "$env:USERPROFILE\OneDrive" } # Fallback
$remoteSave = "$oneDrivePath\Stardew Save"

$screen = Get-CimInstance -ClassName Win32_VideoController | Select-Object -First 1
$pcWidth = $screen.CurrentHorizontalResolution
$pcHeight = $screen.CurrentVerticalResolution

function Apply-StardewFix($targetWidth, $targetHeight) {
    Write-Host "[!] Adjusting UI..." -ForegroundColor Cyan
    $files = Get-ChildItem -Path $localSave -Recurse -File | Where-Object { $_.Name -notmatch "SaveGameInfo" -and $_.Extension -ne ".vdf" }
    
    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw
        $content = $content -replace '<preferredResolutionX>[-0-9.]*</preferredResolutionX>', "<preferredResolutionX>$targetWidth</preferredResolutionX>"
        $content = $content -replace '<preferredResolutionY>[-0-9.]*</preferredResolutionY>', "<preferredResolutionY>$targetHeight</preferredResolutionY>"
        $content = $content -replace '<uiScale>[-0-9.]*</uiScale>', '<uiScale>1</uiScale>'
        $content = $content -replace '<zoomLevel>[-0-9.]*</zoomLevel>', '<zoomLevel>1</zoomLevel>'
        
    
        [System.IO.File]::WriteAllText($file.FullName, $content)
    }
}

do {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "    StardewSync" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host " PC Res  : $pcWidth x $pcHeight"
    Write-Host " OneDrive: $oneDrivePath"
    Write-Host "----------------------------------------"
    Write-Host " 1. BACKUP (PC to Android)"
    Write-Host " 2. RESTORE (Android to PC)"
    Write-Host " 3. Open Save Folder"
    Write-Host " 4. Open OneDrive Backup"
    Write-Host " 5. Exit"
    Write-Host ""
    
    $choice = Read-Host "Choose [1-5]"

    switch ($choice) {
        "1" {
            Apply-StardewFix 1280 720
            if (-not (Test-Path $remoteSave)) { New-Item -ItemType Directory -Path $remoteSave -Force }
            Copy-Item -Path "$localSave\*" -Destination $remoteSave -Recurse -Force
            [System.Windows.MessageBox]::Show("Success: backed up to OneDrive!")
        }
        "2" {
            if (Test-Path $remoteSave) {
                Copy-Item -Path "$remoteSave\*" -Destination $localSave -Recurse -Force
                Apply-StardewFix $pcWidth $pcHeight
                [System.Windows.MessageBox]::Show("Success: Restored and UI fixed to $pcWidth x $pcHeight!")
            } else {
                [System.Windows.MessageBox]::Show("Error: Backup not found!")
            }
        }
        "3" { explorer $localSave }
        "4" { if (-not (Test-Path $remoteSave)) { New-Item -ItemType Directory -Path $remoteSave -Force }; explorer $remoteSave }
    }
} while ($choice -ne "5")