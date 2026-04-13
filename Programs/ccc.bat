:: CMD color change

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
