@echo off

:: MUP is Multi Utility Path
set "MUP=%ProgramFiles%\Multi_Utility\Programs"

:: Check for Administrator Privileges
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    :: Not admin, relaunch using VBScript
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~f0""", "", "runas", 1 >> "%temp%\elevate.vbs"
    cscript //nologo "%temp%\elevate.vbs"
    del "%temp%\elevate.vbs"
    exit /b
)

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
echo Did you know that I, who created this is 13, started when I was 11... probably, no.
echo Please use W (Up), S (Down), X (Select)
echo.

call :printOption 1  "System Report"
call :printOption 2  "Scan File for Viruses"
call :printOption 3  "System Scan"
call :printOption 4  "System Information"
call :printOption 5  "Network Speed Tester"
call :printOption 6  "Format Disk"
:: call :printOption 8  "Format Disk"
call :printOption 7  "Corrupted Pendrive Fixer"
call :printOption 8 "CMD Colour Change"
call :printOption 9 "File Utility's"
call :printOption 10 "---Deprecated---"
call :printOption 11 "Exit"

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

:menu_file
echo ==========================================
echo              MULTI-UTILITY
echo ==========================================
echo.
rem There is NO WAY I can do 1 and 2. Sad... Or else I will have to rewrite the logic... If someone has suggestions, pull up.
call :printOption 91 "Search Files"
call :printOption 92 "File Hider"
call :printOption 93 "File Unhider"

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


:menu_Deprecated
echo ==========================================
echo              MULTI-UTILITY
echo ==========================================
echo.
rem There is NO WAY I can do 1 and 2. Sad... Or else I will have to rewrite the logic... If someone has suggestions, pull up.
call :printOption 101 "Account Managment"

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

:menu_Account
echo ==========================================
echo              MULTI-UTILITY
echo ==========================================
echo.
rem There is NO WAY I can do 1 and 2. Sad... Or else I will have to rewrite the logic... If someone has suggestions, pull up.
call :printOption 1011 "Add an Account"
call :printOption 1012 "Delete an Account"

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
set "choice=%selected%"

:: Temporarily disable delayed expansion for external scripts
setlocal DisableDelayedExpansion

if "%choice%"=="1" call "%MUP%\SysReport.bat"
if "%choice%"=="2" call "%MUP%\FileVirusScan.bat"
if "%choice%"=="3" call "%MUP%\fsvs.bat"
if "%choice%"=="4" call "%MUP%\SysInfo.bat"
if "%choice%"=="5" call "%MUP%\NST.bat"
if "%choice%"=="1011" call "%MUP%\AddAcc.bat"
if "%choice%"=="1012" call "%MUP%\DelAcc.bat"
if "%choice%"=="6" call "%MUP%\FormatDisk.bat"
if "%choice%"=="7" call "%MUP%\CorruptedPenDrive.bat"
if "%choice%"=="8" call "%MUP%\ccc.bat"
if "%choice%"=="10" goto menu_Deprecated
if "%choice%"=="101" goto menu_Account
if "%choice%"=="9" goto menu_file
if "%choice%"=="91" "%MUP%\SearchFiles.exe"
if "%choice%"=="92" call "%MUP%\FileHider.bat"
if "%choice%"=="93" call "%MUP%\FileUnhider.bat"
if "%choice%"=="11" exit
endlocal
goto menu
