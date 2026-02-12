@echo off
setlocal enabledelayedexpansion

set "ZIP_FILE=repo.zip"
set "EXTRACT_TO=./"

for /f "usebackq delims=" %%i in (".env") do (
    set "line=%%i"
    for /f "tokens=1,* delims==" %%a in ("!line!") do (
        set "%%a=%%b"
    )
)

curl -L "%ZIP_URL%" -o "%ZIP_FILE%"
if errorlevel 1 (
    exit /b 1
)

if not exist "%EXTRACT_TO%" (
    mkdir "%EXTRACT_TO%"
)

echo Unpacking zip...
tar -xf "%ZIP_FILE%" -C "%EXTRACT_TO%"
if errorlevel 1 (
    exit /b 1
)
echo Unpacking done

xcopy "%INNER_DIR%\*" "%EXTRACT_TO%\" /E /H /Y >nul
rd /s /q "%INNER_DIR%"

del "%ZIP_FILE%"