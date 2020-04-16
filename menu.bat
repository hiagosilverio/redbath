@Echo Off
setlocal enableextensions 
setlocal EnableDelayedExpansion
:start
cls

:: Call language file and set variables trought it

for /f "delims=" %%x in (lang\pt-BR.txt) do (set "%%x")

if not exist "include\color.bat" (
echo.
echo %WARN_COLOR%
echo.
)

:: This is where set color.bat path and pass hexadecimal colors
:: Parameters [hex hexcolor, string messagename] 

set "t1=ping 127.0.0.1 -n 1 >nul" 
set "info=include\color.bat 9f %*"
set "sucess=include\color.bat 2f %*"
set "warn=include\color.bat 4f %*"

:: Menu
echo  1 - Listar Scripts
echo  0 - SAIR

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
    echo Nenhum script foi encontrado
  )
) else (
  call %warn% "Alerta: Pasta "scripts" nao foi encontrada dentro do diretorio"
  %t1% 
  call %info% "Criando pasta scripts.."
  %t1%
  md scripts
  %t1%
  call %info% "Inserindo arquivo de teste.."
  %t1%
  echo echo batcc executado com sucesso >> scripts\helloWorld.bat 
  if %errorlevel% NEQ 0 ( Echo Erro: Falha ao criar helloWorld   )
  %t1%
  call scripts\helloWorld.bat
)
echo.
pause
set /p script= Deseja rodar algum script? (S/N):
if "%script%" equ "s" (goto:script) else (
echo.
echo Voltando ao menu de opcoes, aguarde..
timeout 2 >nul
goto:start
)

:script
set /p scriptName=Digite o nome do script a ser executado:

if exist "%scriptName%" (
    echo "Arquivo existe"
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

