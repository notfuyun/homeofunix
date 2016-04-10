@echo off
set "cachedir=%~dp0tmp"
set "userdata=%cachedir%\data"

if not exist "%cachedir%" mkdir "%cachedir%"
if not exist "%cachedir%" exit

pushd "%~dp0"
start "mychrome" chrome.exe --no-first-run --no-default-browser-check --start-maximized --disk-cache-dir="%cachedir%" --user-data-dir="%userdata%"
timeout /nobreak /t 2
