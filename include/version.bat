@echo off

SET downloadUrl=https://raw.githubusercontent.com/hiagosilverio/redbath/development/redbath.bat
SET tempFile=%cd%\.%random%-tmp

BITSADMIN /transfer /download %downloadUrl% %tempFile% >nul

for /f "tokens=2 delims==" %%# in (' type %tempFile%^|find /i "version"') do echo %%#

::https://stackoverflow.com/questions/32188232/print-specific-lines-from-a-batch-file

:: TYPE %tempFile%
DEL %tempFile%

:: Need to test condition to verify local version and remote version
pause