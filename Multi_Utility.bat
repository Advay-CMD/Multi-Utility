@echo off
setlocal EnableDelayedExpansion

:: Path
set "MUP=%ProgramFiles%\Multi_Utility\Programs"

:: Admin check
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Requesting admin...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb runAs"
    exit /b
)

:: Enable ANSI
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

:: ---------------- MAIN MENU ----------------
:main_menu
set selected=1
set max=11

:main_loop
cls
echo ==========================================
echo              MULTI-UTILITY
echo ==========================================
echo Did you know that I, who created this is 13, started when I was 11... probably, no.
echo Use W (Up), S (Down), X (Select)
echo.

call :print 1  "System Report"
call :print 2  "Scan File for Viruses"
call :print 3  "System Scan"
call :print 4  "System Information"
call :print 5  "Network Speed Tester"
call :print 6  "Format Disk"
call :print 7  "Corrupted Pendrive Fixer"
call :print 8  "CMD Colour Change"
call :print 9  "File Utilities"
call :print 10 "Account Management"
call :print 11 "-----Plugins-----"
call :print 12 "Exit"

call :input

if "!action!"=="up" set /a selected-=1
if "!action!"=="down" set /a selected+=1
if "!action!"=="select" goto main_select

if !selected! LSS 1 set selected=%max%
if !selected! GTR %max% set selected=1

goto main_loop

:main_select
if %selected%==1 call "%MUP%\SysReport.bat"
if %selected%==2 call "%MUP%\FileVirusScan.bat"
if %selected%==3 call "%MUP%\fsvs.bat"
if %selected%==4 call "%MUP%\SysInfo.bat"
if %selected%==5 call "%MUP%\NST.bat"
if %selected%==6 call "%MUP%\FormatDisk.bat"
if %selected%==7 call "%MUP%\CorruptedPenDrive.bat"
if %selected%==8 call "%MUP%\ccc.bat"
if %selected%==9 goto file_menu
if %selected%==10 goto account_menu
if %selected%==11 goto plugins_menu ::Does NOT work right now...
if %selected%==12 exit

pause
goto main_menu

:: ----------------Plugins Menu--------------
:plugins_menu
set selected=1
set max=4

:plugins_loop
cls
echo ========== Plugins ==========
echo.

call :print 1 "Add Plugins"
call :print 2 "See Installed Plugins"
call :print 3 "Delete Plugins"
call :print 4 "Back"

call :input

if "!action!"=="up" set /a selected-=1
if "!action!"=="down" set /a selected+=1
if "!action!"=="select" goto plugin_select

if !selected! LSS 1 set selected=%max%
if !selected! GTR %max% set selected=1

goto plugins_loop

:plugin_select
if %selected%==1 "%MUP%\AddPlugin.bat"
if %selected%==2 call "%MUP%\ViewPlugin.bat"
if %selected%==3 call "%MUP%\DelPlugin.bat"
if %selected%==4 goto main_menu

pause
goto plugins_menu


:: ---------------- FILE MENU ----------------
:file_menu
set selected=1
set max=4

:file_loop
cls
echo ===== File Utilities =====
echo.

call :print 1 "Search Files"
call :print 2 "File Hider"
call :print 3 "File Unhider"
call :print 4 "Back"

call :input

if "!action!"=="up" set /a selected-=1
if "!action!"=="down" set /a selected+=1
if "!action!"=="select" goto file_select

if !selected! LSS 1 set selected=%max%
if !selected! GTR %max% set selected=1

goto file_loop

:file_select
if %selected%==1 "%MUP%\SearchFiles.exe"
if %selected%==2 call "%MUP%\FileHider.bat"
if %selected%==3 call "%MUP%\FileUnhider.bat"
if %selected%==4 goto main_menu

pause
goto file_menu

:: ---------------- ACCOUNT MENU ----------------
:account_menu
set selected=1
set max=3

:acc_loop
cls
echo ===== Account Management =====
echo.

call :print 1 "Add Account"
call :print 2 "Delete Account"
call :print 3 "Back"

call :input

if "!action!"=="up" set /a selected-=1
if "!action!"=="down" set /a selected+=1
if "!action!"=="select" goto acc_select

if !selected! LSS 1 set selected=%max%
if !selected! GTR %max% set selected=1

goto acc_loop

:acc_select
if %selected%==1 call "%MUP%\AddAcc.bat"
if %selected%==2 call "%MUP%\DelAcc.bat"
if %selected%==3 goto main_menu

pause
goto account_menu

:: ---------------- INPUT HANDLER ----------------
:input
choice /c WSX /n >nul

if errorlevel 3 set action=select
if errorlevel 2 set action=down
if errorlevel 1 set action=up

exit /b

:: ---------------- PRINT ----------------
:print
set "num=%~1"
set "text=%~2"

if "%num%"=="!selected!" (
    echo !ESC![30;47m^> %num%. %text% !ESC![0m
) else (
    echo    %num%. %text%
)
exit /b
