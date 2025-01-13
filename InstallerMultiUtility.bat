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
    echo.
    echo FATAL ERROR!
    echo.
    echo You are not running this program as a administrator!
    echo.
    echo This Program Is Going To Automatically Exit In
    TIMEOUT /T 10
    exit /b
)

echo.
echo Setup is starting...
timeout /t 5 >nullgar
echo.
echo This setup will produce a lot of commands, thus please do not - 1. Close the window 2. Better is not to see those commands and garbage successfulls
echo.
pause
echo.
echo The setup will start Now...
echo.
echo ------------------------------------------------------------------------------------------------------------------------

:: Create a Multi-Utility in System32 folder
if not exist %systemroot%\System32\Multi_Utility (
             md %systemroot%\System32\Multi_Utility
)

:: Create a Format in Multi-Utility folder
if not exist %systemroot%\System32\Multi_Utility\Format (
             md %systemroot%\System32\Multi_Utility\Format
)

:: Create a CorruptedPendirveFix in Multi-Utilty folder
if not exist %systemroot%\System32\Multi_Utility\CorruptedPendirveFix (
             md %systemroot%\System32\Multi_Utility\CorruptedPendirveFix
)

:: Inserting data in  CorruptedPendirveFix.txt
echo select disk %SD% > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select vol %VL% > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo clean > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo create partition primary > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select disk %SD% > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select vol %VL% > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo format fs=%FE% > %systemroot%\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt

:: In Format folder creating ListVol.txt to list volume using diskpart

:: First - Create ListVol.txt
if not exist %systemroot%\System32\Multi_Utility\Format\ListVol.txt (
            md %systemroot%\System32\Multi_Utility\Format\ListVol.txt
)

:: Second - Insert Data
echo list vol > %systemroot%\System32\Multi_Utility\Format\ListVol.txt

:: In Format Folder creating ListDisk to list disk using diskpart

:: First - Create ListDisk.txt
if not exist %systemroot%\System32\Multi_Utility\Format\ListDisk.txt (
            md %systemroot%\Multi_Utility\Format\ListDisk.txt
)

:: Second - Insert Data
echo list disk > %systemroot%\System32\Multi_Utility\Format\ListDisk.txt

:: In Format Folder creating Format to Format the disk using diskpart

:: First - Create Format.txt
if not exist %systemroot%\System32\Multi_Utility\Format\Format.txt (
            md %systemroot%\System32\Multi_Utility\Format\Format.txt
)

:: Second - Insert Data
echo select disk %SD% > %systemroot%\System32\Multi_Utility\Format\Format.txt
echo select vol %VL% > %systemroot%\System32\Multi_Utility\Format\Format.txt
echo format fs=%FE% Quick > %systemroot%\System32\Multi_Utility\Format\Format.txt

:: Edit Here 1# - Add Certificate to Multi-Utility

:: Catch - Aim is to signify that this product is valid and is authentic... and also Installed

md %systemroot%\System32\Multi_Utility\Certificate
md %systemroot%\System32\Multi_Utility\Certificate\IsInstalledProductInSystem.txt

:: Now it has made certificate, now we need data in it...

echo 1 > %systemroot%\System32\Multi_Utility\Certificate\IsInstalledProductInSystem.txt

:: Now the data Can be Read to Signify if the product is valid authentic and still in system...

:: Edit Here 2# - Add a product key...

:: Catch - Here your Aim is to keep it as it is. This is only for futher devolopment of this software.

md %systemroot%\System32\Multi_Utility\Certificate\AlgorithmProtection.txt
set /a rd=%random% / 2 * 7 - 2 / 12 * 1000 - %random% * %random% - 7 / 65 + 75 * 90 - %random% * 10000000 / (90 - 20 / 40 * 100) * 10 * 10 * 10 * 10 * 10 * 10 * 10 * 10 > C:\Windows\System32\Multi_Utility\Certificate\AlgorithmProtection.txt

:: Edit Here 3# - Theif Security password

:: Catch - Aim here is to not let a thief damage the computer by using the software repeatedly.

:: How will it protect? - It will present a number challengephrase and if the no. entered is wrong then it will exit.

:: If user wants to remove the password - He can remove BUT it will count how many times the software is used. If it is 25 then he will be asked a number challengephrase.

md %systemroot%\System32\Multi_Utility\Password
md %systemroot%\System32\Multi_Utility\Password\TimesUsed
md %systemroot%\System32\Multi_Utility\Password\IsTimeUsedThere

:: Not allowing everyone to read just loged in User

icacls "%systemroot%\System32\Multi_Utility\Password\TimesUsed" /inheritance:r
icacls "%systemroot%\System32\Multi_Utility\Password\TimesUsed" /grant:r "Administrator":R
icacls "%systemroot%\System32\Multi_Utility\Password\TimesUsed" /deny "Everyone":F

icacls "%systemroot%\System32\Multi_Utility\Password\IsTimeUsedThere" /inheritance:r
icacls "%systemroot%\System32\Multi_Utility\Password\IsTimeUsedThere" /grant:r "Administrator":R
icacls "%systemroot%\System32\Multi_Utility\Password\IsTimeUsedThere" /deny "Everyone":F

:: Then not allowing anyone :) exept cmd

attrib +h "%systemroot%\System32\Multi_Utility\Password\TimesUsed"
attrib +h "%systemroot%\System32\Multi_Utility\Password\IsTimeUsedThere"

:: By default it is time used.

echo 1 > %systemroot%\System32\Multi_Utility\Password\IsTimeUsedThere

:: Then telling the user that he should not be there >:)

md %systemroot%\System32\Multi_Utility\Password\GETLOST.txt
set "GETLOSTTXT=%systemroot%\System32\Multi_Utility\Password\GETLOST.txt"
echo GET LOST! You SHOULD NOT be here! > %GETLOSTTXT%
echo You will find nothing here! > %GETLOSETTXT%

:: Edit Here 4# - To make sure if OneDrive is there

:: Catch - Aim is to tell the software whether OneDrive is there or not, as many people have this feature in their systems.

md %systemroot%\System32\Multi_Utility\OneDrive
md %systemroot%\System32\Multi_Utility\OneDrive\IsOneDriveThere.txt

if not exist %systemdrive%\Users\%username%\OneDrive (
              echo 0 > %systemroot%\System32\Multi_Utility\OneDrive\IsOneDriveThere.txt
) else if exist %systemdrive%\Users\%username%\OneDrive (
              echo 1 > %systemdrive%\Users\%username%\OneDrive\IsOneDriveThere.txt
) else (
              echo Error!
              echo Exiting in...
              TIMEOUT /T 7
              exit
)

:: Edit here 5# - Put the app in the Multi_Utility folder
:: Catch - Aim is to put the app in this folder

:: First - Where is the app?
for /f "delims=" %%a in ('where /R %systemdrive%\Users *Multi_Utility.bat') do set "a=%%a"

:: Okay, if found then move to Multi_Utility folder
move %a% %systemroot%\System32\Multi_Utility

:: Hmm, what about desktop shortcut
if exist %systemdrive%\Users\%username%\OneDrive (
                    mklink "%systemdrive%\Users\%username%\OneDrive\Desktop\Multi_Utility" "%systemroot%\System32\Multi_Utility\Multi_Utility"
) else (
                    mklink "%systemdrive%\Users\%username%\Desktop\Multi_Utility" "%systemroot%\System32\Multi_Utility\Multi_Utility"
)
:: Now a .symlink file will be there. BUT the user can change it to proper shortcut

:: Edit here 6# - Register the app in settings
:: Catch - Aim is to put the app in settings to make uninstallation pretty easy

:: First - Where should we register this app?
:: Ans - Registry Editor

:: Now if it is like that then we would need to run these following commands
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\MultiUtility.bat" /t REG_SZ /v "" /d "%systemroot%\System32\Multi_Utility\Multi_Utility.bat" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /t REG_SZ /v "DisplayName" /d "Multi Utility" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /t REG_SZ /v "InstallLocation" /d "%systemroot%\System32\Multi_Utility\Multi_Utility.bat" /f
:: I will fill this later
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /t REG_SZ /v "UninstallString" /d "%systemroot%\System32\Multi-Utility\UninstallString.bat" /f

:: Now the app will be seen in Settings

:: Edit here 7# - Put uninstall string in the Multi_Utility
for /f "delims=" %%a in ('where /R %systemdrive%\Users *UninstallString.bat') do set "a=%%a"

:: Okay, if found then move to Multi_Utility folder
move %a% %systemroot%\System32\Multi_Utility
