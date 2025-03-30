@echo off
chcp 65001 >nul
title ABISS - By LIL_GI
color 02
goto start
# GET OUT OF THE CODE YOU SKID

:start
goto banner
goto menu

:banner
echo *Make Sure That You Ran ABISS As Admin*
echo.
echo.
echo    ▄████████ ▀█████████▄   ▄█     ▄████████    ▄████████ 
echo   ███    ███   ███    ███ ███    ███    ███   ███    ███ 
echo   ███    ███   ███    ███ ███▌   ███    █▀    ███    █▀  
echo   ███    ███  ▄███▄▄▄██▀  ███▌   ███          ███        
echo ▀███████████ ▀▀███▀▀▀██▄  ███▌ ▀███████████ ▀███████████ 
echo   ███    ███   ███    ██▄ ███           ███          ███ 
echo   ███    ███   ███    ███ ███     ▄█    ███    ▄█    ███ 
echo   ███    █▀  ▄█████████▀  █▀    ▄████████▀   ▄████████▀  
echo.

:menu
echo.
echo             ╦
echo             ║
echo             ╠═ Add A User
echo             ║
echo             ╠═ List Users
echo             ║
echo             ╠═ Change A Users Password
echo             ║
echo             ╠═ Exit
echo             ╩
echo.

set /p a=Select an option: 
if "%a%"=="1" goto ADDUSER
if "%a%"=="2" goto LISTUSER
if "%a%"=="3" goto CHANGEUSER
if "%a%"=="4" exit

:LISTUSER
cls
net user
pause
cls
goto start

:CHANGEUSER
cls
set /p USERNAMEGHANGE=Username: 
set /p PASSWORDCHANGE=New Password: 
net user %USERNAMEGHANGE% %PASSWORDCHANGE% >nul
echo Successfuly Changed %USERNAMEGHANGE%'s Password To %PASSWORDCHANGE%!
pause
cls
goto start

:ADDUSER
cls
set /p Username=Username: 
set /p Password=Password: 
net user %Username% %Password% /Add
echo Successfuly made user: %Username% With Password: %Password%
pause
cls
goto start
