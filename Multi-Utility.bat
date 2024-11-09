@echo off
set MU=C:\Windows\System32\Multi_Utility
set FORMAT=C:\Windows\System32\Multi_Utility\Format

cls

title Welcome to Multi-Utility!

echo Welcome to Multi-Utility! Here you have to choose an option from menu!
echo.
pause
echo.
:menu
title Multi-Utility Options - 
echo Choose an Option:
echo 1.  System Report
echo 2.  Scan File for Viruses
echo 3.  System Scan
echo 4.  System Information
echo 5.  Network Speed Tester
echo 6.  Add a Account
echo 7.  Delete Account
echo 8.  Format Disk
echo 9.  Corrupted Pendrive Fixer
echo 10. CMD Colour Change
echo 11. Search Files
echo 12. .Bat to .Exe
echo 13. Exit
set /p choice=Enter your choice (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, or 11): 

if "%choice%"=="1" (
    goto SysReport
) else if "%choice%"=="2" (
    goto VirusScan
) else if "%choice%"=="3" (
        goto SystemScan
) else if "%choice%"=="4" (
        goto SystemInfo
) else if "%choice%"=="5" (
        goto NetworkSpeedTester
) else if "%choice%"=="6" (
        goto AddAccount
) else if "%choice%"=="7" (
        goto DeleteAccount
) else if "%choice%"=="8" (
        goto FormatDisk
) else if "%choice%"=="9" (
        goto CorruptedPenDrive
) else if "%choice%"=="10" (
        goto CmdColourChange
) else if "%choice%"=="11" (
        goto SearchFiles
) else if "%choice%"=="12" (
        goto Battoexe
) else if "%choice%"=="13" (
        exit
) else (
    echo.
    echo Invalid choice. Please try again.
    echo.
    goto menu
)

:SysReport

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
wimc OS get Name >>%reportPath%
echo. >> %reportPath%
echo Free Physical Memory (MB), Total Visible Memory Size (MB): >> %reportPath%
wmic OS get FreePhysicalMemory, TotalVisibleMemorySize >> %reportPath%
echo. >> %reportPath%

echo RAM Information: >> %reportPath%
echo ------------------ >> %reportPath%
echo. >> %reportPath%
wimc MEMORYCHIP get Name >> %reportPath%
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
goto menu

:SystemScan

title System Scan

echo Running system scan...
:: You can replace the command below with your preferred scanning tool or command
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1

pause
echo.
goto menu

:VirusScan

title File Virus Scan

echo Enter the full path of the file to scan for viruses:
set /p filepath=File Path: 

:: Check if the file exists before scanning
if exist "%filepath%" (
    echo Scanning the file "%filepath%" for viruses...
    :: Scan the specified file using Windows Defender
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3 -File "%filepath%"
) else (
    echo The file "%filepath%" does not exist. Please check the path and try again.
)

pause
echo.
goto menu

:SystemInfo

title System Information

echo Gathering system information...
echo -------------------------------
echo            SYSTEM INFORMATION
echo -------------------------------

echo CPU:
wmic cpu get Name
wmic cpu get NumberOfCores, CurrentClockSpeed
echo.

echo Memory:
wmic MEMORYCHIP get Capacity, Manufacturer
echo.

echo Operating System:
wmic OS get Caption, Version, OSArchitecture
echo.

echo GPU:
wmic path Win32_VideoController get Name, CurrentRefreshRate
echo.

pause
echo.
goto menu

:NetworkSpeedTester

title Network Speed Tester

echo.
echo Testing network speed...
echo.
echo This may take a little time...
powershell -Command "Test-Connection -ComputerName google.com -Count 1"
pause
echo.
goto menu

:AddAccount

title Add Account

echo.
echo Enter Account Name(without illegal symbols): 
set /p "Account=Enter Account:"
net user %ACCOUNT% /add
if %ERRORLEVEL%==2 (
echo Error! This can be because the account already exists or you have used Illegal symbols. Try not including ?,>, and <.
echo.
pause
goto AddAccount
) else if %ERRORLEVEL%==1 (
echo Error! This can be because the account already exists or you have used Illegal symbols. Try not including ?,>, and <.
echo.
pause
goto AddAccount
) else (
break
)
echo Added!
echo.
echo Enter Password
set /p "Password=Password:"
net user %ACCOUNT% %PASSWORD%
echo Sucsessfully Done!
echo.
pause
echo.
goto menu

:DeleteAccount

title Delete Account

echo.
echo Enter The account you want to delete:
set /p "Daccount=Enter Account:"
net user %DACCOUNT% /delete
if %ERRORLEVEL%==2 (
echo Error! This could be because that the account entered is not correct! Recheck the account!
echo.
pause
goto DeleteAccount
) else if %ERRORLEVEL%==1 (
echo Error! This could be because that the account entered is not correct! Recheck the account!
echo.
pause
goto DeleteAccount
) else (
break
)
echo Deleted!
echo.
pause
echo.
goto menu

:FormatDisk

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
goto menu

:CorruptedPenDrive

title Corrupted pen drive fixer

echo.
echo Put the corrupted pen drive...
echo.
pause
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
echo. Fixing...
Diskpart < C:\Windows\System32\Multi_Utility\CorruptedPendriveFix\CorruptedPendriveFix.txt
echo.
echo Fixed! If it hasn't been fixed it can be because of the pendrive permanently damaged! Please go to a technical store if not fixed!
echo.
pause
echo.
goto menu

:CmdColourChange

title Cmd Colour Change

echo.
echo Please see the table below to select the background colour...
echo     0 = Black       8 = Gray
echo     1 = Blue        9 = Light Blue
echo     2 = Green       A = Light Green
echo     3 = Aqua        B = Light Aqua
echo     4 = Red         C = Light Red
echo     5 = Purple      D = Light Purple
echo     6 = Yellow      E = Light Yellow
echo     7 = White       F = Bright White
echo.
set /p "Background=Enter Background Colour:"
echo You entered %BACKGROUND%
echo.
set /p "Text=Enter Text Colour:"
echo You Entered %TEXT%
echo Setting The Colour...
COLOR %BACKGROUND%%TEXT%
echo.
echo Done! If you do not see any change or not your desired color it might be because you entered wrong or two same numbers or 2 or more numbers.
echo.
pause
echo.
goto menu

:SearchFiles

title Search Files

echo.
echo Please give the name of the file you want to search...
echo.
set /p "filename=Enter File Name:"
echo.
echo Where do you want to search? (Ex:C:\)
echo.
set /p "Pathsearch=Enter Path:"
echo.
echo Searching...
cd %PATHSEARCH%
dir /s *%FILENAME%*
echo.
choice /c YN /m "Do you want to search another file?"
if %ERRORLEVEL% EQU 2 (
echo.
goto menu
) else (
goto SearchFiles
)
