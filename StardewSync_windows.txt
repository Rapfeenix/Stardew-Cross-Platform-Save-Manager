@echo off
setlocal enabledelayedexpansion

:: --- SETTINGS ---
set "LOCAL_SAVE=%APPDATA%\StardewValley\Saves"
set "REMOTE_SAVE=%OneDrive%\StardewBackup\Saves"

:MENU
cls
echo ========================================
echo    StardewSync Save File manager
echo ========================================
echo.
echo  1. BACKUP to OneDrive (PC to Android)
echo  2. RESTORE from OneDrive (Android to PC)
echo  3. Open Save Folder
echo  4. Open OneDrive Backup
echo  5. Exit
echo.
set /p choice="Choose [1-5]: "

if "%choice%"=="1" goto BACKUP
if "%choice%"=="2" goto RESTORE
if "%choice%"=="3" goto OPEN_LOCAL
if "%choice%"=="4" goto OPEN_REMOTE
if "%choice%"=="5" exit
goto MENU

:BACKUP
echo.
echo [!] Applying Resolution Fixes for Mobile...
call :APPLY_FIX
echo [!] Copying to OneDrive...
if not exist "%REMOTE_SAVE%" mkdir "%REMOTE_SAVE%"
xcopy "%LOCAL_SAVE%" "%REMOTE_SAVE%" /E /I /Y /Q
msg * "Success: Adjusted settings and backed up to OneDrive!"
goto MENU

:RESTORE
echo.
echo [!] Copying from OneDrive...
if not exist "%REMOTE_SAVE%" (
    msg * "Error: OneDrive backup folder not found!"
    goto MENU
)
xcopy "%REMOTE_SAVE%" "%LOCAL_SAVE%" /E /I /Y /Q
echo [!] Applying Resolution Fixes for PC...
call :APPLY_FIX
msg * "Success: Restored and UI adjusted!"
goto MENU

:OPEN_LOCAL
explorer "%LOCAL_SAVE%"
goto MENU

:OPEN_REMOTE
if not exist "%REMOTE_SAVE%" mkdir "%REMOTE_SAVE%"
explorer "%REMOTE_SAVE%"
goto MENU

:APPLY_FIX
:: If needed, change this to your own resolution.
powershell -Command "Get-ChildItem -Path '%LOCAL_SAVE%' -Recurse -File | Where-Object { $_.Name -notmatch 'SaveGameInfo' -and $_.Extension -ne '.vdf' } | ForEach-Object { $c = Get-Content $_.FullName -Raw; $c = $c -replace '<preferredResolutionX>[-0-9.]*</preferredResolutionX>', '<preferredResolutionX>1280</preferredResolutionX>'; $c = $c -replace '<preferredResolutionY>[-0-9.]*</preferredResolutionY>', '<preferredResolutionY>720</preferredResolutionY>'; $c = $c -replace '<uiScale>[-0-9.]*</uiScale>', '<uiScale>1</uiScale>'; $c = $c -replace '<zoomLevel>[-0-9.]*</zoomLevel>', '<zoomLevel>1</zoomLevel>'; Set-Content $_.FullName $c -Encoding UTF8 }"
goto :eof