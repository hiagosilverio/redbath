@echo off

tasklist | sort 

set /p scriptQuestion=Type the process name do kill or type quit to return:

@rem Maybe a yes or not here..
if "%scriptQuestion%" == "quit" ( 
    exit /b 0
) else (    
    tasklist /FI "IMAGENAME eq %scriptQuestion%.exe" 2>NUL | find /I /N "%scriptQuestion%.exe">NUL
    if "%ERRORLEVEL%"=="0" (
        Echo Killing..
        taskkill /im "%scriptQuestion%".exe /f
    )
    if "%ERRORLEVEL%"=="1" Echo Process not running
 )
