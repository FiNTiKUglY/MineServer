@echo off
setlocal enabledelayedexpansion

set "IGNORE_FILE=ignore.txt"

for /f "usebackq delims=" %%i in (".env") do (
    set "line=%%i"
    for /f "tokens=1,* delims==" %%a in ("!line!") do (
        set "%%a=%%b"
    )
)

echo open ftp://%FTP_USER%:%FTP_PASS%@%FTP_HOST% > script.txt
echo lcd "./" >> script.txt
echo cd %REMOTE_DIR% >> script.txt
echo option transfer binary >> script.txt
echo get * >> script.txt
echo exit >> script.txt

"./WinSCP/winscp.com" /script=script.txt
del script.txt

java @user_jvm_args.txt @libraries/net/neoforged/neoforge/21.1.1/win_args.txt %*

set "FILEMASK=|"
for /f "usebackq delims=" %%i in ("%IGNORE_FILE%") do (
    set "LINE=%%i"
    if not "!LINE!"=="" (
        set "FILEMASK=!FILEMASK!!LINE!;"
    )
)
set "FILEMASK=!FILEMASK:~0,-1!"

echo open ftp://%FTP_USER%:%FTP_PASS%@%FTP_HOST% > script.txt
echo lcd "./" >> script.txt
echo cd %REMOTE_DIR% >> script.txt
echo option transfer binary >> script.txt
echo put * -filemask="%FILEMASK%" >> script.txt
echo exit >> script.txt

"./WinSCP/winscp.com" /script=script.txt
del script.txt