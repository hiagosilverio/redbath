@echo off
 
:: nslookup myip.opendns.com resolver1.opendns.com | findstr Address:

:: PowerShell
:: (Invoke-WebRequest ifconfig.me/ip).Content.Trim()
:: https://stackoverflow.com/questions/19335004/how-to-run-a-powershell-script-from-a-batch-file
:: https://stackoverflow.com/questions/6037146/how-to-execute-powershell-commands-from-a-batch-file
:: https://stackoverflow.com/questions/18454653/run-powershell-command-from-command-prompt-no-ps1-script

:: Mixing Batch and PowerShell

echo Public IP
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {& irm ipinfo.io/ip; }";

:: Using ^ to concatenate Powershell script 
PowerShell -NoProfile -ExecutionPolicy Bypass -Command ^ "& {& Test-Connection -ComputerName %COMPUTERNAME% -Count 1 "^
| Select IPV4Address}";

pause