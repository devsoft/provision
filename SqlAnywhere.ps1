#Invoke-WebRequest -Uri "http://www.atlantis-interactive.co.uk/api/download.ashx?file=ASE\ASE_Setup_2.1.207.zip" -OutFile .\SqlAnyWhere.zip
#7z x SqlAnyWhere.zip -oSqlAnywhere -aoa
msiexec /i (Resolve-Path .\SqlAnywhere\SQLEverywhereSetup.msi) /quiet /qn /norestart /log "$(Resolve-Path .\SqlAnywhere)\install.log"
echo "Sleep in 10 seconds"
sleep -s 10
cp .\SqlAnywhere\AtlantisSQLEverywhere.exe 'C:\Program Files (x86)\Atlantis Interactive\Atlantis SQL Everywhere\' -Force