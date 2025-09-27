@echo off
set "value="

:: Embed the PowerShell script inline
set "pscode=[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');"
set "pscode=%pscode% $dlg = New-Object Windows.Forms.OpenFileDialog;"
set "pscode=%pscode% $dlg.InitialDirectory = [Environment]::GetFolderPath('Desktop');"
set "pscode=%pscode% $dlg.Filter = 'All Files (*.*)|*.*';"
set "pscode=%pscode% if ($dlg.ShowDialog() -eq 'OK') { Write-Output $dlg.FileName }"

:: Run PowerShell and capture the output
for /f "delims=" %%F in ('powershell -noprofile -command "%pscode%"') do (
    set "resultA=%%F"
)
