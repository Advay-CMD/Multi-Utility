:: File Virus Scan
title File Virus Scan

echo Please Wait ./././././././././././././././././.      
call "C:\Windows\System32\Multi_Utility\filedialogtrial.bat"

:: Check if the file exists before scanning
if exist "%resultA%" (
    echo Scanning the file "%resultA%" for viruses...
    :: Scan the specified file using Windows Defender
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File "%resultA%"
) else (
    echo The file "%resultA%" does not exist. Please check the path and try again.
)

pause
echo.
goto menu
