@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion
: name=Redbath
: description=Batch Script Reader
: version=0.1.3

: => Find some batchdoc standards

: Constructor
:_(
  : Call a function by parameter
  : if first parameter in call bat isn't null
  if not "%~1" == "" (

    : if second parameter in call bat isn't null
    if not "%~2" == "" (
      call:%1 %2
    )

    : else call first only
    call:%1

    : return
    exit /b 0

  ) 

  : Calling language file and setting translate variables trought it, doesn't need a function, guess I
  for /f "delims=" %%x in (%language%\en-US.txt) do (set "%%x")

  :- Global variables

  : Set redbath call alias
  : => stackoverflow/what-does-dp0-mean-and-how-does-it-work
  : %~f0 is like full directory that what point out to here ...redbath.cmd
  set "rd=%~f0"

  : Set menu title
  set title=REDBATH v0.1.3

  : Set language folder 
  set "language=..\lang"

  : Set source folder 
  set "source=..\src"

  : Set library folder
  set "library=..\lib"

  : Set Router
  set "router=..\src\router.cmd"

  : This is where set color.bat path and pass trought it hexadecimal colors
  : Parameters [hex hexcolor, string messagename] 
  : Colors for info, sucess and warn

  set "info=%library%\color.cmd 0B %*"
  set "sucess=%library%\color.cmd 0A %*"
  set "warn=%library%\color.cmd 0C %*"

  : Set scripts folder
  set "scripts=..\scripts"

  : Set custom scripts folder
  set "cscripts=..\custom-scripts"

  : Call wait to set default wait variable
  call :wait

  : Call main to show the choice options
  call :menu

: Call constructor itself passing by parameter to answer a call from other file
: Ex: call ex.bat function value
) | call:_ %1

: I will let this unofunctional function to get insight about callbacks here and stuff
: [Deprecated 0.0.1]
:_wait (

  : Verify if the parameter %~1 (this is like the first param) is null casting to string
  if not "%~1" == "" (
     ping 127.0.0.1 -n %1 >nul
    
    : this command is to prevent batch exit, calling a function for the second time
    : it's kinda return
     exit /b 0
  ) 

  : return a variable to the global scope, I dunno why it happens.. shrug
  set "wait=ping 127.0.0.1 -n 1 >nul"

  : and return to constructor (this is to we procedure to continue from construct)
  exit /b 0
)

: This wait hack is for when we need to pause the script to read
:wait (

  : return a variable to the global scope, I dunno why it happens.. shrug
  set "wait=ping 127.0.0.1 -n 1 >nul"

  : and return to constructor (this is to we procedure to continue from construct)
  exit /b 0
)

: Show options to be chossen
:menu (
  : Clean the prompt screen when nenu is being called
  cls
  
  : Warn if color.bat cannot be read or not exist
  if not exist "%library%\color.cmd" (
    echo.
    : I'm not sure why is it here or if it's completed, shrug again
    echo %WARN_COLOR%
    echo.
  )

  : Check updates...
  : Need to change it to gihub server..
  : Maybe a function to it?
  echo Checking internet connection...
  ping www.google.nl -n 1 -w 1000>nul
  if errorlevel 1 (echo Can't verify update.. skiping) else (
    echo Connected to the internet..
    echo.
  )

  :- Menu
  : There we define three options to select when someone select 
  : Like 0,1,2 and that way so on

  call %info% "========[ %title% ]========"
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
  echo  2 - List custom scripts [Not working]
  echo  0 - Exit
  echo.
  set /p Comando= %SELECT_OPTION%
  if "%Comando%" equ "1" (goto op1)
  if "%Comando%" equ "0" (goto exit)

  : Need to define a config file to disable colors..

  echo.
  echo %INVALID_OPTION%
  timeout 1 >nul
  call:menu

  : Need to transform goto into a fake function...
  :op1
  call "%source%\op1.cmd"

  pause>nul

  call:menu

  :exit
  echo The batch script is being closed...
  timeout 3 >nul

  echo %ERRORLEVEL%
  pause

)