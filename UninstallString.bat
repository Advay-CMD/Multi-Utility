@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
       break
) ELSE (
    :: Not admin, relaunch using VBScript
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c %~s0", "", "runas", 1 >> "%temp%\elevate.vbs"
    cscript //nologo "%temp%\elevate.vbs"
    del "%temp%\elevate.vbs"
    exit /b

)
echo You sure you want to uninstall this program?
@choice /c YN /m "Do you want to continue?"
IF %ERRORLEVEL% EQU 2 (
         echo Cleaning Up...
         TIMEOUT /T 5
         exit /b
) ELSE (
         break
)
:: This will uninstall the Multi_Utility Completely
echo Last Warning! DO YOU WANT TO UNINSTALL THIS PROGRAM
IF %ERRORLEVEL% EQU 2 (
         echo Cleaning Up...
         TIMEOUT /T 5
         exit /b
) ELSE (
         break
)
:: Actually, I don't want the user to uninstall this software

rmdir /s /q %systemroot%\System32\Multi_Utility >null

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\MultiUtility.bat" /f >null
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\MultiUtility" /f >null

echo Done Deleting...
echo Cleaning up...
echo Stoping services
:: This not required but it feels really cool
timeout /t 5 >null
echo.
echo Press any key to continue...
echo.
pause
exit /b
