:: Format Disk
set FORMAT=%systemroot%\System32\Multi_Utility\Format

title Format Disk

echo.
echo Enter what to format to ntfs,fat32,fat(if the name is not out of these 3 it will result in program exit):
set /p "FE=Enter:"
Diskpart < C:\Windows\System32\Multi_Utility\Format\ListDisk.txt
echo.
echo Select Disk - 
set /p "SD=Enter Disk No:"
echo.
Diskpart < C:\Windows\System32\Multi_Utility\Format\ListVol.txt
echo.
echo Select Volume - 
set /p "VL=Enter Volume No:"
echo.
echo Formating...
Diskpart < C:\Windows\System32\Multi_Utility\Format\Format.txt
echo.
echo Formated
echo.
pause
echo.
