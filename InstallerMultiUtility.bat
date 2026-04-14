@echo off
setlocal EnableExtensions EnableDelayedExpansion

echo.
echo Hello! Welcome to Multi-Utility! Thank you for clicking the Installer
echo.
pause
echo.
echo Are you sure you want to install Multi-Utility?
echo Once you approve some settings will be changed that cannot be undone by the uninstaller
choice /c YN /m "Do you want to continue?"

IF ERRORLEVEL 2 (
    TIMEOUT /T 5 >nul
    exit /b
)

:: Admin Checkup
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~f0""", "", "runas", 1 >> "%temp%\elevate.vbs"
    cscript //nologo "%temp%\elevate.vbs"
    del "%temp%\elevate.vbs"
    exit /b
)

echo.
echo Setup is starting...
timeout /t 5 >nul
echo.
echo This setup will produce a lot of commands, thus please do not:
echo 1. Close the window
echo 2. Better is not to see those commands and garbage successfuls
echo.
pause
echo.
echo The setup will start Now...
echo.
echo ------------------------------------------------------------------------------------------------------------------------

:: Define Installation Directory
set "INSTALL_DIR=%SystemRoot%\System32\Multi_Utility"

:: Create Required Directories
mkdir "%INSTALL_DIR%" 2>nul
mkdir "%INSTALL_DIR%\Programs" 2>nul
mkdir "%INSTALL_DIR%\Format" 2>nul
mkdir "%INSTALL_DIR%\Certificate" 2>nul
mkdir "%INSTALL_DIR%\CorruptedPendriveFix" 2>nul
mkdir "%INSTALL_DIR%\OneDrive" 2>nul

:: Inserting data in CorruptedPendriveFix.txt
echo select disk %%SD%% > "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"
echo select vol %%VL%% >> "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"
echo clean >> "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"
echo create partition primary >> "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"
echo select disk %%SD%% >> "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"
echo select vol %%VL%% >> "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"
echo format fs=%%FE%% >> "%INSTALL_DIR%\CorruptedPendriveFix\CorruptedPendriveFix.txt"

:: In Format folder creating ListVol.txt to list volume using diskpart
echo list vol > "%INSTALL_DIR%\Format\ListVol.txt"

:: In Format Folder creating ListDisk.txt to list disk using diskpart
echo list disk > "%INSTALL_DIR%\Format\ListDisk.txt"

:: In Format Folder creating Format.txt to Format the disk using diskpart
echo select disk %%SD%% > "%INSTALL_DIR%\Format\Format.txt"
echo select vol %%VL%% >> "%INSTALL_DIR%\Format\Format.txt"
echo format fs=%%FE%% Quick >> "%INSTALL_DIR%\Format\Format.txt"

:: Edit Here 1# - Add Certificate to Multi-Utility
:: Catch - Aim is to signify that this product is valid and is authentic... and also Installed
echo 1 > "%INSTALL_DIR%\Certificate\IsInstalledProductInSystem.txt"

:: Edit Here 2# - Add a product key...
:: Catch - Here your Aim is to keep it as it is. This is only for futher development of this software.
set /a rd=%random% * %random%
echo %rd% > "%INSTALL_DIR%\Certificate\AlgorithmProtection.txt"

:: Edit Here 3# - To make sure if OneDrive is there
:: Catch - Aim is to tell the software whether OneDrive is there or not.
if exist "%UserProfile%\OneDrive" (
    echo 1 > "%INSTALL_DIR%\OneDrive\IsOneDriveThere.txt"
) else (
    echo 0 > "%INSTALL_DIR%\OneDrive\IsOneDriveThere.txt"
)

:: Edit here 4# - Put the app in the Multi_Utility folder
:: Catch - Aim is to put the app in this folder
for /f "delims=" %%a in ('where /R "%SystemDrive%\Users" Multi_Utility.bat 2^>nul') do (
    move "%%a" "%INSTALL_DIR%\" >nul 2>&1
)

:: Hmm, what about desktop shortcut
if exist "%UserProfile%\OneDrive\Desktop" (
    mklink "%UserProfile%\OneDrive\Desktop\Multi_Utility.bat" "%INSTALL_DIR%\Multi_Utility.bat"
) else (
    mklink "%UserProfile%\Desktop\Multi_Utility.bat" "%INSTALL_DIR%\Multi_Utility.bat"
)

:: Edit here 5# - Register the app in settings
:: Catch - Aim is to put the app in settings to make uninstallation pretty easy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\MultiUtility.bat" /ve /d "%INSTALL_DIR%\Multi_Utility.bat" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /v "DisplayName" /d "Multi Utility" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /v "InstallLocation" /d "%INSTALL_DIR%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /v "UninstallString" /d "%INSTALL_DIR%\UninstallString.bat" /f

:: Edit here 6# - Put the Programs in the Programs folder
mkdir "%INSTALL_DIR%\Programs" 2>nul

for %%F in (
AddAcc.bat
DelAcc.bat
CorruptedPenDrive.bat
FileHider.bat
FileUnhider.bat
FileVirusScan.bat
FormatDisk.bat
NST.bat
SearchFiles.exe
SysInfo.bat
SysReport.bat
ccc.bat
fsvs.bat
CmdColourChange.bat
) do (
    for /f "delims=" %%a in ('where /R "%SystemDrive%\Users" %%F 2^>nul') do (
        move "%%a" "%INSTALL_DIR%\Programs\" >nul 2>&1
    )
)

:: Edit here 7# - Put uninstall string and the file dialog in the Multi_Utility

:: Uninstall string
for /f "delims=" %%a in ('where /R "%SystemDrive%\Users" UninstallString.bat 2^>nul') do (
    move "%%a" "%INSTALL_DIR%\" >nul 2>&1
)

:: File dialog
for /f "delims=" %%a in ('where /R "%SystemDrive%\Users" filedialogtrial.bat 2^>nul') do (
    move "%%a" "%INSTALL_DIR%\" >nul 2>&1
)

:: Thanks
cls
echo.
echo Done installing! Thank you for choosing this product.
pause
exit /b
