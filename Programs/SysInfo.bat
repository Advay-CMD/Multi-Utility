:: System Information
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
