@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion

:_(

  @rem Prevent Window Close when error occurs including closing batch script
  @rem Some kind of witchcraft here /*
  @rem https://stackoverflow.com/questions/17118846/how-to-prevent-batch-window-from-closing-when-error-occurs
  if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) &  exit b/ 0 )
  
    @rem Call a function by parameter
    @rem if first parameter in bat "redbath.cmd x" isn't null
    if not "%~1" == "" (

        @rem if second parameter "redbath.cmd x y"  isn't null
        if not "%~2" == "" (
             if "%~1" == "show" if "%~2" == "scripts" ( 
               call redbath ScriptsList 
               exit /b 0
             )
              if "%~1" == "run" if "%~2" == "script" if not "%~3" == "" ( 
               call redbath ScriptsList red %~3
               exit /b 0
             )
        )

        echo Command invalid, type /? to list commands
        @rem return
        exit /b 0
    )
 
echo.
echo Type /? To list commands
) | call:_ %1*