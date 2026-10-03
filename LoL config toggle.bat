@echo off
setlocal

:: Set log file path to the user's Downloads folder
set "LOG_FILE=%USERPROFILE%\Downloads\LoL_ReadOnly_Toggle.log"

:: Initialize log
echo ========================================= > "%LOG_FILE%"
echo Execution Started: %date% %time% >> "%LOG_FILE%"
echo ========================================= >> "%LOG_FILE%"

:: Define target files
set "FILE1=D:\D_Softwares\Games\Game files\League of Legends\Config\game.cfg"
set "FILE2=D:\D_Softwares\Games\Game files\League of Legends\Config\PersistedSettings.json"

call :Log "Checking current file attributes..."

:: Check if files exist to avoid errors
if not exist "%FILE1%" (
    call :Log "ERROR: game.cfg not found at the specified path."
    goto :End
)
if not exist "%FILE2%" (
    call :Log "ERROR: PersistedSettings.json not found at the specified path."
    goto :End
)

:: Check Read-Only status using dir /ar
dir /ar "%FILE1%" >nul 2>&1
if %errorlevel% equ 0 (
    call :Log "Current State: READ-ONLY"
    call :Log "Action: Removing Read-Only attribute..."
    
    attrib -r "%FILE1%"
    attrib -r "%FILE2%"
    
    call :Log "Success: Files are now NORMAL (Writable)."
) else (
    call :Log "Current State: NORMAL (Writable)"
    call :Log "Action: Applying Read-Only attribute..."
    
    attrib +r "%FILE1%"
    attrib +r "%FILE2%"
    
    call :Log "Success: Files are now READ-ONLY."
)

:End
echo ========================================= >> "%LOG_FILE%"
echo Execution Finished: %date% %time% >> "%LOG_FILE%"
echo.
echo Log saved to: "%LOG_FILE%"
echo.
pause
exit /b

:: Subroutine to handle console and log output simultaneously
:Log
echo %~1
echo %date% %time% - %~1 >> "%LOG_FILE%"
exit /b