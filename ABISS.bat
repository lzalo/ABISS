@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title ABISS - Advanced Batch Interface for System Security
color 0A

:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════╗
    echo ║          ERROR: ADMINISTRATOR RIGHTS REQUIRED          ║
    echo ╚════════════════════════════════════════════════════════╝
    echo.
    echo This script must be run as Administrator.
    echo Right-click the script and select "Run as administrator"
    echo.
    pause
    exit
)

:start
cls
call :banner
call :menu

:banner
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║    ▄████████ ▀█████████▄   ▄█     ▄████████    ▄████████ 
echo ║   ███    ███   ███    ███ ███    ███    ███   ███    ███ 
echo ║   ███    ███   ███    ███ ███▌   ███    █▀    ███    █▀  
echo ║   ███    ███  ▄███▄▄▄██▀  ███▌   ███          ███        
echo ║ ▀███████████ ▀▀███▀▀▀██▄  ███▌ ▀███████████ ▀███████████ 
echo ║   ███    ███   ███    ██▄ ███           ███          ███ 
echo ║   ███    ███   ███    ███ ███     ▄█    ███    ▄█    ███ 
echo ║   ███    █▀  ▄█████████▀  █▀    ▄████████▀   ▄████████▀  
echo ╚════════════════════════════════════════════════════════╝
echo         Advanced Batch Interface for System Security
echo              Running with Administrator Rights ✓
echo.
goto :eof

:menu
echo ╔════════════════════════════════════════════════════════╗
echo ║                    MAIN MENU                           ║
echo ╠════════════════════════════════════════════════════════╣
echo ║                                                        ║
echo ║  [1] Add New User                                      ║
echo ║  [2] List All Users                                    ║
echo ║  [3] Change User Password                              ║
echo ║  [4] Delete User                                       ║
echo ║  [5] Add User to Administrators Group                  ║
echo ║  [6] Exit                                              ║
echo ║                                                        ║
echo ╚════════════════════════════════════════════════════════╝
echo.
set /p choice=Select an option (1-6): 

if "%choice%"=="1" goto ADDUSER
if "%choice%"=="2" goto LISTUSER
if "%choice%"=="3" goto CHANGEUSER
if "%choice%"=="4" goto DELETEUSER
if "%choice%"=="5" goto ADDADMIN
if "%choice%"=="6" goto EXIT
echo.
echo [ERROR] Invalid option. Please select 1-6.
timeout /t 2 >nul
goto start

:LISTUSER
cls
call :banner
echo ╔════════════════════════════════════════════════════════╗
echo ║                  USER ACCOUNTS LIST                    ║
echo ╚════════════════════════════════════════════════════════╝
echo.
net user
echo.
echo ════════════════════════════════════════════════════════
pause
goto start

:CHANGEUSER
cls
call :banner
echo ╔════════════════════════════════════════════════════════╗
echo ║                CHANGE USER PASSWORD                    ║
echo ╚════════════════════════════════════════════════════════╝
echo.
set /p USERNAME_CHANGE=Enter Username: 

:: Verify user exists
net user "%USERNAME_CHANGE%" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] User "%USERNAME_CHANGE%" does not exist.
    timeout /t 3 >nul
    goto start
)

set /p PASSWORD_CHANGE=Enter New Password: 
net user "%USERNAME_CHANGE%" "%PASSWORD_CHANGE%" >nul 2>&1

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Password changed for user: %USERNAME_CHANGE%
) else (
    echo.
    echo [ERROR] Failed to change password. Please check requirements.
)
echo.
pause
goto start

:ADDUSER
cls
call :banner
echo ╔════════════════════════════════════════════════════════╗
echo ║                   ADD NEW USER                         ║
echo ╚════════════════════════════════════════════════════════╝
echo.
set /p USERNAME_NEW=Enter Username: 
set /p PASSWORD_NEW=Enter Password: 

:: Attempt to create user
net user "%USERNAME_NEW%" "%PASSWORD_NEW%" /Add >nul 2>&1

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] User created successfully!
    echo Username: %USERNAME_NEW%
    echo.
    set /p ADD_TO_GROUP=Add to Administrators group? (Y/N): 
    if /i "!ADD_TO_GROUP!"=="Y" (
        net localgroup administrators "%USERNAME_NEW%" /add >nul 2>&1
        if !errorlevel! equ 0 (
            echo [SUCCESS] Added to Administrators group.
        ) else (
            echo [ERROR] Failed to add to Administrators group.
        )
    )
) else (
    echo.
    echo [ERROR] Failed to create user.
    echo Check if username already exists or password meets requirements.
)
echo.
pause
goto start

:DELETEUSER
cls
call :banner
echo ╔════════════════════════════════════════════════════════╗
echo ║                   DELETE USER                          ║
echo ╚════════════════════════════════════════════════════════╝
echo.
echo [WARNING] This will permanently delete a user account.
echo.
set /p USERNAME_DELETE=Enter Username to Delete: 

:: Verify user exists
net user "%USERNAME_DELETE%" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] User "%USERNAME_DELETE%" does not exist.
    timeout /t 3 >nul
    goto start
)

set /p CONFIRM=Are you sure you want to delete "%USERNAME_DELETE%"? (Y/N): 
if /i not "%CONFIRM%"=="Y" (
    echo Operation cancelled.
    timeout /t 2 >nul
    goto start
)

net user "%USERNAME_DELETE%" /delete >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] User "%USERNAME_DELETE%" has been deleted.
) else (
    echo.
    echo [ERROR] Failed to delete user.
)
echo.
pause
goto start

:ADDADMIN
cls
call :banner
echo ╔════════════════════════════════════════════════════════╗
echo ║           ADD USER TO ADMINISTRATORS GROUP             ║
echo ╚════════════════════════════════════════════════════════╝
echo.
set /p USERNAME_ADMIN=Enter Username: 

:: Verify user exists
net user "%USERNAME_ADMIN%" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] User "%USERNAME_ADMIN%" does not exist.
    timeout /t 3 >nul
    goto start
)

net localgroup administrators "%USERNAME_ADMIN%" /add >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] User "%USERNAME_ADMIN%" added to Administrators group.
) else (
    echo.
    echo [ERROR] Failed to add user to Administrators group.
    echo User may already be an administrator.
)
echo.
pause
goto start

:EXIT
cls
call :banner
echo.
echo Thank you for using ABISS!
echo Exiting in 2 seconds...
timeout /t 2 >nul
exit
