@echo off
title Brightness Controller
set "ps1=%temp%\dimscreen.ps1"

echo $brightness = Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightness > "%ps1%"
echo $original = $brightness.CurrentBrightness >> "%ps1%"
echo $methods = Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightnessMethods >> "%ps1%"
echo $methods.WmiSetBrightness(0, 0) >> "%ps1%"

:: Import Windows API to detect keys even when the window is not in focus
echo Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class KeyState { [DllImport("user32.dll")] public static extern short GetAsyncKeyState(int vKey); }' >> "%ps1%"

echo Write-Host "=========================================" >> "%ps1%"
echo Write-Host " Screen is at 0%%." >> "%ps1%"
echo Write-Host " Press the [SPACEBAR] globally to restore." >> "%ps1%"
echo Write-Host "=========================================" >> "%ps1%"

:: Loop and check for the Spacebar (Virtual Key Code 0x20) every 100 milliseconds
echo while ($true) { if ([KeyState]::GetAsyncKeyState(0x20) -lt 0) { break }; Start-Sleep -Milliseconds 100 } >> "%ps1%"

echo $methods.WmiSetBrightness(0, $original) >> "%ps1%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%ps1%"

:: If PowerShell throws an error, keep the window open so you can read it
if %errorlevel% neq 0 pause

del "%ps1%"