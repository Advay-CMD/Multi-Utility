:: Add Account
title Add Account

echo.
net accounts /minpwlen:0 > nul 2>&1
echo Enter Account Name(without illegal symbols): 
set /p "Account=Enter Account:"
net user %ACCOUNT% /add > nul 2>&1
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
net user %ACCOUNT% %PASSWORD% > nul 2>&1
echo Sucsessfully Done!
echo.
pause
echo.
