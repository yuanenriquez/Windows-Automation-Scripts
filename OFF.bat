@echo off
start "" /B powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 1; $code = 'using System.Runtime.InteropServices; public class Pwr { [DllImport(\"user32.dll\")] public static extern int PostMessage(int h, int m, int w, int l); }'; Add-Type -TypeDefinition $code; [Pwr]::PostMessage(0xFFFF, 0x0112, 0xF170, 2)"
exit