:: CorruptedPenDrive Fixer
set FORMAT=%ProgramFiles%\Multi_Utility\Format

title Corrupted pen drive fixer

echo.
echo Put the corrupted pen drive...
echo.
pause
echo.
echo Enter what to format to ntfs,fat32,fat(if the name is not out of these 3 it will result in program exit):
set /p "FE=Enter:"
Diskpart < %ProgramFiles%\Multi_Utility\Format\ListDisk.txt
echo.
echo Select Disk - 
set /p "SD=Enter Disk No:"
echo.
Diskpart < %ProgramFiles%\Multi_Utility\Format\ListVol.txt
echo.
echo Select Volume - 
set /p "VL=Enter Volume No:"
echo.
echo. Fixing...
Diskpart < %ProgramFiles%\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo.
echo Fixed! If it hasn't been fixed it can be because of the pendrive permanently damaged! Please go to a technical store if not fixed!
echo.
pause
echo.
