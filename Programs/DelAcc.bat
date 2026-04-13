:: Delete Account
title Delete Account

echo.
echo Enter The account you want to delete:
set /p "Daccount=Enter Account:"
net user %DACCOUNT% /delete > nul 2>&1
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
