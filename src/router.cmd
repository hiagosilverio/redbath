@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion

:  [File] [Folder]  [Goto Function]
:   %1    %2        %3

call :main (

    set file = %1
    set folder = %2
    set function = %3

    call :Verify folder file

    : return
    EXIT /B 0
)

:Verify (
    
    if exist "%folder%\%file%.bat" (
      echo exists
    )
    else ( 
      : not exists
      EXIT /B 1
    )

    : return
    EXIT /B 0   
)