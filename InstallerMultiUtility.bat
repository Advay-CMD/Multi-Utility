@echo off
echo.
echo Hello! Welcome to Multi-Utility! Thank you for clicking the Installer
echo.
pause
echo.
echo Are you sure you want to install Multi-Utility?
echo Once you approve some settings will be changed that cannot be undone by the uninstaller
@choice /c YN /m "Do you want to continue?"
IF %ERRORLEVEL% EQU 2 (
         TIMEOUT /T 5
         exit /b
) ELSE (
         break
)

:: Admin Checkup
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    break
) ELSE (
         echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
         echo UAC.ShellExecute "cmd.exe", "/c %~s0", "", "runas", 1 >> "%temp%\elevate.vbs"
         cscript //nologo "%temp%\elevate.vbs"
         del "%temp%\elevate.vbs"
         exit /b
)

echo.
echo Setup is starting...
timeout /t 5 >null
echo.
echo Where to install this product?
set /p installlocation="Where to install this product?         "
echo This setup will produce a lot of commands, thus please do not - 1. Close the window 2. Better is not to see those commands and garbage successfulls
echo.
pause
echo.
echo The setup will start Now...
echo.
echo ------------------------------------------------------------------------------------------------------------------------

:: Create a Multi-Utility in System32 folder
if not exist %installlocation%\Multi_Utility (
             md %installlocation%\Multi_Utility
)

:: Create a Format in Multi-Utility folder
if not exist %installlocation%\Multi_Utility\Format\ (
             md %installlocation%\Multi_Utility\Format\
)

:: Create a CorruptedPendirveFix in Multi-Utilty folder
if not exist %installlocation%\Multi_Utility\CorruptedPendirveFix\ (
             md %installlocation%\Multi_Utility\CorruptedPendirveFix\
)

:: Inserting data in  CorruptedPendirveFix.txt
echo select disk %SD% > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select vol %VL% > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo clean > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo create partition primary > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select disk %SD% > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select vol %VL% > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo format fs=%FE% > %installlocation%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt

:: In Format folder creating ListVol.txt to list volume using diskpart

:: First - Insert Data
echo list vol > %installlocation%\Multi_Utility\Format\ListVol.txt

:: In Format Folder creating ListDisk to list disk using diskpart

:: First - Insert Data
echo list disk > %installlocation%\Multi_Utility\Format\ListDisk.txt

:: In Format Folder creating Format to Format the disk using diskpart

:: First - Insert Data
echo select disk %SD% > %installlocation%\Multi_Utility\Format\Format.txt
echo select vol %VL% > %installlocation%\Multi_Utility\Format\Format.txt
echo format fs=%FE% Quick > %installlocation%\Multi_Utility\Format\Format.txt

:: Edit Here 1# - Add Certificate to Multi-Utility

:: Catch - Aim is to signify that this product is valid and is authentic... and also Installed

md %installlocation%\Multi_Utility\Certificate

:: Now it has made certificate, now we need data in it...

echo 1 > %installlocation%\Multi_Utility\Certificate\IsInstalledProductInSystem.txt

:: Now the data Can be Read to Signify if the product is valid authentic and still in system...

:: Edit Here 2# - Add a product key...

:: Catch - Here your Aim is to keep it as it is. This is only for futher devolopment of this software.

set /a rd=%random% / 2 * 7 - 2 / 12 * 1000 - %random% * %random% - 7 / 65 + 75 * 90 - %random% * 10000000 / (90 - 20 / 40 * 100) * 10 * 10 * 10 * 10 * 10 * 10 * 10 * 10 > C:\Windows\System32\Multi_Utility\Certificate\AlgorithmProtection.txt

:: Edit Here 3# - To make sure if OneDrive is there

:: Catch - Aim is to tell the software whether OneDrive is there or not, as many people have this feature in their systems.

md %installlocation%\Multi_Utility\OneDrive

if not exist %systemdrive%\Users\%username%\OneDrive (
              echo 0 > %installlocation%\Multi_Utility\OneDrive\IsOneDriveThere.txt
) else if exist %systemdrive%\Users\%username%\OneDrive (
              echo 1 > %systemdrive%\Users\%username%\OneDrive\IsOneDriveThere.txt
) else (
              echo Error!
              echo Exiting in...
              TIMEOUT /T 7
              exit
)

:: Edit here 4# - Put the app in the Multi_Utility folder
:: Catch - Aim is to put the app in this folder

:: First - Where is the app?
for /f "delims=" %%a in ('where /R %systemdrive%\Users *Multi_Utility.bat') do set "a=%%a"

:: Okay, if found then move to Multi_Utility folder
move %a% %installlocation%\Multi_Utility\

:: Hmm, what about desktop shortcut
if exist %systemdrive%\Users\%username%\OneDrive (
                    mklink "%systemdrive%\Users\%username%\OneDrive\Desktop\Multi_Utility" "%installlocation%\Multi_Utility\Multi_Utility.bat"
) else (
                    mklink "%systemdrive%\Users\%username%\Desktop\Multi_Utility" "%installlocation%\Multi_Utility\Multi_Utility.bat"
)
:: Now a .symlink file will be there. BUT the user can change it to proper shortcut

:: Edit here 5# - Register the app in settings
:: Catch - Aim is to put the app in settings to make uninstallation pretty easy

:: First - Where should we register this app?
:: Ans - Registry Editor

:: Now if it is like that then we would need to run these following commands
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\MultiUtility.bat" /t REG_SZ /v "" /d "%installlocation%\Multi_Utility\Multi_Utility.bat" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /t REG_SZ /v "DisplayName" /d "Multi Utility" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /t REG_SZ /v "InstallLocation" /d "%installlocation%\Multi_Utility\Multi_Utility.bat" /f
:: I will fill this later
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /t REG_SZ /v "UninstallString" /d "%installlocation%\Multi-Utility\UninstallString.bat" /f

:: Now the app will be seen in Settings

:: Edit here 7# - Put uninstall string in the Multi_Utility
for /f "delims=" %%a in ('where /R %systemdrive%\Users *UninstallString.bat') do set "a=%%a"

:: Okay, if found then move to Multi_Utility folder
move %a% %installlocation%\Multi_Utility

::Edit here 8# - Where is the app for the Multi Utility?

echo %installlocation% > %installlocation%\Multi_Utility\Certificate\installocation123098.txt

echo.
echo.
echo Done installing! Thank you for choosing this product.
echo.
pause
