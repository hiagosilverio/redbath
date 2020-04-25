@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion
:start
cls

TITLE = Redbath - Batch Script Reader

:: Call language file and set variables trought it

for /f "delims=" %%x in (lang\pt-BR.txt) do (set "%%x")

if not exist "include\color.bat" (
echo.
echo %WARN_COLOR%
echo.
)

:: This is where set color.bat path and pass hexadecimal colors
:: Parameters [hex hexcolor, string messagename] 

:: This wait hack is for when we need to pause the script to read
set "wait=ping 127.0.0.1 -n 1 >nul" 
set "info=include\color.bat 9f %*"
set "sucess=include\color.bat 2f %*"
set "warn=include\color.bat 4f %*"

:: Menu
:: There we define two options to select when someone select 1 or 0
:: We go to the option
call %info% "---------  Menu ---------" 
call %warn% "Alert: Some scripts may contain dangerous activity"
call %warn% "please verify its content on scripts folder before apply"
echo.
call %warn% "Alert: Do not run any script without bat knowledge," 
call %warn% "this software is in development version"
echo.
call %warn% "Alert: We not have any responsability for any damage"
call %warn% "caused by third scripts, take caution"
echo.
echo  1 - Listar Scripts
echo  0 - SAIR
echo.
set /p Comando= %SELECT_OPTION%
if "%Comando%" equ "1" (goto op1)
if "%Comando%" equ "0" (goto exit)

echo.
echo %INVALID_OPTION%
timeout 2 >nul
goto:start

:op1
cls
echo.
echo Listando arquivos de script disponiveis
echo.
if exist "scripts" (
  if exist "scripts\*.bat" (
    dir /b /a-d scripts\*.bat | findstr /e .bat | more
  ) else (
    call %info% "Nenhum script foi encontrado"
    %wait%
    echo.
    set /p scriptName=Deseja criar um script de exemplo?
    goto :script-build
  )
) else (
  call %warn% "Alerta: Pasta "scripts" nao foi encontrada dentro do diretorio"
  %wait% 
  call %info% "Criando pasta scripts.."
  %wait%
  md scripts
  %wait%
:script-build
  call %info% "Inserindo arquivo de teste.."
  %wait%
  echo echo batcc executado com sucesso >> scripts\helloWorld.bat 
  if %errorlevel% NEQ 0 ( Echo Erro: Falha ao criar helloWorld   )
  %wait%
  call scripts\helloWorld.bat
)
echo.
:script
set /p scriptName=Digite o nome do script a ser executado: 

if exist "scripts\%scriptName%.bat" (
    echo.
    echo O Arquivo foi encontrado..
    %wait%
    call %info% "Para encerrar o script digite CRTL+C"
    echo Rodando script..
    timeout 3 >nul
    echo.
    call "scripts\%scriptName%.bat" 
    echo.
    echo Batch script finalizado com sucesso!
    echo.
    echo Voltando para o menu de scripts..
    timeout 6 >nul
    goto:op1
) else (
    echo.
    call %warn% "Alerta: informacao invalida ou mal informada: %scriptName%"
    echo Redirecionando.. para a listagem de arquivos
    timeout 6 >nul
    goto:op1
)

pause>nul

goto:start

:exit
echo O batch script esta sendo encerrado...
timeout 3 >nul

