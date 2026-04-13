:: System Report Script
title System Report

set time=%time:~0,2%%time:~3,2%%time:~6,2%%time:~9,4%
:: Removing Semicolons from Time

:: Folder where directories will be saved
set reportFile=C:\Windows\System32\Multi_Utility\reportFile
set reportDir=%reportFile%\SysReport
set reportPath=%reportDir%_Date_%date%_Time_%time%.txt

:: Create the folder where directories will be saved if it does not exist
if not exist %reportFile% (
    mkdir %reportFile%
)

:: Create the reports directory if it doesn't exist
if not exist %reportDir% (
    mkdir %reportDir%
)

:: Reset time
set time=%time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2%

:: Write the new report
echo Here is the System Report
echo.
echo ========================= >> %reportPath%
echo        SYSTEM REPORT      >> %reportPath%
echo ========================= >> %reportPath%
echo. >> %reportPath%
echo Report Generated on: %date% at %time% >> %reportPath%
echo. >> %reportPath%

:: Gather system information
echo CPU Information: >> %reportPath%
echo ------------------ >> %reportPath%
echo. >> %reportPath%
wmic cpu Get Name >> %reportPath%
echo. >> %reportPath%
echo Load Percentage (%%), Number of Cores: >> %reportPath%
wmic cpu get loadpercentage, NumberOfCores >> %reportPath%
echo. >> %reportPath%

echo Battery Information: >> %reportPath%
echo --------------------- >> %reportPath%
echo. >> %reportPath%
wmic path Win32_Battery get Name >> %reportPath%
echo. >> %reportPath%
echo Estimated Charge Remaining (%%), Estimated Run Time (minutes): >> %reportPath%
wmic path Win32_Battery get EstimatedChargeRemaining, EstimatedRunTime >> %reportPath%
echo. >> %reportPath%

echo Memory Information: >> %reportPath%
echo -------------------- >> %reportPath%
echo. >> %reportPath%
wmic OS get Name >>%reportPath%
echo. >> %reportPath%
echo Free Physical Memory (MB), Total Visible Memory Size (MB): >> %reportPath%
wmic OS get FreePhysicalMemory, TotalVisibleMemorySize >> %reportPath%
echo. >> %reportPath%

echo RAM Information: >> %reportPath%
echo ------------------ >> %reportPath%
echo. >> %reportPath%
wmic MEMORYCHIP get Name >> %reportPath%
echo. >> %reportPath%
echo Total RAM Capacity (GB): >> %reportPath%
wmic MEMORYCHIP get Capacity >> %reportPath%
echo. >> %reportPath%

echo GPU Information: >> %reportPath%
echo ------------------ >> %reportPath%
echo. >> %reportPath%
wmic path Win32_VideoController get Name
echo. >> %reportPath%
echo Current Refresh Rate (Hz): >> %reportPath%
wmic path Win32_VideoController get CurrentRefreshRate >> %reportPath%

echo. >> %reportPath%
echo ========================= >> %reportPath%
echo         END OF REPORT     >> %reportPath%
echo ========================= >> %reportPath%

echo. >> %reportPath%

type %reportPath%

:: Ask user if they want to see the full report
echo.
CHOICE /C YN /M "Do you want to see the full report (Y/N)?"
if errorlevel 2 (
    echo.
    goto menu
)

:: Display the full report
cd %reportFile%
for %%f in (*.txt) do type "%%f"

pause
echo.
