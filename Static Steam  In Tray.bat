@echo off
:: Define the path to your Steam config file based on your custom installation
set "VDF_FILE=C:\C_Softwares\Games\Launchers\Steam\config\loginusers.vdf"

:: Use PowerShell to quickly flip the Offline Mode flags inside the config file
powershell -Command "(Get-Content '%VDF_FILE%') -replace '\"WantsOfflineMode\"\s*\"0\"', '\"WantsOfflineMode\" \"1\"' -replace '\"SkipOfflineModeWarning\"\s*\"0\"', '\"SkipOfflineModeWarning\" \"1\"' | Set-Content '%VDF_FILE%'"

:: Launch Steam directly to the tray
start "" "C:\C_Softwares\Games\Launchers\Steam\steam.exe" -silent -noverifyfiles