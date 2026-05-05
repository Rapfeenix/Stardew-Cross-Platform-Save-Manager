@echo off
set "APP_NAME=StardewSync"
set "INSTALL_DIR=%USERPROFILE%\%APP_NAME%"

echo ===========================================
echo    Installing %APP_NAME%...
echo ===========================================

:: 1. Create the destination folder
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: 2. Copy the ps1 script and icon
echo [*] Copying files to %INSTALL_DIR%...
copy /y "%~dp0StardewSync.ps1" "%INSTALL_DIR%\"
copy /y "%~dp0StardewSync.ico" "%INSTALL_DIR%\"

:: 3. Create Desktop Shortcut (The "Bulletproof" One-Liner)
echo [*] Creating Desktop shortcut...
powershell -ExecutionPolicy Bypass -Command "$desktop = [Environment]::GetFolderPath('Desktop'); $s = (New-Object -ComObject WScript.Shell).CreateShortcut(\"$desktop\%APP_NAME%.lnk\"); $s.TargetPath = 'powershell.exe'; $s.Arguments = '-NoProfile -ExecutionPolicy Bypass -File \"%INSTALL_DIR%\StardewSync.ps1\"'; $s.IconLocation = '%INSTALL_DIR%\StardewSync.ico'; $s.WorkingDirectory = '%INSTALL_DIR%'; $s.Save()"

echo ===========================================
echo [V] INSTALLATION SUCCESSFUL!
echo The Chicken Icon is now on your Desktop.
echo ===========================================
pause