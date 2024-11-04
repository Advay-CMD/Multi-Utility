@echo off

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
