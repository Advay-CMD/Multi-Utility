@echo off
setlocal

:: Use PowerShell to open folder picker and capture the result
for /f "usebackq delims=" %%F in (`powershell -nologo -noprofile -command ^
  "$f = (New-Object -ComObject Shell.Application).BrowseForFolder(0, 'Select a folder', 0); if ($f) { $f.Self.Path }"`) do (
    set "resultA=%%F"
)

endlocal & set "resultA=%value%"
exit /b
