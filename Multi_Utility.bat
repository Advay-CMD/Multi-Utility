@echo off

setlocal EnableDelayedExpansion

:: Current version
set "VERSION=v1.2.1"

:: Temp file paths
set "VER_FILE=%TEMP%\version_release.txt"
set "DEST=%TEMP%\Multi_Utility.tar"

:: Clean old files
if exist "!VER_FILE!" del /f /q "!VER_FILE!"
if exist "!DEST!" del /f /q "!DEST!"

:: ---------------------------
:: Download version file (curl)
:: ---------------------------
curl -L -o "!VER_FILE!" "https://raw.githubusercontent.com/Advay-CMD/Multi-Utility/main/.version_release" >nul 2>&1

:: Fallback to PowerShell if curl failed
if not exist "!VER_FILE!" (
    echo Curl failed, trying PowerShell...
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Advay-CMD/Multi-Utility/main/.version_release' -OutFile '%VER_FILE%'" >nul 2>&1
)

:: Check again
if not exist "!VER_FILE!" (
    echo Failed to fetch latest version.
    pause
    exit /b
)

:: ---------------------------
:: Read latest version safely
:: ---------------------------
for /f "usebackq delims=" %%A in ("!VER_FILE!") do (
    set "LATEST=%%A"
)

set "LATEST=!LATEST: =!"

:: Debug (remove later if you want)
echo Current: !VERSION!
echo Latest:  !LATEST!
echo.

:: ---------------------------
:: Compare versions
:: ---------------------------
if /I "!VERSION!" NEQ "!LATEST!" (
    echo Update Available!
    echo.

    set /p ANS=Do you want to install update? ^(YES/NO^): 

    if /I "!ANS!"=="YES" (
        echo.
        echo Downloading update...

        set "DOWNLOAD_URL=https://github.com/Advay-CMD/Multi-Utility/releases/download/v1.2.1/Multi-Utility-main.tar.xz"

        :: Try curl
        curl -L -o "!DEST!" "!DOWNLOAD_URL!" >nul 2>&1

        :: Fallback to PowerShell
        if not exist "!DEST!" (
            echo Curl failed, trying PowerShell...
            powershell -Command "Invoke-WebRequest -Uri '!DOWNLOAD_URL!' -OutFile '!DEST!'" >nul 2>&1
        )

        if not exist "!DEST!" (
            echo Download failed.
            pause
            exit /b
        )

        echo.
        echo Extracting...

        :: Detect Desktop path
        if exist "%USERPROFILE%\OneDrive\Desktop" (
            set "DESKTOP=%USERPROFILE%\OneDrive\Desktop"
        ) else (
            set "DESKTOP=%USERPROFILE%\Desktop"
        )

        echo Using Desktop: !DESKTOP!

        :: Extract (requires Windows 10+)
        tar -xf "!DEST!" -C "!DESKTOP!"
        if errorlevel 1 (
            echo Extraction failed. Your system may not support tar.
            pause
            exit /b
        )

        echo.
        echo Update installed on Desktop.
        pause

        echo Running Uninstall...
        call "%~dp0UninstallString.bat"
    ) else (
        echo Update cancelled.
        pause
    )
) else (
    echo You are already up to date.
    pause
)

endlocal


:: MUP is Multi Utility Path
set "MUP=%SystemRoot%\System32\Multi_Utility\Programs"

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
echo New - There is a Menu
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
:: call :printOption 8  "Format Disk"
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
set "choice=%selected%"

:: Temporarily disable delayed expansion for external scripts
setlocal DisableDelayedExpansion

if "%choice%"=="1" call "%MUP%\SysReport.bat"
if "%choice%"=="2" call "%MUP%\FileVirusScan.bat"
if "%choice%"=="3" call "%MUP%\fsvs.bat"
if "%choice%"=="4" call "%MUP%\SysInfo.bat"
if "%choice%"=="5" call "%MUP%\NST.bat"
if "%choice%"=="6" call "%MUP%\AddAcc.bat"
if "%choice%"=="7" call "%MUP%\DelAcc.bat"
if "%choice%"=="8" call "%MUP%\FormatDisk.bat"
if "%choice%"=="9" call "%MUP%\CorruptedPenDrive.bat"
if "%choice%"=="10" call "%MUP%\ccc.bat"
if "%choice%"=="11" "%MUP%\SearchFiles.exe"
if "%choice%"=="12" call "%MUP%\FileHider.bat"
if "%choice%"=="13" call "%MUP%\FileUnhider.bat"
if "%choice%"=="14" exit
endlocal
goto menu
