@echo off
setlocal enabledelayedexpansion

set "EXT_FILE=allowed_extensions.txt"

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
for /f "usebackq delims=" %%E in ("%EXT_FILE%") do (
    for %%F in (".\*.%%E") do (
        if exist "%%F" (
            echo put "%%~nxF"  >> script.txt
        )
    )
)
echo exit >> script.txt

"./WinSCP/winscp.com" /script=script.txt
del script.txt