@Echo off

echo Loading motherboard...
echo -------------------

wmic baseboard get product,Manufacturer,version,serialnumber

pause