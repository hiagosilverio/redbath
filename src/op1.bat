
: If not have parameters passing by finish the script
if not %1 == "op1" ( exit /b)

: init first function called main
:: do not call first main like short hand call:main this could cause trouble during process
:main (

    cls
    echo.
    echo Listing script files...
    echo.

    : Call ListScripts function
    call :ListScripts tesx

    : Necessary to avoid loop
    exit /b 0

) | call:main

: get error and return
echo %ERRORLEVEL%
pause

: List avaliable scripts
:ListScripts (

    if exist "%scripts%" (
        if exist "%scripts%\*.bat" (
            :: Listing scripts on scripts folder
            dir /b /a-d %scripts%\*.bat | findstr /e .bat | more
        ) else (
            call %info% "Empty script folder, no script file found"
            %wait%
            echo.
            set /p question=Do you want to create an example script?
            call :ScriptBuild
        )
    ) else (
        call %warn% "Alert: Scripts folder wasn't found in main directory"
        %wait% 
        call %info% "Creating scripts folder..."
        %wait%
        md scripts
        %wait%
        call :ScriptBuild
    )
    echo.
    :script
    set /p scriptName=Type the script name: 

    if exist ( "%scripts%\%scriptName%.bat" | "%scripts%\%scriptName%" ) (
        echo.
        echo The file was found..
        %wait%
        call %info% "To force stop the batch processing press CRTL+C"
        echo Running script..
        timeout 3 >nul
        echo.
        call "%scripts%\%scriptName%.bat"
        echo. 
        echo Batch script was finished sucessfully!
        echo.
        echo Backing to scripts menu..
        timeout 6 >nul
        call :main 
    ) else (
        echo.
        call %warn% "Alert: Invalid info or bad typing: %scriptName%"
        echo Redirecting to the script listing.. 
        timeout 6 >nul
        call :main
    )

    EXIT /B 0
)

:ScriptBuild (

    call %info% "Inserting script test file.."
    %wait%
    echo echo batch successfuly executed >> scripts\helloWorld.bat 
    if %errorlevel% NEQ 0 ( Echo Error: Unknown error on create helloWorld   )
    %wait%
    call %scripts%\helloWorld.bat

    EXIT /B 0
)