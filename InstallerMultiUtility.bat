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
