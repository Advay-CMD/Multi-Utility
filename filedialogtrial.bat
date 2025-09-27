@echo off
setlocal

:: Use PowerShell to open file picker and capture the result
for /f "usebackq delims=" %%F in (`powershell -nologo -noprofile -command ^
  "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') > $null; ^
   $ofd = New-Object System.Windows.Forms.OpenFileDialog; ^
   $ofd.InitialDirectory = [Environment]::GetFolderPath('Desktop'); ^
   $ofd.Filter = 'All files (*.*)|*.*'; ^
   if ($ofd.ShowDialog() -eq 'OK') { $ofd.FileName }"`) do (
    set "value=%%F"
)

endlocal & set "resultA=%value%"
exit /b
