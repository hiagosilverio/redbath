@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion
:start
cls

: name=Redbath
: description=Batch Script Reader
: version=0.0.1

: Set language folder 
set "language=..\lang"

: Set source folder 
set "source=..\source"

: Set library folder
set "library=..\lib"

: Set Router
set "router"="..\src\router.bat"

: This is where set color.bat path and pass trought it hexadecimal colors
: Parameters [hex hexcolor, string messagename] 
: Colors for info, sucess and warn

set "info=%library%\color.bat 0B %*"
set "sucess=%library%\color.bat 0A %*"
set "warn=%library%\color.bat 0C %*"

@rem Set scripts folder
set "scripts=..\scripts"

:: Set custom scripts folder
set "cscripts=..\custom-scripts"

:: This wait hack is for when we need to pause the script to read
set "wait=ping 127.0.0.1 -n 1 >nul"

:: Call language file and set variables trought it
for /f "delims=" %%x in (%language%\en-US.txt) do (set "%%x")

:: Warn if color.bat cannot be read or not exist
if not exist "%library%\color.bat" (
echo.
echo %WARN_COLOR%
echo.
)

:: Check updates...
:: Change it to gihub server..
echo Checking internet connection...
ping www.google.nl -n 1 -w 1000>nul
if errorlevel 1 (echo No internet can't verify update.. skiping) else (
  echo Connected to the internet..
  echo.
)

:: Menu
:: There we define two options to select when someone select 1 or 0
:: We go to the option
call %info% "========[ REDBATH v0.01 ]========"
call %info% "------------  Menu --------------" 
echo.
echo Set in your prompt command consolas 16px font to better experience..
echo.
call %warn% "Alert: Some scripts may contain dangerous activity"
call %warn% "it may could cause harmfull changes,"
call %warn% "please verify its content on scripts folder before run"
echo.
call %warn% "Alert: Do not run any script without batch knowledge," 
call %warn% "this software is in development version,"
call %warn% "it supports windows 8 and above"
echo.
call %warn% "Alert: This program not have any responsability for any damage"
call %warn% "caused by third scripts, take caution"
echo.
echo  1 - List scripts
echo  2 - List custom scripts
echo  0 - Exit
echo.
set /p Comando= %SELECT_OPTION%
if "%Comando%" equ "1" (goto op1)
if "%Comando%" equ "0" (goto exit)

:: Define a config file to disable colors..

echo.
echo %INVALID_OPTION%
timeout 1 >nul
goto:start

:op1
call "..\src\op1.bat" "op1"

pause>nul

goto:start

:exit
echo The batch script is being closed...
timeout 3 >nul

