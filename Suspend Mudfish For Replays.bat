@echo off
title Suspend Mudfish For Replays

:: Define the log file location (saves in the exact same folder as this script)
set "LOGFILE=%~dp0Mudfish_ReplayMode_Execution.log"
echo [%DATE% %TIME%] Replay script initialized. > "%LOGFILE%"

:: Self-Elevate to Administrator if not already running as Admin
echo [%DATE% %TIME%] Checking for Administrator rights... >> "%LOGFILE%"
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [%DATE% %TIME%] Admin rights missing. Requesting elevation... >> "%LOGFILE%"
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
echo [%DATE% %TIME%] Admin rights confirmed. >> "%LOGFILE%"

echo =====================================================
echo Mudfish Replay Mode (Auto-Resume)
echo =====================================================
echo.

REM Disable the task immediately for the replay
echo [%DATE% %TIME%] Disabling task for replay session... >> "%LOGFILE%"
schtasks /change /tn "\EventViewerAutoMudfish" /disable >> "%LOGFILE%" 2>&1

echo SUCCESS: Mudfish Auto-Run is now OFF!
echo Status: Safe to watch Replays without wasting credits.
echo.
echo =====================================================
echo LEAVE THIS WINDOW OPEN WHILE WATCHING YOUR REPLAY
echo =====================================================
echo.
echo When your replay is over and you are ready for a real match,
echo press ANY KEY in this window to turn Mudfish back ON.
echo.

REM The script will freeze right here and wait for your keystroke
pause

REM Once you press a key, it immediately re-enables the task
echo [%DATE% %TIME%] User pressed a key. Re-enabling task... >> "%LOGFILE%"
schtasks /change /tn "\EventViewerAutoMudfish" /enable >> "%LOGFILE%" 2>&1
echo [%DATE% %TIME%] Task re-enabled successfully. Script finishing. >> "%LOGFILE%"