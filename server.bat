@echo off
chcp 65001 >nul
title Minecraft Server Setup
color 0A
cd ./ServerFiles/

:menu
echo ============================================
echo           ⚙️  УСТАНОВКА СЕРВЕРА
echo ============================================
echo.
echo Выберите действие:
echo   1 - Скачать и обновить (update.bat)
echo   2 - Обновить конфигурационные файлы сервера (update_config.bat)
echo   3 - Запустить сервер (run.bat)
echo   4 - Завершить работу

choice /c 1234 /n
if errorlevel 4 goto end
if errorlevel 3 goto run
if errorlevel 2 goto config
if errorlevel 1 goto update
goto menu

:update
echo 🔄 Запуск update.bat...
call update.bat
goto menu

:config
echo 🔧 Запуск update_config.bat...
call update_config.bat
goto menu

:run
echo 🚀 Запуск run.bat...
call run.bat
goto menu

:end