@echo off
setlocal enabledelayedexpansion

:: Define the directories
set "DOWNLOADS_DIR=%USERPROFILE%\Downloads"
set "MUDFISH_INSTALL_DIR=C:\C_Softwares\Games\Launchers\Mudfish Cloud VPN"

echo Searching for the latest Mudfish installer in your Downloads folder...

:: Find the newest file starting with "mudfish" and ending with ".exe"
set "LATEST_INSTALLER="
for /f "delims=" %%I in ('dir "%DOWNLOADS_DIR%\mudfish*.exe" /b /a-d /o-d 2^>nul') do (
    set "LATEST_INSTALLER=%%I"
    goto :found
)

:found
if "%LATEST_INSTALLER%"=="" (
    echo.
    echo Error: No Mudfish installer found in the Downloads folder.
    pause
    exit /b
)

echo.
echo Found the latest installer: %LATEST_INSTALLER%
echo.
echo Closing Mudfish if it is currently running to prevent installation errors...
taskkill /f /im mudrun.exe >nul 2>&1
taskkill /f /im mudfish.exe >nul 2>&1

echo.
echo Installing %LATEST_INSTALLER% quietly...
:: Run the installer silently, wait for it to finish, and push it to your specific directory
start /wait "" "%DOWNLOADS_DIR%\%LATEST_INSTALLER%" /S /D=%MUDFISH_INSTALL_DIR%

echo.
echo Deleting the installer...
del /f /q "%DOWNLOADS_DIR%\%LATEST_INSTALLER%"

echo.
echo Mudfish has been successfully updated and the installer has been removed!
pause