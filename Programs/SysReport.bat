@echo off
:: System Report Script
title System Report
setlocal DisableDelayedExpansion

:: Generate safe date and time values
for /f %%i in ('wmic os get LocalDateTime ^| find "."') do set "dt=%%i"

if not defined dt (
    echo Error: Unable to retrieve system time.
    pause
    exit /b
)

set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "Min=%dt:~10,2%"
set "Sec=%dt:~12,2%"

set "dateStamp=%DD%-%MM%-%YYYY%"
set "timeStamp=%HH%-%Min%-%Sec%"

:: Folder where directories will be saved
set "reportFile=C:\Windows\System32\Multi_Utility\reportFile"
set "reportDir=%reportFile%\SysReport"
set "reportPath=%reportDir%\SysReport_Date_%dateStamp%_Time_%timeStamp%.txt"

:: Create the folder where directories will be saved if it does not exist
if not exist "%reportFile%" mkdir "%reportFile%"

:: Create the reports directory if it doesn't exist
if not exist "%reportDir%" mkdir "%reportDir%"

:: Write the new report
echo Here is the System Report
echo.

echo ========================= > "%reportPath%"
echo        SYSTEM REPORT      >> "%reportPath%"
echo ========================= >> "%reportPath%"
echo. >> "%reportPath%"
echo Report Generated on: %dateStamp% at %HH%:%Min%:%Sec% >> "%reportPath%"
echo. >> "%reportPath%"

:: Gather system information
echo CPU Information: >> "%reportPath%"
echo ------------------ >> "%reportPath%"
wmic cpu get Name >> "%reportPath%" 2>nul
echo. >> "%reportPath%"
echo Load Percentage (%%), Number of Cores: >> "%reportPath%"
wmic cpu get LoadPercentage,NumberOfCores >> "%reportPath%" 2>nul
echo. >> "%reportPath%"

echo Battery Information: >> "%reportPath%"
echo --------------------- >> "%reportPath%"
wmic path Win32_Battery get Name >> "%reportPath%" 2>nul
echo. >> "%reportPath%"
echo Estimated Charge Remaining (%%), Estimated Run Time (minutes): >> "%reportPath%"
wmic path Win32_Battery get EstimatedChargeRemaining,EstimatedRunTime >> "%reportPath%" 2>nul
echo. >> "%reportPath%"

echo Memory Information: >> "%reportPath%"
echo -------------------- >> "%reportPath%"
wmic os get Name >> "%reportPath%" 2>nul
echo. >> "%reportPath%"
echo Free Physical Memory (KB), Total Visible Memory Size (KB): >> "%reportPath%"
wmic os get FreePhysicalMemory,TotalVisibleMemorySize >> "%reportPath%" 2>nul
echo. >> "%reportPath%"

echo RAM Information: >> "%reportPath%"
echo ------------------ >> "%reportPath%"
wmic memorychip get Name >> "%reportPath%" 2>nul
echo. >> "%reportPath%"
echo Total RAM Capacity (Bytes): >> "%reportPath%"
wmic memorychip get Capacity >> "%reportPath%" 2>nul
echo. >> "%reportPath%"

echo GPU Information: >> "%reportPath%"
echo ------------------ >> "%reportPath%"
wmic path Win32_VideoController get Name >> "%reportPath%" 2>nul
echo. >> "%reportPath%"
echo Current Refresh Rate (Hz): >> "%reportPath%"
wmic path Win32_VideoController get CurrentRefreshRate >> "%reportPath%" 2>nul
echo. >> "%reportPath%"

echo ========================= >> "%reportPath%"
echo         END OF REPORT     >> "%reportPath%"
echo ========================= >> "%reportPath%"
echo. >> "%reportPath%"

:: Display the generated report
type "%reportPath%"

:: Ask user if they want to see the full report
echo.
choice /c YN /m "Do you want to see all saved reports (Y/N)?"

if errorlevel 2 exit /b

:: Display all reports
for %%f in ("%reportDir%\*.txt") do type "%%f"

pause
