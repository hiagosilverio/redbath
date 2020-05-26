@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion

@rem title=RedBath
@rem description=Batch Script Reader
@rem version=0.1.9

@rem Find some batchdoc standards

@rem Constructor

:_(
  
  @rem Prevent Window Close when error occurs including closing batch script
  @rem Some kind of witchcraft here /*
  @rem https://stackoverflow.com/questions/17118846/how-to-prevent-batch-window-from-closing-when-error-occurs
  if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit b/ 0 )
  
  @rem Set current path temporary
  @rem Need some fix..
  @rem Do not include PATH with "%PATH%;%~f0" findstr error
  @rem This guy could cause a lot of trouble here.. 
  @rem Must not use SETX to set variable this mean PATH variable
  @rem https://stackoverflow.com/questions/13222724/command-line-to-remove-an-environment-variable-from-the-os-level-configuration
  
  @rem Clear setx language enviroment file ----- remove at 1.20
  @rem > nul 2> nul | Used to supress error messages
  @rem When not found give to variable errorlevel de number 1
  @rem We use this query to have something to decide if we need to clear or not 
  @rem Do not worry these keys are used to include information at old versions
  
  @rem https://stackoverflow.com/questions/1192476/format-date-and-time-in-a-windows-batch-script

  REG query "HKCU\Environment" /v "language" > nul 2> nul
  if %errorlevel% == 0 (REG delete "HKCU\Environment" /F /V language  ) 
  REG query "HKCU\Environment" /v "source" > nul 2> nul
  if %errorlevel% == 0 ( REG delete "HKCU\Environment" /F /V source  )  
  REG query "HKCU\Environment" /v "library" > nul 2> nul
  if %errorlevel% == 0 ( REG delete "HKCU\Environment" /F /V library  ) 
  REG query "HKCU\Environment" /v "rversion" > nul 2> nul
  if %errorlevel% == 0 ( REG delete "HKCU\Environment" /F /V rversion  ) 
  
  ::IF NOT EXIST "..\backup_PATH.reg" (
  ::  REG export "HKCU\Environment" ..\backup_PATH.reg
  ::)

  @rem https://stackoverflow.com/questions/112055/what-does-d0-mean-in-a-windows-batch-file
  :: REG add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%;%~d0%~p0"


  @rem  https://stackoverflow.com/questions/25166704/convert-a-string-to-integer-in-a-batch-file
  
  @rem Default Language Variables

  set "WARN_COLOR=Error: color.bat missing, alerts may could fail during the process.."
  set "SELECT_OPTION=Select an option:"
  set "INVALID_OPTION=Invalid option, cleaning.."
  set "LISTING_SCRIPTS=Listing script files avaliable"
  set "SCRIPT_NOT_FOUND=No scripts found"
  set "WARN_SCRIPT_FOLDER_NOT_FOUND=Alert: Scripts folder not found inside the directory"

  @rem Constant variables

  @rem  Set redbath call alias
  @rem  stackoverflow/what-does-dp0-mean-and-how-does-it-work
  @rem  %~f0 is like full directory that what point out to here ...redbath.cmd
  @rem  Do not include space between equal and %~f0, with double quotes the result is the same, bug related #15
  set redb=%~f0&
  
  SET parent=%~dp0
  FOR %%a IN ("%parent:~0,-1%") DO SET grandparent=%%~dpa

  @rem Set menu title
  set rversion=0.1.9

  @rem Set language folder 
  set "language=%grandparent%\lang"

  @rem Set source folder 
  set "source=%grandparent%\src"

  @rem Set library folder
  set "library=%grandparent%\lib"

  @rem Set scripts folder
  @rem Overwrite permissions with [%scripts%]
  set "scripts=[%scripts%]"
  set "scripts=%grandparent%scripts"

  @rem Set custom scripts folder
  set "cscripts=%grandparent%\custom-scripts"

  @rem  This is where set color.bat path and pass through it hexadecimal colors
  @rem  Parameters [hex hexcolor, string messagename] 
  @rem  Colors for info, sucess and warn
  
  @rem Deprecated [0.1.5]
  @rem Variables were transformed into child pseudo functions
  @rem Use call Console:Info to display color and message
  @rem usage: %info% "message"
  set "info=call %library%\color.cmd 0B "
  set "sucess=call %library%\color.cmd 0A "
  set "warn=call %library%\color.cmd 0C "

  @rem Calling language file and setting translate variables through it, doesn't need a function, guess I
  IF exist "%language%\en-US.txt" (
    @rem Do not include quotes in the [ for in (" ") ] it displays enviroment variable not defined
    for /f "eol=# delims=" %%x in (%language%\en-US.txt) do (set "%%x")
  )

  @rem Calling language file and setting config variables through it, doesn't need a function, guess I
  IF exist "..\config.ini" (
    @rem Inserted eol parameter to ignore comments with hash #
    for /f "eol=# delims=" %%x in (%grandparent%\config.ini) do (set "%%x")
  )
  
  @rem Call a function by parameter
  @rem if first parameter in bat "redbath.cmd x" isn't null
  if not "%~1" == "" (
   
   call :Wait
   
  @rem if second parameter "redbath.cmd x y"  isn't null
    if not "%~2" == "" if "%~3" == "" (
       @rem Call the goto pseudo function and its parameter %1
      call :%~1 %~2 

    )

  @rem if second parameter "redbath.cmd x y"  isn't null
    if not "%~3" == "" (
       @rem Call the goto pseudo function and its parameter %1

      call :%~1 %~2 %~3   

    )



    @rem else call only the goto pseudo function
    call:%~1

    @rem return
    exit /b 0

  ) 
  
@rem Call constructor itself passing by parameter to answer a call from other file
@rem Ex: call ex.bat function value
) | call:_ %1* 

:Main(

  @rem ----- Calling pseudo-functions ---------

  @rem Need to change it to gihub server..
  call :CheckConnection
  
  @rem Call to check the version before proceed
  call :CheckOsVersion

  @rem Call factory wait to set default wait variable
  call :Wait

  @rem Call main to show the choice options
  call :Menu

  exit /b 0 
) 

:Console (

  @rem Variables to set some path, they can access variables defined before
  @rem Do not include space between = and path 
  @rem message_info = %library%  that way is wrong
   set "message_info=%library%\color.cmd 0B %*"
   set "message_sucess=%library%\color.cmd 0A %*"
   set "message_warn=%library%\color.cmd 0C %*"
  
  @rem memo: In the for in the set statement, do not use % to represent the variable as %var%
  @rem This is to echo the variable's value
  @rem This for separate the :from pseudo function 

  @rem Acessing tokens passed as function, batch interprets that we have two functions in one calling by itself
  @rem It doesn't not drop any error, so we use this to split into a child function
  for /f "tokens=1,2* delims=:" %%0 in ("%0") do (

    @rem If person try to access two or more childs from function
    @rem I can't determine grandchilds unfortunatelly without boilerplate the code and being non-human readable
    if defined %%2 (
      echo Console do not support more than one function by parameter
      exit /b 0
    )

    @rem Call first token after : and call first parameter at pseudo function
    @rem %%1 = First Token, %1 first parameter
    @rem :PseudoFunction:PseudoChildFunction parameter
    @rem It doesn't recognize that child function is part of global scope
    call !:%%1! %1
      
    @rem Prevent CreateMessage use the functions after for 
     exit /b 0
  )
  
  @rem Message, parameter
  :Info (
    call %message_info% %1
    exit /b 0
  )
  
  @rem Message, parameter
  :Warn (
    call %message_warn% %1
    exit /b 0
  )

  @rem Message variable, parameter
  :Sucess (
    call %message_sucess% %1
    exit /b 0
  )

  exit /b 0
)

@rem Function need some fix to pass variable to others scripts
@rem Under construction maybe deprecated
:Sets (

    if not "%1" == "" (

        @rem prevent spaces with double quotes
        @rem set variable as parameter1 and value as parameter2
        @rem No space between = and %~1, %1 
        call set !%~1=%~2!

        exit /b 0
    )
)

@rem Do not let :get together with :get( the way that works is :get (
@rem Function need some fix to pass variable to others scripts
:Gets (

    if not "%~1" == "" (
      
      @rem echo the first parameter
      echo %1

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

  @rem return a variable to the global scope, i dunno why it happens.. shrug
  set "wait=timeout 1 >nul"

  @rem and return to constructor (this is necessary to continue from construct)
  exit /b 0
)

@rem Show options to be chossen
:Menu (
  @rem Clean the prompt screen when nenu is being called
  cls
  
  @rem Warn if color.bat cannot be read or not exist
  if not exist "%library%\color.cmd" (
    echo.
    @rem I'm not sure why is it here or if it's completed
    echo %WARN_COLOR%
    echo.
    pause
    exit /b 0
  )

  :- Menu
  @rem There we define three options to select when someone select 
  @rem Like 0,1,2 and that way so on
  call :Console:Warn " R E D B A T H "
  call :Console:Info " v%rversion%"
  echo.
  call :Console:Info "[ Menu ]"
  echo.
  echo Set in your prompt command consolas 16px font to better experience..
  echo.
  call :Console:Warn "Alert: Some scripts may contain dangerous activity"
  call :Console:Warn "it may could cause harmfull changes,"
  call :Console:Warn "please verify its content on scripts folder before run"
  echo.
  call :Console:Warn "Alert: Do not run any script without batch knowledge," 
  call :Console:Warn "this software is in development version,"
  call :Console:Warn "it supports windows 8 and above"
  echo.
  call :Console:Warn "Alert: This program not have any responsability for any damage"
  call :Console:Warn "caused by third scripts, take caution"

  echo.
  echo  1 - List redbath scripts
  echo  2 - List custom scripts
  :: echo  3 - Options
  echo  3 - Exit
  echo.
  set /p Command= %SELECT_OPTION%

  @rem In this case, else need to be in the same line as if
  @rem And batch not supports multiple elses, only one follow by if conditions
  if "%Command%" == "1" ( call :ScriptsList ) 
  if "%Command%" == "2" ( call :CustomScriptsList ) 
  :: if "%Command%" == "3" ( call :Options ) 
  if "%Command%" == "3" ( call :Exit )

  @rem Is there other clean solution for this? like batch script is so limited in variations
  @rem This is way better to have an exit condition when not passes through ifs
  @rem Than to make a boilerplate to consider a solution itself imo 
  
  echo.
  echo %INVALID_OPTION%
  timeout 2 >nul

  call :Menu
  @rem End of menu

  )
  
  @rem Should define a config file to disable colors.. maybe

  :ScriptsList (
  
    @rem Include listscripts cmd into redbath
    if not "%~2" == "" (
      call %source%\ListScripts.cmd red %~2
    )

    call %source%\ListScripts.cmd

    exit /b 0
  )

  :CustomScriptsList (
    
    @rem Include listscripts cmd into redbath

    call %source%\ListScripts.cmd path %cscripts% 
 
    exit /b 0
    
  )
  :Options (

  )
  :CheckConnection (
    
    echo Checking internet connection...
    @rem If Enable Update is defined and enable update is equal to zero
    if not [%ENABLE_UPDATE%] == [] if "%ENABLE_UPDATE%" == "0" (
      call :Console:Warn "Disabled Update.."
      call :Console:Info "The software will now ignore connection through internet.."
      echo Redirecting..
      timeout 5 >nul
      call :Menu
      exit /b 0
    )

    ping www.google.nl -n 1 -w 1000>nul
    if errorlevel 1 (echo Can't verify update.. skiping) else (
    echo Connected to the internet..
    echo.
    
    exit /b 0
  )

 
  :CheckOsVersion (
   
    @rem 6.1 Windows 7, 6.0 Windows Vista, 6.2 Windows 8, 6.3 Windows 8.1, 10 Windows 10

    @rem If Enable O.S check is defined and enable O.S check is equal to zero
    @rem So the default value is 1
    @rem Or conditions are fuzzy to use in batch file I'd rather prefer to use "AND" conditions
    if not [%ENABLE_OSCHECK%] == [] if "%ENABLE_OSCHECK%" == "0" (
      call :Console:Warn "Disabled OsCheck, the software will not run in compatible mode.."
      call :Console:Info "Errors may can occur during process.."
      echo Redirecting..
      timeout 5 >nul
      call :Menu
    )
     

    for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
    
    if "%version%" == "6.3" ( echo Initializing..& timeout 1 >nul& call :Menu )
    if "%version%" == "6.2" (  echo Initializing..& timeout 1 >nul& call :Menu )
    if "%version%" == "10.0"( echo Initializing..& timeout 1 >nul& call :Menu )
    
    echo Sorry, your operacional system seems not compatible with this software
    echo if you disagree, please disable O.S check
    echo Press any key to exit..
    pause >nul
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

@rem Probabily new function
:CallTimeout(
  @rem Message, timeout, function

)

:PS (
  PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {& %1 }";
)