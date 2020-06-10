@echo off
:init
tasklist /v /fi "STATUS eq running" /NH /FO table 

set /p scriptQuestion=Type the first word or the two first words from the window title or quit to return:
:: Maybe a yes or not here..
if "%scriptQuestion%" == "quit" ( 
    exit /b 0
) else (    

    tasklist /FI "WindowTitle eq *%scriptQuestion%*" 2>NUL | find /I /N "%scriptQuestion%">NUL
    if "%ERRORLEVEL%"=="0" (
        Echo Window title match..
        :: https://superuser.com/questions/763135/how-to-kill-a-process-based-on-the-partial-content-of-its-window-title/763159
        PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {&  Get-Process | Where-Object { $_.MainWindowTitle -like '*%scriptQuestion%*' } | Stop-Process }"
        exit /b 0
    ) else (
       exit /b 1
    )
)

if "%ERRORLEVEL%"=="1"(
    
    set /p scriptQuestion2=Type the process name (process.exe) with .exe from list:
    tasklist /FI "IMAGENAME eq %scriptQuestion2%" 2>NUL | find /I /N "%scriptQuestion2%">NUL

    if "%ERRORLEVEL%"=="0"(
        Echo Imagename found..
        taskkill /F /FI "IMAGENAME eq %scriptQuestion2%.exe"
    )

    if "%ERRORLEVEL%"=="1"(
        Echo Imagename %scriptQuestion2% not found.. something not worked, try again..
        Echo restarting..
        timeout 5
        goto :init
    )
) 

