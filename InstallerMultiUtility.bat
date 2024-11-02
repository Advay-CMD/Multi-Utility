@echo off

:: Create a Multi-Utility in System32 folder
if not exist C:\Windows\System32\Multi_Utility (
             md C:\Windows\System32\Multi_Utility
)

:: Create a Format in Multi-Utility folder
if not exist C:\Windows\System32\Multi_Utility\Format (
             md C:\Windows\System32\Multi_Utility\Format
)

:: Create a CorruptedPendirveFix in Multi-Utilty folder
if not exist C:\Windows\System32\Multi_Utility\CorruptedPendirveFix (
             md C:\Windows\System32\Multi_Utility\CorruptedPendirveFix
)

:: Inserting data in  CorruptedPendirveFix.txt
echo select disk %SD% > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select vol %VL% > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo clean > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo create partition primary > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select disk %SD% > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo select vol %VL% > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo format fs=%FE% > C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt

:: In Format folder creating ListVol.txt to list volume using diskpart

:: First - Create ListVol.txt
if not exist C:\Windows\System32\Multi_Utility\Format\ListVol.txt (
            md C:\Windows\System32\Multi_Utility\Format\ListVol.txt
)

:: Second - Insert Data
echo list vol > C:\Windows\System32\Multi_Utility\Format\ListVol.txt

:: In Format Folder creating ListDisk to list disk using diskpart

:: First - Create ListDisk.txt
if not exist C:\Windows\System32\Multi_Utility\Format\ListDisk.txt (
            md C:\Windows\System32\Multi_Utility\Format\ListDisk.txt
)

:: Second - Insert Data
echo list disk > C:\Windows\System32\Multi_Utility\Format\ListDisk.txt

:: In Format Folder creating Format to Format the disk using diskpart

:: First - Create Format.txt
if not exist C:\Windows\System32\Multi_Utility\Format\Format.txt (
            md C:\Windows\System32\Multi_Utility\Format\Format.txt
)

:: Second - Insert Data
echo select disk %SD% > C:\Windows\System32\Multi_Utility\Format\Format.txt
echo select vol %VL% > C:\Windows\System32\Multi_Utility\Format\Format.txt
echo format fs=%FE% Quick > C:\Windows\System32\Multi_Utility\Format\Format.txt

:: Edit Here 1# - Add Certificate to Multi-Utility

:: Catch - Aim is to signify that this product is valid and is authentic... and also Installed

md C:\Windows\System32\Multi_Utility\Certificate
md C:\Windows\System32\Multi_Utility\Certificate\IsInstalledProductInSystem.txt

:: Now it has made certificate, now we need data in it...

echo 1 > C:\Windows\System32\Multi_Utility\Certificate\IsInstalledProductInSystem.txt

:: Now the data Can be Read to Signify if the product is valid authentic and still in system...
