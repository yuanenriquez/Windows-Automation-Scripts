@echo off
title Auto-Rename and Execute Gemini Script

:: Define the log file name based on the current script's location (e.g., Desktop)
set "LOGFILE=%~dpn0.log"

:: Initialize variable for the global scope to track the new filename
set "RENAMED_FILE="

:: Call the main logic and redirect all output to the log file
call :main >> "%LOGFILE%" 2>&1

:: --- Interactive Menu (Executed outside of logged output so it's visible) ---
if not defined RENAMED_FILE (
    echo [Log updated: %LOGFILE%]
    echo No valid file was found or renamed. Please check the log for details.
    pause
    exit /b
)

:Menu
cls
echo =======================================================
echo Success! File renamed to: %RENAMED_FILE%
echo =======================================================
echo.
echo What would you like to do next?
echo [SPACE] Run "%RENAMED_FILE%"
echo [D]     Open Downloads Folder
echo [3]     Exit
echo.
echo Waiting for input (Press SPACE, D, or 3)...

:: Using PowerShell to reliably capture the Spacebar, as the native 'choice' command cannot map it easily
for /f "delims=" %%K in ('powershell -NoProfile -Command "do { $k = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Character } while (@(' ', 'd', 'D', '3') -notcontains $k); if ($k -eq ' ') { Write-Output 'SPACE' } else { Write-Output $k }"') do set "KEY=%%K"

if "%KEY%"=="3" exit /b
if /i "%KEY%"=="d" (
    explorer "%USERPROFILE%\Downloads"
    exit /b
)
if "%KEY%"=="SPACE" (
    cd /d "%USERPROFILE%\Downloads"
    start "" "%RENAMED_FILE%"
    exit /b
)

:main
setlocal EnableDelayedExpansion
echo [!DATE! !TIME!] --- Starting Conversion Process ---

:: Switch working directory to Downloads so the script always finds your browser downloads
cd /d "%USERPROFILE%\Downloads"

set "TARGET_FILE="

:: Search for the newest file matching the Gemini naming pattern (.txt or .bat)
for /f "delims=" %%F in ('dir /B /O-D /A-D "gemini-code-*.txt" "gemini-code-*.bat" 2^>nul') do (
    set "TARGET_FILE=%%F"
    goto :FileFound
)

echo [!DATE! !TIME!] No files matching "gemini-code-*.txt" or "gemini-code-*.bat" were found in Downloads.
goto :End

:FileFound
echo [!DATE! !TIME!] Latest file identified: "!TARGET_FILE!"

:: Read the file line by line to extract the title
set "NEW_TITLE="
for /f "usebackq tokens=1,* delims= " %%A in ("!TARGET_FILE!") do (
    if /i "%%A"=="title" (
        set "NEW_TITLE=%%B"
        goto :TitleExtracted
    )
)

:TitleExtracted
:: Fallback in case a title command wasn't found
if "!NEW_TITLE!"=="" (
    echo [!DATE! !TIME!] No "title" command found inside "!TARGET_FILE!". Using "no title" as fallback.
    set "NEW_TITLE=no title"
    goto :FinalizeRename
)

echo [!DATE! !TIME!] Found internal title: "!NEW_TITLE!"
    
:: Safely sanitize the title using .NET's invalid character list
:: This loop is intentionally placed outside of any ( ) blocks so the CMD parser doesn't crash
for /f "delims=" %%I in ('powershell -NoProfile -Command "$t=$env:NEW_TITLE; foreach($c in [IO.Path]::GetInvalidFileNameChars()){$t=$t.Replace($c,'_')}; Write-Output $t"') do set "NEW_TITLE=%%I"

:FinalizeRename
:: Append the batch extension to the sanitized title
set "NEW_NAME=!NEW_TITLE!.bat"

:: Duplicate check to prevent crash if multiple old scripts lack a title
if exist "!NEW_NAME!" (
    echo [!DATE! !TIME!] Warning: "!NEW_NAME!" already exists. Appending a random number to avoid overwrite.
    set "NEW_NAME=!NEW_TITLE!_!RANDOM!.bat"
)

echo [!DATE! !TIME!] Attempting to rename "!TARGET_FILE!" to "!NEW_NAME!"

ren "!TARGET_FILE!" "!NEW_NAME!"

if !ERRORLEVEL! EQU 0 (
    echo [!DATE! !TIME!] Success: Renamed "!TARGET_FILE!" to "!NEW_NAME!".
    :: Prepare the variable to be passed out of the localized scope
    set "EXPORT_FILE=!NEW_NAME!"
) else (
    echo [!DATE! !TIME!] Error: Failed to rename the file. Ensure it is not open elsewhere.
    set "EXPORT_FILE="
)

:End
echo [!DATE! !TIME!] --- Process Finished ---
echo.
:: Transfer the localized EXPORT_FILE to the global RENAMED_FILE variable
endlocal & set "RENAMED_FILE=%EXPORT_FILE%"
exit /b