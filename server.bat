@echo off
title Minecraft Server Setup
color 0A
cd ./ServerFiles/

:menu
echo ============================================
echo           ⚙️  SERVER INSTALLATION
echo ============================================
echo.
echo Выберите действие:
echo   1 - Download and update (update.bat)
echo   2 - Update server`s config files (update_config.bat)
echo   3 - run server (run.bat)
echo   4 - close app

choice /c 1234 /n
if errorlevel 4 goto end
if errorlevel 3 goto run
if errorlevel 2 goto config
if errorlevel 1 goto update
goto menu

:update
echo Launching update.bat...
call update.bat
goto menu

:config
echo Launching update_config.bat...
call update_config.bat
goto menu

:run
echo Launching run.bat...
call run.bat
goto menu

:end