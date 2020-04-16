@Echo OFF
setlocal enableextensions 
setlocal EnableDelayedExpansion
:inicio
cls

if not exist "include\color.bat" (
echo.
echo Erro: color.bat faltando alertas podem nao emitir cores
echo.
)

set "t1=ping 127.0.0.1 -n 1 >nul" 
set "info=include\color.bat 9f %*"
set "sucess=include\color.bat 2f %*"
set "warn=include\color.bat 4f %*"

echo  1 - Listar Scripts
echo. 2 - Opcao 2
echo. 3 - Opcao 3
echo  4 - Opcao 4
echo  0 - SAIR

set /p Comando= Digite uma Opcao : 
if "%Comando%" equ "1" (goto op1)
if "%Comando%" equ "0" (goto exit)

echo.
echo Opcao invalida, limpando..
timeout 2 >nul
goto:inicio

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
goto:inicio
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

goto:inicio

:exit
echo O batch script esta sendo encerrado...
timeout 3 >nul

