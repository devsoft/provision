echo Turn off powershell restriction
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Unrestricted"

echo Downloading provision scripts...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "wget 'https://codeload.github.com/devsoft/provision/zip/master' -O provision.zip;Expand-Archive .\provision.zip -DestinationPath .;"

cd provision-master
call provision.cmd
