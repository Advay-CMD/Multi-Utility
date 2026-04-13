:: Network Speed Tester
title Network Speed Tester

echo.
echo Testing network speed...
echo.
echo This may take a little time...
powershell -Command "Test-Connection -ComputerName google.com -Count 1"
pause
echo.
