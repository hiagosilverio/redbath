: If rd not defined finish the script
if [%rd%] == [] ( exit /b)

: init first function called main
: do not call first main like shorthand call:main this could cause trouble during process
:main (

    cls
    echo.
    echo Listing script files...
    echo.

    : Call ListScripts function
    call :ListScripts 

    : Necessary to avoid loop
    exit /b 0

: Call main as first function
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
            : Do not use parentesis in a question (Bug related)
            set /p scriptQuestion=Do you want to create an example script? [y/n]
            : Maybe a yes or not here..
            if "%scriptQuestion%" == "Y" ( 
                call :ScriptBuild
            ) else (
                echo no example script
                call :main
            )
        )
    ) else (
        call %warn% "Alert: Scripts folder wasn't found in main directory"
        %wait% 
        call %info% "Creating scripts folder..."
        %wait%
        : Command to create scripts
        md %scripts%
        %wait%
        : Calling ScriptBuild function
        call :ScriptBuild
        : return to main
        call :main
    )
    echo.
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

    exit /B 0
)

:ScriptBuild (

    call %info% "Inserting script test file.."
    %wait%
    : Inserting text into a file named helloWorld.bat
    echo echo batch successfuly executed >> %scripts%\helloWorld.bat 
    if NOT %errorlevel% == 0 ( Echo Error: Unknown error on create helloWorld   )
    %wait%
    call %scripts%\helloWorld.bat

    : Call wait from redbath clean the screen, so well there we prevent it with timeout
    : >nul is a hack to eliminate echo
    timeout 3 >nul
    EXIT /B 0
)