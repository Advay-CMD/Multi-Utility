@echo off

set "MUP=%systemroot%\System32\Multi_Utility\Programs" :: MUP is Multi Utility Path

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
       break
) ELSE (
    :: Not admin, relaunch using VBScript
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0", "", "runas", 1 >> "%temp%\elevate.vbs"
    cscript //nologo "%temp%\elevate.vbs"
    del "%temp%\elevate.vbs"
    exit /b

)

@echo off
title Welcome to Multi-Utility!
setlocal EnableDelayedExpansion

:: Enable ANSI escape sequences
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

:: Optional: Enable Virtual Terminal Processing (Windows 10/11)
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

echo Welcome to Multi-Utility! Here you have to choose an option from menu!
echo.
pause

:: Total number of menu items
set max=14
set selected=1

:menu
cls
title Multi-Utility Options

echo ==========================================
echo              MULTI-UTILITY
echo ==========================================
echo New! There is a menu!
echo Please use W (Up), S (Down), X (Select)
echo.

call :printOption 1  "System Report"
call :printOption 2  "Scan File for Viruses"
call :printOption 3  "System Scan"
call :printOption 4  "System Information"
call :printOption 5  "Network Speed Tester"
call :printOption 6  "Add an Account"
call :printOption 7  "Delete Account"
call :printOption 8  "Format Disk"
call :printOption 9  "Corrupted Pendrive Fixer"
call :printOption 10 "CMD Colour Change"
call :printOption 11 "Search Files"
call :printOption 12 "File Hider"
call :printOption 13 "File Unhider"
call :printOption 14 "Exit"

echo.
choice /c WSX /n >nul

:: Handle input
if errorlevel 3 goto select
if errorlevel 2 (
    set /a selected+=1
    goto wrap
)
if errorlevel 1 (
    set /a selected-=1
    goto wrap
)

:wrap
if !selected! LSS 1 set selected=%max%
if !selected! GTR %max% set selected=1
goto menu

:printOption
set "num=%~1"
set "text=%~2"

:: Highlight selected option using ANSI colors
if "%num%"=="!selected!" (
    echo !ESC![30;47m^> %num%. %text% !ESC![0m
) else (
    echo    %num%. %text%
)
exit /b

:select
cls
if %selected%==1 call %MUP%\SysReport.bat
if %selected%==2 call %MUP%\FileVirusScan.bat
if %selected%==3 call %MUP%\fsvs.bat
if %selected%==4 call %MUP%\SysInfo.bat
if %selected%==5 call %MUP%\NST.bat
if %selected%==6 call %MUP%\AddAcc.bat
if %selected%==7 call %MUP%\DelAcc.bat
if %selected%==8 call %MUP%\FormatDisk.bat
if %selected%==9 call %MUP%\CorruptedPenDrive.bat
if %selected%==10 call %MUP%\CmdColourChange.bat
if %selected%==11 call %MUP%\SearchFiles.exe
if %selected%==12 call %MUP%\FileHider.bat
if %selected%==13 call %MUP%\FileUnhider.bat
if %selected%==14 exit
goto menu
