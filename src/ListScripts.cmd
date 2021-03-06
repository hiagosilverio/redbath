@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion

@rem If rd not defined finish the script
if [%redb%] == [] ( exit /b)

@rem  init first function called main
@rem  do not call first main like shorthand call:Main this could cause trouble during process
@rem  Constructor


:_(

    @rem Retrieve value passed by parameter as %1
    @rem Overwrite the scripts variable with parameter
    if "%~1" == "red" (
       call :ListScripts %1 %2
    )

    if "%~1" == "path" if not "%~2" == "" (
        set scripts=%2
    )
    
    @rem Call redbath and push functions with scripts
    @rem Parameters: [file] [function] [variable] [value]
    
    @rem Overwrite problem and set problem, necessary fix
    : call redbath Sets teste b
    : call redbath Gets teste

    : echo %scripts%

    call :Main

@rem Recieve the variable parameter
) | call:_ %1* 

:Main (

    : Overwrite when we declare in batch it means a variable that can recieve two or more values..
    cls
    echo.
    echo Listing script files...
    echo.

    : Call ListScripts function
    call :ListScripts 

    : Necessary to avoid loop
    exit /b 0

@rem Call main as first function
) 

@rem get error and return
echo %ERRORLEVEL%
pause

@rem List avaliable scripts
:ListScripts (

    @rem Use new scripts variable value into if
    if exist "%scripts%" (
        if exist "%scripts%\*.bat" (

            @rem Listing scripts on scripts folder
            dir /b /a-d %scripts%\*.bat | findstr /e .bat | more

        ) else (
            
            %info% "Empty script folder, no script file found"
            %wait%
            echo.

            @rem Do not use parentesis in a question (Bug related)
            @rem Use variable with delayed expansion, set /p not working properly with %var%
            set /p scriptQ=Do you want to create an example script? [y/n]:

            @rem Maybe a yes or not here..
            if /i "!scriptQ!" == "y" ( 
                call :ScriptBuild
            ) else (     
                call :Main
            )
        )
    ) else (

        %warn% "Alert: Scripts folder wasn't found in main directory"
        %wait% 
        %info% "Creating scripts folder..."
        %wait%
        @rem Command to create scripts
        md %scripts%
        %wait%
        
        @rem Calling ScriptBuild function
        call :ScriptBuild

        @rem return to main
        call :main

    )
    echo.
       if "%~1" == "red" (
        set "scriptName=%~2"
       ) else (
        set /p scriptName=Type the script name or type 'menu' to return to main menu: 
       )
    @rem Create permission to replacable value
    set SCRIPTFOUND=[%SCRIPTFOUND%]

    if "%scriptName%" == "menu" ( call redbath )
    if exist "%scripts%\%scriptName%.bat" ( set SCRIPTFOUND=1 )
    if exist "%scripts%\%scriptName%" ( set SCRIPTFOUND=1 )

    if [%scriptName%] == [] ( set SCRIPTFOUND=0 )
    
    if %SCRIPTFOUND% == 1 (

        echo.
        echo The file was found..
        %wait%
        call %info% "To force stop the batch processing press CRTL+C"
        echo.
        call %info% "Please, do not close the window or turn off "
        call %info% "the computer between disk formatation, copy or move"
        
        echo.
        echo Running script..
        timeout 3 >nul
        If NOT "%scriptName%"=="%scriptName:.bat=%" (
            call "%scripts%\%scriptName%\"
        ) else (
            call "%scripts%\%scriptName%.bat"
        )
        echo. 
        echo Batch script was finished sucessfully!
        echo.
        echo Backing to scripts menu..
        timeout 6 >nul
        call :Main 

    ) else (
        echo.
        call %warn% "[Error] Script not found: %scriptName%"
        @rem Clear variable set /p garbage
        set scriptName=
        echo Redirecting to the script listing.. 
        timeout 6 >nul
        call :Main
    )

    

    exit /B 0
)

:ScriptBuild (

    %info% "Inserting script test file.."
    %wait%
    @rem Inserting text into a file named helloWorld.bat
    echo @echo off > %scripts%\helloworld.bat
    echo echo HelloWorld successfuly executed >> %scripts%\helloworld.bat
    echo exit /b 0 >> %scripts%\helloworld.bat

    if NOT %errorlevel% == 0 ( Echo Error: Unknown error on create helloworld   )
    %wait%
    %info% "Running helloworld.bat.."
    call %scripts%\helloWorld.bat

    echo.

    @rem Call wait from redbath clean the screen, so well there we prevent it with timeout
    @rem >nul is a hack to eliminate echo
    timeout 3 >nul

    @rem Return to listScripts function
    call :ListScripts

    exit /b 0

)

:Redirect (

    echo.
    echo Backing to scripts menu..
    timeout 6 >nul

)