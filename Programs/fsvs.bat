:: FSVS
@echo off
title Full System Virus Scan

echo Starting FULL system scan... please wait.
echo.

"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1

echo.
echo Scan completed.
pause
