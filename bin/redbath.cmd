@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion

@rem title=REDBATH v0.1.5
@rem description = Batch Script Reader
@rem version = 0.1.5

@rem Find some batchdoc standards

@rem  Constructor

:_(

  @rem Set current path temporary
  @rem Need some fix..
  SET PATH=%PATH%;%~f0

  @rem Call a function by parameter
  @rem if first parameter in call bat isn't null
  if not "%~1" == "" (

    @rem if second parameter in call bat isn't null
     if not "%~2" == "" (
      call :%~1 %~2
    )

    @rem else call first only
    call:%~1

    @rem return
    exit /b 0

  ) 

  : Calling language file and setting translate variables trought it, doesn't need a function, guess I
  for /f "delims=" %%x in (%language%\en-US.txt) do (set "%%x")

  :-Constant variables

  @rem  Set redbath call alias
  @rem  stackoverflow/what-does-dp0-mean-and-how-does-it-work
  @rem  %~f0 is like full directory that what point out to here ...redbath.cmd
  @rem  Do not include space between equal and %~f0, with double quotes the result is the same, bug related.
  set redb=%~f0&

  @rem Set menu title
  set title=REDBATH v0.1.5

  @rem Set language folder 
  set "language=..\lang"

  @rem Set source folder 
  set "source=..\src"

  @rem Set library folder
  set "library=..\lib"

  @rem Set Router
  set "router=..\src\router.cmd"

  @rem Set scripts folder
  @rem Overwrite permissions with [%scripts%]
  set "scripts=[%scripts%]"
  set "scripts=..\scripts"

  @rem Set custom scripts folder
  set "cscripts=..\custom-scripts"

  @rem  This is where set color.bat path and pass trought it hexadecimal colors
  @rem  Parameters [hex hexcolor, string messagename] 
  @rem  Colors for info, sucess and warn

  set "info=%library%\color.cmd 0B %*"
  set "sucess=%library%\color.cmd 0A %*"
  set "warn=%library%\color.cmd 0C %*"

  @rem Call wait to set default wait variable
  call :Wait

  @rem Call main to show the choice options
  call :Main

@rem Call constructor itself passing by parameter to answer a call from other file
@rem Ex: call ex.bat function value
) | call:_ %1


:Sets (

    if not "%~1" == "" (

        @rem prevent spaces with double quotes
        @rem set variable as parameter1 and value as parameter2
        @rem No space between = and %~1, %1 
        set !%~1=%~2!

        exit /b 0

    )
)

@rem Do not let @get together with @get( the way that works is @get (

:Getas (

    if not "%~1" == "" (
      
      @rem Some kind of Witchcraft here
      @rem !! cast string parameter %~1 to %1% with delayed expansion
      echo !%1!

      exit /b 0 

    )  


)



@rem I will let this unofunctional function to get insight about callbacks here and stuff
@rem [Deprecated 0.0.1]
:_wait (

  @rem Verify if the parameter %~1 (this is like the first param) is null casting to string
  if not "%~1" == "" (
     ping 127.0.0.1 -n %1 >nul
    
    @rem this command is to prevent batch exit, calling a function for the second time
    @rem it's kinda return
     exit /b 0
  ) 

  @rem return a variable to the global scope, I dunno why it happens.. shrug
  set "wait=ping 127.0.0.1 -n 1 >nul"

  @rem and return to constructor (this is to we procedure to continue from construct)
  exit /b 0
)

@rem This wait hack is for when we need to pause the script to read
:Wait (

  @rem return a variable to the global scope, I dunno why it happens.. shrug
  set "wait=timeout 1 >nul"

  @rem and return to constructor (this is necessary to continue from construct)
  exit /b 0
)

@rem Show options to be chossen
:Main (

  @rem Clean the prompt screen when nenu is being called
  cls
  
  @rem Warn if color.bat cannot be read or not exist
  if not exist "%library%\color.cmd" (
    echo.
    @rem I'm not sure why is it here or if it's completed
    echo %WARN_COLOR%
    echo.
  )

  @rem Check updates...
  @rem Need to change it to gihub server..
  @rem Maybe a function to it?
  echo Checking internet connection...
  call :CheckConnection
 
  :- Menu
  @rem There we define three options to select when someone select 
  @rem Like 0,1,2 and that way so on

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
  echo  2 - List custom scripts
  echo  0 - Exit
  echo.
  set /p Command= %SELECT_OPTION%

  @rem In this case, else need to be in the same line as if
  @rem And batch not supports multiple elses, only one follow by if conditions
  if "%Command%" == "1" ( call :CallScriptsList ) 
  if "%Command%" == "2" ( call :CallCustomScriptsList ) 
  if "%Command%" == "0" ( call :Exit )

  @rem Is there other clean solution for this? like batch script is so limited in variations
  @rem Is better to have an exit condition when not passes trought ifs
  @rem Than make a boilerplate to consider a solution itself  
  
  echo.
  echo %INVALID_OPTION%
  timeout 1 >nul

  call :Main

  @rem End of menu

  )
  
  @rem Should define a config file to disable colors.. maybe

  :CallScriptsList (
  
    @rem Include listscripts cmd into redbath
    call "%source%\ListScripts.cmd"
    
    call :Main
    
    exit /b 0
  )

  :CallCustomScriptsList (
    
    @rem Include listscripts cmd into redbath

    call "%source%\ListScripts.cmd" %cscripts% 
    
    call :Main
    
    exit /b 0
    
  )

  :CheckConnection (
    
    ping www.google.nl -n 1 -w 1000>nul
    if errorlevel 1 (echo Can't verify update.. skiping) else (
    echo Connected to the internet..
    echo.
    
    exit /b 0
  )

  :Exit (

    echo The batch script is being closed...
    timeout 3 >nul

    exit
  )

  echo %ERRORLEVEL%
  pause

)