@echo off
REM ================================================================
REM Double-click this file to update your image gallery!
REM ================================================================

title Priti's Mehandi Art - Image Gallery Generator

echo.
echo =====================================
echo   Priti's Mehandi Art
echo   Quick Gallery Update
echo =====================================
echo.

REM Run the PowerShell script
powershell.exe -ExecutionPolicy Bypass -File "%~dp0generate-images.ps1"

REM Keep window open if there's an error
if errorlevel 1 (
    echo.
    echo Error occurred! Press any key to close...
    pause >nul
)
