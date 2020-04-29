@echo off

SET downloadUrl=https://raw.githubusercontent.com/hiagosilverio/redbath/development/README.md
SET tempFile=%cd%\.%random%-tmp

BITSADMIN /transfer /download %downloadUrl% %tempFile% >nul
::for /f "delims=" %%x in (%tempFile%) do (set "%%x")
TYPE %tempFile%
DEL %tempFile%

pause