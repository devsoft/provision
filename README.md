# provision
provision script for new computers/boxes

# Usage
1. Start CMD as Administrator
2. Copy and paste these line into the console:
```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "mkdir \Devsoft -Force;cd \Devsoft;wget 'https://codeload.github.com/devsoft/provision/zip/master' -O provision.zip;Expand-Archive .\provision.zip -DestinationPath .;cd provision-master;.\provision.cmd"
```
