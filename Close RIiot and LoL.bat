@echo off
echo Force closing League of Legends and Riot Client...

:: Kill League of Legends Game Client
taskkill /F /IM "League of Legends.exe" /T >nul 2>&1

:: Kill League Client background processes
taskkill /F /IM LeagueClient.exe /T >nul 2>&1
taskkill /F /IM LeagueClientUx.exe /T >nul 2>&1
taskkill /F /IM LeagueClientUxRender.exe /T >nul 2>&1
taskkill /F /IM LeagueCrashHandler.exe /T >nul 2>&1

:: Kill Riot Client background processes
taskkill /F /IM RiotClientServices.exe /T >nul 2>&1
taskkill /F /IM RiotClientUx.exe /T >nul 2>&1
taskkill /F /IM RiotClientUxRender.exe /T >nul 2>&1

echo.
echo All Riot and League processes have been completely closed!

:: Automatically close the command prompt window
exit