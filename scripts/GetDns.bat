@echo off

echo Listing current configurations

echo Local Ip:
echo | nslookup | findstr "Address"

echo Dns Server:
echo nslookup | findstr "Default\ Server"

nslookup myip.opendns.com. resolver1.opendns.com