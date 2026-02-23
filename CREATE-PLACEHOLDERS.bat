@echo off
REM ================================================================
REM Double-click this file to create placeholder images!
REM ================================================================

title Priti's Mehandi Art - Create Placeholder Images

echo.
echo =====================================
echo   Creating Placeholder Images
echo   with Correct Names
echo =====================================
echo.

REM Run the PowerShell script
powershell.exe -ExecutionPolicy Bypass -File "%~dp0create-placeholders.ps1"

REM Keep window open if there's an error
if errorlevel 1 (
    echo.
    echo Error occurred! Press any key to close...
    pause >nul
)
