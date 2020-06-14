@echo off
setlocal enableextensions 
setlocal EnableDelayedExpansion

:init
tasklist /v /fi "STATUS eq running" /NH /FO table 

set /p scriptQuestion=Type the first word or the two first words from the window title or quit to return:
:: Maybe a yes or not here..
if "%scriptQuestion%" == "quit" ( 
    exit /b 0
) else (    
 
    tasklist /v /fo list | find /i "%scriptQuestion%" > temp.txt 
    (for /f "usebackq eol= " %%a in (temp.txt) do break) && ( echo. && echo Process found.. && echo.) || (
        echo. && echo Not was possible to found a process with this window name.. trying image name method
        timeout 5 >nul
        call :processFinder
    ) 
    for /f "tokens=2 delims=:" %%x in (temp.txt) do ( 
        set MyVar=%%x
        set MyVar=!MyVar: =!
        echo !MyVar!

    )
   del temp.txt
   pause

    if "%ERRORLEVEL%"=="0" (
        Echo Window title match..
        pause
        :: https://superuser.com/questions/763135/how-to-kill-a-process-based-on-the-partial-content-of-its-window-title/763159
        PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {&  Get-Process | Where-Object { $_.MainWindowTitle -like '*%scriptQuestion%*' } | Stop-Process }"
        exit /b 0
    ) else (
       exit /b 1
    )
)

:processFinder (
    
    tasklist /v /fi "STATUS eq running" /NH /FO table | sort

    set /p scriptQuestion=Type the process name (process.exe) with .exe from list:
    tasklist /v /fi "IMAGENAME eq %scriptQuestion%" | find /I /N "%scriptQuestion2%">NUL

    if "%ERRORLEVEL%"=="0"(
        Echo Imagename found..
        taskkill /F /FI "IMAGENAME eq %scriptQuestion%.exe"
    )

    if "%ERRORLEVEL%"=="1"(
        Echo Imagename %scriptQuestion% not found.. something not worked, try again..
        Echo restarting..
        timeout 5
        goto :init
    )
    timeout 3 >nul
    exit /b 0
) 

