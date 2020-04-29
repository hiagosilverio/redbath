@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion
:start
cls

:: name=Redbath
:: description=Batch Script Reader
:: version=0.0.1


:: Call language file and set variables trought it
for /f "delims=" %%x in (lang\en-US.txt) do (set "%%x")

:: Warn if color.bat cannot be read or not exist
if not exist "include\color.bat" (
echo.
echo %WARN_COLOR%
echo.
)

:: This is where set color.bat path and pass hexadecimal colors
:: Parameters [hex hexcolor, string messagename] 

:: This wait hack is for when we need to pause the script to read
set "wait=ping 127.0.0.1 -n 1 >nul"
 
:: Included colors for info, sucess and warn
set "info=include\color.bat 0B %*"
set "sucess=include\color.bat 0A %*"
set "warn=include\color.bat 0C %*"

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
cls
echo.
echo Listing script files...
echo.
if exist "scripts" (
  if exist "scripts\*.bat" (
    dir /b /a-d scripts\*.bat | findstr /e .bat | more
  ) else (
    call %info% "Empty script folder, no script file found"
    %wait%
    echo.
    set /p scriptName=Do you want to create an example script?
    goto :script-build
  )
) else (
  call %warn% "Alert: Scripts folder wasn't found in main directory"
  %wait% 
  call %info% "Creating scripts folder..."
  %wait%
  md scripts
  %wait%
:script-build
  call %info% "Inserting script test file.."
  %wait%
  echo echo batch successfuly executed >> scripts\helloWorld.bat 
  if %errorlevel% NEQ 0 ( Echo Error: Unknown error on create helloWorld   )
  %wait%
  call scripts\helloWorld.bat
)
echo.
:script
set /p scriptName=Type the script name: 

if exist "scripts\%scriptName%.bat" (
    echo.
    echo The file was found..
    %wait%
    call %info% "To stop this bat processing type CRTL+C"
    echo Running script..
    timeout 3 >nul
    echo.
    call "scripts\%scriptName%.bat" 
    echo.
    echo Batch script was finished sucessfully!
    echo.
    echo Backing to scripts menu..
    timeout 6 >nul
    goto:op1
) else (
    echo.
    call %warn% "Alert: Invalid info or bad typing: %scriptName%"
    echo Redirecting to the script listing.. 
    timeout 6 >nul
    goto:op1
)

pause>nul

goto:start

:exit
echo The batch script is being closed...
timeout 3 >nul

